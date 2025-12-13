# Development Workflow Guide

This repository includes a repeatable 4-phase development workflow to ensure consistent, quality code changes.

## Quick Start

```bash
# Start a new task
./workflow.sh plan

# Edit .workflow_plan.md with your task details

# Implement your changes
./workflow.sh execute

# Make your code changes...

# Test and validate
./workflow.sh debug

# Document and commit
./workflow.sh document
```

## Workflow Phases

### 1️⃣ Plan Mode (`./workflow.sh plan`)
- Creates a structured plan template (`.workflow_plan.md`)
- Define task requirements and scope
- Identify files to change
- List potential risks
- Set success criteria

**Template sections:**
- Task Description
- Current State Analysis
- Requirements & Constraints
- Clarifying Questions
- Implementation Plan
- Files to Modify/Create
- Potential Risks/Challenges
- Success Criteria

### 2️⃣ Execute Mode (`./workflow.sh execute`)
- Reviews your plan
- Confirms you're ready to implement
- Guides implementation best practices
- Tracks execution state

**Best practices:**
- Make minimal, surgical changes
- Follow existing code patterns
- Preserve working functionality
- One logical change at a time

### 3️⃣ Debug Mode (`./workflow.sh debug`)
- Automatically detects and runs available tests
- Checks for linters (npm, make, etc.)
- Validates changes work as expected
- Confirms all tests pass

**Automatic detection:**
- `package.json` → runs `npm test` / `npm run lint`
- `Makefile` → runs `make test`
- Manual validation prompts

### 4️⃣ Document Mode (`./workflow.sh document`)
- Shows git status
- Prompts for documentation updates
- Creates meaningful commit messages
- Commits and pushes changes
- Cleans up workflow state

**Includes:**
- Documentation checklist
- Git add/commit/push automation
- Workflow completion summary

## Utility Commands

```bash
# Check current workflow state
./workflow.sh status

# Reset workflow (start over)
./workflow.sh reset

# Show help
./workflow.sh help
```

## Features

✅ **Enforced Workflow** - Can't skip phases  
✅ **State Tracking** - Remembers where you are  
✅ **Auto-Detection** - Finds and runs your tests/linters  
✅ **Interactive** - Prompts for confirmation  
✅ **Colorized Output** - Easy to read status  
✅ **Reusable** - Same process every time  

## Example Session

```bash
$ ./workflow.sh plan
📋 PLAN MODE - Clarify and Design
✓ Created plan template at: .workflow_plan.md

$ vim .workflow_plan.md  # Edit your plan

$ ./workflow.sh execute
⚙️  EXECUTE MODE - Implement Changes
Ready to implement? (y/n) y

$ # Make your code changes...

$ ./workflow.sh debug
🐛 DEBUG MODE - Test and Validate
Found test script!
Run 'npm test'? (y/n) y
✓ All tests passing!

$ ./workflow.sh document
📝 DOCUMENT MODE - Document and Commit
Enter commit message: Add new feature X
✓ Changes committed and pushed!
✅ WORKFLOW COMPLETE
```

## Benefits

- **Consistency** - Same process for every task
- **Quality** - Forces planning, testing, and documentation
- **Traceability** - Clear commit messages and documentation
- **Safety** - Validation before committing
- **Efficiency** - Automated test/lint detection

## Files Created

- `.workflow_state` - Current workflow phase (auto-managed)
- `.workflow_plan.md` - Your implementation plan (edit this)

Both files are cleaned up after successful completion.

## Integration with Git

The workflow integrates with your git workflow:
- Shows `git status` before committing
- Prompts for documentation updates
- Creates descriptive commit messages
- Optional push to remote

Add to `.gitignore`:
```
.workflow_state
.workflow_plan.md
```

---

**Start your next task:** `./workflow.sh plan`
