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
	INCLUDES   := -Ithirdparty/stb_image -I/opt/local/include -I/usr/include/ImageMagick
	STDLIB 	   := -lc++ -lsupc++ 
	COMPILER   := -std=c++11 -stdlib=libc++ -pthread 
	CPPFLAGS   := -MMD -MP $(DEFINES) -g -Wall $(INCLUDES) $(COMPILER)
	CXXFLAGS   := $(CPPFLAGS) -fcolor-diagnostics -ferror-limit=5
	LDFLAGS 	=
	LIBS       := -lc++ -lsupc++ -lGL -lglfw -lGLEW -lassimp -lMagick++ -lMagickCore -lMagickWand
endif

# ifeq ($(config),release)
# 	OBJDIR 		= obj
# 	TARGET 		= $(TARGETDIR)/chimera.release
# 	DEFINES 	= -DNDEBUG
# 	INCLUDES   := -Ithirdparty/stb_image -I/opt/local/include
# 	COMPILER   := -std=c++11 -stdlib=libc++ -lc++ -lsupc++ -lpthread
# 	CPPFLAGS   := -MMD -MP $(DEFINES) -02 -Wall $(COMPILER)
# 	CXXFLAGS   := $(CPPFLAGS) -fcolor-diagnostics -ferror-limit=5
# 	LDFLAGS 	= -s
# 	MAGICK      = `Magick++-config --cppflags --cxxflags --ldflags --libs`
# 	LIBS       += -lGL -lglfw -lGLEW -lassimp -lMagick++ 
# endif

OBJECTS := \
	$(OBJDIR)/main.o \
	$(OBJDIR)/Engine.o \
	$(OBJDIR)/Program.o \
	$(OBJDIR)/Shader.o \
	$(OBJDIR)/Texture.o \
	$(OBJDIR)/Mesh.o \
	$(OBJDIR)/GraphicsSystem.o \
	$(OBJDIR)/InputSystem.o \
	$(OBJDIR)/PlatformManager.o \


.PHONY: clean

all: $(TARGETDIR) $(OBJDIR) ${TARGET}

$(TARGET): $(TARGETDIR) $(OBJDIR) $(OBJECTS)
	$(CXX) $(LDFLAGS) -o $(TARGET) $(OBJECTS) $(LIBS) 

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

# $(OBJDIR)/GraphicsSystem.o: $(GRAPHICSDIR)/GraphicsSystem.cpp
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# $(OBJDIR)/Program.o: $(GRAPHICSDIR)/Program.cpp
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# $(OBJDIR)/Shader.o: $(GRAPHICSDIR)/Shader.cpp
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# $(OBJDIR)/Mesh.o: $(GRAPHICSDIR)/Mesh.cpp
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<" 

# $(OBJDIR)/Texture.o: $(GRAPHICSDIR)/Texture.cpp
# 	@echo $(notdir $<)
# 	@ $(CXX)  $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<" 

	
$(OBJDIR)/%.o: $(GRAPHICSDIR)/%.cpp
	$(CXX) $(MAGICK) -o $@ -c $(CXXFLAGS)$<

$(OBJDIR)/%.d: $(GRAPHICSDIR)/%.cpp
	 set -e; $(CC) -M $(MAGICK) $(CXXFLAGS) $< \
        | sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
        [ -s $@ ] || rm -f $@

# ----------------------- Compile HUD Folder ------------------------------ #

# ----------------------- Compile Input Folder ------------------------------ #

# $(OBJDIR)/InputSystem.o: $(INPUTDIR)/InputSystem.cpp
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/%.o: $(INPUTDIR)/%.cpp
	$(CXX) $(MAGICK) -o $@ -c $(CXXFLAGS)$<

$(OBJDIR)/%.d: $(INPUTDIR)/%.cpp
	 set -e; $(CC) -M $(MAGICK) $(CXXFLAGS) $< \
        | sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
        [ -s $@ ] || rm -f $@

# ----------------------- Compile Networking Folder ------------------------------ #

# ----------------------- Compile Particle Folder ------------------------------ #

# ----------------------- Compile Physics Folder ------------------------------ #

# ----------------------- Compile Resource Folder ------------------------------ #

# ----------------------- Compile Scripting Folder ------------------------------ #

# ----------------------- Compile System Folder ------------------------------- #

# $(OBJDIR)/main.o: $(SYSTEMDIR)/main.cpp
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# $(OBJDIR)/Engine.o: $(SYSTEMDIR)/Engine.cpp 
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# $(OBJDIR)/PlatformManager.o: $(SYSTEMDIR)/PlatformManager.cpp 
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

$(OBJDIR)/%.o: $(SYSTEMDIR)/%.cpp
	$(CXX) $(MAGICK) -o $@ -c $(CXXFLAGS)$<

$(OBJDIR)/%.d: $(SYSTEMDIR)/%.cpp
	 set -e; $(CC) -M $(MAGICK) $(CXXFLAGS) $< \
        | sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
        [ -s $@ ] || rm -f $@

# ----------------------- End of stuff -------------------------------------- #


# -include $(OBJECTS:%.o=%.d)