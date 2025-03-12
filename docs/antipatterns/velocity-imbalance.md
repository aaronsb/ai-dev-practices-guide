# Velocity Imbalance

When AI agents generate code at a pace that far exceeds the team's capacity to review, test, and integrate it. This creates a bottleneck where the volume of AI-generated code overwhelms the human-driven processes meant to ensure quality, leading to reduced scrutiny, integration delays, or bypassed review processes.

## How to Spot It

Look for these signs:

- Large backlogs of AI-generated code awaiting review
- Decreasing thoroughness of code reviews as volume increases
- Extending deadlines due to integration bottlenecks
- Team members expressing frustration with review workload
- Increasing time between code generation and deployment
- Pressure to approve changes without adequate review
- Rise in post-integration issues and bug reports

## Why It's Harmful

- Quality suffers when reviews become cursory
- Creates pressure to rush or skip proper validation
- May lead to integration of untested or under-reviewed code
- Demoralizes team members with overwhelming review queues
- Makes tracking the state of the project difficult
- Disrupts planning and velocity predictions
- May lead to rushed deployments or feature releases

## What to Do About It

When you see this happening:

1. Say "Let's slow down and ensure we can properly review what we've created."
2. Suggest "Instead of generating more code, let's focus on integrating what we have."
3. Ask "What's our current review capacity and how should we pace our development?"
4. Establish "Let's create smaller, focused changes that are easier to review."

To prevent it next time:

1. Implement "velocity governor" tools that match AI output to team capacity
2. Create review complexity estimators to better distribute review workload
3. Develop progressive enhancement patterns for features
4. Establish clear priorities for which components to develop first
5. Build batch size limiters that restrict the amount of pending changes

## Example

**Human**: "Can you implement these five new features for our application?"

**AI**: "Rather than implementing all five features at once, which would create a large review burden, let's prioritize them and tackle them sequentially. Which feature would provide the most value to start with? We can implement that one with thorough testing and documentation, get it through review and integration, and then proceed to the next one."

## Benefits of Fixing This

- Better quality through thorough reviews
- More sustainable development pace
- Improved team morale and reduced burnout
- Clearer project status and progress tracking
- Better alignment between generation and integration 
- More predictable feature delivery
- Reduced risk of quality issues in production

## Implementing Velocity Management

### Production Capacity Analysis

Create a tool to analyze the team's review and integration capacity:

```bash
#!/bin/bash
# analyze-velocity.sh

# Analyze recent PR review velocity
recent_days=30
avg_review_time=$(gh pr list --state closed --limit 100 --json closedAt,createdAt \
  | jq -r 'map((.closedAt | fromdateiso8601) - (.createdAt | fromdateiso8601)) | add/length/86400' \
  | awk '{printf "%.1f", $1}')

avg_pr_size=$(git log --since="${recent_days} days ago" --numstat \
  | awk '/^[0-9]+\s+[0-9]+\s+/ {plus+=$1; minus+=$2} END {print plus+minus}' \
  | awk -v count="$(git log --since="${recent_days} days ago" --format="%H" | wc -l)" '{printf "%.0f", $1/count}')

daily_throughput=$(git log --since="${recent_days} days ago" --numstat \
  | awk '/^[0-9]+\s+[0-9]+\s+/ {plus+=$1; minus+=$2} END {print plus+minus}' \
  | awk -v days="$recent_days" '{printf "%.0f", $1/days}')

echo "Team Velocity Analysis:"
echo "======================="
echo "Average review time: ${avg_review_time} days"
echo "Average commit size: ${avg_pr_size} lines"
echo "Daily code throughput: ${daily_throughput} lines"
echo ""
echo "Recommendations:"
echo "---------------"
echo "Maximum new PR size: $((avg_pr_size * 2)) lines"
echo "Maximum WIP code: $((daily_throughput * 3)) lines"
echo "Target PR count: $((daily_throughput / avg_pr_size * avg_review_time)) PRs"
```

### AI Output Governor

Create a mechanism to limit AI output based on team capacity:

```typescript
// velocity-governor.ts
export class VelocityGovernor {
  private pendingReviewLines: number = 0;
  private readonly capacityConfig: CapacityConfig;
  
  constructor(configPath: string) {
    this.capacityConfig = this.loadConfig(configPath);
    this.syncWithCurrentState();
  }
  
  canGenerateMore(estimatedLines: number): boolean {
    return (this.pendingReviewLines + estimatedLines) <= this.capacityConfig.maxPendingLines;
  }
  
  registerGeneratedCode(filePath: string, lineCount: number): void {
    this.pendingReviewLines += lineCount;
    this.persistState();
  }
  
  registerCompletedReview(filePath: string): void {
    // Get the line count of the file
    const lineCount = this.getFileLineCount(filePath);
    this.pendingReviewLines -= lineCount;
    this.persistState();
  }
  
  getCurrentUtilization(): UtilizationStats {
    return {
      pendingLines: this.pendingReviewLines,
      capacityLimit: this.capacityConfig.maxPendingLines,
      utilizationPercentage: (this.pendingReviewLines / this.capacityConfig.maxPendingLines) * 100,
      estimatedClearTime: this.pendingReviewLines / this.capacityConfig.dailyThroughput
    };
  }
  
  private syncWithCurrentState(): void {
    // Calculate pending lines from current PRs
    this.pendingReviewLines = this.calculatePendingReviewLines();
  }
  
  private persistState(): void {
    // Save current state to file
    fs.writeFileSync(
      '.velocity-state.json', 
      JSON.stringify({ pendingReviewLines: this.pendingReviewLines })
    );
  }
  
  private loadConfig(path: string): CapacityConfig {
    // Load team capacity configuration
    const config = JSON.parse(fs.readFileSync(path, 'utf8'));
    return config;
  }
  
  private calculatePendingReviewLines(): number {
    // Implementation to calculate lines of code in PRs
  }
  
  private getFileLineCount(filePath: string): number {
    // Implementation to count lines in a file
  }
}
```

### Integration in CI/CD Pipeline

Add checks to prevent PR overload:

```yaml
# .github/workflows/velocity-check.yml
name: Velocity Check

on:
  pull_request:
    types: [opened, synchronize]
    
jobs:
  check-velocity:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Check team capacity
        run: |
          ./analyze-velocity.sh > velocity.txt
          
          # Get number of open PRs
          OPEN_PRS=$(gh pr list --json number | jq length)
          
          # Get maximum recommended PRs
          MAX_PRS=$(grep "Target PR count" velocity.txt | awk '{print $NF}')
          
          # Check if we're over capacity
          if (( OPEN_PRS > MAX_PRS )); then
            echo "::warning::Team is over review capacity with $OPEN_PRS open PRs (recommended max: $MAX_PRS)"
            echo "Consider waiting for existing PRs to be merged before creating new ones."
          fi
          
          # Check PR size
          PR_ADDITIONS=$(gh pr view ${{ github.event.pull_request.number }} --json additions --jq .additions)
          PR_DELETIONS=$(gh pr view ${{ github.event.pull_request.number }} --json deletions --jq .deletions)
          PR_SIZE=$((PR_ADDITIONS + PR_DELETIONS))
          
          MAX_SIZE=$(grep "Maximum new PR size" velocity.txt | awk '{print $NF}')
          
          if (( PR_SIZE > MAX_SIZE )); then
            echo "::warning::PR is larger than recommended size ($PR_SIZE lines, recommended max: $MAX_SIZE)"
            echo "Consider breaking this PR into smaller, more focused changes."
          fi
```

### Include in .clinerules

Add velocity management to your `.clinerules` file:

```yaml
tooling:
  velocity_management:
    command: ./analyze-velocity.sh
    description: "Check team capacity and review velocity"
    when:
      - "Before starting a new feature"
      - "When planning work"
      - "Before creating large PRs"
      - "When prioritizing tasks"
    examples:
      - "./analyze-velocity.sh"

workflows:
  new_feature:
    steps:
      - "Check team velocity and capacity"
      - "Prioritize based on current workload"
      - "Size implementation appropriately"
      - "Break down large features"
    tools:
      - velocity_management
      - git_workflow
```

By implementing these patterns, teams can maintain a healthy balance between AI-powered code generation and human-driven quality processes.
