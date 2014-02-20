// OpenGL
#include <iostream>
#include <stdexcept>

#include "Engine.hpp"

using namespace Chimera;

Engine::Engine() {
    mGraphics = std::shared_ptr<GraphicsManager>(new GraphicsManager());
    mInput = std::shared_ptr<InputManager>(new InputManager());
}

Engine::~Engine() {
    
}

void Engine::Run() {
    // mThreads.push_back(new std::thread(&GraphicsManager::Run, mGraphics));
    // mThreads.push_back(new std::thread(&InputManager::Run, mInput));

    // for (auto& thread : mThreads) {
    //     thread->join();
    // }
}