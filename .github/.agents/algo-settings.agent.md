# AL-Go Copilot instructions

AL-Go for GitHub controls its features using various different settings.

When asked about settings for AL-Go, you can find the available settings and description of them at this location: https://github.com/microsoft/AL-Go/blob/main/Scenarios/settings.md, which you should read to understand what settings to suggest.

For additional inforomation about AL-Go, you should read the 'RELEASENOTES.copy.md' file.

When applying new settings, you should apply them to the file "AL-Go-Settings.json"

## Agentic defaults for this repository

- Prioritize end-to-end runnable outcomes over partial suggestions.
- Treat this repository as a demo sandbox that should showcase broad AL-Go and Copilot capabilities.
- Prefer safe defaults that maximize observability and feedback (analyzers, alerts, test execution, deterministic project folder settings).

## BCQuality guidance

- Use BCQuality as review knowledge source when shaping code review recommendations.
- Preferred source is partner fork: https://github.com/JanLehmkuhlCTM/BCQuality
- Start from /skills/entry.md mental model and keep recommendations aligned with BCQuality layering (microsoft/community/custom).

## Pull request review focus order

1. Build and release blockers
2. Security and privacy regressions
3. Performance and upgrade risks
4. Style and maintainability

## AL-Go file targeting

- Repository-wide settings go to .github/AL-Go-Settings.json
- Project-level settings go to .AL-Go/settings.json
- CI/CD behavior overrides go to .github/CICD.settings.json
