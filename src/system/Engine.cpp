// OpenGL
#include <iostream>
#include <stdexcept>

#include "Engine.hpp"

using namespace Chimera;

Engine::Engine() {
    mGraphics = shared_ptr<GraphicsManager>(new GraphicsManager());
    mInputManager = shared_ptr<InputManager>(new InputManager());
}

Engine::~Engine() {
    
}

void Engine::Run() {
    mThreads.push_back(std::thread(mGraphicsManager.Run));
    mThreads.push_back(std::thread(mInputManager.Run));

    for (int i = 0; i < mThreads.size(); i++) {
        mThreads.at(i).join();
    }
}