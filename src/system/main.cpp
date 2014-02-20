#include <memory>
#include <iostream> 
#include <stdexcept>

#include "Engine.hpp"

using namespace std;

int main(int argc, char* argv[]) {
    
    unique_ptr<Chimera::Engine> engine{nullptr};

    try {
        engine = unique_ptr<Chimera::Engine>(new Chimera::Engine());
        engine->Run();

    } catch (exception& e) {
        cout << e.what() << endl;
    }

    return EXIT_SUCCESS;
}