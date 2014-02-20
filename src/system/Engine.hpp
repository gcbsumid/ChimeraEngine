#ifndef ENGINE_HPP
#define ENGINE_HPP

#include <memory>
#include <iostream>
#include <stdexcept>
#include <list>
#include <thread>

#include "GraphicsManager.hpp"
#include "InputManager.hpp"

namespace Chimera {
    class Engine {
    public:
        Engine();
        ~Engine();

        void Run();

    private:
        std::shared_ptr<GraphicsManager> mGraphics;
        std::shared_ptr<InputManager> mInput;

        std::list<std::thread> mThreads;

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