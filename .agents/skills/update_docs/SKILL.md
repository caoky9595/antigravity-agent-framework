---
name: update_docs
description: Quy trình đồng bộ tài liệu kiến trúc (docs-as-code). Dùng khi cần cập nhật tài liệu cho khớp với code thực tế.
---
# Update Docs Workflow

**MỆNH LỆNH BẮT BUỘC:**
Hành động ĐẦU TIÊN của bạn là chạy đúng lệnh shell sau (không dùng tool đọc file khác), rồi thực hiện chính xác các bước trong nội dung nó in ra:

```
test -f .agents/workflows/update_docs.md && cat .agents/workflows/update_docs.md || cat ~/.antigravity-agent-framework/.agents/workflows/update_docs.md
```

Lệnh này ưu tiên bản workflow của project hiện tại (nếu đã chạy `init.sh`); nếu chưa, nó tự động lấy bản trong framework repo qua symlink toàn cục `~/.antigravity-agent-framework`.
