# Domain Glossary Avoidance

When AI agents fail to establish or use a consistent vocabulary for domain-specific terms. Instead of creating and maintaining a shared understanding of domain language, the agent introduces terminology inconsistencies, misinterprets domain concepts, or uses general terms that lack domain precision.

## How to Spot It

Look for these signs:

- Inconsistent naming of domain concepts across messages
- Using generic terms when domain-specific ones exist
- Misinterpretation of domain-specific terminology
- Failure to clarify ambiguous domain terms
- Creating new terms instead of using established domain language
- Avoiding explicit definition of key business concepts
- Mixing technical and domain vocabularies inappropriately

## Why It's Harmful

- Creates confusion about core domain concepts
- Produces code that doesn't reflect the business domain
- Makes communication between technical and domain experts difficult
- Results in inconsistent naming in the codebase
- Reduces the value of domain-driven approaches
- Makes requirements harder to trace to implementation
- Creates technical debt through terminology drift

## What to Do About It

When you see this happening:

1. Say "Let's establish a clear glossary of domain terms for this project."
2. Ask "What's the correct domain term for this concept in your business?"
3. Suggest "Can we create a reference for domain terminology that we'll use consistently?"
4. Clarify: "When you say X, does that correspond to concept Y in the domain model?"

To prevent it next time:

1. Create domain glossary extraction tools that identify key terms
2. Build terminology consistency checkers for conversations
3. Implement domain term highlighting in documentation
4. Develop domain-specific language validators for code
5. Maintain persistent domain glossaries across sessions

## Example

**Human**: "We need to implement the customer journey tracking."

**AI**: "I'll create a user flow tracking system with the following components..."

**You**: "Let's clarify our domain language first. In our business, we specifically use 'customer journey' to refer to the stages a customer goes through, from 'prospect' to 'lead' to 'opportunity' to 'client'. Could you revise your approach to use our established domain terminology?"

## Benefits of Fixing This

- Creates code that accurately reflects the business domain
- Improves communication between technical and domain experts
- Ensures consistent use of terminology across the codebase
- Makes domain concepts explicit in the implementation
- Facilitates better requirements tracing
- Reduces confusion and misinterpretation
- Supports effective domain-driven design
