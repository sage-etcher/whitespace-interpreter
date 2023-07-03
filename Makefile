TARGET_EXEC := wsi

BUILD_DIR := ./build
SRC_DIR := ./src

FILES := fileio.c utils.c ws_errors.c hashmap.c ws_program.c wsi.c
SRC_FILES := $(addprefix $(SRC_DIR)/,$(FILES))
OBJ_FILES := $(foreach file,$(SRC_FILES),$(BUILD_DIR)/$(file).o)

INCLUDES := -I$(SRC_DIR)/include -I$(SRC_DIR)
LIBRARIES := -L$(SRC_DIR)/lib

BUILD_FLAGS := -std=c89 -pedantic $(INCLUDES)
LINKER_FLAGS := $(INCLUDES) $(LIBRARIES)

CC := gcc
LD := gcc


.PHONY: build
build: $(BUILD_DIR)/$(TARGET_EXEC)

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJ_FILES)
	if not exist "$(dir $@)" mkdir "$(dir $@)"
	$(LD) -o $@ $(LINKER_FLAGS) $(OBJ_FILES)

$(BUILD_DIR)/$(SRC_DIR)/%.c.o: $(SRC_DIR)/%.c
	if not exist "$(dir $@)" mkdir "$(dir $@)"
	$(CC) -c -o $@ $(BUILD_FLAGS) $<


.PHONY: clean
clean:
	del /s /q "$(BUILD_DIR)"
	rmdir /s /q "$(BUILD_DIR)"