# Dockerfile 실무 가이드

이 문서는 이 저장소의 [Dockerfile](./Dockerfile)을 기준으로 Dockerfile의 역할, 자주 쓰는 지시어, 빌드 흐름, 그리고 다양한 환경을 위한 실무형 예제를 한 번에 이해할 수 있도록 정리한 문서입니다.

단순 입문 설명에 그치지 않고, 실제 현업에서 자주 마주치는 개발 환경, 운영 환경, 멀티 스테이지 빌드, 이미지 경량화, 보안, 캐시 전략까지 함께 다룹니다.

## 1. Dockerfile이란

Dockerfile은 "이미지를 어떻게 만들지"를 선언형으로 적어 둔 레시피 파일입니다.

`docker build` 명령은 이 파일을 위에서 아래로 읽으며 레이어를 만들고, 최종적으로 실행 가능한 이미지(image)를 생성합니다.

핵심 흐름은 아래와 같습니다.

1. 베이스 이미지를 고릅니다.
2. 필요한 패키지와 런타임을 설치합니다.
3. 소스 코드나 정적 파일을 복사합니다.
4. 실행 환경 변수와 작업 디렉터리를 설정합니다.
5. 기본 실행 명령을 지정합니다.

즉, Dockerfile은 "내 앱이 어디서 시작해서, 무엇을 설치하고, 어떤 파일을 담고, 어떻게 실행되는지"를 코드로 관리하는 파일입니다.

## 2. 현재 저장소의 Dockerfile 해설

이 저장소의 현재 [Dockerfile](./Dockerfile)은 다음과 같습니다.

```dockerfile
FROM nginx:alpine

LABEL org.opencontainers.image.title="ai-sw-workstation-web"
LABEL org.opencontainers.image.description="Mission 1 custom nginx image"
LABEL org.opencontainers.image.version="1.0"

ENV APP_ENV=dev

# 포트 바인딩
EXPOSE 8080

COPY app/ /usr/share/nginx/html/
```

각 줄의 의미는 아래와 같습니다.

### `FROM nginx:alpine`

- `nginx` 공식 이미지를 베이스로 사용합니다.
- `alpine` 태그는 가벼운 리눅스 배포판 기반이라 이미지 크기를 줄이는 데 유리합니다.
- 이 한 줄이 "정적 웹 파일을 NGINX로 서비스한다"는 전체 방향을 결정합니다.

### `LABEL ...`

- 이미지 메타데이터를 기록합니다.
- 이미지 이름, 설명, 버전 같은 정보를 남겨두면 레지스트리 관리나 운영 추적 시 도움이 됩니다.
- 실무에서는 `source`, `revision`, `created` 같은 정보도 함께 넣는 경우가 많습니다.

예:

```dockerfile
LABEL org.opencontainers.image.source="https://github.com/example/repo"
LABEL org.opencontainers.image.revision="$GIT_COMMIT"
```

### `ENV APP_ENV=dev`

- 컨테이너 내부 기본 환경 변수를 설정합니다.
- 런타임에서 `APP_ENV`를 읽는 애플리케이션이 있다면 기본값으로 `dev`를 사용하게 됩니다.
- 단, 지금 이 저장소의 현재 `nginx` 정적 페이지 구성에서는 이 값이 직접적인 동작 변경을 만들지는 않습니다.

### `EXPOSE 8080`

- 이 이미지는 `8080` 포트를 사용한다고 문서화하는 역할을 합니다.
- 매우 중요한 점은 `EXPOSE`가 실제 서버 리슨 포트를 바꾸지는 않는다는 것입니다.
- 현재 NGINX 기본 설정과 [compose/nginx/default.conf](./compose/nginx/default.conf)는 `80` 포트에서 리슨합니다.
- 따라서 실제 실행 시에는 `-p 8080:80`처럼 호스트 `8080`을 컨테이너 `80`에 매핑하는 방식이 자연스럽습니다.

즉, 아래 두 개는 전혀 다른 의미입니다.

```bash
docker run -p 8080:80 my-image
docker run -p 8080:8080 my-image
```

현재 저장소 기준으로 올바른 쪽은 첫 번째입니다.

### `COPY app/ /usr/share/nginx/html/`

- 호스트의 `app/` 디렉터리를 컨테이너 안 NGINX 웹 루트로 복사합니다.
- 이 구조는 HTML, CSS, JS 같은 정적 웹 콘텐츠 배포에 아주 적합합니다.
- 빌드 시점에 파일이 이미지 안으로 들어가므로, 실행 후에는 호스트 파일을 직접 참조하지 않습니다.

## 3. 이 저장소에서 바로 해볼 수 있는 빌드와 실행

### 이미지 빌드

```bash
docker build -t ai-sw-workstation-web:1.0 .
```

### 컨테이너 실행

```bash
docker run --rm -p 8080:80 ai-sw-workstation-web:1.0
```

브라우저나 `curl`로 확인:

```bash
curl http://localhost:8080
```

백그라운드 실행:

```bash
docker run -d --name ai-sw-web -p 8080:80 ai-sw-workstation-web:1.0
docker logs ai-sw-web
docker rm -f ai-sw-web
```

Compose로 실행:

```bash
docker compose up -d
docker compose ps
docker compose logs
docker compose down
```

## 4. Dockerfile에서 자주 쓰는 지시어

| 지시어 | 역할 | 실무 포인트 |
| --- | --- | --- |
| `FROM` | 베이스 이미지 선택 | 이미지 크기, 보안, 지원 버전을 함께 고려 |
| `LABEL` | 메타데이터 추가 | 운영 추적과 레지스트리 관리에 유용 |
| `WORKDIR` | 작업 디렉터리 지정 | 이후 `RUN`, `COPY`, `CMD`의 기준 경로 |
| `COPY` | 파일 복사 | 가장 자주 쓰며 캐시 전략에 영향 큼 |
| `ADD` | 복사 + 압축 해제/URL 가능 | 대부분은 `COPY`가 더 안전하고 예측 가능 |
| `RUN` | 빌드 중 명령 실행 | 패키지 설치, 빌드, 권한 설정 |
| `ENV` | 환경 변수 설정 | 런타임 기본값 제공 |
| `ARG` | 빌드 시 인자 | 버전 선택, 환경별 빌드 분기 |
| `EXPOSE` | 포트 문서화 | 포트 공개 자체는 아님 |
| `USER` | 실행 사용자 지정 | 보안을 위해 루트 대신 일반 사용자 권장 |
| `VOLUME` | 볼륨 마운트 지점 선언 | DB, 업로드 저장소 등에 사용 |
| `CMD` | 기본 실행 명령 | 가장 마지막에 실행되는 기본값 |
| `ENTRYPOINT` | 고정 실행 진입점 | 앱 전용 이미지에 자주 사용 |
| `HEALTHCHECK` | 헬스 체크 정의 | 오케스트레이션 환경에서 상태 판단에 유용 |

## 5. 실무에서 꼭 기억할 Dockerfile 원칙

### 5-1. 작은 이미지가 곧 좋은 이미지인 경우가 많습니다

- 전송 속도가 빨라집니다.
- 배포 시간이 짧아집니다.
- 공격 표면이 줄어듭니다.
- 불필요한 패키지가 줄어듭니다.

그래서 실무에서는 `alpine`, `slim`, `distroless`, 멀티 스테이지 빌드를 자주 사용합니다.

### 5-2. 캐시가 잘 먹도록 레이어 순서를 설계해야 합니다

아래 순서는 캐시 효율이 떨어집니다.

```dockerfile
COPY . .
RUN npm ci
```

소스 하나만 바뀌어도 `npm ci`가 다시 실행될 수 있기 때문입니다.

더 나은 패턴은 아래와 같습니다.

```dockerfile
COPY package*.json ./
RUN npm ci
COPY . .
```

의존성 파일이 바뀌지 않으면 설치 레이어를 재사용할 수 있습니다.

### 5-3. 개발 환경과 운영 환경은 분리하는 편이 좋습니다

- 개발 환경은 핫 리로드, 디버깅 툴, 테스트 도구가 필요합니다.
- 운영 환경은 최소 런타임, 빠른 시작, 작은 이미지, 낮은 권한이 중요합니다.

그래서 한 파일 안에서 `dev`, `build`, `prod` 스테이지를 분리하는 패턴이 널리 쓰입니다.

### 5-4. 루트 사용자로 실행하지 않는 것이 좋습니다

앱이 침해되었을 때 피해 범위를 줄이기 위해 `USER`를 지정하는 것이 권장됩니다.

예:

```dockerfile
RUN adduser --disabled-password --gecos "" appuser
USER appuser
```

### 5-5. 시크릿은 이미지에 넣지 않는 것이 원칙입니다

비밀번호, 토큰, 인증서 파일을 `COPY`하거나 `ENV`에 하드코딩하면 이미지 유출 시 그대로 노출됩니다.

권장 방식:

- 런타임 환경 변수 주입
- 시크릿 매니저 사용
- CI/CD secret store 사용

## 6. `.dockerignore` 예시

Docker 빌드 컨텍스트를 줄이면 속도와 보안 모두 좋아집니다.

예:

```gitignore
.git
.github
node_modules
dist
build
coverage
.env
.DS_Store
*.log
tmp
```

특히 `node_modules`, `.git`, 대용량 로그, 로컬 캐시 디렉터리는 빌드 컨텍스트에 포함하지 않는 것이 좋습니다.

## 7. 실무형 Dockerfile 예제 모음

아래 예제들은 "다양한 환경을 어떻게 Dockerfile로 구성하는가"를 빠르게 참고할 수 있도록 실무 위주로 정리했습니다.

### 7-1. 정적 웹 페이지 + NGINX

용도:

- 회사 소개 페이지
- 정적 문서 사이트
- 단순 프런트 배포

```dockerfile
FROM nginx:1.27-alpine

COPY ./dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

빌드 및 실행:

```bash
docker build -t static-web:latest .
docker run --rm -p 8080:80 static-web:latest
```

### 7-2. React/Vite 프런트엔드 멀티 스테이지 빌드

용도:

- Vite, React, Vue, Svelte 기반 SPA
- 빌드 결과물만 운영 이미지에 포함하고 싶을 때

```dockerfile
FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM nginx:1.27-alpine AS prod

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

장점:

- 운영 이미지에 `node`, `npm`, 소스 전체가 들어가지 않습니다.
- 최종 이미지는 정적 산출물만 포함하므로 훨씬 가볍습니다.

빌드:

```bash
docker build -t vite-web:prod .
docker run --rm -p 8080:80 vite-web:prod
```

### 7-3. Node.js API를 위한 `dev`/`prod` 멀티 타깃 예제

용도:

- 로컬 개발과 운영 배포를 같은 Dockerfile로 관리
- 개발에는 핫 리로드, 운영에는 최소 런타임 사용

```dockerfile
FROM node:22-bookworm-slim AS base

WORKDIR /app

COPY package*.json ./
RUN npm ci

FROM base AS dev

ENV NODE_ENV=development

COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]

FROM node:22-bookworm-slim AS prod

WORKDIR /app

ENV NODE_ENV=production

COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]
```

개발용 빌드:

```bash
docker build --target dev -t my-api:dev .
docker run --rm -p 3000:3000 my-api:dev
```

운영용 빌드:

```bash
docker build --target prod -t my-api:prod .
docker run --rm -p 3000:3000 my-api:prod
```

실무 팁:

- 실제 운영에서는 `COPY . .` 대신 필요한 파일만 더 명시적으로 복사하는 편이 좋습니다.
- `USER node` 같은 비루트 실행을 추가하면 더 안전합니다.
- `node_modules`는 `.dockerignore`에 넣고, 컨테이너 내부에서 설치하게 관리하는 편이 안정적입니다.

### 7-4. Python FastAPI 운영 이미지 예제

용도:

- FastAPI, Flask, Django 같은 Python 웹 서비스
- 간단하면서도 운영 배포에 무난한 기본형

```dockerfile
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN adduser --disabled-password --gecos "" appuser

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

빌드 및 실행:

```bash
docker build -t fastapi-app:latest .
docker run --rm -p 8000:8000 fastapi-app:latest
```

실무 팁:

- `requirements.txt` 또는 `poetry.lock`만 먼저 복사하면 pip 캐시를 더 잘 활용할 수 있습니다.
- 데이터 과학 패키지가 많은 프로젝트는 `slim` 기반과 OS 패키지 레이어를 분리해 최적화하는 것이 좋습니다.

### 7-5. Spring Boot 멀티 스테이지 빌드 예제

용도:

- Java 백엔드 서비스
- 빌드 도구는 무겁지만 운영 이미지는 가볍게 유지하고 싶을 때

```dockerfile
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .
RUN chmod +x mvnw
RUN ./mvnw -q -DskipTests dependency:go-offline

COPY src src
RUN ./mvnw -q -DskipTests package

FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
```

빌드 및 실행:

```bash
docker build -t spring-app:latest .
docker run --rm -p 8080:8080 spring-app:latest
```

실무 팁:

- 테스트를 분리할 수 있다면 이미지 빌드 단계에서는 `-DskipTests`를 쓰고 CI에서 별도 테스트를 수행하는 경우가 많습니다.
- 실제 프로젝트에서는 계층형 JAR 레이어 전략을 사용하면 캐시 효율을 더 높일 수 있습니다.

### 7-6. Go 바이너리 + Distroless 운영 이미지

용도:

- 단일 바이너리 서비스
- 아주 작은 운영 이미지가 필요한 경우

```dockerfile
FROM golang:1.24-alpine AS build

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app/server ./cmd/server

FROM gcr.io/distroless/static-debian12

COPY --from=build /app/server /server

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/server"]
```

장점:

- 최종 이미지에 셸이나 패키지 매니저가 없습니다.
- 공격 표면이 작고 배포가 빠릅니다.

주의:

- 디버깅 도구가 거의 없기 때문에 개발 단계에는 다른 이미지가 더 편할 수 있습니다.

### 7-7. PostgreSQL 초기화 스크립트 포함 예제

용도:

- 로컬 개발 DB
- 팀 공용 데모 환경
- 초기 스키마와 샘플 데이터를 함께 넣고 싶을 때

```dockerfile
FROM postgres:17

COPY ./init-sql/ /docker-entrypoint-initdb.d/
```

실무 팁:

- DB 자체를 직접 커스텀 빌드하기보다 공식 이미지를 그대로 쓰는 경우가 많습니다.
- 다만 초기화 SQL, 시드 데이터, 확장 모듈 설정이 필요할 때는 위 패턴이 유용합니다.

### 7-8. 테스트 전용 스테이지 예제

용도:

- CI 파이프라인에서 테스트 전용 이미지를 만들고 싶을 때
- 운영 이미지와 테스트 환경을 분리하고 싶을 때

```dockerfile
# syntax=docker/dockerfile:1.7

FROM node:22-alpine AS test

WORKDIR /app

COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci

COPY . .

CMD ["npm", "test"]
```

실무 포인트:

- BuildKit 캐시 마운트를 활용하면 CI 재빌드 속도를 줄일 수 있습니다.
- 테스트용 의존성과 운영용 의존성을 같은 이미지에 섞지 않아도 됩니다.

## 8. 환경별 빌드 명령 예제

### 개발 환경 빌드

```bash
docker build --target dev -t myapp:dev .
```

### 운영 환경 빌드

```bash
docker build --target prod -t myapp:prod .
```

### 빌드 인자 사용

```dockerfile
ARG APP_ENV=production
ENV APP_ENV=$APP_ENV
```

```bash
docker build --build-arg APP_ENV=staging -t myapp:staging .
```

### 캐시 없이 다시 빌드

```bash
docker build --no-cache -t myapp:clean .
```

### 특정 플랫폼용 빌드

```bash
docker buildx build --platform linux/amd64 -t myapp:amd64 .
docker buildx build --platform linux/arm64 -t myapp:arm64 .
```

### 멀티 아키텍처 빌드

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t registry.example.com/myapp:1.0 \
  --push .
```

이 패턴은 Mac, Linux 서버, ARM 기반 인스턴스가 혼재하는 환경에서 특히 자주 사용됩니다.

## 9. `CMD`와 `ENTRYPOINT`를 어떻게 구분할까

둘은 자주 헷갈리지만 역할이 조금 다릅니다.

### `CMD`

- "기본 실행 명령"입니다.
- 사용자가 `docker run` 시 다른 명령을 주면 쉽게 덮어쓸 수 있습니다.

예:

```dockerfile
CMD ["npm", "start"]
```

### `ENTRYPOINT`

- "이 이미지는 이 프로그램으로 실행된다"는 고정 진입점에 가깝습니다.
- 앱 이미지, CLI 이미지, Java 실행 이미지에서 자주 사용합니다.

예:

```dockerfile
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
```

실무 기준으로 보면:

- 일반 웹 앱 컨테이너는 `CMD`만으로 충분한 경우가 많습니다.
- 앱 실행 방식이 확실히 정해진 전용 이미지라면 `ENTRYPOINT`가 더 적합합니다.

## 10. 자주 하는 실수와 예방 팁

### 실수 1. `EXPOSE`가 포트를 열어준다고 생각함

`EXPOSE`는 문서화일 뿐입니다. 실제 외부 연결은 `-p` 또는 Compose 포트 설정이 담당합니다.

### 실수 2. 너무 이른 시점에 `COPY . .`를 사용함

의존성 캐시가 자주 깨집니다. 먼저 잠금 파일이나 매니페스트만 복사하는 편이 좋습니다.

### 실수 3. `.env`나 인증 파일을 이미지에 포함함

이미지 레이어에 남을 수 있어 보안상 좋지 않습니다.

### 실수 4. 개발용 도구를 운영 이미지에 그대로 넣음

운영 이미지가 무거워지고 공격 표면도 커집니다.

### 실수 5. 컨테이너를 루트로 실행함

가능하면 일반 사용자로 전환하는 편이 안전합니다.

### 실수 6. 베이스 이미지를 `latest`에만 의존함

언제든 결과가 바뀔 수 있으므로 버전 고정이 더 재현성이 높습니다.

예:

```dockerfile
FROM node:22.15.0-alpine
```

## 11. 실무용 추천 체크리스트

아래 항목을 만족하면 대체로 품질이 좋은 Dockerfile에 가까워집니다.

- 베이스 이미지가 목적에 맞게 작고 명확한가
- 불필요한 파일이 빌드 컨텍스트에 포함되지 않는가
- 캐시가 잘 먹도록 `COPY` 순서를 설계했는가
- 개발용과 운영용 스테이지가 분리되어 있는가
- 시크릿이 이미지에 포함되지 않는가
- 컨테이너가 비루트 사용자로 실행되는가
- 포트, 볼륨, 엔트리포인트가 명확한가
- 헬스 체크나 운영 메타데이터가 필요한 경우 반영했는가

## 12. 이 저장소 기준으로 추천하는 다음 단계

현재 저장소는 정적 웹 페이지를 NGINX로 서빙하는 구조이므로, 다음 순서로 실습하면 이해가 빠릅니다.

1. 현재 [Dockerfile](./Dockerfile)로 이미지를 빌드해 보기
2. `-p 8080:80` 매핑으로 실행해 보기
3. [docker-compose.yml](./docker-compose.yml)로 Compose 실행해 보기
4. 이후 멀티 스테이지 Dockerfile 예제로 확장해 보기
5. 마지막으로 `.dockerignore`와 `USER`, `HEALTHCHECK`를 추가해 개선해 보기

## 13. 빠른 요약

- Dockerfile은 이미지를 만드는 설계도입니다.
- `FROM`, `COPY`, `RUN`, `ENV`, `CMD`는 가장 자주 쓰는 핵심 지시어입니다.
- 실무에서는 멀티 스테이지 빌드, 작은 베이스 이미지, 캐시 최적화, 비루트 실행이 중요합니다.
- 개발 환경과 운영 환경은 같은 Dockerfile 안에서도 분리하는 것이 좋습니다.
- 현재 저장소 예제는 NGINX 기반 정적 웹 배포의 가장 단순하고 좋은 출발점입니다.
