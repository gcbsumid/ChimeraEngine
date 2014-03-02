#ifndef TASK_MANAGER_HPP
#define TASK_MANAGER_HPP

#include <vector>
#include <deque>
#include <thread>
#include <future>
#include <mutex>
#include <condition_variable>
#include <memory>
#include <functional>
#include <type_traits>
#include <stdexcept>

namespace Chimera {
    class TaskInterface {
    public:
        template<class T, class... Args>
        auto Enqueue(T&& task, Args&&... args)
            -> std::future<typename std::result_of<T(Args...)>::type>;
    };

    // class TaskManager : TaskInterface {
    class TaskManager {
    public:
        TaskManager(size_t numOfThreads);
        ~TaskManager();

        template<class T, class... Args>
        auto Enqueue(T&& task, Args&&... args)
             -> std::future<typename std::result_of<T(Args...)>::type>;

    private:
        std::vector<std::thread> mWorkers;
        std::deque<std::function<void()>> mTasks;

        // for synchronization
        std::mutex mMutex;
        std::condition_variable mCondition;
        bool mStop;
    };


    inline TaskManager::TaskManager(size_t numOfThreads) 
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

    inline TaskManager::~TaskManager() {
        {
            std::unique_lock<std::mutex> lock(mMutex);
            mStop = true;
        }

        mCondition.notify_all();
        for (size_t i = 0; i < mWorkers.size(); ++i) {
            mWorkers.at(i).join();
        }
    }

    template<class T, class... Args> 
    auto TaskManager::Enqueue(T&& task, Args&&... args) 
        -> std::future<typename std::result_of<T(Args...)>::type> 
    {
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
}

#endif