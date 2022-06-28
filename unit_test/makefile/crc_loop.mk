####################################################################################################
# Targets
####################################################################################################

BUILD_DIRECTORY := ../build
EXECUTABLE := crc_loop.exe
LIBRARY := crc_loop.a

####################################################################################################
# Defines
####################################################################################################

APPLICATION_DEFINES :=                \
  -DCRC_CRC8_LOOP_METHOD              \
  -DCRC_CRC8_CDMA2000_LOOP_METHOD     \
  -DCRC_CRC8_DARC_LOOP_METHOD         \
  -DCRC_CRC8_DVB_S2_LOOP_METHOD       \
  -DCRC_CRC8_EBU_LOOP_METHOD          \
  -DCRC_CRC8_I_CODE_LOOP_METHOD       \
  -DCRC_CRC8_ITU_LOOP_METHOD          \
  -DCRC_CRC8_MAXIM_LOOP_METHOD        \
  -DCRC_CRC8_ROHC_LOOP_METHOD         \
  -DCRC_CRC8_WCDMA_LOOP_METHOD        \
  -DCRC_CRC16_ARC_LOOP_METHOD         \
  -DCRC_CRC16_CCITT_FALSE_LOOP_METHOD

LIBRARY_DEFINES := 

####################################################################################################
# Include Paths
####################################################################################################

APPLICATION_INCLUDE_PATHS := \
  -I../unity/                \
  -I../../crc/

LIBRARY_INCLUDE_PATHS := \
  -I../unity/

####################################################################################################
# Compiler Flags
####################################################################################################

APPLICATION_COMPILER_FLAGS := \
  -Weverything

LIBRARY_COMPILER_FLAGS := \
  -Wno-everything

####################################################################################################
# Sources
####################################################################################################

APPLICATION_SOURCES := \
  ../main.c            \
  ../test/crc_test.c   \
  ../../crc/crc.c

LIBRARY_SOURCES :=         \
  ../unity/unity.c         \
  ../unity/unity_fixture.c

####################################################################################################
# Rules
####################################################################################################

all: $(BUILD_DIRECTORY)/$(LIBRARY)
	@echo "Building Executable: $(EXECUTABLE)"
	@clang -c $(APPLICATION_DEFINES) $(APPLICATION_COMPILER_FLAGS) $(APPLICATION_INCLUDE_PATHS) $(APPLICATION_SOURCES)
	@clang *.o -o $(EXECUTABLE) $(BUILD_DIRECTORY)/$(LIBRARY)
	@mv $(EXECUTABLE) $(BUILD_DIRECTORY)
	@rm -f *.o
	@./$(BUILD_DIRECTORY)/$(EXECUTABLE)

$(BUILD_DIRECTORY)/$(LIBRARY): $(BUILD_DIRECTORY)
	@clang -c $(LIBRARY_DEFINES) $(LIBRARY_COMPILER_FLAGS) $(LIBRARY_INCLUDE_PATHS) $(LIBRARY_SOURCES)
	@ar rcs $(LIBRARY) *.o
	@mv $(LIBRARY) $(BUILD_DIRECTORY)
	@rm -f *.o

$(BUILD_DIRECTORY):
	@mkdir $(BUILD_DIRECTORY)

clean: FORCE
	@rm -f *.exe.stackdump
	@rm -f *.o
	@rm -fr $(BUILD_DIRECTORY)

FORCE:
