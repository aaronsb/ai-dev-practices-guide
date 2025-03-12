# Historical Amnesia

When AI agents forget critical context from earlier in the conversation when generating solutions. Despite previous discussions about requirements, constraints, or architectural decisions, the agent produces code that ignores or contradicts this established context, requiring repeated correction.

## How to Spot It

Look for these signs:

- Reverting to approaches that were explicitly ruled out earlier
- Forgetting established requirements from previous messages
- Contradicting design decisions made earlier in the conversation
- Ignoring established naming conventions discussed previously
- Reintroducing patterns that were determined to be problematic
- Asking for information that was already provided
- Acting as if seeing the problem for the first time

## Why It's Harmful

- Wastes time repeating information and requirements
- Creates inconsistent solutions that don't build on previous work
- Requires constant vigilance and correction
- Reduces the value of extended conversations
- Makes iterative development difficult
- Results in solutions that ignore important constraints
- Erodes trust in the agent's ability to maintain context

## What to Do About It

When you see this happening:

1. Say "Let's recall that we decided X earlier in our conversation."
2. Create summaries: "To recap our decisions so far: we're using approach A, avoiding pattern B, and focusing on requirement C."
3. Reference previous messages: "As we discussed in message #3, we need to maintain backward compatibility."
4. Ask: "Can you ensure this solution incorporates our previous decisions about X, Y, and Z?"

To prevent it next time:

1. Implement conversation summarizers that extract key decisions
2. Create project decision registers that persist across sessions
3. Add explicit decision tracking in conversation
4. Develop tools that extract requirements from conversation history
5. Tag important context with "remember this" markers

## Example

**Human**: "As we discussed earlier, we need to implement this using functional components and hooks."

**AI**: "Here's a class component implementation of the feature..."

**You**: "Let's stick with our previous decision to use functional components and hooks for this implementation, as we discussed. Could you revise your solution to align with that approach?"

## Benefits of Fixing This

- Maintains coherent development progress across the conversation
- Reduces repetition and correction
- Creates more cohesive, requirement-aligned solutions
- Enables successful iterative development
- Builds trust in the agent's ability to maintain context
- Allows focus on new challenges rather than revisiting old decisions
- Creates more efficient development conversations
