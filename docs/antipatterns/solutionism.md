# Solutionism Over Problem Analysis

When AI agents rush to propose solutions before thoroughly understanding the underlying problem. Instead of analyzing requirements, constraints, and existing code, the agent jumps straight to implementing a solution, often solving the wrong problem or missing critical context.

## How to Spot It

Look for these signs:

- Proposing implementations without asking clarifying questions
- Minimal time spent examining existing code or architecture
- Solutions that miss key edge cases mentioned in requirements
- Lack of exploration of alternative approaches
- Skipping problem definition or requirement validation
- Diving into implementation details immediately
- No explicit analysis of trade-offs or constraints

## Why It's Harmful

- Creates solutions that solve the wrong problem
- Misses underlying issues that need addressing
- Wastes effort on implementations that need extensive rework
- Overlooks important constraints or requirements
- Results in code that doesn't integrate well with existing systems
- Produces naive solutions that don't account for edge cases
- Bypasses opportunities for simpler approaches

## What to Do About It

When you see this happening:

1. Pause and say "Before we implement, let's make sure we understand the problem fully."
2. Ask "What are the core requirements and constraints we need to address?"
3. Suggest "Let's analyze the existing code first to understand how this fits in."
4. Prompt "What are some alternative approaches we could consider?"

To prevent it next time:

1. Create requirement analysis templates to guide initial exploration
2. Implement problem statement formulation as a first step
3. Build constraints discovery tools that identify system limitations
4. Establish explicit design-before-implementation protocols
5. Develop solution evaluation criteria before coding begins

## Example

**Human**: "We need to implement user profile updates."

**AI**: "Here's a complete React component for user profile updates with form validation..."

**You**: "Let's take a step back. Before implementing, could you help me identify the key requirements for user profile updates? What data needs to be editable, what validation rules apply, and how does this integrate with our existing authentication system?"

## Benefits of Fixing This

- Solutions that actually solve the right problem
- More robust implementations that handle edge cases
- Better integration with existing systems
- Potentially simpler approaches that save development time
- Increased likelihood of meeting actual user needs
- More maintainable code with clearer purpose
- Reduced rework and post-implementation fixes
