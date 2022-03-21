CC=gcc
RM=rm -f
CLANG-FORMAT=clang-format

WARNING=-Wall -Wextra -Werror
FLAGS=$(WARNING) -std=c11
MAIN=
SRC=
DEPS=$(MAIN) $(SRC)
BINARY=

TEST_FLAGS=$(FLAGS) -g -O0
TEST_SRC=tests/smoke.c
TEST_DEPS=$(TEST_SRC) tests/greatest.h
TEST_BINARY=./test_smoke
INTEGRATION_TEST_SCRIPT=./tests/run_full.py
EXEC_INTEGRATION_TEST_SCRIPT=$(PY) $(INTEGRATION_TEST_SCRIPT)
INTEGRATION_TESTS=tests/full/*.in tests/full/*.exp

$(BINARY): $(DEPS)
	$(CC) $(FLAGS) $(SRC) -o $@

.PHONY: isformatted
isformatted: $(DEPS)
	$(CLANG-FORMAT) -dry-run -Werror $(DEPS) $(TEST_DEPS)

.PHONY: format
format: $(DEPS)
	$(CLANG-FORMAT) -i $(DEPS) $(TEST_DEPS)

.PHONY: clean
clean:
	$(RM) $(BINARY)
	$(RM) $(BINARY)

$(TEST_BINARY): $(TEST_DEPS)
	$(CC) $(TEST_FLAGS) $(TEST_SRC) $(SRC_WITHOUT_MAIN) -o $@

.PHONY: test
test: $(TEST_BINARY)
	$(TEST_BINARY)

.PHONY: integrationtest
integrationtest: $(BINARY) $(INTEGRATION_TEST_SCRIPT) $(INTEGRATION_TEST_SCRIPT)
	$(EXEC_INTEGRATION_TEST_SCRIPT) $(BINARY)
