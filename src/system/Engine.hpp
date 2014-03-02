#ifndef ENGINE_HPP
#define ENGINE_HPP

#include <memory>
#include <iostream>
#include <stdexcept>
#include <vector>

#include "../graphics/GraphicsSystem.hpp"
#include "../input/InputSystem.hpp"

#include "TaskManager.hpp"

namespace Chimera {
    class Engine {
    public:
        Engine();
        ~Engine();

        void Run();

    private:

        // System
        std::shared_ptr<GraphicsSystem> mGraphics;
        std::shared_ptr<InputSystem> mInput;

        // Managers
        std::shared_ptr<TaskManager> mTaskManager;
        // std::shared_ptr<PlatformManager> mPlatformManager;
        // std::shared_ptr<StateManager> mStateManager;
        // std::shared_ptr<ServiceManager> mServiceManager;
        // std::shared_ptr<Loader> mLoader;




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