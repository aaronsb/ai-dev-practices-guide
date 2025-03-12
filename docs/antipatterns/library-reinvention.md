# Library and Framework Reinvention

When AI assistants implement custom solutions for problems that already have established, well-tested libraries or frameworks. Instead of leveraging existing tools, they create novel implementations that duplicate available functionality, causing unnecessary complexity and potential reliability issues.

## How to Spot It

Look for these signs:

- Lengthy custom implementations of common functionality (authentication, validation, etc.)
- Phrases like "let's create our own X" without justifying why existing solutions are inadequate
- Absence of import statements for standard libraries that would solve the problem
- Complex utility functions that replicate standard library features
- Implementing low-level functionality (HTTP clients, JSON parsing, etc.) from scratch
- Detailed explanations of algorithms that exist in standard libraries
- No mention of established packages when proposing solutions in domains with clear standards

## Why It's Harmful

- Creates maintenance burden for custom code
- Misses security features and edge case handling present in established libraries
- Wastes time reinventing solutions to already-solved problems
- Extends development time
- Produces inconsistent behavior compared to standard implementations
- Generates technical debt from non-standard approaches

## What to Do About It

When you see this happening:

1. Ask "Is there an existing library or framework that handles this for us?"
2. Request "What established libraries could we use instead of building this ourselves?"
3. Question "What are the tradeoffs between your custom implementation and using library X?"
4. Challenge "Why are we building this from scratch rather than using existing tools?"

To prevent it next time:

1. Start with discovery: "What libraries are commonly used for this type of problem?"
2. Set expectations: "Our default approach is to use existing libraries unless there's a compelling reason not to."
3. Request library-first solutions: "Please suggest solutions that leverage established libraries first."
4. Define boundaries: "We only want custom implementations for X, Y, and Z; everything else should use standard libraries."
5. Require justification: "If suggesting a custom implementation, explain why existing libraries don't meet our needs."

## Example

**AI**: "For handling HTTP requests, we'll create a custom HttpClient class that manages connections and handles different content types. Here's the implementation..."

**You**: "Let's use Axios (or fetch in a browser environment) instead of writing our own HTTP client. Can you revise the approach to leverage that established library?"

## Benefits of Fixing This

- Reduces development time and effort
- Creates more reliable and secure solutions
- Makes onboarding easier for developers familiar with standard libraries
- Improves maintainability and upgradability
- Provides access to community support and documentation
- Focuses effort on novel aspects of the problem rather than solved ones
