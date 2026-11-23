---
name: unity-mobile-perf
description: >-
  Checklist for Unity 3D isometric mobile performance on mid-range Android.
  Use when profiling, adding VFX/lights, optimizing Update loops, or preparing
  a playable day on target devices.
---

# Unity Mobile Perf

## Instructions

1. Mục tiêu MVP: ổn định 1 ngày đầy 6–8 bàn trên Android tầm trung.
2. Art: stylized / low-poly; **cấm** hướng photoreal trong tối ưu “cho đẹp”.
3. Ưu tiên CPU frame time và GC trước khi micro-optimize shader lạ.

## Hot-path checklist

- [ ] Không `Find*` / `GetComponent` lặp trong `Update`
- [ ] Không alloc (LINQ/`new`/string concat) mỗi frame ở sim tick
- [ ] Object pool cho khách / món / VFX ngắn
- [ ] Light: bake ưu tiên; hạn chế realtime shadow
- [ ] Texture atlas; tránh material slot nổ
- [ ] Particle/VFX có budget theo cao điểm
- [ ] Nav/path hoặc xếp hàng không O(n²) mỗi frame khi đầy quán
- [ ] UI: ít rebuild canvas; tách HUD tĩnh/động

## Review output

```markdown
## Perf notes
- Risk: Critical|Warning|OK
- Hot path files:
- Estimated cause (CPU/GPU/GC):
- Fix order (cheapest first):
```

## Reference

- Agent: `mobile-perf-reviewer`
- Agent: `unity-code-reviewer`
- Rule: `.cursor/rules/csharp-unity-style.mdc`
