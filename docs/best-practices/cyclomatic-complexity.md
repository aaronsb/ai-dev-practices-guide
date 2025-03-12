# Managing Code Complexity: A Guide for Working with AI Coding Agents

## Introduction

This guide provides practical strategies for maintaining optimal code complexity when working with AI coding assistants. It covers complexity metrics, language-specific tools, and prompting techniques to ensure that AI-generated code remains maintainable, testable, and robust.

## Understanding Cyclomatic Complexity

Cyclomatic complexity measures the number of independent paths through a program's code. It provides a quantitative assessment of code complexity.

### How It's Calculated

- Starting value: 1
- Add 1 for each:
  - `if` statement
  - `else if` statement
  - `case` in a `switch`
  - Boolean operator (`&&`, `||`) in conditions
  - Loop (`for`, `while`, `do-while`)
  - `catch` block

### Complexity Thresholds

| Complexity | Risk Level | Recommendation |
|------------|------------|----------------|
| 1-10       | Low        | Ideal target range for most functions |
| 11-20      | Moderate   | Consider refactoring |
| 21-50      | High       | Requires immediate refactoring |
| 50+        | Very High  | Untestable, must be broken down |

## Guidelines for Optimal Code Structure

### Function Design

- **Size**: Keep functions under 30 lines of code
- **Responsibility**: One function = one responsibility
- **Complexity**: Target maximum cyclomatic complexity of 10
- **Parameters**: Limit to 3-4 parameters per function
- **Return statements**: Use early returns for edge cases

### Conditional Logic

- **Nesting**: Maximum 2-3 levels of nested conditionals
- **Complex conditions**: Extract into named helper functions or variables
- **Decision making**: Use switch statements instead of long if-else chains
- **Validation**: Handle edge cases and validation at the beginning of functions

### Code Organization

- **Modules**: Each file should have a clear, single purpose
- **Interfaces**: Design clean, minimal public interfaces
- **Dependencies**: Reduce coupling between components
- **Patterns**: Apply consistent patterns for similar problems

## Prompting AI Coding Agents

When working with AI coding assistants, include these specific instructions in your prompts:

### General Prompting Template

```
[Describe the task]

Please follow these complexity guidelines:
- Keep functions under 30 lines with cyclomatic complexity under 10
- One function = one responsibility
- Maximum 2-3 levels of nesting
- Extract complex conditions into named helper functions
- Use early returns for validation and edge cases
- Include brief comments explaining complex logic
```

### For Refactoring Tasks

```
Please refactor this code to:
- Break up functions with complexity over 10
- Extract helper functions for repeated or complex logic
- Reduce nesting depth
- Make the code more testable
```

### For Code Reviews

```
Review this code focusing on complexity issues:
- Identify functions with high cyclomatic complexity
- Suggest refactoring for nested conditionals
- Check for functions with too many responsibilities
- Look for opportunities to extract helper methods
```

## Language-Specific Tools for Measuring Complexity

### Python

1. **Radon** - Command-line tool and Python API
   ```bash
   pip install radon
   radon cc path/to/file.py --min B
   ```

2. **Pylint** - Linting with complexity checks
   ```bash
   pip install pylint
   pylint --max-complexity=10 path/to/file.py
   ```

3. **Wily** - Tracks complexity over time
   ```bash
   pip install wily
   wily build path/to/codebase
   wily report path/to/file.py
   ```

### TypeScript/JavaScript

1. **ESLint with complexity plugin**
   ```bash
   npm install eslint eslint-plugin-complexity
   ```
   
   In `.eslintrc.json`:
   ```json
   {
     "plugins": ["complexity"],
     "rules": {
       "complexity": ["error", 10]
     }
   }
   ```

2. **CodeClimate** - Quality monitoring tool
   - Set up through the CodeClimate platform
   - Integrates with GitHub for automated reviews

3. **Plato** - JavaScript complexity reporting
   ```bash
   npm install -g plato
   plato -r -d report path/to/source
   ```

### Rust

1. **Clippy** - Official Rust linter
   ```bash
   rustup component add clippy
   cargo clippy
   ```

2. **Rust-code-analysis** - Mozilla's metrics tool
   ```bash
   cargo install rust-code-analysis-cli
   rust-code-analysis-cli -p path/to/src -o metrics.json
   ```

## CI/CD Integration

Add complexity checking to your continuous integration pipeline:

### GitHub Actions Example

```yaml
name: Code Quality

on: [push, pull_request]

jobs:
  complexity:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.x'
          
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install radon
          
      - name: Check cyclomatic complexity
        run: |
          radon cc --min C . > complexity_report.txt
          if grep -q "^[EF]" complexity_report.txt; then
            echo "High complexity code detected:"
            cat complexity_report.txt
            exit 1
          fi
```

## Best Practices for AI-Generated Code Review

1. **Immediate review** - Always review AI-generated code before integration
2. **Complexity check** - Run complexity tools on generated code
3. **Understanding** - Ensure you understand every line generated
4. **Test coverage** - Write tests that cover all paths through the code
5. **Incremental adoption** - Integrate smaller, well-understood chunks

## Conclusion

Maintaining optimal code complexity is crucial for long-term project health. By following these guidelines and using appropriate tools, you can work effectively with AI coding agents to produce clean, maintainable, and robust code.

Remember that complexity metrics are guidelines, not strict rules. Balance them with readability, performance requirements, and the specific context of your project.
