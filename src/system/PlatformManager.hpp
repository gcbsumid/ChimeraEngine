#ifndef PLATFORM_MANAGER_HPP
#define PLATFORM_MANAGER_HPP

#include <memory>

#include "../graphics/GraphicsSystem.hpp"
#include "../input/InputSystem.hpp"
#include "TaskManager.hpp"

namespace Chimera {
    class PlatformManager {
    public:
        PlatformManager(std::shared_ptr<TaskInterface> taskInterface);
        ~PlatformManager();



    private:
        std::shared_ptr<TaskInterface> mTaskInterface;

    };
}




#endif