# AI Agent Handbook (AGENTS.md)
> Đây là "Sổ tay nhân sự" dành cho mọi AI Agent hoạt động trong project này.
> **BẮT BUỘC**: Mọi role (Analyst, Architect, Coder, Reviewer, Tester, Debugger, DevOps) phải đọc và tuân thủ các rule trong file này trước khi thực thi lệnh.

## 1. Project Context
- **Tên dự án**: [Tên dự án của bạn]
- **Mục đích**: [Mô tả ngắn gọn mục đích của dự án]
- **Ngôn ngữ/Stack chính**: [VD: Python / JS / TS / Go / Rust] (Sửa đổi cho phù hợp).

## 2. Agentic Workflow Rules (SOTA 2026)
1. **Persistent Memory**:
   - Tất cả phân tích, yêu cầu và kiến trúc phải được lưu dưới dạng Docs-as-Code tại thư mục `docs/ai/`.
   - Các bài học và bug fixes (Recovery Ledger) phải được lưu tại `docs/ai/KNOWLEDGE.md`.
2. **Iron Laws (Luật Thép)**:
   - *Debugger*: KHÔNG tự ý đề xuất fix nếu chưa trace ra root cause.
   - *Coder/Tester*: KHÔNG viết production code nếu chưa có failing test case (Red-Green-Refactor).
   - *Tất cả roles*: KHÔNG bao giờ nói "Hoàn thành" nếu chưa có bằng chứng xác thực (Linter, Test output).
3. **Repo Map**:
   - Luôn cập nhật và dựa vào `docs/ai/repomap.txt` để nắm kiến trúc codebase thay vì tìm kiếm (grep) mù quáng.

## 3. Tech Stack & Coding Style
- **Python**: Dùng `pytest` cho testing. Dùng type hints bắt buộc. Dùng docstrings chuẩn cho mọi public methods.
- **Error Handling**: Áp dụng "Fortress Error Handling" (không dùng empty except, bắt lỗi specific, log chi tiết).
- **Logging**: Dùng Structured JSON Logging, không dùng `print()`.

## 4. Security, DevOps & Observability
- Tuyệt đối KHÔNG lưu API keys vào code. Luôn dùng Environment Variables (`.env`).
- Mọi feature mới phải tuân thủ Least Privilege và có sẵn health-check endpoints.
- **Observability (Agentic Tracing)**: Các quyết định phức tạp và Tool Calls của Agent phải được log chi tiết để tiện cho việc audit và debug quá trình phân rã task.

## 5. Model Context Protocol (MCP)
- Các Agent (đặc biệt là Coder và DevOps) **BẮT BUỘC** ưu tiên sử dụng MCP Servers để tương tác với external tools (như Database, GitHub, Slack) thay vì tự code lại các đoạn mã tích hợp API từ đầu. Đây là chuẩn công nghiệp mới giúp hệ thống linh hoạt và dễ maintain.
