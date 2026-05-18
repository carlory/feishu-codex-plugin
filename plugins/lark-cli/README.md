# Lark CLI Codex Plugin

This Codex plugin wraps the official [larksuite/cli](https://github.com/larksuite/cli) project for use from Codex marketplace.

The plugin does not vendor or fork the CLI binary. It packages the upstream AI Agent Skills under `skills/` and lets Codex use the official `lark-cli` command.

## First Use

Install the upstream CLI:

```bash
npx @larksuite/cli@latest install
```

Then initialize and authenticate:

```bash
lark-cli config init --new
lark-cli auth login --recommend
lark-cli auth status
```

Some setup and login commands print browser verification URLs. Codex should forward those URLs to the user exactly as returned by the CLI.

## Updating Skills

The `skills/` directory is mirrored from:

https://github.com/larksuite/cli/tree/main/skills

Do not hand-edit files under `skills/`. Run:

```bash
./scripts/sync-upstream-skills.sh main
```

GitHub Actions also runs this sync weekly and can open a PR when upstream changes.
