# AI Agent Handbook (AGENTS.md)
> Đây là "Sổ tay nhân sự" dành cho mọi AI Agent hoạt động trong project này.
> **BẮT BUỘC**: Mọi role (Analyst, Architect, Coder, Reviewer, Tester, Debugger, DevOps) phải đọc và tuân thủ các rule trong file này trước khi thực thi lệnh.

## 1. Project Context
- **Tên dự án**: Make Video Automation (make-video)
- **Mục đích**: Tự động hóa quá trình tạo video từ script (TTS, background music/video ghép nối).
- **Ngôn ngữ/Stack chính**: [Python / JS / TS] (Sửa đổi cho phù hợp).

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

## 4. Security & DevOps
- Tuyệt đối KHÔNG lưu API keys (Pexels, OpenAI, v.v.) vào code. Luôn dùng Environment Variables (`.env`).
- Mọi feature mới phải tuân thủ Least Privilege và có sẵn health-check endpoints.
