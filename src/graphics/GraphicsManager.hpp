#ifndef GRAPHICS_MANAGER_HPP
#define GRAPHICS_MANAGER_HPP

namespace Chimera {
    class GraphicsManager {
    public:
        GraphicsManager();
        ~GraphicsManager();

        bool Run();
                
    private:
        bool Render();
    };
}