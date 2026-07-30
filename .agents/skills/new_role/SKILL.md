---
name: new_role
description: Tự động tạo role/skill chuyên biệt (vd. Backend Engineer, Database Architect) dựa trên stack thực tế của project. Dùng khi cần thêm persona mới vào .agents/skills/.
---
# New Role Workflow

**MỆNH LỆNH BẮT BUỘC:**
Hành động ĐẦU TIÊN của bạn là chạy đúng lệnh shell sau (không dùng tool đọc file khác), rồi thực hiện chính xác các bước trong nội dung nó in ra:

```
test -f .agents/workflows/new_role.md && cat .agents/workflows/new_role.md || cat ~/.antigravity-agent-framework/.agents/workflows/new_role.md
```

Lệnh này ưu tiên bản workflow của project hiện tại (nếu đã chạy `init.sh`); nếu chưa, nó tự động lấy bản trong framework repo qua symlink toàn cục `~/.antigravity-agent-framework`.
