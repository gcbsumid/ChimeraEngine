#include <iostream>
#include <stdexcept>
#include <thread>
#include <vector> 
#include <future>

#include "Engine.hpp"

using namespace Chimera;

Engine::Engine() {
    mGraphics = std::shared_ptr<GraphicsSystem>(new GraphicsSystem());
    mInput = std::shared_ptr<InputSystem>(new InputSystem());

    mTaskManager = std::shared_ptr<TaskManager>(new TaskManager(std::thread::hardware_concurrency()));
}

Engine::~Engine() {
    
}

void Engine::Run() {

    // mTaskManager->Enqueue(&func, this, params);

    // mThreads.push_back(new std::thread(&GraphicsManager::Run, mGraphics));
    // mThreads.push_back(new std::thread(&InputManager::Run, mInput));

    // for (auto& thread : mThreads) {
    //     thread->join();
    // }
}