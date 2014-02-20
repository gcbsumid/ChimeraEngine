# makefile

ifndef config
	config = debug
endif

TARGETDIR = bin
GAMEPLAYDIR = src/gameplay
AIDIR = src/ai
ANIMATIONDIR = src/animation
INPUTDIR = src/input
PHYSICSDIR = src/physics
GRAPHICSDIR = src/graphics
AUDIODIR = src/audio
HUDDIR = src/hud
NETWORKINGDIR = src/networking
PARTICLEDIR = src/particle 
SYSTEMDIR = src/system
SCRIPTINGDIR = src/scripting 

# Note: -fcolor-diagnostics, for some reason, is defaulted to false in Clang 3.4


CXX = clang++

ifeq ($(config),debug)
	OBJDIR 		= obj
	TARGET 		= $(TARGETDIR)/chimera.debug
	DEFINES 	= -DDEBUG
	INCLUDES   := -Ithirdparty/stb_image -I/opt/local/include
	STDLIB 	   := -stdlib=libc++ -lc++ -lsupc++ 
	COMPILER   := -std=c++11 -pthread
	CPPFLAGS   := -MMD -MP $(DEFINES) -g -Wall $(INCLUDES) $(COMPILER)
	CXXFLAGS   := $(CPPFLAGS) -fcolor-diagnostics -ferror-limit=5
	LDFLAGS 	= 
	MAGICK     := `Magick++-config --cppflags --cxxflags --ldflags --libs`
	LIBS       := -lGL -lglfw -lGLEW -lassimp -lMagick++ 
endif

ifeq ($(config),release)
	OBJDIR 		= obj
	TARGET 		= $(TARGETDIR)/chimera.release
	DEFINES 	= -DNDEBUG
	INCLUDES   := -Ithirdparty/stb_image -I/opt/local/include
	COMPILER   := -std=c++11 -stdlib=libc++ -lc++ -lsupc++ -lpthread
	CPPFLAGS   := -MMD -MP $(DEFINES) -02 -Wall $(COMPILER)
	CXXFLAGS   := $(CPPFLAGS) -fcolor-diagnostics -ferror-limit=5
	LDFLAGS 	= -s
	MAGICK      = `Magick++-config --cppflags --cxxflags --ldflags --libs`
	LIBS       += -lGL -lglfw -lGLEW -lassimp -lMagick++ 
endif

OBJECTS := \
	$(OBJDIR)/main.o \
	$(OBJDIR)/Engine.o \
	$(OBJDIR)/GraphicsManager.o \
	$(OBJDIR)/InputManager.o \


.PHONY: clean

all: $(TARGETDIR) $(OBJDIR) ${TARGET}

$(TARGET): $(TARGETDIR) $(OBJDIR) $(OBJECTS)
	$(CXX) -o $(TARGET) $(OBJECTS) $(LIBS) $(LDFLAGS)

$(OBJDIR):
	@echo "Creating $(OBJDIR)"
	@ mkdir -p $(OBJDIR)

$(TARGETDIR):
	@echo "Creating $(TARGETDIR)"
	@ mkdir -p $(TARGETDIR)

clean:
	@echo "Cleaning program"
	@ rm -f $(TARGET)
	@ rm -rf $(OBJDIR)
	
run: ${TARGET}
	./${TARGET}

# ----------------------- Compile AI Folder --------------------------------- #

# ----------------------- Compile Audio Folder ------------------------------ #

# ----------------------- Compile Game Folder ------------------------------ #

# ----------------------- Compile Graphics Folder ------------------------------ #

$(OBJDIR)/GraphicsManager.o: $(GRAPHICSDIR)/GraphicsManager.cpp
	@echo $(notdir $<)
	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# ----------------------- Compile HUD Folder ------------------------------ #

# ----------------------- Compile Input Folder ------------------------------ #

$(OBJDIR)/InputManager.o: $(INPUTDIR)/InputManager.cpp
	@echo $(notdir $<)
	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# ----------------------- Compile Networking Folder ------------------------------ #

# ----------------------- Compile Particle Folder ------------------------------ #

# ----------------------- Compile Physics Folder ------------------------------ #

# ----------------------- Compile Resource Folder ------------------------------ #

# ----------------------- Compile Scripting Folder ------------------------------ #

# ----------------------- Compile System Folder ------------------------------- #

$(OBJDIR)/main.o: $(SYSTEMDIR)/main.cpp
	@echo $(notdir $<)
	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/Engine.o: $(SYSTEMDIR)/Engine.cpp 
	@echo $(notdir $<)
	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# ----------------------- End of stuff -------------------------------------- #

-include $(OBJECTS:%.o=%.d)