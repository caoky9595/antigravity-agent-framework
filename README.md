# Antigravity Agent Framework 🚀

**Universal Boilerplate (Vỏ rỗng vạn năng) cho Trợ Lý AI Lập Trình — SOTA 2026**

Biến trợ lý AI của bạn (Cursor, Claude Code, Google Antigravity) thành một kỹ sư phần mềm kỷ luật. Repo này đóng vai trò như một **Hệ điều hành (OS)** cho Agent của bạn: symlink một lần là dùng được trên mọi project, cung cấp bộ nhớ dài hạn, quy trình làm việc khắt khe, tự tạo persona chuyên biệt theo đúng stack thật, và các kịch bản tự động kiểm tra chất lượng.
Áp dụng được cho MỌI ngôn ngữ lập trình (Python, JS/TS, Go, Rust, v.v.).

---

## 🌟 Tính Năng Chính

- **Zero-Setup Toàn Máy** — `./machine-setup.sh` chạy 1 lần/máy: symlink Iron Laws cơ bản + 6 skill vào Claude Code (và Antigravity/Cursor nếu hỗ trợ), áp dụng ngay cho MỌI project trên máy, kể cả project chưa từng chạy `init.sh`.
- **6 Workflows Cốt Lõi (Lazy Loading)** — `fix_bug`, `new_feature`, `quick_fix`, `refactor`, `update_docs`, `new_role`. Thiết kế dưới dạng con trỏ (Pointer) để tối ưu Token trong System Prompt — không cần nhớ tên lệnh, cứ mô tả việc cần làm bằng lời.
- **Tự Tạo Role Theo Ngữ Cảnh** — `fix_bug`/`new_feature`/`refactor` tự nhận diện domain của task, tự tạo role chuyên biệt (Backend Engineer, Database Architect...) khớp đúng stack thật của project nếu chưa có, rồi dùng luôn để làm việc — không cần bạn tạo role tay hay nhớ gọi lệnh nào.
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
├── init.sh                        # Bootstrap mỗi project: <path> hoặc không kèm gì (folder picker)
├── machine-setup.sh                # Bootstrap 1 lần/máy — gõ tab là ra, không cần nhớ flag
├── AGENTS.md                      # Nội quy project — nguồn gốc, init.sh copy sang project mới [G]
├── README.md                      # File này
│
├── claude-global-config/          # Cấu hình machine-level — symlink vào ~/.claude, ~/.gemini
│   ├── CLAUDE.md                  # → ~/.claude/CLAUDE.md (Claude Code, mọi project)
│   ├── GEMINI.md                  # → ~/.gemini/GEMINI.md (Antigravity, best-effort)
│   └── agents/                    # → ~/.claude/agents/*.md (quick-worker, deep-reasoner)
│
├── .agents/
│   ├── skills/                    # Pointer Skills — bản gốc [S]
│   │   ├── fix_bug/SKILL.md       # → cũng symlink vào ~/.claude/skills/fix_bug/
│   │   ├── new_feature/SKILL.md
│   │   ├── quick_fix/SKILL.md
│   │   ├── refactor/SKILL.md
│   │   ├── update_docs/SKILL.md
│   │   ├── new_role/SKILL.md      # Tự tạo role mới — xem mục "Domain Skills" bên dưới
│   │   └── agent-<domain>/SKILL.md  # [G] do new_role tạo, riêng từng project, KHÔNG symlink
│   │
│   ├── workflows/                 # Chi tiết hướng dẫn từng bước — bản gốc [S]
│   │   ├── fix_bug.md
│   │   ├── new_feature.md
│   │   ├── quick_fix.md
│   │   ├── refactor.md
│   │   ├── update_docs.md
│   │   └── new_role.md
│   │
│   └── scripts/
│       ├── pre_submit_check.sh    # Mẫu script kiểm tra chất lượng [G] — mỗi project tự customize
│       └── generate_repomap.sh    # Bản gốc, dùng chung mọi project [S]
│
└── docs/ai/                       # Bộ nhớ dài hạn (AI tự tạo) [G]
    ├── repomap.txt                # Bản đồ cấu trúc project
    ├── KNOWLEDGE.md               # Sổ tay phục hồi (bài học debug)
    ├── requirements/              # Tài liệu yêu cầu (PRD)
    ├── planning/                  # Kế hoạch triển khai
    └── design/                    # Thiết kế kiến trúc & ADR
```

`[S]` = **Symlink dùng chung** — `init.sh` trỏ thẳng về bản gốc trong repo này; sửa 1 lần, áp dụng ngay cho mọi project (và global qua `~/.claude/skills/`).
`[G]` = **Generate 1 lần** — `init.sh` chỉ tạo nếu project chưa có file này; không bao giờ ghi đè, vì đây là state/tuỳ biến riêng của từng project.

---

## 🚀 Hướng Dẫn Bắt Đầu

### 1. Setup (không cần copy tay)

1. **1 lần / máy:** clone repo này, rồi chạy `./machine-setup.sh` (file riêng, gõ `./m` + Tab là ra, không cần nhớ flag gì cả). Lệnh này symlink `CLAUDE.md`/`GEMINI.md`/2 subagent/6 skill vào `~/.claude` và `~/.gemini`, để **mọi project trên máy** tự động có Iron Laws cơ bản + 6 skill, kể cả khi project đó chưa từng chạy bước 2 (chi tiết xem [claude-global-config/README.md](claude-global-config/README.md)).
2. **Mỗi project mới:** chạy `/path/to/antigravity-agent-framework/init.sh /path/to/your/project` — hoặc đơn giản hơn, chạy `init.sh` **không kèm path**, nó sẽ tự bật hộp thoại chọn thư mục (macOS: native Finder dialog qua `osascript`; Linux: `zenity`/`kdialog` nếu có) thay vì phải gõ/đi tìm đường dẫn tay. Lệnh này symlink phần dùng chung (`.agents/skills`, `.agents/workflows`, `generate_repomap.sh`) và sinh sẵn (nếu chưa có) `AGENTS.md`, `docs/ai/`, `.agents/scripts/pre_submit_check.sh` cho riêng project đó — an toàn để chạy lại nhiều lần, không bao giờ ghi đè file đã tuỳ biến.
3. Mở `AGENTS.md` (vừa được sinh ra) và điền thông tin project của bạn.
4. Mở `.agents/scripts/pre_submit_check.sh` và bỏ comment/cấu hình lệnh Test/Lint cho đúng ngôn ngữ dự án của bạn.

### 2. Cách dùng — không cần nhớ tên lệnh

Mỗi skill có sẵn `description` mô tả rõ "dùng khi nào" — Cursor/Claude Code/Antigravity đều hỗ trợ cơ chế tự chọn skill dựa trên mô tả, không chỉ gọi tay bằng `/`. Cứ mô tả task bằng lời tự nhiên, AI tự nhận diện đúng workflow:

| Tình huống | Cú pháp (gõ tay, vẫn dùng được) | Hoặc chỉ cần nói |
|-----------|------------|------------|
| Thêm tính năng mới | *"Làm chức năng đăng nhập `/new_feature`"* | *"Làm giúp tôi chức năng đăng nhập"* |
| Sửa bug | *"Fix lỗi 500 ở API giỏ hàng `/fix_bug`"* | *"API giỏ hàng đang lỗi 500, sửa giúp"* |
| Sửa nhỏ (typo, config) | *"Sửa lại text ở footer `/quick_fix`"* | *"Sửa lại text ở footer"* |
| Refactor / dọn code | *"Dọn dẹp lại module User `/refactor`"* | *"Module User code rối quá, dọn lại"* |
| Cập nhật Tài Liệu | *"Đồng bộ tài liệu sau khi code xong `/update_docs`"* | *"Cập nhật lại docs cho khớp code"* |
| Tạo role chuyên biệt | *"Tạo role Backend Engineer cho project này `/new_role`"* | *(tự động — xem mục 3)* |

*Nguyên lý: AI tự động đọc workflow tương ứng, làm theo từng bước, tự động gọi script test và cập nhật KNOWLEDGE.md trước khi báo cáo hoàn thành.*

### 3. Domain Skills — Role chuyên biệt (Backend/Frontend/Database...)

Vì `antigravity` là framework vạn năng (Core OS), nó không chứa sẵn role cụ thể như Frontend Engineer hay Database Architect. Có 2 cách để có role đó:

**Tự động, không cần gõ gì cả (mặc định):** Cứ làm việc bình thường — `fix_bug`, `new_feature`, `refactor` đều có **"Step 0: ROLE CHECK"** ở đầu workflow: AI tự nhận diện domain của task (backend/frontend/database/...), kiểm tra `.agents/skills/agent-*/` xem đã có role khớp chưa; nếu chưa thì tự chạy quy trình `new_role` ngay trong lượt đó để tạo — đọc `docs/ai/repomap.txt` + manifest thật của project (package.json/requirements.txt/go.mod/...) để khớp đúng stack thực tế, không phải template chung chung — rồi **dùng luôn** persona vừa tạo để hoàn thành task, tất cả trong 1 lượt. (`quick_fix`/`update_docs` cố tình bỏ qua bước này vì việc quá nhỏ, không cần persona.)

**Thủ công:** Gọi tay `/new_role` để tạo trước khi làm việc thật (vd. *"Tạo role Backend Engineer cho project này `/new_role`"*), hoặc tự viết `.agents/skills/agent-<tên-role>/SKILL.md` — hữu ích khi muốn copy nguyên 1 role có sẵn từ cộng đồng thay vì để AI tự soạn:
  - [obra/superpowers](https://github.com/obra/superpowers) - Bộ skill tư duy hệ thống cực đỉnh (Systematic Debugging, TDD, Planning).
  - [wshobson/agents](https://github.com/wshobson/agents) - Tổng hợp Domain Skills cực kỳ chi tiết (Architecture, Backend, API Design...).
  - [Cursor.directory](https://cursor.directory/) - Thư viện rules khổng lồ cho mọi stack ngôn ngữ.
  - [Awesome CursorRules](https://github.com/PatrickJS/awesome-cursorrules) - Tổng hợp các prompt/role chất lượng cao trên Github.

> ⚠️ **Bắt buộc:** dù tạo tự động hay thủ công, tên thư mục role LUÔN phải có tiền tố `agent-` (vd. `agent-backend`). `.agents/skills/` còn chứa 6 skill cốt lõi (`fix_bug`, `new_feature`, `quick_fix`, `refactor`, `update_docs`, `new_role`) là symlink trỏ về framework repo dùng chung mọi project — nếu đặt tên role trùng 1 trong 6 tên đó, bạn sẽ ghi đè lên symlink và làm hỏng workflow đó cho **tất cả project trên máy**. Role tạo ra là **file thật của riêng project đó**, không symlink dùng chung như 6 skill cốt lõi.

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
| AI tự đặt tên role trùng 6 skill lõi | *"Vi phạm quy tắc `agent-` prefix. Đổi tên thư mục role, đừng đè symlink dùng chung."* |
