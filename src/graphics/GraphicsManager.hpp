#ifndef GRAPHICS_MANAGER_HPP
#define GRAPHICS_MANAGER_HPP

#include <memory>
#include <thread>

namespace Chimera {
    class GraphicsManager {
    public:
        GraphicsManager();
        ~GraphicsManager();

        void Run();
                
    private:
        void Render();

        std::shared_ptr<std::thread> mThread;
    };
}

#endif