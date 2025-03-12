# Inconsistent Conventions

When AI agents ignore or deviate from established project conventions and style guidelines. Instead of maintaining consistent patterns across the codebase, the agent introduces its own naming, formatting, or architectural approaches, creating inconsistency that reduces maintainability.

## How to Spot It

Look for these signs:

- Different naming conventions than the rest of the codebase (camelCase vs snake_case)
- Inconsistent file organization or module structure
- Deviation from established architectural patterns
- Using different comment styles or documentation formats
- Applying different error handling approaches
- Implementing different testing patterns
- Structuring functions or methods differently
- Mixing code styles within a single file

## Why It's Harmful

- Creates a patchwork codebase with inconsistent styles
- Makes code harder to read and understand
- Increases cognitive load for developers
- Complicates maintenance and refactoring
- Makes automated tooling less effective
- Creates confusion about project standards
- Requires manual clean-up and standardization

## What to Do About It

When you see this happening:

1. Say "This doesn't match our project's conventions. Let's revise to be consistent."
2. Point out specific examples: "We use PascalCase for component names, not kebab-case."
3. Provide reference: "Here's how error handling is done in the rest of the codebase."
4. Ask: "Can you update this to match our established patterns?"

To prevent it next time:

1. Create style guide extractors that analyze existing code patterns
2. Implement convention enforcers that validate generated code
3. Provide explicit examples of project conventions in prompts
4. Add linting tools that automatically flag convention deviations
5. Generate project-specific templates for common patterns

## Example

**AI**: "Here's a new React component using hooks and arrow functions..."

**You**: "I notice you've used hooks and arrow functions, but our codebase consistently uses class components and regular function declarations. Could you revise your solution to match our established patterns?"

## Benefits of Fixing This

- Maintains a cohesive, consistent codebase
- Reduces cognitive load when reading and maintaining code
- Makes code reviews faster and more focused on logic, not style
- Enables more effective use of automated tools
- Ensures generated code integrates seamlessly
- Preserves architectural consistency
- Makes knowledge transfer easier for team members
