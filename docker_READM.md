# Docker 입문 가이드

이 문서는 Docker를 처음 접하는 사람이 이 저장소를 예제로 삼아
`docker 명령어`, `실행 예제`, `응용하는 순서`를 한 번에 이해할 수 있도록 정리한 안내서입니다.

실습은 이 프로젝트 루트 디렉토리에서 진행한다고 가정합니다.

## 1. 먼저 잡아야 할 핵심 개념 6가지

### 1-1. 이미지(Image)

이미지는 컨테이너를 만들기 위한 설계도입니다.

예:

- `nginx:alpine`
- `ubuntu`
- `my-web:1.0`

쉽게 말해 "실행 가능한 템플릿"이라고 생각하면 됩니다.

### 1-2. 컨테이너(Container)

컨테이너는 이미지를 실제로 실행한 결과물입니다.

예:

- `docker run nginx:alpine`

이미지는 설계도이고, 컨테이너는 실제로 돌아가는 프로그램입니다.

### 1-3. Dockerfile

Dockerfile은 "내 이미지를 어떻게 만들지"를 적는 레시피 파일입니다.

이 프로젝트의 [`Dockerfile`](/Users/metastudy9997479/codyssey/ai-sw-workstation/Dockerfile)는
`nginx:alpine` 이미지를 바탕으로 `app/` 폴더의 정적 웹 파일을 복사합니다.

### 1-4. 포트 매핑(Port Mapping)

컨테이너 안에서 웹 서버가 돌아가도, 바깥에서 바로 접속되지는 않습니다.
그래서 `-p 호스트포트:컨테이너포트` 형식으로 연결해야 합니다.

예:

```bash
docker run -p 8080:80 nginx:alpine
```

의미:

- 내 컴퓨터 `8080` 포트로 들어온 요청을
- 컨테이너 내부 `80` 포트로 전달

### 1-5. 바인드 마운트(Bind Mount)

내 컴퓨터의 폴더를 컨테이너 안에 그대로 연결하는 방식입니다.

개발할 때 자주 씁니다.
파일을 수정하면 이미지를 다시 빌드하지 않아도 바로 반영됩니다.

### 1-6. 볼륨(Volume)

컨테이너를 지워도 데이터를 남기고 싶을 때 사용합니다.

예:

- 업로드 파일
- 데이터베이스 데이터
- 캐시

핵심은:

- 바인드 마운트는 "내 폴더를 연결"
- 볼륨은 "Docker가 관리하는 저장 공간"

## 2. 이 프로젝트에서 보는 Docker 관련 파일

- [`Dockerfile`](/Users/metastudy9997479/codyssey/ai-sw-workstation/Dockerfile): 커스텀 NGINX 이미지 빌드
- [`docker-compose.yml`](/Users/metastudy9997479/codyssey/ai-sw-workstation/docker-compose.yml): 여러 컨테이너 설정
- [`.env`](/Users/metastudy9997479/codyssey/ai-sw-workstation/.env): Compose 환경 변수
- [`app/index.html`](/Users/metastudy9997479/codyssey/ai-sw-workstation/app/index.html): 웹 페이지 예제
- [`compose/nginx/default.conf`](/Users/metastudy9997479/codyssey/ai-sw-workstation/compose/nginx/default.conf): NGINX 설정

이 저장소는 Docker를 배우기에 좋은 흐름을 이미 갖추고 있습니다.

- `nginx:alpine`으로 웹 서버를 띄워 볼 수 있고
- `Dockerfile`로 이미지를 직접 만들 수 있고
- `docker compose`로 멀티 컨테이너도 실습할 수 있습니다

## 3. 입문자가 가장 먼저 익힐 명령어

| 목적 | 명령어 | 의미 |
| --- | --- | --- |
| Docker 설치 확인 | `docker --version` | Docker CLI 버전 확인 |
| 엔진 상태 확인 | `docker info` | Docker가 실제 실행 가능한지 확인 |
| 이미지 실행 | `docker run 이미지명` | 이미지를 실행해서 컨테이너 생성 |
| 이미지 목록 | `docker images` | 로컬 이미지 확인 |
| 실행 중 컨테이너 | `docker ps` | 현재 실행 중인 컨테이너 확인 |
| 전체 컨테이너 | `docker ps -a` | 종료된 것까지 모두 확인 |
| 로그 보기 | `docker logs 컨테이너명` | 컨테이너 출력 확인 |
| 컨테이너 내부 실행 | `docker exec -it 컨테이너명 bash` | 실행 중인 컨테이너에 들어가기 |
| 이미지 빌드 | `docker build -t 이름:태그 .` | Dockerfile로 이미지 생성 |
| 컨테이너 삭제 | `docker rm -f 컨테이너명` | 컨테이너 강제 종료 후 삭제 |
| 볼륨 생성 | `docker volume create 이름` | 영속 저장소 생성 |
| Compose 실행 | `docker compose up -d` | 여러 서비스 백그라운드 실행 |
| Compose 상태 | `docker compose ps` | Compose 서비스 상태 확인 |
| Compose 종료 | `docker compose down` | Compose 서비스 종료 및 정리 |

## 4. 입문자 추천 학습 순서

아래 순서대로 진행하면 Docker를 훨씬 덜 헷갈리게 배울 수 있습니다.

### 1단계. Docker가 준비되었는지 확인하기

```bash
docker --version
docker info
```

여기서 확인할 것:

- Docker 명령이 실행되는가
- 엔진이 살아 있는가

이 단계가 안 되면 다음 단계는 전부 막힙니다.

### 2단계. 가장 작은 예제로 컨테이너 감 잡기

```bash
docker run hello-world
```

배우는 내용:

- 이미지를 처음 받으면 자동으로 pull 된다는 점
- `run` 한 번으로 이미지 다운로드와 컨테이너 실행이 같이 일어난다는 점

이 명령은 아주 짧지만 Docker의 핵심 동작을 가장 압축해서 보여줍니다.

### 3단계. 웹 서버를 바로 실행해서 포트 감 익히기

```bash
docker run -d --name web-basic -p 8080:80 nginx:alpine
docker ps
curl http://localhost:8080
docker logs web-basic
```

배우는 내용:

- `-d`: 백그라운드 실행
- `--name`: 컨테이너 이름 지정
- `-p 8080:80`: 내 컴퓨터 8080 포트를 컨테이너 80 포트에 연결

실습이 끝나면 정리:

```bash
docker rm -f web-basic
```

이 단계에서 제일 중요하게 이해할 점은 "컨테이너 내부 포트와 내 컴퓨터 포트는 다를 수 있다"는 것입니다.

### 4단계. Dockerfile로 내 이미지를 직접 만들기

이 프로젝트의 [`Dockerfile`](/Users/metastudy9997479/codyssey/ai-sw-workstation/Dockerfile)는
`app/` 폴더 내용을 NGINX 웹 루트에 복사합니다.

실행:

```bash
docker build -t my-web:1.0 .
docker images
docker run -d --name my-web -p 8080:80 my-web:1.0
curl http://localhost:8080
docker logs my-web
```

배우는 내용:

- 베이스 이미지에서 내 이미지를 만드는 방법
- `COPY`가 실제로 웹 페이지 반영과 연결된다는 점
- "공식 이미지 사용"에서 "내 이미지 제작"으로 넘어가는 흐름

정리:

```bash
docker rm -f my-web
```

### 5단계. 바인드 마운트로 개발 흐름 이해하기

이미지를 다시 빌드하지 않고 바로 파일 반영이 되는 경험을 해보는 단계입니다.

```bash
docker run -d --name my-web-bind -p 8080:80 \
  -v "$(pwd)/app:/usr/share/nginx/html" \
  nginx:alpine
curl http://localhost:8080
```

이제 호스트의 [`app/index.html`](/Users/metastudy9997479/codyssey/ai-sw-workstation/app/index.html)을 수정하고
브라우저를 새로고침하거나 다시 `curl` 해보면 즉시 반영됩니다.

배우는 내용:

- 개발할 때는 바인드 마운트가 왜 편한지
- 이미지 빌드와 실시간 수정의 차이

정리:

```bash
docker rm -f my-web-bind
```

### 6단계. 볼륨으로 데이터가 남는 이유 이해하기

```bash
docker volume create mydata
docker volume ls
docker run -d --name vol-test -v mydata:/data ubuntu sleep infinity
docker exec -it vol-test bash -lc "echo hi > /data/hello.txt && cat /data/hello.txt"
docker rm -f vol-test
docker run -d --name vol-test2 -v mydata:/data ubuntu sleep infinity
docker exec -it vol-test2 bash -lc "cat /data/hello.txt"
```

배우는 내용:

- 컨테이너는 지워져도
- 볼륨에 넣은 데이터는 남는다는 점

이 단계부터 "애플리케이션"과 "데이터"를 분리하는 사고가 생깁니다.

정리:

```bash
docker rm -f vol-test2
docker volume rm mydata
```

### 7단계. `docker compose`로 설정을 파일로 관리하기

이 프로젝트의 [`docker-compose.yml`](/Users/metastudy9997479/codyssey/ai-sw-workstation/docker-compose.yml)은
`web`과 `helper` 두 서비스를 정의합니다.

실행:

```bash
docker compose up -d
docker compose ps
docker compose logs
curl http://localhost:8080
curl http://localhost:8080/health
```

배우는 내용:

- 긴 `docker run` 명령을 YAML 파일로 옮겨 관리하는 방법
- 환경 변수와 볼륨 설정을 반복 없이 재사용하는 방법
- 여러 컨테이너를 하나의 프로젝트처럼 다루는 방법

종료:

```bash
docker compose down
```

## 5. 왜 이 순서가 좋은가

추천 순서는 아래처럼 이해하면 됩니다.

1. `docker run hello-world`
2. `docker run nginx:alpine`
3. `docker build`
4. `docker run -v ...`
5. `docker volume ...`
6. `docker compose up`

이 순서가 좋은 이유:

- 먼저 "실행"을 이해하고
- 그 다음 "내 이미지 만들기"를 배우고
- 그 다음 "개발 중 수정 반영"을 경험하고
- 마지막에 "데이터 유지"와 "여러 컨테이너 관리"로 확장할 수 있기 때문입니다

처음부터 Compose를 배우면 편해 보이지만,
`run`, `build`, `volume` 개념이 약하면 설정 파일이 더 어렵게 느껴질 수 있습니다.

## 6. 이 저장소 기준으로 이해하면 좋은 포인트

### 6-1. `Dockerfile`

현재 [`Dockerfile`](/Users/metastudy9997479/codyssey/ai-sw-workstation/Dockerfile)의 핵심은 아래 3가지입니다.

```dockerfile
FROM nginx:alpine
ENV APP_ENV=dev
COPY app/ /usr/share/nginx/html/
```

의미:

- `FROM`: 공식 NGINX 이미지를 기반으로 사용
- `ENV`: 환경 변수 예제
- `COPY`: 로컬 `app/` 폴더를 컨테이너 안으로 복사

### 6-2. `docker-compose.yml`

현재 [`docker-compose.yml`](/Users/metastudy9997479/codyssey/ai-sw-workstation/docker-compose.yml)은
아래 개념을 한 번에 보여줍니다.

- 포트 매핑
- 바인드 마운트
- 환경 변수 사용
- 멀티 컨테이너
- `depends_on`

초보자 입장에서는 "명령어로 길게 쓰던 내용을 파일로 옮긴 것"이라고 이해하면 충분합니다.

### 6-3. `default.conf`

[`compose/nginx/default.conf`](/Users/metastudy9997479/codyssey/ai-sw-workstation/compose/nginx/default.conf)에는
`/health` 경로가 들어 있습니다.

그래서 Compose 실행 뒤 아래처럼 헬스 체크 느낌으로 확인할 수 있습니다.

```bash
curl http://localhost:8080/health
```

## 7. 초보자가 자주 헷갈리는 부분

### 7-1. `EXPOSE`와 `-p`는 다르다

`Dockerfile`의 `EXPOSE`는 "이 포트를 사용한다"는 문서 성격의 메타데이터입니다.
실제로 내 컴퓨터에서 접속하려면 `docker run -p 8080:80 ...` 같은 포트 매핑이 필요합니다.

이 프로젝트는 실행 예제를 `8080:80` 기준으로 이해하면 됩니다.
즉, 브라우저는 `localhost:8080`으로 접속하고 실제 요청은 컨테이너 내부 NGINX의 `80` 포트로 전달됩니다.

### 7-2. `run`은 생성까지 같이 한다

`docker start`는 이미 있는 컨테이너를 다시 켜는 명령이고,
`docker run`은 이미지로부터 컨테이너를 새로 만들면서 실행합니다.

### 7-3. 이름이 겹치면 실행이 안 된다

예를 들어 `my-web`이라는 이름이 이미 있으면 같은 이름으로 다시 만들 수 없습니다.

확인:

```bash
docker ps -a
```

정리:

```bash
docker rm -f my-web
```

### 7-4. 포트가 이미 사용 중이면 충돌한다

`8080` 포트를 다른 프로그램이 쓰고 있으면 실행이 실패할 수 있습니다.

해결 방법:

- 기존 컨테이너 종료
- 다른 포트 사용

예:

```bash
docker run -d --name my-web -p 8081:80 my-web:1.0
```

## 8. 초보자용 최소 실습 루틴

처음 복습할 때는 아래만 반복해도 충분합니다.

```bash
docker --version
docker run hello-world
docker run -d --name web-basic -p 8080:80 nginx:alpine
docker ps
curl http://localhost:8080
docker rm -f web-basic
docker build -t my-web:1.0 .
docker run -d --name my-web -p 8080:80 my-web:1.0
curl http://localhost:8080
docker rm -f my-web
docker compose up -d
docker compose ps
docker compose down
```

이 흐름만 자연스럽게 이해해도 Docker의 기본기는 꽤 탄탄해집니다.

## 9. 다음에 응용하면 좋은 주제

기초를 익힌 뒤에는 아래 순서로 확장하면 좋습니다.

1. `docker exec`로 컨테이너 내부 점검
2. 볼륨과 바인드 마운트 차이 반복 실습
3. `.env`를 활용한 설정 분리
4. `docker compose` 멀티 컨테이너 운영
5. 데이터베이스 컨테이너 추가
6. 배포용 Dockerfile과 개발용 Dockerfile 분리

## 10. 한 줄 정리

처음에는 아래 흐름만 기억하면 됩니다.

`이미지 받기 -> 컨테이너 실행 -> 포트 연결 -> 내 이미지 빌드 -> 마운트 -> 볼륨 -> Compose`
