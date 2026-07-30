---
name: quick_fix
description: Quy trình sửa nhỏ nhanh gọn. Dùng cho typos, config, minor adjustments.
---
# Quick Fix Workflow

**MỆNH LỆNH BẮT BUỘC:**
Hành động ĐẦU TIÊN của bạn là chạy đúng lệnh shell sau (không dùng tool đọc file khác), rồi thực hiện chính xác các bước trong nội dung nó in ra:

```
test -f .agents/workflows/quick_fix.md && cat .agents/workflows/quick_fix.md || cat ~/.antigravity-agent-framework/.agents/workflows/quick_fix.md
```

Lệnh này ưu tiên bản workflow của project hiện tại (nếu đã chạy `init.sh`); nếu chưa, nó tự động lấy bản trong framework repo qua symlink toàn cục `~/.antigravity-agent-framework`.
