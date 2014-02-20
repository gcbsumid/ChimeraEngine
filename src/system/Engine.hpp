#ifndef ENGINE_HPP
#define ENGINE_HPP

#include <memory>
#include <iostream>
#include <stdexcept>
#include <vector>
#include <thread>

#include "../graphics/GraphicsManager.hpp"
#include "../input/InputManager.hpp"

namespace Chimera {
    class Engine {
    public:
        Engine();
        ~Engine();

        void Run();

    private:
        std::shared_ptr<GraphicsManager> mGraphics;
        std::shared_ptr<InputManager> mInput;

        std::vector<std::thread*> mThreads;

        // GraphicsManager mGraphicsManager;
        // AiManager       mAiManager;
        // AudioManager
        // InputManager
        // NetworkManager
        // ParticleManager
        // ResourceManager
        // ScriptingManager
        // HudManager

        Engine(const Engine&);
        void operator=(const Engine&);
    };
}

#endif 