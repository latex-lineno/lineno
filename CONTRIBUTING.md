# Contributing to `lineno`

I am just the maintainer of this package, not its original author(s), and have
very limited time to fix bugs and add new features. Pull requests are therefore
very welcome!

## Test suite

When contributing a new feature or bug fix, please add a unit test to the test
suite:

1. Create a new directory under `test/`. If this is a bug fix, it should be
   named after the corresponding issue on the [issue tracker][issues],
   e.g. `test/issue-123`. If this is a new feature, it should have a usefully
   descriptive name.

2. The `test/...` directory must contain at least 2 files:

   * `test.tex`: a minimal working example demonstrating the feature or
     bugfix. Please use standard LaTeX classes where possible
     e.g. `article`. Please keep the code as simple as possible, as the test
     will need to be compiled by both old and new versions of LaTeX.

   * `ref-test.pdf`: PDF output demonstrating how `test.tex` is meant to look.

   * If it makes sense to have multiple tests for this contribution, you can add
     a prefix to the above files, for example:

      * `test-good.tex`, `ref-test-good.pdf`
      * `test-bad.tex`, `ref-test-bad.pdf`

## Opening a pull request

Open a pull request at the [`lineno` repository][repo]. This will trigger a
build against various old and new versions of LaTeX. These tests must pass
before a pull request can be merged.

[repo]: https://github.com/latex-lineno/lineno
[issues]: https://github.com/latex-lineno/lineno/issues
