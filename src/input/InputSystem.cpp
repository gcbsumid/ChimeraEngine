#include <GL/glfw.h>

#include "InputSystem.hpp"

using namespace Chimera;

InputSystem::InputSystem() {

}

InputSystem::~InputSystem() {

}

void InputSystem::Run() {
    while (!glfwGetKey(GLFW_KEY_ESC)) {
        HandleKeyPress(0.3);

    }
}

void InputSystem::HandleKeyPress(double elapsedTime) {
    elapsedTime *= 0.01;

    // float speed = 0.1f;

    // if(glfwGetKey(GLFW_KEY_LSHIFT)) {
    //     speed = 0.25f;
    // }



    // if (glfwGetKey('S')) {
    //     glm::vec3 bck = -camera->Forward() * speed;
    //     bck = glm::vec3(bck[0], 0.0, bck[2]);

    //     camera->Translate(bck);
    // } else if (glfwGetKey('W')) {
    //     glm::vec3 fwd = camera->Forward() * speed;
    //     fwd = glm::vec3(fwd[0], 0.0, fwd[2]);
    //     camera->Translate(fwd);
    // }

    // if (glfwGetKey('A')){
    //     glm::vec3 left = camera->Right() * speed;
    //     left = glm::vec3(left[0], 0.0, left[2]);
    //     camera->Translate(left);
    // } else if (glfwGetKey('D')){
    //     glm::vec3 right = -camera->Right() * speed;
    //     right = glm::vec3(right[0], 0.0, right[2]);
    //     camera->Translate(right);
    // }

    // if (glfwGetKey('Z')){
    //     glm::vec3 up = camera->Up() * speed;
    //     up = glm::vec3(0.0, up[1], 0.0);
    //     camera->Translate(up);
    // } else if (glfwGetKey('X')){
    //     glm::vec3 down = -camera->Up() * speed;
    //     down = glm::vec3(0.0, down[1], 0.0);
    //     camera->Translate(down);
    // }
}

void HandleMouseMotion(double elapsedTime) {
    int mouseX = 0, mouseY = 0;
    glfwGetMousePos(&mouseX, &mouseY);
    mouseX *= -0.1;
    mouseX *= 0.1;

    if (mouseX || mouseY) {
        // Set camera offset

        glfwSetMousePos(0,0);
    }
}

void HandleMouseButton(double elapsedTime) {
    if (glfwGetMouseButton(GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS) {

    } 

    if (glfwGetMouseButton(GLFW_MOUSE_BUTTON_RIGHT) == GLFW_PRESS) {
        
    }

    if (glfwGetMouseButton(GLFW_MOUSE_BUTTON_MIDDLE) == GLFW_PRESS) {
        
    }

}