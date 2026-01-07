# LLM Safety Filter – TerminalBench Sample Task

This repository contains a TerminalBench-style CLI task that simulates
a post-processing safety filter for LLM-generated outputs.

## Task Overview

The task processes stored LLM output and applies a YAML-based blocked-term
policy to:
- Sanitize unsafe content
- Determine safety status (safe / unsafe)
- Append an audit log entry with derived metadata

The task is fully deterministic and designed to evaluate multi-step
reasoning in a controlled CLI environment.

## Key Features

- LLM-relevant safety filtering logic
- YAML-based policy configuration
- Multi-step file processing
- Append-only audit logging (anti-cheat)
- Derived consistency checks in tests
- Fully reproducible Docker environment

## How to Run

```bash
docker compose -f dockercompose.yaml up --build
