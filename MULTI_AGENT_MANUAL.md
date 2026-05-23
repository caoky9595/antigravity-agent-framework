# 📘 Sổ Tay Sử Dụng Hệ Thống Multi-Agent (Antigravity SOTA 2026)

Chào mừng bạn đến với hệ thống **Autonomous Multi-Agent Coding Framework**. Hệ thống này biến Antigravity từ một chatbot AI đơn thuần thành một nhóm kỹ sư phần mềm thực thụ với các nguyên tắc làm việc khắt khe (Iron Laws), khả năng tự học (Persistent Memory) và cấu trúc quản lý bài bản.

---

## 🏗️ 1. Cấu Trúc Đội Ngũ (9 Roles)

Hệ thống được chia thành 9 vai trò (Roles) cụ thể nằm trong thư mục `.agents/skills/`. Tùy vào độ phức tạp của Task, bạn có thể gọi đích danh một Role hoặc gọi Orchestrator để tự động điều phối toàn bộ.

1. **🎭 Orchestrator (Nhạc trưởng)**: Tiếp nhận yêu cầu phức tạp, phân rã công việc (decomposition) và điều phối các agent khác.
2. **💼 Product Manager (PM)**: Phân tích yêu cầu nghiệp vụ, định nghĩa User Stories và Acceptance Criteria trước khi thiết kế.
3. **🔍 Analyst (Phân tích & Lên kế hoạch)**: Sinh Repo Map, phân tích codebase, gom requirements và lập kế hoạch (Implementation Plan).
4. **📐 Architect (Kiến trúc sư)**: Thiết kế giải pháp (System Design, API Contracts) và viết ADR (Architecture Decision Record) cho các tính năng lớn.
5. **💻 Coder (Lập trình viên)**: Viết code chính xác theo plan. Tập trung vào Clean Code, Logging và Error Handling. Không tự ý đổi thiết kế.
6. **🛡️ Reviewer (Người kiểm duyệt)**: Review 2 vòng (Spec Compliance -> Code Quality). Dọn dẹp code rác, giữ codebase sạch sẽ.
7. **🧪 Tester (Kỹ sư kiểm thử)**: Đảm bảo nguyên tắc TDD. Viết test, chạy test và báo cáo. Chỉ khi test FAIL mới gọi Debugger.
8. **🐛 Debugger (Chuyên gia gỡ lỗi)**: Tìm Root Cause thay vì sửa triệu chứng. Ghi chép bài học vào Sổ tay phục hồi (Recovery Ledger).
9. **⚙️ DevOps**: Xử lý Docker, CI/CD pipelines, và Observability (Logging, Metrics).

---

## ⚖️ 2. "Luật Thép" Của Hệ Thống (The Iron Laws)

Để tránh tình trạng "vibe coding" (code hên xui), hệ thống bị ràng buộc bởi 3 Đạo luật tối cao:

*   **Luật #1 - Systematic Debugging**: `NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST`. Debugger tuyệt đối không được đề xuất sửa code nếu chưa Trace data flow và tìm ra nguyên nhân gốc. Nếu sửa thất bại 3 lần -> Bắt buộc dừng lại và xem xét lại Kiến trúc.
*   **Luật #2 - TDD (Red-Green-Refactor)**: `NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST`. Không được viết code production nếu chưa có test bị lỗi (FAIL).
*   **Luật #3 - Verification Before Completion**: `NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE`. Không một Agent nào được phép báo "Xong", "Fix thành công" nếu chưa có bằng chứng hiển thị trên terminal (ví dụ: `0 failures`, exit code `0`).
*   **Luật #4 - MCP First**: `USE MCP SERVERS BEFORE CODING CUSTOM INTEGRATIONS`. Ưu tiên dùng Model Context Protocol (MCP) khi cần kết nối với công cụ bên ngoài (Database, GitHub, Slack) để chuẩn hóa giao tiếp.

---

## 🧠 3. Trí Nhớ Cục Bộ (Docs-as-Code & Persistent Memory)

Agent AI thường bị "mất trí nhớ" nếu file chat quá dài. Hệ thống này giải quyết việc đó bằng cách ghi mọi thứ ra file:

*   **`AGENTS.md`**: Sổ tay nội quy dự án (Chứa ngữ cảnh, stack, chuẩn code). Mọi agent đều phải đọc.
*   **`docs/ai/repomap.txt`**: Tấm bản đồ của project (Danh sách mọi class, func). Analyst tạo ra để quét dự án mà không tốn Token.
*   **`docs/ai/requirements/` & `docs/ai/planning/`**: Nơi Analyst lưu trữ các kế hoạch.
*   **`docs/ai/design/` & `docs/ai/ARCHITECTURE.md`**: Nơi Architect lưu bản vẽ hệ thống và các ADR.
*   **`docs/ai/KNOWLEDGE.md`**: Sổ tay phục hồi (Recovery Ledger). Nơi Debugger/Orchestrator ghi chép lại các cách sửa lỗi đã thành công để session sau không lặp lại lỗi cũ.

---

## 🚀 4. Cách Sử Dụng Thực Tế (Prompt Guide)

Để sử dụng hệ thống, bạn không cần phải Prompt quá dài. Chỉ cần nói đúng "Key-word" kích hoạt.

### Trường hợp 1: Tính năng lớn, phức tạp (Cyclic Pipeline)
> Hãy để Orchestrator làm mọi việc. Có cơ chế vòng lặp phản hồi (Feedback Loops) tự động.
*   **Prompt của bạn:** *"Hãy dùng Orchestrator, tôi muốn thêm tính năng Đăng nhập bằng Google cho dự án."*
*   **Luồng chạy tự động:** Orchestrator -> Product Manager (Viết PRD) -> Analyst -> Architect -> Coder -> Reviewer -> Tester. *(Nếu Tester báo lỗi -> Debugger -> Coder -> Tester)*.

### Trường hợp 2: Tính năng nhỏ, thêm một logic đơn giản
> Bỏ qua Architect để làm nhanh.
*   **Prompt của bạn:** *"Dùng Analyst và Coder: Hãy viết thêm một hàm utils để parse định dạng dữ liệu (JSON) sang dạng chuỗi."*
*   **Luồng chạy tự động:** Analyst (Đọc repomap, lập plan) -> Coder (Viết code) -> Tester (Verify).

### Trường hợp 3: Code bị lỗi (Cần Fix Bug)
> Kích hoạt thám tử Debugger.
*   **Prompt của bạn:** *"Test ở file `test_auth.py` đang fail. Gọi Debugger tìm Root Cause và fix lỗi này."*
*   **Luồng chạy tự động:** Debugger (Phân tích, Fix) -> Tester (Verify) -> Coder (Cập nhật `KNOWLEDGE.md`).

### Trường hợp 4: Cần Refactor / Dọn dẹp code rác
> Kích hoạt Gardener (Reviewer).
*   **Prompt của bạn:** *"Gọi Reviewer, hãy quét module `src/api` và tìm các code smells, sau đó refactor lại cho Clean Code."*

---

## 🛑 5. Xử Lý Các Sự Cố Tiêu Biểu

*   **Nếu AI code sai kiến trúc:** Nhắc nhở *"Bạn đã vi phạm Principle #0 của Coder (Sacred Plan Adherence). Đọc lại plan và code lại."*
*   **Nếu AI đoán mò lỗi:** Nhắc nhở *"Bạn đã vi phạm Iron Law của Debugger. Hãy quay lại bước 1: Trace Root Cause."*
*   **Nếu AI nói 'Xong' nhưng chưa chạy test:** Nhắc nhở *"Bạn vi phạm Verification Before Completion. Chạy test và đưa tôi xem output."*

---
*Hệ thống được thiết kế dựa trên các tiêu chuẩn SOTA 2026 từ OpenHands, SWE-agent, Microsoft AutoGen, và các nguyên tắc Engineering của PatrickJS, Jwadow, Baz-scm.*
