# Thư Mục Agents

Thư mục này chứa toàn bộ cấu hình Multi-Agent Framework.

## Cấu Trúc

```
.agents/
├── skills/          # 6 pointer-skill (fix_bug, new_feature, quick_fix, refactor, update_docs, new_role)
│   └── <skill>/
│       └── SKILL.md # Trỏ tới workflows/<skill>.md
│
├── workflows/       # Hướng dẫn từng bước theo loại task
│   ├── fix_bug.md
│   ├── new_feature.md
│   ├── quick_fix.md
│   ├── refactor.md
│   ├── update_docs.md
│   └── new_role.md     # Tự tạo role/skill chuyên biệt mới, xem §"Domain Skills" ở root README
│
└── scripts/
    ├── pre_submit_check.sh    # Quality gate — tuỳ biến riêng từng project
    └── generate_repomap.sh    # Quét cấu trúc source — dùng chung mọi project
```

> Các role do `new_role` tạo ra luôn có tên dạng `agent-<domain>/SKILL.md` (vd. `agent-backend/`) — **bắt buộc** có tiền tố `agent-` để không bao giờ trùng tên với 6 skill cốt lõi ở trên (nếu trùng sẽ ghi đè lên symlink dùng chung, hỏng luôn cho mọi project). Đây là **file thật, không symlink** — chỉ áp dụng riêng cho project đó. `new_role` thường tự chạy ngầm qua "Step 0: ROLE CHECK" trong `fix_bug`/`new_feature`/`refactor`, không cần gọi tay.

## Cách Dùng

1. **Cho một loại task cụ thể** → Đọc file tương ứng trong `workflows/`
2. **Cho một skill cụ thể** → Đọc `SKILL.md` trong `skills/<skill>/`
3. **Kiểm tra chất lượng** → Chạy `bash scripts/pre_submit_check.sh`
4. **Quét lại cấu trúc project** → Chạy `bash scripts/generate_repomap.sh`

Mỗi SKILL.md có phần **QUICK REFERENCE** ở đầu file với checklist hành động, phần chi tiết nằm trong mục mở rộng bên dưới.

> **Lưu ý:** `skills/`, `workflows/` và `scripts/generate_repomap.sh` trong thư mục này là bản gốc (canonical) — chúng được symlink vào `~/.claude/skills/` (global, mọi project) và vào từng project đã chạy `init.sh` ở root repo. Sửa ở đây là sửa cho tất cả mọi nơi cùng lúc.
