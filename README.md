# AL-Go Per Tenant Extension Template

This template repository can be used for managing Per-tenant Extensions (PTEs) for Business Central.

Please go to https://aka.ms/AL-Go to learn more.

## Demo Goal (CTM Heimspiel)

This repository is configured as a demo sandbox to exercise a broad AL-Go and GitHub Copilot Cloud workflow:

- PR build and CI/CD
- AL code analyzers and GitHub alert tracking
- Incremental and workspace compilation
- Test app build and execution
- Agent-guided review conventions

## Enabled Baseline

The repository currently enables a high-capability baseline in:

- .github/AL-Go-Settings.json
- .AL-Go/settings.json
- .github/CICD.settings.json
- .github/.agents/algo-settings.agent.md

## Quick Test Plan

1. Run workflow: Update AL-Go System Files
2. Run workflow: Pull Request Build (open a small PR against main)
3. Verify build includes apps and test app from configured project folders
4. Verify analyzers are active and warnings are surfaced
5. Verify AL alerts are tracked in GitHub security/code scanning views
6. Run workflow: CI/CD on main to validate full pipeline behavior

## Suggested Demo Scenarios

1. Analyzer signal demo: Introduce a small AL warning and validate failOn behavior
2. Incremental build demo: Change one app file and compare scope vs full build
3. Agentic review demo: Let Copilot review PR changes using repository agent instructions

## Contributing

Please read [this](https://github.com/microsoft/AL-Go/blob/main/Scenarios/Contribute.md) description on how to contribute to AL-Go for GitHub.

We do not accept Pull Requests on the template repository directly.

## Notes

- This is a demo-first setup. For production hardening, tune analyzer strictness, branch policies, and deployment safeguards.
