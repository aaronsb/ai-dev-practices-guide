# Dependency Blindness

When AI agents operate without awareness of the project's dependencies, versions, or package ecosystem. The agent proposes solutions that use unavailable dependencies, incompatible versions, or overlooked package limitations, leading to implementation errors and integration challenges.

## How to Spot It

Look for these signs:

- Suggesting libraries not listed in package.json/requirements.txt
- Recommending features from newer versions than those in use
- Ignoring compatibility constraints between dependencies
- Overlooking transitive dependency issues
- Missing peer dependency requirements
- Creating import statements for packages not installed
- Ignoring platform-specific dependency limitations

## Why It's Harmful

- Creates solutions that can't be implemented as written
- Introduces version conflicts that break builds
- Requires additional debugging and implementation time
- Adds unnecessary dependencies when existing ones would suffice
- Increases complexity of the dependency tree
- Potentially introduces security vulnerabilities
- Reduces confidence in AI-generated solutions

## What to Do About It

When you see this happening:

1. Say "Let's check which dependencies we already have in the project."
2. Ask "Can we implement this using our existing dependency set?"
3. Clarify: "We're using version X.Y.Z of this library, not the latest version."
4. Request: "Please verify that your solution works with our current dependencies."

To prevent it next time:

1. Create a dependency information tool that extracts and summarizes package details
2. Include package.json/requirements.txt in the initial context
3. Generate "allowed dependencies" lists for different project areas
4. Build version constraint checkers for AI-generated code
5. Implement a dependency validator for preprocessing AI suggestions

## Example

**AI**: "You should use React Query for this data fetching pattern. Here's how you could implement it..."

**You**: "We're actually standardized on SWR for data fetching in this project. Could you revise your approach to use our existing SWR pattern instead of introducing React Query?"

## Benefits of Fixing This

- Solutions that work out-of-the-box without dependency changes
- Consistent use of libraries across the project
- Reduced integration effort
- Lower complexity and maintenance burden
- Better alignment with team standards
- Fewer security risks from unnecessary dependencies
- More predictable builds and deployments
