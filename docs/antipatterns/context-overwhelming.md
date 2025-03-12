# Context Overwhelming

When humans provide excessive information to AI coding agents, overwhelming their context window with irrelevant details. Instead of focusing the agent on the specific task, they flood it with large codebases, excessive documentation, or tangential information that reduces effectiveness.

## How to Spot It

Look for these signs:

- Pasting entire files instead of relevant snippets
- Sharing multiple files when only one is needed for the task
- Including detailed documentation unrelated to the current issue
- Providing lengthy logs or error messages without filtering
- Filling context with repository structure explanations
- Continuously adding more context without curating previous information
- Agent responses indicating confusion about priorities or task scope

## Why It's Harmful

- Wastes tokens on irrelevant information
- Forces the agent to spend time processing unnecessary context
- Pushes relevant information out of the context window
- Reduces focus on the actual problem to solve
- Creates confusion about which parts are important
- Leads to solutions addressing the wrong aspects of the problem
- Increases likelihood of context truncation during processing

## What to Do About It

When you see this happening:

1. Say "Let's focus only on the specific code that relates to this issue."
2. Ask "What's the minimal context needed for this particular task?"
3. Suggest "Let's start fresh with just the essential information."
4. Provide guidance: "Focus only on the authentication flow; we can ignore the UI components for now."

To prevent it next time:

1. Create context compression tools that extract only relevant code
2. Establish a "minimal viable context" principle for each task type
3. Implement context curators that filter and prioritize information
4. Use project-specific templates that guide context sharing
5. Train team members on effective context scoping

## Example

**Human**: "Here's our entire codebase with 50 files. I need you to fix a bug in the login form validation."

**You**: "Let's focus specifically on the login form component and the validation logic. Could you share just those files rather than the entire codebase? This will help us address the issue more effectively."

## Benefits of Fixing This

- More focused and accurate solutions
- Faster response times
- Better use of token allocations
- Clearer understanding of the actual problem
- Increased agent productivity
- Less context getting pushed out of the window
- More memory available for complex reasoning
