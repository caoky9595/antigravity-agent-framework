# Antigravity Agent Framework 🚀

**Universal Boilerplate (Vỏ rỗng vạn năng) cho Trợ Lý AI Lập Trình — SOTA 2026**

Biến trợ lý AI của bạn thành một kỹ sư phần mềm kỷ luật. Repo này đóng vai trò như một **Hệ điều hành (OS)** cho Agent của bạn, cung cấp bộ nhớ dài hạn, quy trình làm việc khắt khe và các kịch bản tự động kiểm tra chất lượng.
Áp dụng được cho MỌI ngôn ngữ lập trình (Python, JS/TS, Go, Rust, v.v.).

---

## 🌟 Tính Năng Chính

- **5 Workflows Cốt Lõi (Lazy Loading)** — `/fix_bug`, `/new_feature`, `/quick_fix`, `/refactor`, `/update_docs`. Được thiết kế dưới dạng con trỏ (Pointer) để tối ưu Token trong System Prompt.
- **Luật Thép (Iron Laws)** — Các quy tắc bắt buộc ngăn AI code bừa:
  - Không đoán cấu trúc file → phải đọc trước
  - Không nói "xong" → phải chạy test, paste output
  - Không sửa bug mà không tìm root cause trước
- **Templates Kiểm Tra Tự Động** — Script template cho `pre_submit_check.sh` và `generate_repomap.sh` giúp bạn thiết lập Quality Gate cho từng project.
- **Bộ nhớ dài hạn (Docs-as-Code)** — Mọi kế hoạch, thiết kế, bài học rút ra (Root Cause Analysis) đều được AI tự động ghi chép vào `docs/ai/` để không bao giờ lặp lại sai lầm.

---

## 📂 Cấu Trúc Boilerplate

```
.
├── AGENTS.md                      # Nội quy project — AI đọc đầu tiên
├── README.md                      # File này
│
├── .agents/
│   ├── skills/                    # Pointer Skills (Cú pháp gạch chéo /)
│   │   ├── fix_bug/SKILL.md       # Trỏ tới quy trình sửa bug
│   │   ├── new_feature/SKILL.md   # Trỏ tới quy trình code mới
│   │   ├── quick_fix/SKILL.md     # Trỏ tới quy trình sửa nhanh
│   │   ├── refactor/SKILL.md      # Trỏ tới quy trình dọn code
│   │   └── update_docs/SKILL.md   # Trỏ tới quy trình đồng bộ tài liệu
│   │
│   ├── workflows/                 # Chi tiết hướng dẫn từng bước
│   │   ├── fix_bug.md             
│   │   ├── new_feature.md         
│   │   ├── quick_fix.md           
│   │   ├── refactor.md            
│   │   └── update_docs.md
│   │
│   └── scripts/                   # Templates công cụ kiểm tra
│       ├── pre_submit_check.sh    # Mẫu script kiểm tra chất lượng
│       └── generate_repomap.sh    # Mẫu script quét bản đồ mã nguồn
│
└── docs/ai/                       # Bộ nhớ dài hạn (AI tự tạo)
    ├── repomap.txt                # Bản đồ cấu trúc project
    ├── KNOWLEDGE.md               # Sổ tay phục hồi (bài học debug)
    ├── requirements/              # Tài liệu yêu cầu (PRD)
    ├── planning/                  # Kế hoạch triển khai
    └── design/                    # Thiết kế kiến trúc & ADR
```

---

## 🚀 Hướng Dẫn Bắt Đầu

### 1. Cấu hình cho dự án của bạn (Setup Template)
1. Copy thư mục `.agents/` và `docs/ai/` vào dự án mới của bạn.
2. Mở `AGENTS.md` và điền thông tin project của bạn.
3. Mở `.agents/scripts/pre_submit_check.sh` và bỏ comment/cấu hình lệnh Test/Lint cho đúng ngôn ngữ dự án của bạn.

### 2. Mở rộng: Tạo các Role/Skill chuyên biệt (Domain Skills)
Bởi vì `antigravity` là một framework vạn năng (Core OS), nó không chứa sẵn các vai trò cụ thể như Frontend Engineer, Backend Expert, hay Database Architect. Bạn cần **tự bổ sung** các Role này cho dự án của bạn vào thư mục `.agents/skills/`.
- Tạo một thư mục mới: `.agents/skills/agent-backend/SKILL.md`.
- Định nghĩa rõ persona, stack công nghệ, và coding standards của bạn trong file đó.
- 🔗 **Nguồn tham khảo các Skill chất lượng cao:** Bạn có thể copy các role/prompt cực đỉnh từ cộng đồng tại:
  - [Cursor.directory](https://cursor.directory/) - Thư viện rules khổng lồ cho mọi stack.
  - [Awesome CursorRules](https://github.com/PatrickJS/awesome-cursorrules) - Tổng hợp các prompt/role chất lượng cao trên Github.

### 3. Sử dụng Slash Commands (Khuyến nghị cho 100% công việc)
Nhờ cơ chế Lazy Loading, bạn có thể gọi thẳng quy trình bằng phím tắt:

| Tình huống | Cú pháp (Dùng trong Cursor / Gemini) |
|-----------|------------|
| Thêm tính năng mới | *"Làm chức năng đăng nhập `/new_feature`"* |
| Sửa bug | *"Fix lỗi 500 ở API giỏ hàng `/fix_bug`"* |
| Sửa nhỏ (typo, config) | *"Sửa lại text ở footer `/quick_fix`"* |
| Refactor / dọn code | *"Dọn dẹp lại module User `/refactor`"* |
| Cập nhật Tài Liệu | *"Đồng bộ tài liệu sau khi code xong `/update_docs`"* |

*Nguyên lý: AI sẽ tự động đọc workflow tương ứng, làm theo từng bước, tự động gọi script test và cập nhật KNOWLEDGE.md trước khi báo cáo hoàn thành.*

### 4. Quy trình làm tính năng phức tạp (Docs-as-code)
Nếu bạn có một Epic (tính năng lớn), đừng bắt AI code ngay. Hãy bắt nó vạch kế hoạch trước:
1. **Lên kế hoạch:** *"Hãy nghiên cứu yêu cầu này và viết bản kế hoạch implementation lưu vào `docs/ai/planning/`."*
2. **Thiết kế kiến trúc:** *"Dựa vào bản kế hoạch, hãy thiết kế data flow và lưu vào `docs/ai/design/`."*
3. **Thi công:** *"Sử dụng `/new_feature`, hãy code module đầu tiên dựa trên bản thiết kế."*

---

## 🛑 Xử Lý Khi AI Làm Sai (Luật Thép)

| Vấn đề | Prompt chấn chỉnh |
|--------|--------|
| AI đoán cấu trúc file | *"Vi phạm Luật Thép #1. Đọc file thật trước đã."* |
| AI nói 'xong' mà chưa test | *"Vi phạm: Chưa có bằng chứng. Chạy test/lint và paste output."* |
| AI sửa bừa không tìm root cause | *"Vi phạm: Chưa trace root cause. Quay lại bước phân tích."* |
| AI tự ý sửa thêm thứ không yêu cầu | *"Vi phạm: Thay đổi tối thiểu. Revert và chỉ sửa cái tôi yêu cầu."* |
| AI bịa đặt cấu trúc project | *"Chạy script `bash .agents/scripts/generate_repomap.sh` và đọc file `docs/ai/repomap.txt`"* |
