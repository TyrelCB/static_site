#!/usr/bin/env bash
# Multi-Mode Development Workflow Script
# This script provides a repeatable, interactive workflow for development tasks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Current mode state file
STATE_FILE=".workflow_state"
PLAN_FILE=".workflow_plan.md"

# Function to print colored headers
print_header() {
    local color=$1
    local text=$2
    echo -e "\n${color}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${color}  $text${NC}"
    echo -e "${color}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Function to save current state
save_state() {
    echo "$1" > "$STATE_FILE"
}

# Function to get current state
get_state() {
    if [ -f "$STATE_FILE" ]; then
        cat "$STATE_FILE"
    else
        echo "plan"
    fi
}

# Function to clear workflow state
clear_state() {
    rm -f "$STATE_FILE" "$PLAN_FILE"
}

# PLAN MODE
mode_plan() {
    print_header "$BLUE" "📋 PLAN MODE - Clarify and Design"
    
    echo -e "${CYAN}This mode helps you:${NC}"
    echo "  1. Clarify the task requirements"
    echo "  2. Review existing code and documentation"
    echo "  3. Identify potential challenges"
    echo "  4. Create an implementation plan"
    echo ""
    
    # Create plan template
    cat > "$PLAN_FILE" << 'EOF'
# Development Plan

## Task Description
<!-- Describe what needs to be done -->

## Current State Analysis
<!-- What exists now? What files/code are relevant? -->

## Requirements & Constraints
<!-- What are the requirements? Any constraints or limitations? -->

## Clarifying Questions
<!-- Questions that need answers before proceeding -->
1. 

## Implementation Plan
<!-- Step-by-step plan -->
1. 
2. 
3. 

## Files to Modify/Create
<!-- List of files that will be changed -->
- [ ] 

## Potential Risks/Challenges
<!-- What could go wrong? -->

## Success Criteria
<!-- How do we know it's done and working? -->
- [ ] 

---
**Status:** Draft - Awaiting Review
EOF
    
    echo -e "${GREEN}✓ Created plan template at: $PLAN_FILE${NC}"
    echo -e "\n${YELLOW}Next steps:${NC}"
    echo "  1. Edit $PLAN_FILE with your task details"
    echo "  2. Review and refine the plan"
    echo "  3. Run: ./workflow.sh execute"
    echo ""
    
    save_state "plan"
}

# EXECUTE MODE
mode_execute() {
    print_header "$GREEN" "⚙️  EXECUTE MODE - Implement Changes"
    
    if [ ! -f "$PLAN_FILE" ]; then
        echo -e "${RED}✗ No plan file found. Run './workflow.sh plan' first.${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}Implementation checklist:${NC}"
    echo "  ✓ Follow the approved plan"
    echo "  ✓ Make minimal, surgical changes"
    echo "  ✓ Preserve existing functionality"
    echo "  ✓ Follow project conventions"
    echo ""
    
    echo -e "${YELLOW}Plan summary:${NC}"
    cat "$PLAN_FILE"
    echo ""
    
    read -p "Ready to implement? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Execution cancelled. Refine your plan and try again.${NC}"
        exit 0
    fi
    
    echo -e "\n${GREEN}Proceeding with implementation...${NC}"
    echo -e "${YELLOW}Make your changes, then run: ./workflow.sh debug${NC}\n"
    
    save_state "execute"
}

# DEBUG MODE
mode_debug() {
    print_header "$YELLOW" "🐛 DEBUG MODE - Test and Validate"
    
    current_state=$(get_state)
    if [ "$current_state" != "execute" ] && [ "$current_state" != "debug" ]; then
        echo -e "${RED}✗ Must execute changes before debugging.${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}Testing checklist:${NC}"
    echo "  ⚡ Run linters (if configured)"
    echo "  ⚡ Run test suites (if available)"
    echo "  ⚡ Manual verification"
    echo "  ⚡ Check for errors/warnings"
    echo "  ⚡ Validate edge cases"
    echo ""
    
    # Check for common test/lint commands
    if [ -f "package.json" ]; then
        echo -e "${BLUE}Detected package.json - checking for test scripts...${NC}"
        if grep -q '"test"' package.json; then
            echo -e "${GREEN}Found test script!${NC}"
            read -p "Run 'npm test'? (y/n) " -n 1 -r
            echo
            [[ $REPLY =~ ^[Yy]$ ]] && npm test
        fi
        if grep -q '"lint"' package.json; then
            echo -e "${GREEN}Found lint script!${NC}"
            read -p "Run 'npm run lint'? (y/n) " -n 1 -r
            echo
            [[ $REPLY =~ ^[Yy]$ ]] && npm run lint
        fi
    fi
    
    if [ -f "Makefile" ]; then
        echo -e "${BLUE}Detected Makefile${NC}"
        if grep -q "^test:" Makefile; then
            read -p "Run 'make test'? (y/n) " -n 1 -r
            echo
            [[ $REPLY =~ ^[Yy]$ ]] && make test
        fi
    fi
    
    echo ""
    read -p "All tests passing and changes validated? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Fix issues and run './workflow.sh debug' again.${NC}"
        save_state "debug"
        exit 0
    fi
    
    echo -e "\n${GREEN}✓ Debugging complete!${NC}"
    echo -e "${YELLOW}Next: ./workflow.sh document${NC}\n"
    
    save_state "debug"
}

# DOCUMENT MODE
mode_document() {
    print_header "$MAGENTA" "📝 DOCUMENT MODE - Document and Commit"
    
    current_state=$(get_state)
    if [ "$current_state" != "debug" ] && [ "$current_state" != "document" ]; then
        echo -e "${RED}✗ Must debug before documenting.${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}Documentation checklist:${NC}"
    echo "  📄 Update relevant documentation"
    echo "  💬 Add inline comments if needed"
    echo "  📖 Update README if applicable"
    echo "  ✍️  Write clear commit message"
    echo ""
    
    # Show git status
    echo -e "${BLUE}Current git status:${NC}"
    git status --short
    echo ""
    
    # Check for modified files
    if [ -z "$(git status --porcelain)" ]; then
        echo -e "${YELLOW}No changes to commit.${NC}"
        save_state "complete"
        exit 0
    fi
    
    # Documentation updates
    read -p "Have you updated all relevant documentation? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Update documentation first, then run './workflow.sh document' again.${NC}"
        exit 0
    fi
    
    # Commit message
    echo -e "\n${CYAN}Enter commit message (or 'skip' to abort):${NC}"
    read -r commit_message
    
    if [ "$commit_message" = "skip" ]; then
        echo -e "${YELLOW}Commit skipped.${NC}"
        exit 0
    fi
    
    if [ -z "$commit_message" ]; then
        echo -e "${RED}✗ Commit message cannot be empty.${NC}"
        exit 1
    fi
    
    # Add and commit
    echo -e "\n${BLUE}Adding changes...${NC}"
    git add -A
    
    echo -e "${BLUE}Committing...${NC}"
    git commit -m "$commit_message"
    
    # Push
    read -p "Push to remote? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Pushing...${NC}"
        git push
        echo -e "\n${GREEN}✓ Changes pushed to remote!${NC}"
    fi
    
    # Summary
    print_header "$GREEN" "✅ WORKFLOW COMPLETE"
    echo -e "${CYAN}Summary:${NC}"
    echo "  • Plan created and reviewed"
    echo "  • Changes implemented"
    echo "  • Tests validated"
    echo "  • Documentation updated"
    echo "  • Changes committed and pushed"
    echo ""
    
    # Cleanup
    clear_state
    echo -e "${GREEN}Workflow state cleared. Ready for next task!${NC}\n"
}

# Main script
main() {
    case "${1:-help}" in
        plan)
            mode_plan
            ;;
        execute)
            mode_execute
            ;;
        debug)
            mode_debug
            ;;
        document)
            mode_document
            ;;
        reset)
            clear_state
            echo -e "${GREEN}✓ Workflow state cleared.${NC}"
            ;;
        status)
            current=$(get_state)
            echo -e "${CYAN}Current mode: ${GREEN}$current${NC}"
            if [ -f "$PLAN_FILE" ]; then
                echo -e "${CYAN}Plan file exists: ${GREEN}$PLAN_FILE${NC}"
            fi
            ;;
        help|*)
            print_header "$CYAN" "Multi-Mode Development Workflow"
            echo "Usage: ./workflow.sh [mode]"
            echo ""
            echo "Modes (run in order):"
            echo "  ${BLUE}plan${NC}      - Create implementation plan"
            echo "  ${GREEN}execute${NC}   - Implement the plan"
            echo "  ${YELLOW}debug${NC}     - Test and validate changes"
            echo "  ${MAGENTA}document${NC}  - Update docs and commit"
            echo ""
            echo "Utilities:"
            echo "  status    - Show current workflow state"
            echo "  reset     - Clear workflow state"
            echo "  help      - Show this help"
            echo ""
            echo "Example workflow:"
            echo "  ./workflow.sh plan"
            echo "  # Edit .workflow_plan.md"
            echo "  ./workflow.sh execute"
            echo "  # Make your code changes"
            echo "  ./workflow.sh debug"
            echo "  ./workflow.sh document"
            echo ""
            ;;
    esac
}

main "$@"
