# 터미널 입문 가이드

이 문서는 터미널을 처음 배우는 사람이
`자주 쓰는 터미널 명령어`, `실행 예제`, `어떤 순서로 익히면 좋은지`를
쉽게 이해할 수 있도록 정리한 입문용 안내서입니다.

실습은 macOS/Linux의 `zsh` 또는 `bash` 기준으로 설명합니다.
예제는 이 저장소 루트 디렉터리에서 실행한다고 가정합니다.

핵심 목표는 다음과 같습니다.

- 터미널이 무엇을 하는 도구인지 감을 잡는다.
- 현재 위치 확인, 이동, 파일/폴더 다루기를 익힌다.
- 파일 내용을 읽고 검색하는 기본 명령어를 익힌다.
- 명령어를 어떤 순서로 응용하면 되는지 이해한다.
- 초보자가 특히 조심해야 할 명령어를 구분할 수 있다.

---

## 1. 터미널이란?

터미널은 **명령어를 입력해서 컴퓨터에 작업을 시키는 창**입니다.

마우스로 클릭해서 작업하는 대신,
직접 명령어를 입력해서 파일을 만들거나, 이동하거나, 내용을 보거나, 프로그램을 실행할 수 있습니다.

예를 들어 터미널에서는 이런 일을 합니다.

- 지금 내가 어느 폴더에 있는지 확인한다.
- 다른 폴더로 이동한다.
- 새 파일이나 새 폴더를 만든다.
- 파일 내용을 빠르게 읽는다.
- 특정 단어가 들어 있는 파일을 찾는다.

처음에는 검은 화면처럼 보여서 어렵게 느껴질 수 있지만,
실제로는 "정해진 문장을 입력해서 컴퓨터에게 지시하는 방식"이라고 생각하면 이해가 쉽습니다.

---

## 2. 먼저 알아두면 쉬운 핵심 개념 6가지

### 2-1. 현재 위치

터미널은 항상 "지금 어느 폴더 안에서 작업 중인지"를 기준으로 동작합니다.

이 현재 위치를 확인하는 명령어가 `pwd`입니다.

```bash
pwd
```

예를 들어 결과가 아래처럼 나오면:

```bash
/Users/metastudy9997479/codyssey/ai-sw-workstation
```

지금 이 저장소의 루트 폴더 안에서 작업 중이라는 뜻입니다.

### 2-2. 폴더와 파일

터미널에서는 폴더와 파일을 구분해서 봐야 합니다.

- 폴더: 다른 파일이나 폴더를 담는 공간
- 파일: 실제 내용이 들어 있는 문서, 코드, 이미지 등

이 저장소 기준 예시:

- 폴더: `app`, `docs`, `compose`
- 파일: `README.md`, `docker_READM.md`, `git_READM.md`

### 2-3. 경로(Path)

경로는 파일이나 폴더의 위치를 뜻합니다.

자주 보는 기호:

- `.` : 현재 폴더
- `..` : 상위 폴더
- `~` : 내 홈 폴더
- `/` : 경로 구분자

예:

- `cd app` : 현재 위치에서 `app` 폴더로 이동
- `cd ..` : 한 단계 위 폴더로 이동
- `cd ~` : 홈 폴더로 이동

### 2-4. 명령어의 기본 구조

대부분의 터미널 명령어는 아래처럼 읽으면 됩니다.

```text
명령어 옵션 대상
```

예:

```bash
ls -la
```

읽는 방법:

- `ls` : 목록 보기
- `-la` : 자세히 보기 옵션

또 다른 예:

```bash
cp README.md copy.md
```

읽는 방법:

- `cp` : 복사
- `README.md` : 원본 파일
- `copy.md` : 새로 만들 복사본 이름

### 2-5. 자동완성과 이전 명령 재사용

터미널에서 꼭 익혀 두면 편한 기능입니다.

- `Tab`: 파일/폴더 이름 자동완성
- `위/아래 방향키`: 이전에 입력한 명령어 다시 불러오기
- `Ctrl + C`: 현재 실행 중인 명령 중단
- `clear`: 화면 정리

초보자는 긴 파일명을 끝까지 직접 치지 말고 `Tab`을 적극적으로 쓰는 것이 좋습니다.

### 2-6. 터미널은 매우 정확하게 동작한다

터미널은 편리하지만, 입력한 명령을 꽤 그대로 수행합니다.

예를 들어:

- 파일 삭제 명령을 잘못 입력하면 실제로 지워질 수 있고
- 폴더 위치를 잘못 이해한 채 명령을 실행하면 엉뚱한 곳이 바뀔 수 있습니다

그래서 초보자는 아래 습관이 중요합니다.

- 먼저 `pwd`로 현재 위치 확인
- `ls`로 폴더 안 내용 확인
- 그다음 명령 실행

---

## 3. 입문자가 가장 먼저 익힐 명령어

| 목적 | 명령어 | 의미 |
| --- | --- | --- |
| 현재 위치 확인 | `pwd` | 지금 작업 중인 폴더 경로 확인 |
| 목록 보기 | `ls` | 현재 폴더 안 파일/폴더 보기 |
| 자세히 보기 | `ls -la` | 숨김 파일 포함 자세히 보기 |
| 폴더 이동 | `cd 폴더명` | 다른 폴더로 이동 |
| 상위 폴더 이동 | `cd ..` | 한 단계 위로 이동 |
| 홈 폴더 이동 | `cd ~` | 내 홈 폴더로 이동 |
| 화면 정리 | `clear` | 화면을 깨끗하게 정리 |
| 폴더 만들기 | `mkdir 폴더명` | 새 폴더 생성 |
| 파일 만들기 | `touch 파일명` | 빈 파일 생성 |
| 파일 내용 보기 | `cat 파일명` | 파일 전체 내용 출력 |
| 길게 보기 | `less 파일명` | 스크롤하며 파일 읽기 |
| 파일 복사 | `cp 원본 복사본` | 파일 복사 |
| 파일 이동/이름 변경 | `mv 기존이름 새이름` | 파일 이동 또는 이름 변경 |
| 파일 삭제 | `rm 파일명` | 파일 삭제 |
| 폴더 삭제 | `rm -r 폴더명` | 폴더와 내부 내용 삭제 |
| 문자열 출력 | `echo "문장"` | 텍스트 출력 |
| 파일 검색 | `rg "단어"` | 특정 단어가 들어 있는 파일 검색 |
| 명령 기록 보기 | `history` | 이전 명령어 기록 확인 |

---

## 4. 명령어별 가장 쉬운 예제

### 4-1. `pwd`

현재 내가 어디 있는지 확인합니다.

```bash
pwd
```

초보자 팁:

헷갈리면 가장 먼저 `pwd`를 입력해도 됩니다.

### 4-2. `ls`

현재 폴더 안에 무엇이 있는지 확인합니다.

```bash
ls
```

자세히 볼 때:

```bash
ls -la
```

예를 들어 이 저장소 루트에서 보면
[`README.md`](/Users/metastudy9997479/codyssey/ai-sw-workstation/README.md),
[`docker_READM.md`](/Users/metastudy9997479/codyssey/ai-sw-workstation/docker_READM.md),
[`git_READM.md`](/Users/metastudy9997479/codyssey/ai-sw-workstation/git_READM.md),
`app/` 같은 항목을 확인할 수 있습니다.

### 4-3. `cd`

폴더를 이동합니다.

```bash
cd app
```

한 단계 위로 이동:

```bash
cd ..
```

홈 폴더로 이동:

```bash
cd ~
```

입문자 팁:

- 이동한 뒤에는 `pwd`
- 폴더 안을 보고 싶으면 `ls`

이 두 개를 같이 쓰면 실수할 가능성이 크게 줄어듭니다.

### 4-4. `mkdir`

새 폴더를 만듭니다.

```bash
mkdir terminal-practice
```

여러 단계 폴더를 한 번에 만들 때:

```bash
mkdir -p study/day1
```

### 4-5. `touch`

빈 파일을 만듭니다.

```bash
touch memo.txt
```

예:

```bash
touch terminal-practice/hello.txt
```

### 4-6. `cat`

파일 내용을 한 번에 출력합니다.

```bash
cat README.md
```

짧은 파일을 볼 때 편합니다.

예:

```bash
cat app/index.html
```

### 4-7. `less`

긴 파일을 천천히 읽을 때 사용합니다.

```bash
less README.md
```

자주 쓰는 조작:

- `Space`: 다음 화면
- `b`: 이전 화면
- `q`: 종료

### 4-8. `cp`

파일을 복사합니다.

```bash
cp README.md README-copy.md
```

폴더까지 복사할 때:

```bash
cp -r app app-copy
```

### 4-9. `mv`

파일을 옮기거나 이름을 바꿉니다.

이름 변경:

```bash
mv memo.txt note.txt
```

다른 폴더로 이동:

```bash
mv note.txt terminal-practice/
```

중요:

`mv`는 "이동"과 "이름 변경"에 모두 쓰입니다.

### 4-10. `rm`

파일을 삭제합니다.

```bash
rm memo.txt
```

폴더 삭제:

```bash
rm -r terminal-practice
```

주의:

- `rm`은 휴지통으로 보내지지 않는 경우가 많습니다.
- 특히 `rm -r`은 폴더 전체를 지웁니다.
- 초보자는 삭제 전에 `ls`로 다시 확인하는 습관이 좋습니다.

### 4-11. `echo`

텍스트를 출력합니다.

```bash
echo "hello terminal"
```

파일에 내용을 저장할 때:

```bash
echo "hello terminal" > hello.txt
```

의미:

- `>` : 새로 쓰기
- `>>` : 뒤에 이어 쓰기

예:

```bash
echo "second line" >> hello.txt
```

### 4-12. `rg`

특정 단어가 들어 있는 파일을 빠르게 찾습니다.

```bash
rg "Docker"
```

특정 파일들 안에서만 찾기:

```bash
rg "Git" README.md git_READM.md
```

입문자 팁:

코드나 문서에서 "이 단어가 어디 있지?" 싶을 때 가장 유용한 명령어 중 하나입니다.

### 4-13. `history`

이전에 실행한 명령어를 봅니다.

```bash
history
```

같이 기억할 점:

- 위 방향키를 누르면 최근 명령어를 다시 가져올 수 있습니다.

---

## 5. 입문자 추천 학습 순서

터미널은 한꺼번에 많이 외우려고 하면 금방 복잡해집니다.
아래 순서대로 익히면 훨씬 편합니다.

### 1단계. 현재 위치와 목록 보기

먼저 아래 두 개만 익히세요.

```bash
pwd
ls
```

이 단계의 목표:

- 내가 지금 어디 있는지 알기
- 현재 폴더 안에 무엇이 있는지 알기

터미널 입문자는 이 두 명령어만 익혀도 방향 감각이 크게 좋아집니다.

### 2단계. 폴더 이동 익히기

```bash
cd app
pwd
ls

cd ..
pwd
```

이 단계의 목표:

- 이동 전후에 위치가 어떻게 바뀌는지 이해하기
- `cd`, `pwd`, `ls`를 묶어서 사용하는 습관 만들기

### 3단계. 새 폴더와 파일 만들어 보기

```bash
mkdir terminal-practice
touch terminal-practice/hello.txt
ls terminal-practice
```

이 단계의 목표:

- 직접 무언가를 생성해 보기
- 폴더와 파일의 차이 감 익히기

### 4단계. 파일 내용 읽기

```bash
echo "hello terminal" > terminal-practice/hello.txt
cat terminal-practice/hello.txt
less terminal-practice/hello.txt
```

이 단계의 목표:

- 단순히 파일을 만드는 것에서 끝내지 않고
- 안에 어떤 내용이 있는지도 터미널에서 읽을 수 있다는 점 익히기

### 5단계. 복사, 이동, 이름 변경 익히기

```bash
cp terminal-practice/hello.txt terminal-practice/hello-copy.txt
mv terminal-practice/hello-copy.txt terminal-practice/hello-renamed.txt
ls terminal-practice
```

이 단계의 목표:

- 같은 파일을 복제하기
- 파일 이름을 바꾸기
- 파일을 다른 위치로 옮기기

### 6단계. 삭제는 가장 나중에 익히기

```bash
rm terminal-practice/hello-renamed.txt
ls terminal-practice
```

폴더까지 삭제할 때:

```bash
rm -r terminal-practice
```

이 단계의 목표:

- 삭제는 쉽지만 되돌리기 어렵다는 점 이해하기
- `rm`은 익숙해진 뒤 조심해서 쓰기

### 7단계. 검색으로 실전 감각 익히기

이 저장소에서 실제 문서를 검색해 볼 수 있습니다.

```bash
rg "Docker" README.md docker_READM.md
rg "Git" README.md git_READM.md
```

이 단계의 목표:

- 큰 프로젝트에서 필요한 내용을 빠르게 찾는 법 익히기
- "파일 열기 전에 검색"하는 습관 만들기

### 8단계. 리다이렉션과 이어 쓰기 익히기

```bash
echo "first line" > note.txt
echo "second line" >> note.txt
cat note.txt
```

이 단계의 목표:

- 명령어 출력 결과를 파일에 저장하는 법 익히기
- 간단한 로그, 메모, 실험 파일 만들기

초보자에게는 여기까지 익혀도 실무 기초가 꽤 탄탄해집니다.

---

## 6. 이 저장소에서 바로 해볼 수 있는 실습 예제

아래 순서대로 따라 하면 터미널 기본기를 한 번에 연습할 수 있습니다.

### 실습 1. 현재 위치와 파일 보기

```bash
pwd
ls
ls -la
```

확인 포인트:

- 내가 저장소 루트에 있는지
- 어떤 파일과 폴더가 있는지

### 실습 2. `app` 폴더 안으로 들어가 보기

```bash
cd app
pwd
ls
cat index.html
cd ..
```

확인 포인트:

- 폴더 이동이 어떻게 되는지
- 파일 내용을 바로 읽을 수 있는지

### 실습 3. 문서 검색해 보기

```bash
rg "Docker" .
rg "Git" .
```

확인 포인트:

- 단어 하나로 관련 파일을 찾아낼 수 있는지
- 문서가 많아져도 검색이 가능한지

### 실습 4. 연습용 폴더 만들어 보기

```bash
mkdir terminal-practice
touch terminal-practice/memo.txt
echo "terminal study day 1" > terminal-practice/memo.txt
cat terminal-practice/memo.txt
```

### 실습 5. 복사하고 이름 바꾸기

```bash
cp terminal-practice/memo.txt terminal-practice/memo-copy.txt
mv terminal-practice/memo-copy.txt terminal-practice/memo-final.txt
ls terminal-practice
```

### 실습 6. 정리하기

```bash
rm terminal-practice/memo-final.txt
rm terminal-practice/memo.txt
rm -r terminal-practice
```

---

## 7. 초보자가 자주 하는 실수

### 7-1. 현재 위치를 확인하지 않고 명령 실행

예를 들어 다른 폴더에 있는데 파일을 만들거나 삭제하면
원하지 않는 위치가 바뀔 수 있습니다.

해결 습관:

```bash
pwd
ls
```

를 먼저 확인합니다.

### 7-2. `rm`을 너무 빨리 사용함

삭제는 되돌리기 어려울 수 있습니다.

특히 아래 명령은 초보자가 아주 조심해야 합니다.

```bash
rm -r 폴더명
```

더 조심할 것:

```bash
rm -rf 폴더명
```

`-f`는 강제로 삭제하는 옵션이라 확인 과정이 줄어듭니다.

### 7-3. `cd` 후 어디로 갔는지 놓침

이동은 했는데 현재 위치를 모르면 바로 헷갈립니다.

해결:

```bash
cd app
pwd
ls
```

처럼 묶어서 확인합니다.

### 7-4. 파일 이름을 직접 끝까지 다 입력함

긴 이름을 매번 직접 입력하면 오타가 잘 납니다.

해결:

- 앞부분만 입력하고 `Tab` 자동완성 사용

---

## 8. 다음 단계로 배우면 좋은 것들

기초 명령어에 익숙해진 뒤에는 아래 순서로 확장하면 좋습니다.

### 다음 단계 1. 권한 이해하기

예:

```bash
ls -l
```

배우는 내용:

- 읽기, 쓰기, 실행 권한
- 왜 어떤 파일은 수정이 안 되는지

### 다음 단계 2. 프로세스와 실행 중인 프로그램 보기

예:

```bash
ps
top
```

배우는 내용:

- 지금 어떤 프로그램이 실행 중인지
- 멈추지 않는 프로그램을 어떻게 다루는지

### 다음 단계 3. 파이프와 조합

예:

```bash
history | rg docker
```

배우는 내용:

- 한 명령의 결과를 다른 명령에 넘기는 방식
- 점점 더 효율적으로 검색하는 방법

### 다음 단계 4. Git, Docker 같은 도구로 확장

터미널 기초가 잡히면
이제 터미널 위에서 Git, Docker, Python, Node.js 같은 도구를 훨씬 편하게 다룰 수 있습니다.

이 저장소 안의 입문 문서도 이어서 보면 좋습니다.

- [`git_READM.md`](/Users/metastudy9997479/codyssey/ai-sw-workstation/git_READM.md)
- [`docker_READM.md`](/Users/metastudy9997479/codyssey/ai-sw-workstation/docker_READM.md)

---

## 9. 입문자를 위한 한 줄 정리

터미널은 어려운 도구라기보다,
`현재 위치 확인 -> 이동 -> 만들기 -> 읽기 -> 복사/이동 -> 삭제 -> 검색 -> 응용`
순서로 익히면 훨씬 쉬운 도구입니다.

처음에는 아래 흐름만 반복해도 충분합니다.

```text
pwd
ls
cd
mkdir / touch
cat / less
cp / mv
rm
rg
```

핵심은 "외우는 것"보다 "작게 직접 여러 번 해보는 것"입니다.
