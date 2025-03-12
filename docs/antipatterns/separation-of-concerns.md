# Failure to Separate Concerns

When AI assistants create code that mixes different responsibilities within the same components. Rather than organizing code around clear boundaries of responsibility, the implementation intermingles concerns like business logic, data access, presentation, and error handling, creating tight coupling and dependencies.

## How to Spot It

Look for these signs:

- Methods or classes that serve multiple distinct purposes
- Direct database calls within UI components or business logic
- Formatting and presentation logic mixed with data processing
- Error handling scattered throughout the codebase
- Configuration and environment concerns embedded in business logic
- Large, complex functions that handle multiple aspects of a process
- Difficulty explaining what a component's single responsibility is
- Cross-cutting concerns (logging, authorization) duplicated everywhere

## Why It's Harmful

- Makes maintaining or extending the codebase difficult
- Increases bugs when changing one aspect affects others
- Creates testing challenges due to inability to isolate components
- Reduces code reusability
- Makes onboarding new developers harder
- Creates tight coupling that makes changes risky
- Limits ability to refactor or replace individual components

## What to Do About It

When you see this happening:

1. Ask "What is the single responsibility of this component?"
2. Point out "I notice this class is handling both X and Y. Should we separate these?"
3. Suggest "Can we separate the data access from the business logic here?"
4. Question "What are the natural boundaries between different concerns in this system?"

To prevent it next time:

1. Start with modeling: "Before coding, let's identify the key abstractions and responsibilities."
2. Set architectural patterns: "We'll follow clean architecture with these specific layers..."
3. Define interfaces first: "Let's define the interfaces between components before implementation."
4. Apply SOLID principles: "Each class should have only one reason to change."
5. Visualize architecture: Sketch out the separation of concerns before implementation
6. Separate cross-cutting concerns: "Authentication, logging, etc., should be handled through dedicated mechanisms."

## Example

**AI**: "Here's the UserController class that handles authentication, retrieves user data from the database, formats it for the UI, and logs all activities..."

**You**: "This controller is doing too many things. Let's separate these concerns: authentication should be middleware, data access should be in a repository, formatting in a separate view model or service, and logging through a cross-cutting concern. Can you refactor with these separations?"

## Benefits of Fixing This

- Creates more maintainable and understandable code
- Makes testing easier through properly isolated components
- Allows changing individual parts without affecting others
- Improves reusability of components
- Gives a clearer mental model of the system
- Reduces risk when making changes
- Creates more natural division of work among team members

## Quick Reference: Clean Separation

1. **Presentation Layer**: UI components, controllers, view models
2. **Application Layer**: Use cases, application services, coordination
3. **Domain Layer**: Business logic, entities, domain services
4. **Infrastructure Layer**: Data access, external services, technical implementation

## Warning Signs

- Methods longer than a screen
- Classes with more than one reason to change
- Difficulty writing unit tests
- "God objects" that know too much
- Direct database queries in UI handlers
- Business logic in presentation components
