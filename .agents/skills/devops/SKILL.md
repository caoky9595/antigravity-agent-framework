---
name: Coding DevOps
description: Xử lý containerization (Docker), CI/CD pipelines, deployment scripts, và observability (logging, metrics, monitoring). Kích hoạt khi user cần deploy, setup Docker, cấu hình GitHub Actions, hoặc thêm monitoring vào app.
sources:
  - PatrickJS/awesome-cursorrules (36,900+ stars) — Docker rules
  - jwadow/agentic-prompts — Observer/Observability role
  - Industry best practices (n8n 160k stars, Dify 120k stars ecosystem)
  - https://github.com/PatrickJS/awesome-cursorrules
---

# DevOps Agent
> Inspired by: **Docker rules** from `PatrickJS/awesome-cursorrules` (36.9k ⭐) + **Observer** from `jwadow/agentic-prompts`

> "Hệ thống không được quan sát = hệ thống chết. Mọi code mới phải đi kèm với observability."

---

## Scope của DevOps Agent

DevOps Agent chịu trách nhiệm:
- 🐳 **Docker**: Dockerfile, docker-compose, .dockerignore
- ⚙️ **CI/CD**: GitHub Actions, deployment pipelines
- 📊 **Observability**: Logging, metrics, health checks
- 🔒 **Security**: Secrets management, scanning
- 📈 **Performance**: Profiling, benchmarking

---

## Principle #1: Docker — Minimal, Secure, Reproducible
> Source: `PatrickJS/awesome-cursorrules` (36,900 ⭐)

### Dockerfile Rules

**Version pinning — KHÔNG BAOGIỜ dùng `:latest`**:
```dockerfile
# ✅ Good — pinned version
FROM python:3.12.3-slim-bookworm
FROM node:20.11-alpine3.19

# ❌ Bad — unpredictable
FROM python:latest
FROM node:alpine
```

**Multi-stage builds để minimize image size**:
```dockerfile
# Stage 1: Builder
FROM python:3.12.3-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Stage 2: Runtime (nhỏ gọn, không có build tools)
FROM python:3.12.3-slim AS runtime
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
USER appuser
CMD ["python", "main.py"]
```

**Layer caching — đúng thứ tự**:
```dockerfile
# ✅ Good — dependencies trước, code sau (cache efficient)
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

# ❌ Bad — copy code trước (invalidates cache mỗi lần code thay đổi)
COPY . .
RUN pip install -r requirements.txt
```

**Security checklist**:
```dockerfile
# ✅ Non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

# ✅ HEALTHCHECK bắt buộc
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl --fail http://localhost:8080/health || exit 1

# ✅ File ownership
COPY --chown=appuser:appuser . .
```

**Forbidden**:
```dockerfile
# ❌ KHÔNG BAO GIỜ
FROM python:latest
USER root
ADD . /app              # Dùng COPY thay vì ADD
COPY .env /app/.env     # Secrets không vào image!
```

### .dockerignore (bắt buộc)
```
# .dockerignore
.git
.env
.env.*
*.log
__pycache__
*.pyc
node_modules
.pytest_cache
.mypy_cache
venv/
.venv/
tests/
*.test.ts
```

### docker-compose — Development vs Production
```yaml
# docker-compose.yml (production)
services:
  app:
    image: myapp:${APP_VERSION:-latest}
    environment:
      - PEXELS_API_KEY=${PEXELS_API_KEY}  # Từ .env, không hardcode
    volumes:
      - app_output:/app/output             # Named volumes only
    networks:
      - app_network                         # Custom network, not host
    restart: unless-stopped
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

volumes:
  app_output:
networks:
  app_network:
    driver: bridge
```

---

## Principle #2: CI/CD Pipeline
> Pattern: Build → Lint → Test → Security Scan → Build Image → Deploy

### GitHub Actions Template
```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'
          cache: 'pip'

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Lint
        run: |
          pip install ruff
          ruff check .
          ruff format --check .

      - name: Run tests
        run: |
          pip install pytest pytest-cov
          pytest --cov=. --cov-report=xml -v

      - name: Security scan
        run: |
          pip install bandit
          bandit -r . -ll --exclude venv

  build-image:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Build Docker image
        run: docker build -t myapp:${{ github.sha }} .

      - name: Scan image
        run: |
          docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
            aquasec/trivy image myapp:${{ github.sha }} --exit-code 1 --severity HIGH,CRITICAL
```

**Pipeline stages chuẩn**:
```
Build → Lint → Test → Benchmark → Security Scan → Build Image → Deploy
```

---

## Principle #3: Observability — Three Pillars

### Logs — Structured JSON, không plain text
```python
# ✅ Good — structured logging với context
import logging
import json

logging.basicConfig(
    format='%(message)s',
    level=logging.INFO
)

class StructuredLogger:
    def __init__(self, name: str):
        self.logger = logging.getLogger(name)

    def info(self, event: str, **kwargs):
        self.logger.info(json.dumps({
            "event": event,
            "level": "INFO",
            **kwargs
        }))

logger = StructuredLogger(__name__)
logger.info("video_created", title="Story Part 1", duration=45.2, size_mb=12.3)
# Output: {"event": "video_created", "level": "INFO", "title": "Story Part 1", ...}

# ❌ Bad — không thể parse/query
print(f"Video created: Story Part 1")
```

### Health Check Endpoint
```python
# app.py — Health check cho Docker HEALTHCHECK và load balancer
@app.get("/health")
def health_check():
    """Health check endpoint."""
    return {
        "status": "healthy",
        "version": os.getenv("APP_VERSION", "unknown"),
        "timestamp": datetime.utcnow().isoformat()
    }

@app.get("/ready")
def readiness_check():
    """Readiness check — kiểm tra dependencies."""
    checks = {
        "api_key_configured": bool(os.getenv("PEXELS_API_KEY")),
        "output_dir_writable": os.access("output/", os.W_OK),
    }
    all_ready = all(checks.values())
    return {"ready": all_ready, "checks": checks}
```

### Secrets Management
```bash
# ✅ Good — từ environment variables
PEXELS_API_KEY=xxx python main.py

# ✅ Good — .env file (không commit vào git!)
# .env
PEXELS_API_KEY=px-abc123
OPENAI_API_KEY=sk-xxx

# ❌ Bad — hardcoded
api_key = "px-abc123"  # Trong source code

# ❌ Bad — trong Dockerfile
ENV PEXELS_API_KEY=px-abc123
```

```python
# ✅ Good — validate secrets khi startup
import os
from typing import Optional

def get_required_env(key: str) -> str:
    value = os.getenv(key)
    if not value:
        raise RuntimeError(f"Required environment variable '{key}' is not set")
    return value

PEXELS_API_KEY = get_required_env("PEXELS_API_KEY")
```

---

## Principle #4: Security Scanning

```bash
# Docker image scanning
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image myapp:latest --severity HIGH,CRITICAL

# Python dependency scanning
pip install safety
safety check -r requirements.txt

# Secret scanning (pre-commit)
pip install detect-secrets
detect-secrets scan > .secrets.baseline
```

---

## Principle #5: Performance Baseline

```python
# benchmarks/benchmark_video_creation.py
import time
import statistics

def benchmark_tts_generation(runs=10):
    """Benchmark TTS generation time."""
    times = []
    for _ in range(runs):
        start = time.perf_counter()
        # tts.generate(test_script)
        elapsed = time.perf_counter() - start
        times.append(elapsed)

    print(f"TTS Benchmark ({runs} runs):")
    print(f"  Mean:   {statistics.mean(times):.3f}s")
    print(f"  P95:    {sorted(times)[int(runs*0.95)]:.3f}s")
    print(f"  StdDev: {statistics.stdev(times):.3f}s")
```

---

## Output Checklist

Sau khi DevOps Agent hoàn thành:
- [ ] Dockerfile có multi-stage build, non-root user, HEALTHCHECK
- [ ] .dockerignore tồn tại và đủ đầy
- [ ] Không có secrets trong code/Dockerfile
- [ ] CI/CD pipeline có đủ stages (lint → test → scan → build)
- [ ] Health check endpoint hoạt động
- [ ] Logging là structured (JSON), không phải plain text
- [ ] .env.example tồn tại (template không có values thật)
