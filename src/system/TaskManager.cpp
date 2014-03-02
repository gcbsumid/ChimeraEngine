#include <stdexcept>
#include "TaskManager.hpp"

using namespace Chimera;

TaskManager::TaskManager(size_t numOfThreads) 
    : mStop(false) 
{
    for (size_t i = 0; i < numOfThreads; i++) {
        mWorkers.emplace_back(
            [this] 
            {
                while(true) {
                    std::unique_lock<std::mutex> lock(this->mMutex);

                    while(!this->mStop && this->mTasks.empty()) {
                        this->mCondition.wait(lock);
                    } 

                    // finish up remaining tasks
                    if (this->mStop && this->mTasks.empty()) {
                        return;
                    }

                    std::function<void()> task(this->mTasks.front());
                    this->mTasks.pop_front();

                    lock.unlock();
                    task();
                }
            }
        );
    }
}

template<class T, class... Args> 
auto TaskManager::Enqueue(T&& task, Args&&... args) 
    -> std::future<typename std::result_of<T(Args...)>::type> {
    typedef typename std::result_of<T(Args...)>::type return_type;

    if (mStop) {
        throw std::runtime_error("Enqueue on stopped ThreadPool");
    }

    auto job = std::make_shared<std::packaged_task<return_type()>>(
            std::bind(std::forward<T>(task), std::forward<Args>(args)...)
        );

    std::future<return_type> res = job->get_future();
    {
        std::unique_lock<std::mutex> lock(mMutex);
        mTasks.emplace_back([job](){ (*job)(); });
    }

    mCondition.notify_one();
    return res;
}

TaskManager::~TaskManager() {
    {
        std::unique_lock<std::mutex> lock(mMutex);
        mStop = true;
    }

    for (size_t i = 0; i < mWorkers.size(); i++) {
        mWorkers.at(i).join();
    }
}