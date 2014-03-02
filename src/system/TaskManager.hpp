#ifndef TASK_MANAGER_HPP
#define TASK_MANAGER_HPP

#include <vector>
#include <deque>
#include <thread>
#include <future>
#include <mutex>
#include <condition_variable>
#include <memory>

namespace Chimera {
    class TaskInterface {
    public:
        template<class T, class... Args>
        auto Enqueue(T&& task, Args&&... args)
            -> std::future<typename std::result_of<T(Args...)>::type>;
    };

    class TaskManager : TaskInterface {
    public:
        TaskManager(size_t size);
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
}

#endif