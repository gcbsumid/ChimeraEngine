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


CXX = g++

ifeq ($(config),debug)
	OBJDIR 		= obj
	TARGET 		= $(TARGETDIR)/chimera.debug
	DEFINES 	= -DDEBUG
	INCLUDES   :=  -I/opt/local/include -I/usr/include/ImageMagick
	STDLIB 	   := -lc++ -lsupc++ 
	COMPILER   :=  -pthread # -stdlib=libc++
	MAGICK      = `Magick++-config --cppflags --cxxflags`
	CPPFLAGS   := -g -Wall -MMD -std=c++11 # -MP $(DEFINES) $(INCLUDES) 
	CXXFLAGS   := $(CPPFLAGS) # -fcolor-diagnostics -ferror-limit=5
	LDFLAGS 	=
	LIBS       := -lc++ -lsupc++ -lGL -lglfw -lGLEW -lassimp `Magick++-config --ldflags --libs`
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


SOURCES = \
	$(SYSTEMDIR)/main.cpp \
	$(SYSTEMDIR)/Engine.cpp \
	$(SYSTEMDIR)/PlatformManager.cpp \
	$(GRAPHICSDIR)/Program.cpp \
	$(GRAPHICSDIR)/Shader.cpp \
	$(GRAPHICSDIR)/Texture.cpp \
	$(GRAPHICSDIR)/Mesh.cpp \
	$(GRAPHICSDIR)/GraphicsSystem.cpp \
	$(INPUTDIR)/InputSystem.cpp \

OBJECTS = \
	$(OBJDIR)/main.o \
	$(OBJDIR)/Engine.o \
	$(OBJDIR)/Program.o \
	$(OBJDIR)/Shader.o \
	$(OBJDIR)/Texture.o \
	$(OBJDIR)/Mesh.o \
	$(OBJDIR)/GraphicsSystem.o \
	$(OBJDIR)/InputSystem.o \
	$(OBJDIR)/PlatformManager.o \

DEPENDS = \
	$(OBJDIR)/main.d \
	$(OBJDIR)/Engine.d \
	$(OBJDIR)/Program.d \
	$(OBJDIR)/Shader.d \
	$(OBJDIR)/Texture.d \
	$(OBJDIR)/Mesh.d \
	$(OBJDIR)/GraphicsSystem.d \
	$(OBJDIR)/InputSystem.d \
	$(OBJDIR)/PlatformManager.d \

.PHONY: clean

all: $(TARGETDIR) $(OBJDIR) ${TARGET}

# depend: $(DEPENDS)

$(TARGET): $(TARGETDIR) $(OBJDIR) $(OBJECTS)
	$(CXX) -o $(TARGET) $(OBJECTS) $(LDFLAGS) $(LIBS)

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


$(OBJDIR)/%.o: $(SYSTEMDIR)/%.cpp 
	@echo $(notdir $<)
	@ $(CXX) $(MAGICK) -o $@ -MF $(@:%.o=%.d) -c $(CXXFLAGS) $(COMPILER) $<

$(OBJDIR)/%.o: $(INPUTDIR)/%.cpp
	@echo $(notdir $<)
	@ $(CXX) $(MAGICK) -o $@ -MF $(@:%.o=%.d) -c $(CXXFLAGS) $(COMPILER) $<

$(OBJDIR)/%.o: $(GRAPHICSDIR)/%.cpp 
	@echo $(notdir $<)
	@ $(CXX) $(MAGICK) -o $@ -MF $(@:%.o=%.d) -c $(CXXFLAGS) $(COMPILER) $<

# $(OBJDIR)/%.d: $(SYSTEMDIR)/%.cpp 
# 	 set -e; $(CC) -M $(MAGICK) $(CPPFLAGS) $< \
#         | sed 's/\(obj\/$*\)\.o[ :]*/\1.o $@ : /g' > $@; \
#         [ -s $@ ] || rm -f $@


# $(OBJDIR)/%.d: $(INPUTDIR)/%.cpp
# 	 set -e; $(CC) -M $(MAGICK) $(CPPFLAGS) $< \
#         | sed 's/\(obj\/$*\)\.o[ :]*/\1.o $@ : /g' > $@; \
#         [ -s $@ ] || rm -f $@

# $(OBJDIR)/%.d: $(GRAPHICSDIR)/%.cpp
# 	 set -e; $(CC) -M $(MAGICK) $(CPPFLAGS) $< \
#         | sed 's/\(obj\/$*\)\.o[ :]*/\1.o $@ : /g' > $@; \
#         [ -s $@ ] || rm -f $@


# include $(DEPENDS)

# # ----------------------- Compile AI Folder --------------------------------- #

# # ----------------------- Compile Audio Folder ------------------------------ #

# # ----------------------- Compile Game Folder ------------------------------ #

# # ----------------------- Compile Graphics Folder ------------------------------ #

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


# # $(OBJDIR)/%.o: $(GRAPHICSDIR)/%.cpp
# # 	$(CXX) $(MAGICK) -o $@ -c $(CXXFLAGS)$<

# # $(OBJDIR)/%.d: $(GRAPHICSDIR)/%.cpp
# # 	 set -e; $(CC) -M $(MAGICK) $(CXXFLAGS) $< \
# #         | sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
# #         [ -s $@ ] || rm -f $@

# # ----------------------- Compile HUD Folder ------------------------------ #

# # ----------------------- Compile Input Folder ------------------------------ #

# $(OBJDIR)/InputSystem.o: $(INPUTDIR)/InputSystem.cpp
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# # $(OBJDIR)/%.o: $(INPUTDIR)/%.cpp
# # 	$(CXX) $(MAGICK) -o $@ -c $(CXXFLAGS)$<

# # $(OBJDIR)/%.d: $(INPUTDIR)/%.cpp
# # 	 set -e; $(CC) -M $(MAGICK) $(CXXFLAGS) $< \
# #         | sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
# #         [ -s $@ ] || rm -f $@

# # ----------------------- Compile Networking Folder ------------------------------ #

# # ----------------------- Compile Particle Folder ------------------------------ #

# # ----------------------- Compile Physics Folder ------------------------------ #

# # ----------------------- Compile Resource Folder ------------------------------ #

# # ----------------------- Compile Scripting Folder ------------------------------ #

# # ----------------------- Compile System Folder ------------------------------- #

# $(OBJDIR)/main.o: $(SYSTEMDIR)/main.cpp
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# $(OBJDIR)/Engine.o: $(SYSTEMDIR)/Engine.cpp 
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# $(OBJDIR)/PlatformManager.o: $(SYSTEMDIR)/PlatformManager.cpp 
# 	@echo $(notdir $<)
# 	@ $(CXX) $(CXXFLAGS) -o "$@" -MF $(@:%.o=%.d) -c "$<"

# # $(OBJDIR)/%.o: $(SYSTEMDIR)/%.cpp
# # 	$(CXX) $(MAGICK) -o $@ -c $(CXXFLAGS)$<

# # $(OBJDIR)/%.d: $(SYSTEMDIR)/%.cpp
# # 	 set -e; $(CC) -M $(MAGICK) $(CXXFLAGS) $< \
# #         | sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
# #         [ -s $@ ] || rm -f $@

# # ----------------------- End of stuff -------------------------------------- #


# -include $(OBJECTS:%.o=%.d)