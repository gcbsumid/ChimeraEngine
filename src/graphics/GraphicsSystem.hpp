#ifndef GRAPHICS_SYSTEM_HPP
#define GRAPHICS_SYSTEM_HPP

#include <memory>

namespace Chimera {
    class GraphicsSystem {
    public:
        GraphicsSystem();
        ~GraphicsSystem();

        void Run();
                
    private:
        void Render();
    };
}

#endif