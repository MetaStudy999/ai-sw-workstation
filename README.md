# AI/SW 개발 워크스테이션 구축

## 1. 프로젝트 개요

이 프로젝트는 macOS 공용 실습 환경에서 터미널, Docker, Git/GitHub를 이용해 **재현 가능한 개발 워크스테이션**을 구축한 결과를 정리한 문서이다.

핵심 목표는 다음과 같다.

- 터미널(CLI)로 파일/디렉토리를 생성·이동·삭제하고, 권한을 확인·변경할 수 있다.
- OrbStack 기반 Docker 환경에서 이미지와 컨테이너를 실행·관리할 수 있다.
- Dockerfile을 작성해 기존 베이스 이미지를 기반으로 커스텀 웹 서버 이미지를 만들 수 있다.
- 포트 매핑, 바인드 마운트, Docker 볼륨을 이용해 접속과 데이터 유지 여부를 검증할 수 있다.
- Git과 GitHub를 연동해 로컬 작업 결과를 원격 저장소에 반영할 수 있다.
- README만 보고도 평가자가 동일한 절차를 재현할 수 있도록 수행 로그와 증거를 남긴다.

이 문서는 필수 과제와 보너스 과제를 모두 포함한다.

---

## 2. 실행 환경

- OS: macOS Sequoia 15.7.4
- Hardware: iMac Retina 5K, 27-inch, 2019 / 3.1 GHz 6-Core Intel Core i5 / RAM 32GB
- Shell: zsh
- Terminal: macOS Terminal
- Container Runtime: OrbStack
- Docker: 28.5.2, build ecc6942
- Git: 2.53.0
- Editor: VS Code

### 2-1. 버전 확인

```bash
% sw_vers
% uname -a
% sysctl hw.memsize
$ echo "$(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024)) GB"
% echo $SHELL
% docker --version
% docker info
% git --version
% code --version
````

### 2-2. 실행 결과

```bash
% sw_vers
ProductName:		macOS
ProductVersion:		15.7.4
BuildVersion:		24G517

% uname -a
Darwin c3r6s3.codyssey.kr 24.6.0 Darwin Kernel Version 24.6.0: Mon Jan 19 22:00:10 PST 2026; root:xnu-11417.140.69.708.3~1/RELEASE_X86_64 x86_64


% sysctl hw.memsize 
hw.memsize: 34359738368


% echo "$(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024)) GB"
32 GB


% echo $SHELL
/bin/zsh


% docker --version
Docker version 28.5.2, build ecc6942


% docker info
Client:
 Version:    28.5.2
 Context:    orbstack
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.29.1
    Path:     /Users/metastudy9997479/.docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.40.3
    Path:     /Users/metastudy9997479/.docker/cli-plugins/docker-compose

Server:
 Containers: 2
  Running: 2
  Paused: 0
  Stopped: 0
 Images: 3
 Server Version: 28.5.2
 Storage Driver: overlay2
  Backing Filesystem: btrfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Swarm: inactive
 Runtimes: runc io.containerd.runc.v2
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 1c4457e00facac03ce1d75f7b6777a7a851e5c41
 runc version: d842d7719497cc3b774fd71620278ac9e17710e0
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.17.8-orbstack-00308-g8f9c941121b1
 Operating System: OrbStack
 OSType: linux
 Architecture: x86_64
 CPUs: 6
 Total Memory: 15.67GiB
 Name: orbstack
 ID: 85eb8cc9-c144-44c0-ab71-2bfbd6c68f93
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false
 Product License: Community Engine
 Default Address Pools:
   Base: 192.168.97.0/24, Size: 24
   Base: 192.168.107.0/24, Size: 24
   Base: 192.168.117.0/24, Size: 24
   Base: 192.168.147.0/24, Size: 24
   Base: 192.168.148.0/24, Size: 24
   Base: 192.168.155.0/24, Size: 24
   Base: 192.168.156.0/24, Size: 24
   Base: 192.168.158.0/24, Size: 24
   Base: 192.168.163.0/24, Size: 24
   Base: 192.168.164.0/24, Size: 24
   Base: 192.168.165.0/24, Size: 24
   Base: 192.168.166.0/24, Size: 24
   Base: 192.168.167.0/24, Size: 24
   Base: 192.168.171.0/24, Size: 24
   Base: 192.168.172.0/24, Size: 24
   Base: 192.168.181.0/24, Size: 24
   Base: 192.168.183.0/24, Size: 24
   Base: 192.168.186.0/24, Size: 24
   Base: 192.168.207.0/24, Size: 24
   Base: 192.168.214.0/24, Size: 24
   Base: 192.168.215.0/24, Size: 24
   Base: 192.168.216.0/24, Size: 24
   Base: 192.168.223.0/24, Size: 24
   Base: 192.168.227.0/24, Size: 24
   Base: 192.168.228.0/24, Size: 24
   Base: 192.168.229.0/24, Size: 24
   Base: 192.168.237.0/24, Size: 24
   Base: 192.168.239.0/24, Size: 24
   Base: 192.168.242.0/24, Size: 24
   Base: 192.168.247.0/24, Size: 24
   Base: fd07:b51a:cc66:d000::/56, Size: 64


% git --version
git version 2.53.0


% code --version
1.112.0
07ff9d6178ede9a1bd12ad3399074d726ebe6e43
x64
```

---

## 3. 프로젝트 디렉토리 구조

```text
ai-sw-workstation/
├── README.md
├── Dockerfile
├── docker-compose.yml
├── .env
├── .gitignore
├── app/
│   ├── index.html
│   └── about.html
├── compose/
│   └── nginx/
│       └── default.conf
├── data/
│   └── notes/
├── docs/
│   ├── screenshots/
│   │   ├── 01-browser-8080.png
│   │   ├── 02-vscode-github-login.png
│   │   ├── 03-github-repo.png
│   │   ├── 04-compose-browser-8080.png
│   │   └── 05-compose-multi-container.png
│   └── logs/
│       ├── terminal-basic.txt
│       ├── docker-basic.txt
│       ├── docker-volume.txt
│       └── compose.txt
└── bonus/
    └── ssh/
        └── ssh-test-log.txt
```

### 디렉토리 구조 설계 기준

* `app/`: 웹 서버가 서비스할 정적 파일 보관
* `docs/screenshots/`: 브라우저 접속, GitHub 연동, VSCode 연동 등의 시각적 증거 보관
* `docs/logs/`: 긴 로그를 별도 보관하여 README 가독성 유지
* `compose/`: 보너스 과제용 Compose 관련 설정 보관
* `data/`: 바인드 마운트나 볼륨 실험 시 사용할 샘플 데이터
* `bonus/`: SSH, Compose 확장 실험 결과 분리

이 구조는 **코드 / 증거 / 설정 / 부가 실험**을 분리하여 재현성과 가독성을 높이기 위해 설계했다.

---

## 4. 수행 체크리스트

### 4-1. 필수 과제

* [x] 터미널 기본 조작 및 폴더 구성
* [x] 절대 경로 / 상대 경로 실습
* [x] 파일 권한 확인 및 변경
* [x] Docker 버전 및 동작 점검
* [x] `docker run hello-world` 실행
* [x] Ubuntu 컨테이너 실행 및 내부 명령 수행
* [x] 이미지 / 컨테이너 목록 및 로그 확인
* [x] Dockerfile 기반 커스텀 이미지 빌드
* [x] 포트 매핑 후 브라우저 접속 확인
* [x] 바인드 마운트 반영 확인
* [x] Docker 볼륨 영속성 검증
* [x] Git 사용자 설정
* [x] GitHub 저장소 연동
* [x] VSCode GitHub 연동 증거 첨부
* [x] 트러블슈팅 2건 이상 정리
* [x] 민감정보 마스킹 확인

### 4-2. 보너스 과제

* [x] Docker Compose 단일 서비스 실행
* [x] Docker Compose 멀티 컨테이너 실행
* [x] Compose 운영 명령어 확인
* [x] 환경 변수 주입 실습
* [x] GitHub SSH 키 설정 및 테스트

---

## 5. 사전 준비

### 5-1. OrbStack 실행

공용 맥 환경에서는 `sudo` 권한 제약으로 일반적인 Docker 설치/데몬 제어가 어려울 수 있으므로, OrbStack을 실행한 뒤 터미널에서 `docker` 명령을 사용했다.

* OrbStack 앱 실행
```bash
orb status  # 상태확인
orb start   # 시작
orb stop    # 중지
```
* 터미널 실행
* `docker info`로 엔진 상태 확인

---

## 6. 터미널 기본 조작 로그

### 6-1. 작업 폴더 생성 및 이동

```bash
mkdir -p ~/codyssey/ai-sw-workstation/{app,docs/screenshots,docs/logs,data/notes,compose/nginx,bonus/ssh}
cd ~/codyssey/ai-sw-workstation
pwd
ls -la
```

### 6-2. 파일 및 디렉토리 생성 / 이동 / 복사 / 이름 변경 / 삭제

```bash
touch notes.txt
echo "hello workstation" > notes.txt
cat notes.txt

mkdir practice
cd practice
touch a.txt
cp a.txt b.txt
mv b.txt renamed.txt
ls -la
cd ..

mv practice practice_lab
ls -la

rm notes.txt
rm -rf practice_lab
ls -la
```

### 6-3. 결과 해석

* `pwd`: 현재 작업 위치 확인
* `ls -la`: 숨김 파일 포함 전체 목록 확인
* `touch`: 빈 파일 생성
* `echo > 파일명`: 파일 내용 작성
* `cat`: 파일 내용 확인
* `cp`: 복사
* `mv`: 이동 또는 이름 변경
* `rm`, `rm -rf`: 파일/디렉토리 삭제

---

## 7. 절대 경로와 상대 경로

### 7-1. 실습

```bash
mkdir -p app
echo "<h1>Hello Path</h1>" > app/path.html

cat ./app/path.html
cat /Users/$USER/codyssey/ai-sw-workstation/app/path.html
```

### 7-2. 설명

* **상대 경로**: 현재 위치를 기준으로 파일에 접근하는 방식
  예: `./app/path.html`
* **절대 경로**: 루트(`/`)부터 전체 경로를 모두 적는 방식
  예: `/Users/$USER/codyssey/ai-sw-workstation/app/path.html`

### 7-3. 언제 어떤 방식을 쓰는가

* 상대 경로: 프로젝트 내부 파일 참조, 이식성 높음
* 절대 경로: 현재 위치가 불분명할 때, 정확한 파일 위치 지정 필요 시 유용

---

## 8. 파일 권한 실습

### 8-1. 권한 확인 및 변경

```bash
touch permission_file.txt
mkdir permission_dir

ls -l permission_file.txt
ls -ld permission_dir

chmod 644 permission_file.txt
chmod 755 permission_dir

ls -l permission_file.txt
ls -ld permission_dir
```

### 8-2. 권한 의미

* `r`: read = 4
* `w`: write = 2
* `x`: execute = 1

#### 644 해석

* 소유자: `rw-` = 6
* 그룹: `r--` = 4
* 기타: `r--` = 4

#### 755 해석

* 소유자: `rwx` = 7
* 그룹: `r-x` = 5
* 기타: `r-x` = 5

### 8-3. 왜 파일과 디렉토리 권한이 다른가

* 파일은 보통 읽기/쓰기 중심으로 사용
* 디렉토리는 내부 진입과 탐색을 위해 `x` 권한이 중요

---

## 9. Docker 설치 및 기본 점검

### 9-1. 버전 및 엔진 상태 확인

```bash
docker --version
docker info
```

### 9-2. 결과 예시

```bash
% docker --version
Docker version 28.5.2, build ecc6942

% docker info
Client:
 Version:    28.5.2
 Context:    orbstack
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.29.1
    Path:     /Users/metastudy9997479/.docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.40.3
    Path:     /Users/metastudy9997479/.docker/cli-plugins/docker-compose

Server:
 Containers: 2
  Running: 2
  Paused: 0
  Stopped: 0
 Images: 3
 Server Version: 28.5.2
 Storage Driver: overlay2
  Backing Filesystem: btrfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 1c4457e00facac03ce1d75f7b6777a7a851e5c41
 runc version: d842d7719497cc3b774fd71620278ac9e17710e0
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.17.8-orbstack-00308-g8f9c941121b1
 Operating System: OrbStack
 OSType: linux
 Architecture: x86_64
 CPUs: 6
 Total Memory: 15.67GiB
 Name: orbstack
 ID: 85eb8cc9-c144-44c0-ab71-2bfbd6c68f93
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false
 Product License: Community Engine
 Default Address Pools:
   Base: 192.168.97.0/24, Size: 24
   Base: 192.168.107.0/24, Size: 24
   Base: 192.168.117.0/24, Size: 24
   Base: 192.168.147.0/24, Size: 24
   Base: 192.168.148.0/24, Size: 24
   Base: 192.168.155.0/24, Size: 24
   Base: 192.168.156.0/24, Size: 24
   Base: 192.168.158.0/24, Size: 24
   Base: 192.168.163.0/24, Size: 24
   Base: 192.168.164.0/24, Size: 24
   Base: 192.168.165.0/24, Size: 24
   Base: 192.168.166.0/24, Size: 24
   Base: 192.168.167.0/24, Size: 24
   Base: 192.168.171.0/24, Size: 24
   Base: 192.168.172.0/24, Size: 24
   Base: 192.168.181.0/24, Size: 24
   Base: 192.168.183.0/24, Size: 24
   Base: 192.168.186.0/24, Size: 24
   Base: 192.168.207.0/24, Size: 24
   Base: 192.168.214.0/24, Size: 24
   Base: 192.168.215.0/24, Size: 24
   Base: 192.168.216.0/24, Size: 24
   Base: 192.168.223.0/24, Size: 24
   Base: 192.168.227.0/24, Size: 24
   Base: 192.168.228.0/24, Size: 24
   Base: 192.168.229.0/24, Size: 24
   Base: 192.168.237.0/24, Size: 24
   Base: 192.168.239.0/24, Size: 24
   Base: 192.168.242.0/24, Size: 24
   Base: 192.168.247.0/24, Size: 24
   Base: fd07:b51a:cc66:d000::/56, Size: 64
```

### 9-3. 해석

* `docker --version`: Docker CLI 설치 확인
* `docker info`: Docker 엔진이 실제로 동작 가능한 상태인지 확인

---

## 10. Docker 기본 운영 명령

### 10-1. hello-world 실행

```bash
docker run hello-world
```

### 10-2. 이미지 / 컨테이너 목록 확인

```bash
docker images
docker ps
docker ps -a
```

### 10-3. 로그 및 리소스 확인

```bash
docker logs my-web    # 실제 컨테이너 이름
docker stats --no-stream
```


### 10-4. 해석

* `docker images`: 현재 로컬 이미지 목록 확인
* `docker ps`: 실행 중 컨테이너 확인
* `docker ps -a`: 종료된 컨테이너 포함 전체 확인
* `docker logs`: 컨테이너 로그 확인
* `docker stats --no-stream`: CPU/메모리 등 리소스 상태 1회 출력

---

## 11. Ubuntu 컨테이너 실행 및 내부 진입

### 11-1. 대화형 컨테이너 실행

```bash
docker run -it --name my-ubuntu ubuntu bash
```

### 11-2. 컨테이너 내부 명령

```bash
ls
echo "inside container"
pwd
exit
```

### 11-3. 종료 후 상태 확인

```bash
docker ps
docker ps -a
```

### 11-4. exec 방식 실습

```bash
docker run -dit --name my-ubuntu-bg ubuntu bash
docker exec -it my-ubuntu-bg bash
echo "exec test"
exit
docker ps
```

### 11-5. attach / exec 차이 정리

* `attach`: 컨테이너의 메인 프로세스에 직접 연결
* `exec`: 실행 중인 컨테이너 안에서 새로운 명령을 실행

실무에서는 보통 `exec`가 더 안전하고 자주 사용된다.

---

## 12. Dockerfile 기반 커스텀 이미지 제작

### 12-1. 선택한 베이스 이미지

이번 과제에서는 **`nginx:alpine`** 을 베이스 이미지로 선택했다.

선택 이유:

* 가볍고 빠르다
* 정적 HTML 배포가 쉽다
* 포트 매핑, 마운트, 이미지 개념을 학습하기 좋다

### 12-2. 웹 페이지 작성

`app/index.html`

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>AI/SW Workstation</title>
</head>
<body>
  <h1>AI/SW 개발 워크스테이션 구축 성공</h1>
  <p>Dockerfile 기반 커스텀 웹 서버 테스트 페이지입니다.</p>
</body>
</html>
```

### 12-3. Dockerfile 작성

```dockerfile
FROM nginx:alpine
LABEL org.opencontainers.image.title="ai-sw-workstation-web"
ENV APP_ENV=dev
COPY app/ /usr/share/nginx/html/
```

### 12-4. 커스텀 포인트와 목적

* `FROM nginx:alpine`
  → 기존 베이스 이미지를 재사용하여 웹 서버 기능 확보
* `LABEL`
  → 이미지 메타데이터 추가
* `ENV APP_ENV=dev`
  → 환경 변수 설정 예시
* `COPY app/ /usr/share/nginx/html/`
  → 정적 웹 파일을 NGINX 기본 웹 루트로 복사

### 12-5. 빌드 및 실행

```bash
docker build -t my-web:1.0 .
docker images
docker run -d -p 8080:80 --name my-web my-web:1.0
docker ps
docker logs my-web
```

---

## 13. 포트 매핑 및 접속 증거

### 13-1. 실행 명령

```bash
docker run -d -p 8080:80 --name my-web my-web:1.0
```

### 13-2. curl 검증

```bash
curl http://localhost:8080
```

### 13-3. 브라우저 접속

* 주소: `http://localhost:8080`
* 증거 파일: `docs/screenshots/01-browser-8080.png`

### 13-4. 포트 매핑이 필요한 이유

컨테이너 내부의 포트는 기본적으로 컨테이너 네트워크 내부에서만 열려 있다.
호스트(macOS) 브라우저에서 접근하려면 `-p 호스트포트:컨테이너포트` 방식으로 연결해야 한다.

예:

* 호스트 포트: `8080`
* 컨테이너 포트: `80`

즉, 브라우저는 `localhost:8080`으로 접속하지만 실제 요청은 컨테이너 내부 NGINX의 `80`번 포트로 전달된다.

---

## 14. 바인드 마운트 실습

### 14-1. 기존 컨테이너 삭제

```bash
docker rm -f my-web
```

### 14-2. 바인드 마운트로 NGINX 실행

```bash
docker run -d -p 8080:80 --name my-web-bind -v "$(pwd)/app:/usr/share/nginx/html" nginx:alpine
docker ps
curl http://localhost:8080
```

### 14-3. 호스트 파일 수정

```bash
cat > app/index.html <<'EOF'
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Bind Mount Test</title>
</head>
<body>
  <h1>바인드 마운트 반영 성공</h1>
  <p>호스트 파일 수정이 컨테이너에 바로 반영되었습니다.</p>
</body>
</html>
EOF
```

### 14-4. 재확인

```bash
curl http://localhost:8080
```

### 14-5. 설명

바인드 마운트는 **호스트 디렉토리를 컨테이너 내부 경로에 직접 연결**하는 방식이다.
이미지를 다시 빌드하지 않고도 호스트 파일 수정 내용이 즉시 반영되므로 개발 중 반복 실험에 유리하다.

---

## 15. Docker 볼륨 영속성 검증

### 15-1. 볼륨 생성

```bash
docker volume create mydata
docker volume ls
```

### 15-2. 볼륨 연결 컨테이너 실행

```bash
docker run -d --name vol-test -v mydata:/data ubuntu sleep infinity
docker ps
```

### 15-3. 데이터 생성

```bash
docker exec -it vol-test bash -lc "echo hi > /data/hello.txt && cat /data/hello.txt"
```

### 15-4. 컨테이너 삭제

```bash
docker rm -f vol-test
docker ps -a
```

### 15-5. 새 컨테이너에 동일 볼륨 연결

```bash
docker run -d --name vol-test2 -v mydata:/data ubuntu sleep infinity
docker exec -it vol-test2 bash -lc "cat /data/hello.txt"
```

### 15-6. 결과 해석

컨테이너는 삭제되었지만, 데이터가 `mydata` 볼륨에 저장되어 있으므로 새 컨테이너에서도 `hello.txt`가 그대로 남아 있다.

### 15-7. 왜 중요한가

컨테이너는 교체 가능하지만 데이터는 유지되어야 하는 경우가 많다.
따라서 데이터베이스, 업로드 파일, 애플리케이션 상태값 등은 볼륨으로 분리하는 것이 중요하다.

---

## 16. Git 설정

### 16-1. 사용자 정보 및 기본 브랜치 설정

```bash
git --version
git config --global user.name "이름"
git config --global user.email "이메일"
git config --global init.defaultBranch main
git config --list
```

### 16-2. 설명

* `user.name`: 커밋 작성자 이름
* `user.email`: 커밋 작성자 이메일
* `init.defaultBranch`: 새 저장소 기본 브랜치를 `main`으로 설정

---

## 17. Git 저장소 초기화 및 첫 커밋

### 17-1. 초기화

```bash
git init
git status
```

### 17-2. `.gitignore` 작성

```bash
cat > .gitignore <<'EOF'
.DS_Store
EOF
```

### 17-3. 첫 커밋

```bash
git add .
git commit -m "feat: initialize AI/SW workstation mission project"
```

---

## 18. GitHub 저장소 및 VSCode 연동

### 18-1. GitHub 저장소 생성

GitHub에서 `ai-sw-workstation` 저장소를 생성했다.

* 저장소 URL: `https://github.com/metastudy999/ai-sw-workstation`
* 증거 파일: `docs/screenshots/03-github-repo.png`

### 18-2. 원격 저장소 연결

```bash
git remote add origin https://github.com/metastudy999/ai-sw-workstation.git
git branch -M main
git push -u origin main
```

### 18-3. VSCode GitHub 연동

* VSCode Source Control에서 GitHub 로그인 완료
* 저장소 동기화 확인
* 증거 파일: `docs/screenshots/02-vscode-github-login.png`

### 18-4. 보안 주의

스크린샷과 로그에는 토큰, 인증 코드, 개인키, 비밀번호가 노출되지 않도록 마스킹했다.

---

## 19. Git과 GitHub의 역할 차이

* **Git**: 내 컴퓨터에서 버전 기록을 남기고 관리하는 도구
* **GitHub**: 원격 저장소를 제공하고 협업, 공유, 백업을 가능하게 하는 플랫폼

즉, Git은 **로컬 버전관리**, GitHub는 **원격 협업 플랫폼**이다.

---

## 20. Docker 이미지와 컨테이너의 차이

### 이미지

* 읽기 전용 설계도
* 빌드 결과물
* 같은 이미지로 여러 컨테이너를 만들 수 있음

### 컨테이너

* 이미지를 실제로 실행한 인스턴스
* 실행 중 상태, 로그, 프로세스, 임시 변경을 가짐
* 삭제하면 내부 변경 내용은 사라질 수 있음

### 빌드 / 실행 / 변경 관점 정리

* 빌드: Dockerfile → 이미지 생성
* 실행: 이미지 → 컨테이너 생성 및 실행
* 변경: 컨테이너 내부 변경은 기본적으로 일시적이며, 재현 가능한 변경은 Dockerfile 또는 마운트/볼륨으로 관리해야 한다

---

## 21. 검증 방법

### 21-1. 필수 항목별 검증 명령

| 항목            | 검증 명령                                                             | 결과 증거                                  |
| ------------- | ----------------------------------------------------------------- | -------------------------------------- |
| 터미널 기본 조작     | `pwd`, `ls -la`, `mkdir`, `touch`, `cp`, `mv`, `rm`               | README 코드블록                            |
| 권한 변경         | `ls -l`, `ls -ld`, `chmod`                                        | README 코드블록                            |
| Docker 동작     | `docker --version`, `docker info`                                 | README 코드블록                            |
| hello-world   | `docker run hello-world`                                          | README 코드블록                            |
| 이미지/컨테이너 확인   | `docker images`, `docker ps`, `docker ps -a`                      | README 코드블록                            |
| 로그/리소스        | `docker logs`, `docker stats --no-stream`                         | README 코드블록                            |
| Dockerfile 빌드 | `docker build -t my-web:1.0 .`                                    | README 코드블록                            |
| 포트 접속         | `curl http://localhost:8080`                                      | `docs/screenshots/01-browser-8080.png` |
| 바인드 마운트       | `docker run -v ...` + 파일 수정 후 `curl`                              | README 코드블록                            |
| 볼륨 영속성        | `docker volume create`, `docker exec`, `docker rm`, `docker exec` | README 코드블록                            |
| Git 설정        | `git config --list`                                               | README 코드블록                            |
| GitHub 연동     | `git remote -v`, `git push -u origin main`                        | GitHub/VSCode 스크린샷                     |

---

## 22. 트러블슈팅

### 트러블슈팅 1. `Cannot connect to the Docker daemon`

#### 문제

`docker info` 실행 시 Docker daemon에 연결할 수 없다는 오류가 발생했다.

#### 원인 가설

OrbStack이 실행되지 않았거나 Docker 엔진이 아직 올라오지 않았을 수 있다.

#### 확인

* OrbStack 앱 실행 여부 확인
* 메뉴바 상태 확인
* 몇 초 후 `docker info` 재실행

#### 해결

OrbStack을 실행한 뒤 `docker info`를 다시 실행하니 정상 출력되었다.

#### 대안

* OrbStack 재실행     # orb stop, orb start
* 터미널 재시작         # exec $SHELL
* 여전히 안 되면 공용 환경 관리 정책 확인

---

### 트러블슈팅 2. 호스트 포트 충돌

#### 문제

`docker run -d -p 8080:80 ...` 실행 시 포트가 이미 사용 중이라는 오류가 발생할 수 있다.

#### 원인 가설

이미 동일 포트를 사용하는 다른 컨테이너 또는 로컬 프로세스가 실행 중일 수 있다.

#### 확인

```bash
docker ps
lsof -i :8080
```

#### 해결

* 기존 컨테이너 종료/삭제
* 또는 다른 포트 사용

```bash
docker rm -f my-web
docker run -d -p 8080:80 --name my-web my-web:1.0
```

#### 대안

README에 포트 변경 가능성을 함께 기록해 재현성을 높인다.

---

### 트러블슈팅 3. 컨테이너 삭제 후 데이터 소실

#### 문제

컨테이너 안에 저장한 파일이 컨테이너 삭제 후 사라졌다.

#### 원인 가설

컨테이너 내부 파일 시스템에만 저장했고, 볼륨을 사용하지 않았기 때문이다.

#### 확인

컨테이너 재생성 후 동일 경로 파일 존재 여부 확인

#### 해결

볼륨을 생성하고 `-v mydata:/data` 방식으로 분리 저장했다.

#### 대안

* 데이터는 반드시 볼륨에 저장
* 개발 편의 목적이면 바인드 마운트 사용

---

## 23. 심층 인터뷰 대비 답변 정리

### 23-1. “호스트 포트가 이미 사용 중”이면 어떻게 진단하는가

1. `docker ps`로 이미 실행 중인 컨테이너 확인
2. `lsof -i :포트번호`로 로컬 프로세스 확인
3. 충돌 중인 프로세스/컨테이너 종료 여부 판단
4. 필요 시 다른 호스트 포트로 재실행
5. README에 실제 사용한 포트 기록

### 23-2. 컨테이너 삭제 후 데이터가 사라지는 것을 어떻게 방지하는가

* 임시 데이터는 컨테이너 내부에 둘 수 있음
* 유지할 데이터는 Docker 볼륨 또는 바인드 마운트 사용
* 운영 환경에서는 특히 볼륨 사용이 중요

### 23-3. 이 미션에서 가장 어려웠던 점

예시 작성:

* 가장 어려웠던 지점은 컨테이너 내부 포트와 호스트 포트의 관계를 이해하는 부분이었다.
* 처음에는 컨테이너가 80번 포트를 사용하므로 브라우저에서도 바로 80번으로 접근할 수 있다고 생각했다.
* 그러나 실제로는 호스트와 컨테이너의 네트워크가 분리되어 있어 `-p 8080:80` 같은 매핑이 필요했다.
* `curl http://localhost:8080` 과 브라우저 접속을 통해 이를 확인했고, 이후 포트 매핑 개념을 명확히 이해하게 되었다.

---

## 24. 보너스 과제 1: Docker Compose 기초

### 24-1. `.env`

```env
HOST_PORT=8080
APP_ENV=compose-dev
```

### 24-2. `docker-compose.yml`

```yaml
services:
  web:
    image: nginx:alpine
    container_name: compose-web
    ports:
      - "${HOST_PORT}:80"
    volumes:
      - ./app:/usr/share/nginx/html
    environment:
      APP_ENV: ${APP_ENV}
```

### 24-3. 실행

```bash
docker compose up -d
docker compose ps
docker compose logs
curl http://localhost:8080
```

### 24-4. 설명

Compose를 사용하면 길고 반복적인 `docker run` 명령을 YAML 파일에 문서화할 수 있다.
즉, 실행 설정 자체가 프로젝트 일부가 되어 재현성이 높아진다.

---

## 25. 보너스 과제 2: Docker Compose 멀티 컨테이너

### 25-1. 멀티 컨테이너 예시

```yaml
services:
  web:
    image: nginx:alpine
    container_name: compose-web
    ports:
      - "8080:80"
    volumes:
      - ./app:/usr/share/nginx/html
    depends_on:
      - helper

  helper:
    image: alpine
    container_name: compose-helper
    command: ["sh", "-c", "while true; do echo helper-running; sleep 30; done"]
```

### 25-2. 실행

```bash
docker compose up -d
docker compose ps
docker compose logs
```

### 25-3. 네트워크 통신 개념 설명

Compose는 기본적으로 같은 프로젝트 내 서비스들을 하나의 네트워크에 배치한다.
따라서 서비스 이름(`web`, `helper`) 자체가 내부 DNS 이름처럼 동작할 수 있다.

### 25-4. 증거

* `docs/screenshots/05-compose-multi-container.png`

---

## 26. 보너스 과제 3: Compose 운영 명령어

### 실행

```bash
docker compose up -d
```

### 상태 확인

```bash
docker compose ps
```

### 로그 확인

```bash
docker compose logs
docker compose logs web
```

### 종료 및 정리

```bash
docker compose down
```

### 설명

* `up`: 서비스 기동
* `ps`: 상태 확인
* `logs`: 로그 확인
* `down`: 종료 및 네트워크 정리

이 흐름은 운영 관점의 기본 점검 루틴이다.

---

## 27. 보너스 과제 4: 환경 변수 활용

### 27-1. `.env` 파일

```env
HOST_PORT=8080
APP_ENV=compose-dev
```

### 27-2. Compose 파일에서 사용

```yaml
ports:
  - "${HOST_PORT}:80"
environment:
  APP_ENV: ${APP_ENV}
```

### 27-3. 설명

설정을 코드와 분리하면 포트, 모드, 경로 같은 값을 환경별로 쉽게 바꿀 수 있다.
즉, 코드 수정 없이 실행 설정만 변경 가능하다.

---

## 28. 보너스 과제 5: GitHub SSH 키 설정

### 28-1. SSH 키 생성

```bash
ssh-keygen -t ed25519 -C "metastudy999@gmail.com"
```

### 28-2. 공개키 확인

```bash
cat ~/.ssh/id_ed25519.pub
```

### 28-3. GitHub에 공개키 등록 후 테스트

```bash
ssh -T git@github.com
```

### 28-4. 원격 저장소 주소를 SSH 방식으로 변경

```bash
git remote set-url origin git@github.com:metastudy999/ai-sw-workstation.git
git remote -v
git push
```

### 28-5. 설명

* HTTPS: 로그인/토큰 기반
* SSH: 키 기반 인증
* SSH는 반복 푸시 시 더 편리하고 안전한 인증 습관을 만들 수 있다.

---

## 29. 증거 파일 목록

| 종류                | 파일                                                |
| ----------------- | ------------------------------------------------- |
| 브라우저 접속           | `docs/screenshots/01-browser-8080.png`            |
| VSCode GitHub 로그인 | `docs/screenshots/02-vscode-github-login.png`     |
| GitHub 저장소 화면     | `docs/screenshots/03-github-repo.png`             |
| Compose 브라우저 접속   | `docs/screenshots/04-compose-browser-8080.png`    |
| Compose 멀티 컨테이너   | `docs/screenshots/05-compose-multi-container.png` |
| 터미널 로그            | `docs/logs/terminal-basic.txt`                    |
| Docker 로그         | `docs/logs/docker-basic.txt`                      |
| 볼륨 로그             | `docs/logs/docker-volume.txt`                     |
| Compose 로그        | `docs/logs/compose.txt`                           |
| SSH 테스트 로그        | `bonus/ssh/ssh-test-log.txt`                      |

---

## 30. 보안 및 개인정보 보호

* README와 로그, 스크린샷에 토큰·비밀번호·개인키·인증 코드가 노출되지 않도록 확인했다.
* 이메일이나 사용자 계정이 노출될 경우 일부 마스킹 처리했다.
* SSH 공개키는 공개 가능하지만, 개인키(`~/.ssh/id_ed25519`)는 절대 저장소에 올리지 않았다.
* `.gitignore`로 불필요한 로컬 파일을 제외했다.

---

## 31. 최종 결론

이번 과제를 통해 다음을 직접 확인했다.

1. 터미널만으로 기본 파일 시스템 작업과 권한 제어가 가능하다.
2. OrbStack 환경에서 Docker 엔진을 사용해 컨테이너를 실행할 수 있다.
3. Dockerfile을 통해 기존 베이스 이미지를 바탕으로 커스텀 이미지를 만들 수 있다.
4. 포트 매핑을 통해 컨테이너 내부 서비스에 호스트 브라우저로 접속할 수 있다.
5. 바인드 마운트는 개발 중 빠른 변경 반영에 유리하다.
6. Docker 볼륨은 컨테이너 삭제 후에도 데이터를 유지하게 해 준다.
7. Git은 로컬 버전관리, GitHub는 원격 협업 플랫폼이라는 역할 차이가 명확하다.
8. Compose를 사용하면 실행 설정이 문서화되어 재현성이 높아진다.
9. SSH 인증은 반복적인 GitHub 작업에 더 효율적인 방식이다.

이 문서는 필수 과제와 보너스 과제를 모두 포함하며, README만으로도 동일한 절차를 따라 개발 워크스테이션을 재현할 수 있도록 구성하였다.
