CC = arm-none-eabi-gcc
VPATH = src/
OBJ_DIR := build/
SRC      :=                      \
   $(wildcard src/*.cpp)         \
   $(wildcard src/*.c)         \

BASENAMES := $(notdir $(SRC))
OBJECTS  := $(BASENAMES:%.c=%.o)  #Don't wrap BASENAMES with $()
OBJECT_PATHS = $(addprefix $(OBJ_DIR),$(OBJECTS))
CPP_FLAGS = -I include -I CMSIS

vpath %.cpp src
vpath %.c
vpath %.h include
vpath %.s src
vpath %.o build

all: main

# Dep
deps := $(patsubst %.o, %.d, $(OBJECT_PATHS))
-include $(deps)
DEPFLAGS = -MMD -MF build/deps/$(@:.o=.d)

test:
	echo $(OBJECTS)
# Targets
main: $(OBJECTS)
	g++ $(OBJECT_PATHS) $(CPP_FLAGS) -o build/main

#Patterns
%.o: %.cpp
	$(CC) -c $< $(CPP_FLAGS) -o build/$@ $(DEPFLAGS)

#Patterns
%.o: %.c
	$(CC) -mcpu=cortex-m0 -c $< $(CPP_FLAGS) -o build/$@ $(DEPFLAGS)

.PHONY: clean
clean: 
	rm -f build/*.o
	rm -f build/deps/*.d


