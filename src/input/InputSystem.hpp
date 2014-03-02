#ifndef INPUT_SYSTEM_HPP
#define INPUT_SYSTEM_HPP

#include <memory>

namespace Chimera {
    class InputSystem{
    public:
        InputSystem();
        ~InputSystem();

        void Run();

    private:
        void HandleKeyPress(double elapsedTime);
        void HandleMouseMotion(double elapsedTime);
        void HandleMouseButton(double elapsedTime);
    };
}

#endif