#ifndef INPUT_MANAGER_HPP
#define INPUT_MANAGER_HPP

#include <thread>
#include <memory>

namespace Chimera {
    class InputManager{
    public:
        InputManager();
        ~InputManager();

        void Run();

    private:
        void HandleKeyPress(double elapsedTime);
        void HandleMouseMotion(double elapsedTime);
        void HandleMouseButton(double elapsedTime);

        std::shared_ptr<std::thread> mThread;
    };
}

#endif