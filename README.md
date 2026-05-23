# Antigravity Agent Framework 🚀

**SOTA 2026 Autonomous Agentic Workflow Framework for AI Coding Assistants**

Antigravity Agent Framework là một cấu trúc quản lý đa đặc vụ (Multi-Agent) biến trợ lý AI của bạn từ một chatbot đơn thuần thành một nhóm kỹ sư phần mềm thực thụ. Với các nguyên tắc làm việc khắt khe (Iron Laws), khả năng tự học (Persistent Memory) và sự phân chia vai trò rõ ràng, framework này giúp bạn tự động hóa quy trình phát triển phần mềm một cách chuyên nghiệp và có thể kiểm chứng được.

---

## 🌟 Các Tính Năng Cốt Lõi

- **Đội ngũ 9 AI Agents chuyên biệt:** Tự động điều phối hoặc gọi đích danh từng role (Product Manager, Analyst, Architect, Coder, Reviewer, Tester, Debugger, DevOps, Orchestrator).
- **Model Context Protocol (MCP) Ready:** Ưu tiên sử dụng MCP servers cho các tích hợp external API, giúp hệ thống mở rộng linh hoạt theo chuẩn công nghiệp mới nhất.
- **Cyclic Workflow & Observability:** Hỗ trợ vòng lặp tự động (Feedback loops) khi test fail và log toàn bộ quy trình ra quyết định (Agentic Tracing).
- **Luật Thép (Iron Laws):** Loại bỏ tình trạng "vibe coding" bằng cách bắt buộc áp dụng:
  - **Systematic Debugging:** Không sửa code nếu chưa tìm ra Root Cause.
  - **TDD (Test-Driven Development):** Không viết production code nếu chưa có failing test.
  - **Verification Before Completion:** Mọi kết luận "hoàn thành" phải được minh chứng bằng kết quả chạy trên terminal.
- **Trí Nhớ Cục Bộ (Persistent Memory):** Lưu trữ toàn bộ ngữ cảnh dự án, kiến trúc (Docs-as-Code) và bài học kinh nghiệm (Recovery Ledger) để AI không lặp lại lỗi cũ.

---

## 📂 Cấu Trúc Framework

- `.agents/skills/`: Chứa định nghĩa và nguyên tắc hoạt động cho 9 vai trò chuyên biệt.
- `MULTI_AGENT_MANUAL.md`: Sổ tay hướng dẫn chi tiết cách vận hành toàn bộ hệ thống.
- `AGENTS.md`: "Sổ tay nhân sự" mẫu. Bạn cần điền thông tin dự án của mình vào đây để thiết lập Context (Tên dự án, Stack công nghệ, Rules) cho các AI Agent.

---

## 🚀 Hướng Dẫn Bắt Đầu (Quick Start)

### 1. Cài đặt Context cho dự án
Mở file `AGENTS.md` ở thư mục gốc và chỉnh sửa phần `Project Context` để phù hợp với dự án hiện tại của bạn:
```markdown
## 1. Project Context
- **Tên dự án**: [Tên dự án của bạn]
- **Mục đích**: [Mô tả ngắn gọn]
- **Ngôn ngữ/Stack chính**: [VD: Python / Node.js / TypeScript]
```

### 2. Sử dụng thông qua Prompt
Bạn không cần phải viết prompt quá phức tạp hay gọi thủ công từng agent. Hệ thống mặc định sẽ đóng vai **Orchestrator** để tự động phân rã và điều phối công việc.
- **Tính năng lớn:** *"Hãy làm cho tôi tính năng Authentication."* -> Hệ thống sẽ tự kích hoạt PM -> Analyst -> Architect -> Coder -> Reviewer -> Tester.
- **Sửa lỗi (Fix bug):** *"Test ở file `test_auth.py` đang fail, tìm và fix đi."* -> Hệ thống tự động điều phối Debugger tìm lỗi và Coder sửa lỗi.
- **Chỉ định cụ thể (Nếu muốn):** *"Hãy đóng vai Reviewer, quét module `src/api` và refactor cho chuẩn Clean Code."*

---

## 📖 Tài Liệu Chi Tiết

Để hiểu rõ hơn về luồng làm việc, nguyên tắc của từng Role và các Prompt mẫu nâng cao, vui lòng xem tại:
👉 **[MULTI_AGENT_MANUAL.md](./MULTI_AGENT_MANUAL.md)**
