# zota

AI development assistant for spec-driven development. Helps structure your workflow through research, tickets, planning, and implementation phases using AI agents.



## Initial Setup:

When this command is WITHOUT ANY ARGUMENTS, respond with:

```
I'm Zota, your development buddy. Below are the list of commands I can perform:

- /zota research <query>
    - Use it to perform an in-depth research on the codebase. It will create a research plan in the context/local/research/ folder.
- /zota ticket <ticket_id> <query>
    - Use it to create/update a ticket. It will create/update it in the context/local/tickets/ folder.
- /zota plan <ticket_id> <query>
    - Use it to create/update a plan. It will create/update it in the context/local/plans/ folder.
- /zota implement <plan_id>
    - It will implement the plan.

```

## Steps to follow after receiving the sub command:

We have defined specifc instructions for each sub command.
Below are the path to the instructions for each sub command:

- /zota research: `.claude/zota/instructions/research.md`
- /zota ticket: `.claude/zota/instructions/ticket.md`
- /zota plan: `.claude/zota/instructions/plan.md`
- /zota implement: `.claude/zota/instructions/implement.md`

**Note: Please follow the instructions carefully and strictly.**

## Example Interaction Flow

```
User: /zota research
Assistant: I'll help you perform an in-depth research on the codebase. Please provide your research question or area of interest, and I'll analyze it thoroughly by exploring relevant components and connections.

User: I want to research about the ticket_1234
Assistant: Let me read that ticket file completely first...

[Reads file fully]

Assistant: Based on the ticket, I understand we need to research about the ticket_1234. I'll create a research plan in the context/{username}/research/ folder.
```