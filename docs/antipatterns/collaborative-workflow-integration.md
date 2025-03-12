# Collaborative Workflow Integration

When AI agents fail to integrate with the team's collaborative workflow and version control practices. Instead of respecting the social contract between developers, the agent generates code without consideration for branching strategies, commit conventions, pull request workflows, or the pace of integration.

## How to Spot It

Look for these signs:

- Generating large volumes of code without a clear integration strategy
- Ignoring branch naming conventions or branching strategies
- Creating sweeping changes across multiple components simultaneously
- Disregarding established commit message conventions
- Proposing changes without consideration for ongoing work
- Overlooking code review processes and expectations
- Failing to consider the team's velocity and integration capacity

## Why It's Harmful

- Creates merge conflicts and integration challenges
- Overwhelms code review processes with too much code
- Disrupts team coordination and planning
- Makes change history difficult to track and understand
- Reduces visibility into the purpose and context of changes
- Increases the risk of breaking existing functionality
- Leads to solution sprawl that's difficult to test and validate

## What to Do About It

When you see this happening:

1. Say "Let's consider how this fits into our team's workflow and branching strategy."
2. Ask "How should we break this down into manageable, reviewable commits?"
3. Clarify: "Our team uses this specific git workflow—let's plan how these changes align with it."
4. Suggest: "We should coordinate this with other ongoing work on related components."

To prevent it next time:

1. Create git workflow guides specific to your team's practices
2. Implement commit message validators that enforce conventions
3. Build branch naming and structure tools
4. Develop change size estimators that suggest appropriate scoping
5. Add PR preparation tools that organize changes for effective review

## Example

**AI**: "Here's a complete implementation that refactors the authentication system, user profile management, and database schema."

**You**: "This is valuable work, but we need to break it down into manageable pieces that align with our git workflow. Let's create a feature branch for authentication changes first, following our branching convention of 'feature/auth-refactor', and prepare a focused PR that our team can review effectively. Then we can address the other components as separate PRs."

## Benefits of Fixing This

- Smoother integration of AI-generated code
- Respect for the team's social contract and workflow
- Better alignment with review capacity and processes
- Clearer change history and commit messages
- Reduced risk of breaking changes or conflicts
- More effective collaboration between AI and human developers
- Sustainable pace of code integration

## Implementing AI-Aware Git Workflows

### Git Tool Integration

Create wrappers for common git operations that provide AI agents with project-specific context:

```bash
#!/bin/bash
# ai-git-helper.sh

action=$1
shift

case $action in
  "branch-for")
    # Suggest appropriate branch name for a feature
    feature_description=$1
    convention=$(cat .git-conventions.json | jq -r '.branchNaming')
    echo "Suggested branch name: $(./format-branch-name.sh "$convention" "$feature_description")"
    ;;
    
  "commit-scope")
    # List valid commit scopes for the project
    cat .git-conventions.json | jq -r '.commitScopes[]'
    ;;
    
  "prepare-pr")
    # Structure changes for a PR
    branch_name=$(git rev-parse --abbrev-ref HEAD)
    template=$(cat .github/PULL_REQUEST_TEMPLATE.md)
    echo "PR Title: $(./suggest-pr-title.sh "$branch_name")"
    echo "PR Template: $template"
    ;;
    
  "team-velocity")
    # Show team's recent integration velocity
    ./analyze-velocity.sh
    ;;
    
  "change-impact")
    # Analyze impact of changes in specified files
    ./analyze-change-impact.sh $@
    ;;
    
  *)
    echo "Unknown action: $action"
    exit 1
    ;;
esac
```

### .git-conventions.json

Create a structured representation of your team's git conventions:

```json
{
  "branchNaming": {
    "feature": "feature/{kebab-case-description}",
    "bugfix": "bugfix/{issue-number}-{kebab-case-description}",
    "hotfix": "hotfix/{kebab-case-description}",
    "release": "release/{semver-version}"
  },
  "commitMessage": {
    "format": "{scope}: {type}({optional-ticket}) {imperative-description}",
    "examples": [
      "feat(auth): add multi-factor authentication",
      "fix(JIRA-123): resolve user session timeout issue",
      "chore: update dependencies to latest versions"
    ]
  },
  "commitScopes": [
    "auth", "api", "ui", "db", "config", "docs", "tests", "ci", "deps"
  ],
  "commitTypes": [
    "feat", "fix", "docs", "style", "refactor", "test", "chore", "revert"
  ],
  "prWorkflow": {
    "requiredApprovals": 2,
    "targetReviewTimeHours": 24,
    "maxLinesPerPR": 500,
    "requiredChecks": ["lint", "build", "test"]
  }
}
```

### GitHub CLI Integration

For GitHub-based projects, create AI-friendly GitHub CLI wrappers:

```bash
#!/bin/bash
# ai-gh-helper.sh

action=$1
shift

case $action in
  "list-issues")
    # List open issues with labels and assignees
    gh issue list --state open --limit 50 --json number,title,labels,assignees \
      | jq 'map({number, title, labels: [.labels[].name], assignees: [.assignees[].login]})'
    ;;
    
  "suggest-issue")
    # Suggest issues related to a specific component
    component=$1
    gh issue list --state open --label "$component" --json number,title,labels \
      | jq 'map({number, title, labels: [.labels[].name]})'
    ;;
    
  "pr-status")
    # Show status of PRs and reviews
    gh pr list --state open --json number,title,author,reviewRequests,reviews \
      | jq 'map({number, title, author: .author.login, reviewers: [.reviewRequests[].login], reviewStatus: [.reviews[].state]})'
    ;;
    
  "create-pr")
    # Create a PR with proper formatting
    title=$1
    body=$2
    gh pr create --title "$title" --body "$body"
    ;;
    
  *)
    echo "Unknown action: $action"
    exit 1
    ;;
esac
```

## Guidance in .clinerules

Add a git workflow section to your `.clinerules` file:

```yaml
tooling:
  # Git workflow tools
  git_workflow:
    command: ./ai-git-helper.sh
    description: "Work with team's git conventions and workflow"
    when:
      - "Starting a new feature or task"
      - "Preparing code for review"
      - "Creating commits"
      - "Evaluating change impact"
    examples:
      - "./ai-git-helper.sh branch-for 'add user authentication'"
      - "./ai-git-helper.sh commit-scope"
      - "./ai-git-helper.sh prepare-pr"
      - "./ai-git-helper.sh team-velocity"

  github_workflow:
    command: ./ai-gh-helper.sh
    description: "Work with GitHub issues, PRs, and reviews"
    when:
      - "Finding suitable tasks"
      - "Creating or updating PRs"
      - "Checking review status"
    examples:
      - "./ai-gh-helper.sh list-issues"
      - "./ai-gh-helper.sh suggest-issue auth"
      - "./ai-gh-helper.sh pr-status"

workflows:
  new_feature:
    steps:
      - "Identify appropriate issue"
      - "Create feature branch using conventions"
      - "Break implementation into manageable commits"
      - "Ensure tests and documentation"
      - "Prepare PR with appropriate scope"
    tools:
      - github_workflow
      - git_workflow
      - static_analysis
      - build
```

By implementing these tools and conventions, AI agents can become better team players that work harmoniously with established development practices.
