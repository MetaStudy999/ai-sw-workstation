# OrbStack 입문 가이드

이 문서는 OrbStack을 처음 접하는 사람이
`OrbStack 명령어`, `실행 예제`, `응용하는 순서`를 한 번에 이해할 수 있도록 정리한 안내서입니다.

특히 초보자가 가장 많이 헷갈리는 아래 2가지를 먼저 분리해서 설명합니다.

- `orb`: OrbStack 자체와 Linux 머신을 다루는 명령
- `docker`: 컨테이너, 이미지, Compose를 다루는 명령

즉, OrbStack을 쓴다고 해서 `docker` 명령이 사라지는 것은 아닙니다.
OrbStack은 Docker 엔진과 Linux 머신을 잘 돌려주는 바탕이고,
우리는 그 위에서 `orb`와 `docker`를 목적에 따라 나눠서 사용합니다.

## 1. OrbStack을 한 줄로 이해하기

OrbStack은 macOS에서
`Docker 컨테이너`와 `Linux 머신`을 빠르고 가볍게 실행할 수 있게 해주는 도구입니다.

초보자 입장에서는 이렇게 이해하면 충분합니다.

- Docker Desktop 비슷한 역할을 한다
- `docker` 명령을 그대로 사용할 수 있다
- 필요하면 Ubuntu 같은 Linux 머신도 쉽게 만들 수 있다

## 2. 먼저 구분하면 덜 헷갈리는 것

| 하고 싶은 일 | 주로 쓰는 명령 |
| --- | --- |
| OrbStack 켜기 / 끄기 | `orb start`, `orb stop`, `orb status` |
| OrbStack 버전 확인 | `orb version` |
| Linux 머신 만들기 | `orb create ubuntu my-machine` |
| Linux 머신 목록 보기 | `orb list` |
| Linux 머신 셸 들어가기 | `orb -m my-machine` |
| Linux 머신에서 명령 실행 | `orb -m my-machine uname -a` |
| Linux 파일 가져오기 / 보내기 | `orb pull`, `orb push` |
| Docker 엔진 상태 확인 | `docker info` |
| 컨테이너 실행 | `docker run ...` |
| Compose 실행 | `docker compose up -d` |

핵심은 아래처럼 기억하면 됩니다.

- `orb`는 "OrbStack과 Linux 머신 관리"
- `docker`는 "컨테이너 작업"

## 3. 입문자가 먼저 익힐 `orb` 명령어

| 명령어 | 의미 | 초보자용 해석 |
| --- | --- | --- |
| `orb help` | 도움말 보기 | OrbStack 명령어 전체 보기 |
| `orb version` | 버전 확인 | 내 컴퓨터의 OrbStack 버전 확인 |
| `orb status` | 상태 확인 | 지금 OrbStack이 켜져 있는지 확인 |
| `orb start` | 시작 | OrbStack 실행 |
| `orb stop` | 중지 | OrbStack 종료 |
| `orb list` | 머신 목록 | 만들어 둔 Linux 머신 확인 |
| `orb create ubuntu my-machine` | 머신 생성 | Ubuntu 머신 하나 만들기 |
| `orb info my-machine` | 머신 정보 | 머신 상태와 정보 확인 |
| `orb -m my-machine` | 셸 시작 | 해당 Linux 머신 안으로 들어가기 |
| `orb -m my-machine uname -a` | 명령 실행 | Linux 안에서 명령 한 줄 실행 |
| `orb push -m my-machine ...` | 파일 보내기 | Mac 파일을 Linux로 복사 |
| `orb pull -m my-machine ...` | 파일 가져오기 | Linux 파일을 Mac으로 복사 |
| `orb restart docker` | Docker 엔진 재시작 | Docker 쪽만 다시 켜기 |
| `orb logs docker` | Docker 로그 보기 | Docker 엔진 로그 확인 |
| `orb config` | 설정 변경 | OrbStack 설정 확인 / 수정 |

주의할 명령어도 있습니다.

- `orb delete my-machine`: 특정 Linux 머신 삭제
- `orb reset`: Linux와 Docker 데이터를 모두 지울 수 있는 강한 명령

초보자라면 `orb reset`은 함부로 쓰지 않는 것이 좋습니다.

## 4. 가장 쉬운 학습 순서

아래 순서대로 배우면 훨씬 덜 헷갈립니다.

### 1단계. OrbStack이 켜지는지 확인하기

```bash
orb version
orb status
orb start
orb status
```

여기서 배우는 것:

- OrbStack이 설치되어 있는지
- 현재 켜져 있는지
- `Stopped` 상태면 `orb start`로 시작하면 된다는 점

이 단계가 안 되면 뒤의 `docker` 명령도 잘 동작하지 않을 수 있습니다.

### 2단계. OrbStack 위에서 Docker가 도는지 확인하기

```bash
docker info
docker run hello-world
```

여기서 배우는 것:

- OrbStack이 Docker 엔진까지 같이 제공한다는 점
- `docker` 명령은 그대로 사용한다는 점

처음에는 "OrbStack을 배운다"와 "Docker를 배운다"가 따로 느껴질 수 있는데,
실제로는 OrbStack이 Docker 실행 환경을 제공한다고 이해하면 자연스럽습니다.

### 3단계. Linux 머신 하나 만들기

```bash
orb create ubuntu my-ubuntu
orb list
orb info my-ubuntu
```

여기서 배우는 것:

- OrbStack은 컨테이너만이 아니라 Linux 머신도 만들 수 있다는 점
- `my-ubuntu`처럼 이름을 붙여 관리한다는 점

초보자에게는 `ubuntu`가 가장 이해하기 쉽습니다.

### 4단계. Linux 머신 안으로 들어가 보기

```bash
orb -m my-ubuntu
```

머신 안으로 들어간 뒤에는 예를 들어 아래처럼 확인할 수 있습니다.

```bash
uname -a
cat /etc/os-release
pwd
exit
```

또는 셸에 들어가지 않고 한 줄만 실행할 수도 있습니다.

```bash
orb -m my-ubuntu uname -a
orb -m my-ubuntu cat /etc/os-release
```

여기서 배우는 것:

- `orb -m 머신이름`은 Linux 셸을 여는 방식
- `orb -m 머신이름 명령어`는 Linux에서 한 줄 명령을 실행하는 방식

초보자는 당분간 `-m` 옵션을 붙여 쓰는 습관이 좋습니다.
`orb`만 단독으로 실행하면 기본 머신으로 들어가는데,
처음에는 이 동작이 오히려 헷갈릴 수 있습니다.

### 5단계. Linux 머신에서 서비스 실행해 보기

예를 들어 Ubuntu 머신 안에서 NGINX를 띄우는 흐름은 아래와 같습니다.

```bash
orb -m my-ubuntu sudo apt update
orb -m my-ubuntu sudo apt install -y nginx
orb -m my-ubuntu sudo systemctl start nginx
curl http://localhost
```

여기서 배우는 것:

- Linux 머신 안에서 일반 리눅스처럼 패키지를 설치할 수 있다는 점
- 머신 안에서 띄운 서비스가 `localhost`로 연결될 수 있다는 점

이 단계까지 오면 OrbStack을 "단순한 Docker 앱"이 아니라
"Mac 위에서 Linux 개발 환경을 돌리는 도구"로 이해하게 됩니다.

### 6단계. Mac과 Linux 사이에 파일 보내기

Mac에서 파일 하나를 만들고 Linux 머신으로 보내보겠습니다.

```bash
echo "hello orbstack" > sample.txt
orb push -m my-ubuntu ./sample.txt /tmp/sample.txt
orb -m my-ubuntu cat /tmp/sample.txt
orb pull -m my-ubuntu /tmp/sample.txt ./sample-from-linux.txt
cat sample-from-linux.txt
```

여기서 배우는 것:

- `orb push`: Mac -> Linux
- `orb pull`: Linux -> Mac

실무에서는 설정 파일, 로그, 스크립트, 결과물 복사에 자주 씁니다.

### 7단계. Docker 컨테이너를 OrbStack에서 실행하기

OrbStack을 켠 상태라면 `docker` 명령은 평소처럼 사용할 수 있습니다.

```bash
docker context ls
docker info
docker run -d --name web-basic -p 8080:80 nginx:alpine
docker ps
curl http://localhost:8080
docker rm -f web-basic
```

여기서 배우는 것:

- OrbStack이 Docker 실행 환경을 제공한다는 점
- 컨테이너는 여전히 `docker run`, `docker ps`로 다룬다는 점
- 브라우저나 `curl`로 `localhost:8080`에 접속할 수 있다는 점

### 8단계. 이 저장소의 Compose 예제로 응용하기

이 저장소에는 이미 [`docker-compose.yml`](./docker-compose.yml)이 있으므로,
OrbStack이 켜진 상태에서 아래처럼 바로 실습할 수 있습니다.

```bash
docker compose up -d
docker compose ps
docker compose logs
docker compose down
```

Docker 쪽은 [`docker_READM.md`](./docker_READM.md)를 같이 보면 더 연결해서 이해하기 좋습니다.

## 5. 왜 이 순서가 좋은가

추천 순서는 아래 흐름입니다.

1. `orb status`, `orb start`
2. `docker info`, `docker run hello-world`
3. `orb create ubuntu my-ubuntu`
4. `orb -m my-ubuntu`
5. `orb push`, `orb pull`
6. Linux 서비스 실행
7. `docker run`
8. `docker compose`

이 순서가 좋은 이유는 간단합니다.

- 먼저 "OrbStack이 켜지는지" 확인하고
- 그 다음 "Docker가 실제로 도는지" 확인하고
- 그 다음 "Linux 머신"을 배우고
- 마지막에 "컨테이너와 Compose 응용"으로 넘어가기 때문입니다

처음부터 Linux 머신과 Docker Compose를 한꺼번에 배우면
무엇이 OrbStack 역할이고 무엇이 Docker 역할인지 섞이기 쉽습니다.

## 6. 초보자가 자주 헷갈리는 부분

### 6-1. `orb`와 `docker`는 역할이 다르다

아래처럼 생각하면 쉽습니다.

- `orb`: OrbStack 관리, Linux 머신 관리
- `docker`: 이미지, 컨테이너, Compose 관리

예를 들어:

- OrbStack 켜기: `orb start`
- Ubuntu 머신 만들기: `orb create ubuntu my-ubuntu`
- NGINX 컨테이너 실행: `docker run -d -p 8080:80 nginx:alpine`

### 6-2. `orb`만 입력하면 기본 머신 셸이 열린다

공식 동작은 맞지만,
초보자에게는 현재 어떤 머신에 들어간 건지 헷갈릴 수 있습니다.

처음에는 아래처럼 명시적으로 쓰는 편이 좋습니다.

```bash
orb -m my-ubuntu
```

### 6-3. `orb stop`을 하면 Docker도 같이 멈춘다

OrbStack이 꺼지면 그 위에서 돌아가던 Docker 작업도 영향을 받습니다.
그래서 `docker info`가 갑자기 안 되면 먼저 `orb status`를 확인하는 습관이 좋습니다.

### 6-4. 위험한 정리 명령은 구분해야 한다

- `orb delete my-ubuntu`: 특정 Linux 머신만 삭제
- `docker rm -f web-basic`: 특정 컨테이너만 삭제
- `orb reset`: Linux와 Docker 데이터를 크게 정리할 수 있음

특히 `orb reset`은 초보자가 실수로 쓰기엔 영향 범위가 큽니다.

### 6-5. Docker 엔진 문제와 Linux 머신 문제는 다를 수 있다

예를 들어:

- Linux 머신은 있는데 Docker만 이상하다 -> `orb restart docker`
- OrbStack 자체가 안 켜진다 -> `orb start`
- 컨테이너 문제다 -> `docker ps`, `docker logs`

문제를 역할별로 나눠 보면 훨씬 빠르게 해결할 수 있습니다.

## 7. 입문자용 최소 실습 루틴

처음 복습할 때는 아래만 반복해도 충분합니다.

```bash
orb status
orb start
docker info
docker run hello-world
orb create ubuntu my-ubuntu
orb list
orb -m my-ubuntu uname -a
echo "hello orbstack" > sample.txt
orb push -m my-ubuntu ./sample.txt /tmp/sample.txt
orb -m my-ubuntu cat /tmp/sample.txt
docker run -d --name web-basic -p 8080:80 nginx:alpine
curl http://localhost:8080
docker rm -f web-basic
```

이 흐름이 익숙해지면 OrbStack의 기본 사용법은 이미 많이 잡힌 상태입니다.

## 8. 다음에 응용하면 좋은 순서

기초를 익힌 뒤에는 아래 순서로 확장하면 좋습니다.

1. `orb info`, `orb logs`로 상태 점검 익히기
2. Linux 머신 안에서 패키지 설치와 서비스 실행하기
3. `orb push`, `orb pull`로 파일 복사 익히기
4. `docker run`으로 컨테이너 단일 실행하기
5. `docker compose`로 여러 서비스 실행하기
6. `orb restart docker`, `orb config`로 운영 느낌 익히기

## 9. 한 줄 정리

처음에는 아래 흐름만 기억하면 됩니다.

`OrbStack 켜기 -> Docker 확인 -> Linux 머신 만들기 -> Linux 명령 실행 -> 파일 복사 -> 컨테이너 실행 -> Compose 응용`
