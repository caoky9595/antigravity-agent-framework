# Thư Mục Agents

Thư mục này chứa toàn bộ cấu hình Multi-Agent Framework.

## Cấu Trúc

```
.agents/
├── skills/          # Định nghĩa 9 vai trò
│   └── <role>/
│       └── SKILL.md # Quick Reference + Chi tiết
│
├── workflows/       # Hướng dẫn từng bước theo loại task
│   ├── fix_bug.md
│   ├── new_feature.md
│   ├── quick_fix.md
│   └── refactor.md
│
└── scripts/         # Công cụ kiểm tra tự động
    └── pre_submit_check.sh
```

## Cách Dùng

1. **Cho một loại task cụ thể** → Đọc file tương ứng trong `workflows/`
2. **Cho một vai trò cụ thể** → Đọc `SKILL.md` trong `skills/<role>/`
3. **Kiểm tra chất lượng** → Chạy `bash scripts/pre_submit_check.sh`

Mỗi SKILL.md có phần **QUICK REFERENCE** ở đầu file với checklist hành động, phần chi tiết nằm trong mục mở rộng bên dưới.
