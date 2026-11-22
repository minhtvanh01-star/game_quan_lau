---
name: pre-push-checklist
description: >-
  Enforces format, tests, secret scan, and MVP scope before git push or PR.
  Use when the user asks to push, open a PR, prepare a release branch, or
  finish a feature for team review.
---

# Pre-Push Checklist

## Instructions

1. Chạy: `pwsh ./scripts/pre-push-check.ps1`
2. Nếu fail → sửa rồi chạy lại; **không** push khi fail.
3. Tự kiểm thêm:
   - [ ] Diff không chứa secret
   - [ ] `*.cs` đã format theo `.editorconfig`
   - [ ] Test liên quan pass (hoặc ghi rõ Unity chưa sẵn sàng)
   - [ ] Không mở P2 ngoài change request
   - [ ] Commit message Conventional Commits
4. Chỉ `git push` khi user yêu cầu tường minh.

## Agent report format

```markdown
## Pre-push report
- Script: pass|fail
- Format: pass|skip|fail
- Tests: pass|skip|fail
- Secrets: pass|fail
- Scope: pass|fail
- Ready to push: yes|no
```
