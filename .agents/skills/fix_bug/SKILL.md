---
name: fix_bug
description: Quy trình sửa bug theo 5 bước. Dùng khi cần fix bug bất kỳ.
---
# Fix Bug Workflow

**MỆNH LỆNH BẮT BUỘC:**
Hành động ĐẦU TIÊN của bạn là chạy đúng lệnh shell sau (không dùng tool đọc file khác), rồi thực hiện chính xác các bước trong nội dung nó in ra:

```
test -f .agents/workflows/fix_bug.md && cat .agents/workflows/fix_bug.md || cat ~/.antigravity-agent-framework/.agents/workflows/fix_bug.md
```

Lệnh này ưu tiên bản workflow của project hiện tại (nếu đã chạy `init.sh`); nếu chưa, nó tự động lấy bản trong framework repo qua symlink toàn cục `~/.antigravity-agent-framework`.
