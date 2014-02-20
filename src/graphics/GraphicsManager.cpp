#include <GL/glew.h>
#include <GL/glfw.h>
#include <glm/glm.hpp>

#include <stdexcept>
#include <chrono>

#include "GraphicsManager.hpp"

using namespace Chimera;

const glm::vec2 SCREEN_SIZE(1200, 800);

GraphicsManager::GraphicsManager() {
    if (!glfwInit()) 
        throw runtime_error("GLFW Error: glfwInit() failed.");

    // open a window in GLFW
    glfwOpenWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwOpenWindowHint(GLFW_OPENGL_VERSION_MAJOR, 3);
    glfwOpenWindowHint(GLFW_OPENGL_VERSION_MINOR, 3);
    glfwOpenWindowHint(GLFW_WINDOW_NO_RESIZE, GL_TRUE);
    if (!glfwOpenWindow(SCREEN_SIZE.x, SCREEN_SIZE.y, 8, 8, 8, 8, 32, 24, GLFW_WINDOW)) 
        throw runtime_error("GLFW Error: glfwOpenWindow() failed. Hardware can't handle OpenGL 3.3");

    // initialize GLEW 
    glewExperimental = GL_TRUE;
    if (glewInit() != GLEW_OK) 
        throw runtime_error("GLEW Error: glewInit() failed.");

    if (!GLEW_VERSION_3_3) 
        throw runtime_error("GLEW Error: OpenGL 3.3 Api is not availavle.");

    glfwDisable(GLFW_MOUSE_CURSOR);
    glfwSetMousePos(0,0);

    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glFrontFace(GL_CW);
    glCullFace(GL_BACK);
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_TEXTURE_2D);
    glDepthFunc(GL_LEQUAL);
}

GraphicsManager::~GraphicsManager() {

}

void GraphicsManager::Run() {
    auto lastFrame = std::chrono::high_resolution_clock::now();
    auto currentFrame = lastFrame;
    double last_time = 0;

    while (glfwGetWindowParam(GLFW_OPENED)) {
        currentFrame = std::chrono::high_resolution_clock::now();
        float cur_time = std::chrono::duration_cast<std::chrono::microseconds>(currentFrame-lastFrame).count();
        double tick = (double) cur_time - last_time;
        last_time = cur_time;

        // Todo: Send all messages to whoever needs it.
        try {
            Render();
        } catch (std::exception& err) {
            std::cerr << "Runtime Error: " << err.what() << std::endl;
            break;
        }

        // if (got a message from Input to close window) {
        //      glfwCloseWindow();
        // }
    }

    glfwTerminate();
}

void GraphicsManager::Render() {
    
}
