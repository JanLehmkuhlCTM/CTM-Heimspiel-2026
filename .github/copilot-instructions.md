# CTM Heimspiel Copilot Instructions

This repository is a demo environment to showcase agentic Business Central development with AL-Go.

## Primary objective

Maximize useful, testable automation in pull requests and CI/CD while keeping output understandable for live demos.

## Behavior expectations

- Prefer actionable repository changes over abstract recommendations.
- Keep changes small, reversible, and easy to validate in workflows.
- Always include validation steps for any settings or code changes.

## AL and AL-Go focus

- Respect AL-Go settings precedence and file locations.
- Keep app and test app folder settings explicit.
- Favor build feedback loops that surface analyzer output early.

## Review priorities

1. Build and deployment blockers
2. Security and privacy issues
3. Performance and upgrade risks
4. Maintainability and style

## BCQuality alignment

When generating review findings or coding guidance, align with BCQuality patterns and terminology.
Preferred source for this repository is:

https://github.com/JanLehmkuhlCTM/BCQuality

Use the entry-point mental model:

- skills/entry.md for dispatch
- knowledge relevance by context
- findings with clear rationale and references

## Output style

- Be concise and practical.
- Propose exact files to change where possible.
- For demo workflows, provide a short runbook with expected outcomes.
