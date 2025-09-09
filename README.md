# zota

AI-powered spec-driven development assistant that helps structure your workflow through research, tickets, planning, and implementation phases using AI agents.

## Installation

### Prerequisites

- `jq` - Command-line JSON processor (required for settings management)
- `git` - For cloning the repository and version management

### Quick Start

Install zota:

```bash
git clone https://github.com/ataul443/zota.git /tmp/zota-install
cd /tmp/zota-install
chmod +x setup.sh
./setup.sh
cd - && rm -rf /tmp/zota-install
```

Or as a one-liner:

```bash
git clone https://github.com/ataul443/zota.git /tmp/zota-install && cd /tmp/zota-install && chmod +x setup.sh && ./setup.sh && cd - && rm -rf /tmp/zota-install
```

For debugging installation issues, use the debug flag:

```bash
./setup.sh -d
# or
./setup.sh --debug
```

Then initialize in your project:

```bash
zota init
```

## Features

- **Spec-driven Development**: Structure your workflow with research → tickets → plans → implementation
- **AI Agent Integration**: Specialized agents for different development phases
- **Project Registry**: Track and update all zota-enabled projects globally
- **Version Control**: Automatic updates from GitHub with version tracking
- **Context Management**: Separate shared and local context files with proper git handling

## Commands

- `zota init` - Initialize zota in current directory
- `zota new <project>` - Create new project with zota pre-configured
- `zota update [commit/branch]` - Update zota to latest or specific version
- `zota update-projects` - Update all registered projects with latest zota
- `zota list` - List all registered zota projects
- `zota --version` - Show version information

## AI Workflow Commands

Use these commands within your AI assistant:

- `/zota research <query>` - Perform in-depth codebase research
- `/zota ticket <id> <query>` - Create/update tickets
- `/zota plan <id> <query>` - Create/update implementation plans
- `/zota implement <plan_id>` - Execute implementation plans

## Project Structure

When you run `zota init`, it creates:

```
context/
├── plans/              # Shared implementation plans
└── local/              # Local context (gitignored)
    ├── tickets/        # Issue tickets
    ├── research/       # Research documents
    └── plans/          # Local planning documents

.zota/
└── config.yaml         # Project configuration

.claude/
├── zota/
│   ├── instructions/   # Command templates for AI workflows
│   └── scripts/        # Utility scripts (metadata.sh, etc.)
├── commands/
│   └── zota.md        # AI assistant command definitions
├── agents/             # Specialized AI agents
└── settings.local.json # Local settings with required permissions
```

## Supported Coding Agents & IDE

- **Claude Code** - Full support with integrated AI agents and workflow commands

## Development Workflow

1. **Research**: Use `/zota research` to explore and understand your codebase
2. **Ticket**: Create tickets with `/zota ticket` to define work items
3. **Plan**: Build implementation plans with `/zota plan`
4. **Implement**: Execute plans with `/zota implement`

## Updates

Keep zota and all your projects up to date:

```bash
# Update zota itself to latest version
zota update

# Update to a specific commit, branch, or tag
zota update <commit-sha>
zota update <branch-name>
zota update v0.2.0

# Update all registered projects with latest zota version
zota update-projects
```

## Version Management

The zota tool maintains version information at `~/.zota/version.info` and tracks all registered projects in `~/.zota/projects.registry`.

## Files and Directories

### Installation Location

- `~/.zota/` - Main installation directory containing:
  - `zota` - Main executable script
  - `zota.md` - Command documentation for AI assistants
  - `agents/` - AI agent definitions
  - `commands/` - Command instruction templates
  - `scripts/` - Utility scripts
  - `version.info` - Version and commit information
  - `projects.registry` - Registry of all zota-enabled projects

### Project Files

After initialization, each project contains:

- `context/` - Project context files (plans and local data)
- `.zota/config.yaml` - Project-specific configuration
- `.claude/` - Claude Code integration files
