###############################################################################
## Compilation Parameters
##
## Directories
HDIR=./header
SDIR=./source
ODIR=./object
LDIR=./library
BDIR=./bin

## Compiler intructions
CC=g++
CFLAGS=-Wall -c -g -I$(HDIR) -std=c++98
LDFLAGS=-static -L$(LDIR)
AR=ar
AFLAGS=rcs

## Library Test
TEST_SOURCE=Secex.cpp test.cpp
TEST_OBJS=$(patsubst %.cpp, $(ODIR)/%.o, $(TEST_SOURCE))
## Static Library
LIB_SOURCE=Secex.cpp
LIB_OBJS=$(patsubst %.cpp, $(ODIR)/%.o, $(LIB_SOURCE))
## Static Library Test
STEST_SOURCE=test.cpp
STEST_OBJS=$(patsubst %.cpp, $(ODIR)/%.o, $(STEST_SOURCE))


###############################################################################
# Compilation Instructions
#
all: cleanall test
run:
	@./bin/test
run_static:
	@./bin/test_slib


# Compile all .cpp
$(ODIR)/%.o: $(SDIR)/%.cpp
	@$(CC) $(CFLAGS) $^ -o $@

# TEST Library
test: $(TEST_OBJS)
	@echo "Building Secex test"
	@$(CC) -o $(BDIR)/$@ $^

# Static Library
static_library: $(LIB_OBJS)
	@echo "Building Secex as static library"
	@$(AR) $(AFLAGS) $(LDIR)/lib$@.a $^

# TEST Static Library
test_slib: $(STEST_OBJS)
	@echo "Building Secex test with static library"
	@$(CC) -o $(BDIR)/$@ $^ $(LDFLAGS) -libstatic_stdio.a


clean:
	@rm -f $(BDIR)/* $(ODIR)/*
	@echo "Binaries and Object Removed"

cleanall:
	@rm -f $(BDIR)/* $(ODIR)/* $(LDIR)/*
	@echo "All old buildings removed"
