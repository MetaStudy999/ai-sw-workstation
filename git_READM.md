# Git 입문 가이드

이 문서는 Git을 처음 배우는 사람이 `무슨 명령어를`, `언제`, `어떤 순서로` 써야 하는지 쉽게 이해할 수 있도록 정리한 입문용 안내서입니다.

핵심 목표는 다음과 같습니다.

- Git의 기본 개념을 어렵지 않게 이해한다.
- 자주 쓰는 Git 명령어를 예제와 함께 익힌다.
- 혼자 작업할 때의 기본 흐름을 먼저 익힌다.
- 이후 브랜치, 병합, GitHub 연동까지 순서대로 응용할 수 있다.

---

## 1. Git이란?

Git은 **파일 변경 이력을 기록하고 관리하는 도구**입니다.

예를 들어 문서를 수정하다가:

- "어제 상태로 되돌리고 싶다"
- "어떤 부분이 바뀌었는지 보고 싶다"
- "기능별로 따로 작업하고 싶다"
- "GitHub에 올려서 백업하거나 팀원과 협업하고 싶다"

이럴 때 Git을 사용합니다.

쉽게 말하면 Git은:

- 파일의 변경 기록을 저장하고
- 원하는 시점으로 되돌아갈 수 있게 해 주고
- 여러 사람이 함께 작업하기 쉽게 만들어 주는 도구입니다.

---

## 2. 먼저 알아두면 쉬운 핵심 개념 4가지

Git 명령어를 외우기 전에 아래 4가지를 먼저 이해하면 훨씬 쉽습니다.

### 2-1. 작업 폴더(Working Directory)

내가 실제로 파일을 만들고 수정하는 공간입니다.

예:

- `README.md` 내용을 수정한다.
- `app.js` 파일을 새로 만든다.

아직 Git에 "이 변경을 저장해 주세요"라고 말한 상태는 아닙니다.

### 2-2. 스테이징 영역(Staging Area)

커밋하기 전에 **이번 기록에 포함할 파일을 고르는 중간 공간**입니다.

예:

- 파일 3개를 수정했지만
- 그중 2개만 이번 커밋에 넣고 싶을 때

`git add`로 스테이징 영역에 올립니다.

### 2-3. 로컬 저장소(Local Repository)

내 컴퓨터 안에 있는 Git 저장 기록입니다.

`git commit`을 하면 변경 내용이 로컬 저장소에 기록됩니다.

### 2-4. 원격 저장소(Remote Repository)

GitHub 같은 인터넷 저장소입니다.

로컬에서 커밋한 뒤 `git push`를 하면 원격 저장소에 업로드됩니다.

---

## 3. Git 작업 흐름 한눈에 보기

초보자는 아래 흐름을 먼저 익히면 됩니다.

```text
파일 수정
  ↓
git status
  ↓
git add
  ↓
git commit
  ↓
git log
  ↓
(필요하면) git push
```

가장 중요한 것은 다음 한 줄입니다.

**수정 -> 확인 -> 추가 -> 커밋 -> 업로드**

---

## 4. 가장 자주 쓰는 Git 명령어

아래 명령어부터 익히면 Git의 기본 작업은 대부분 할 수 있습니다.

### 4-1. `git init`

현재 폴더를 Git 저장소로 시작합니다.

```bash
git init
```

언제 쓰나:

- 새 프로젝트를 처음 Git으로 관리할 때

참고:

- 환경에 따라 첫 기본 브랜치 이름이 `main`이 아닐 수 있습니다.
- 예제에서 `main`을 사용했는데 내 환경이 `master`라면 같은 위치에 `master`를 넣어 사용하면 됩니다.

### 4-2. `git clone`

이미 존재하는 원격 저장소를 내 컴퓨터로 복사합니다.

```bash
git clone https://github.com/username/sample-project.git
```

언제 쓰나:

- GitHub에 있는 프로젝트를 받아서 작업할 때

### 4-3. `git status`

현재 어떤 파일이 변경되었는지 보여 줍니다.

```bash
git status
```

언제 쓰나:

- 명령어를 실행하기 전후로 항상 확인할 때
- 무엇이 수정되었는지 헷갈릴 때

입문자 팁:

**Git이 헷갈리면 일단 `git status`부터 확인하면 됩니다.**

### 4-4. `git add`

커밋할 파일을 스테이징 영역에 올립니다.

```bash
git add README.md
```

모든 변경 파일을 한 번에 올릴 때:

```bash
git add .
```

언제 쓰나:

- 커밋하기 전에 "이번 기록에 넣을 파일"을 선택할 때

### 4-5. `git commit`

스테이징한 변경 사항을 하나의 기록으로 저장합니다.

```bash
git commit -m "README 파일 추가"
```

언제 쓰나:

- 작업 단위가 끝났을 때
- 되돌릴 수 있는 의미 있는 저장 지점을 만들 때

좋은 커밋 메시지 예시:

- `git commit -m "로그인 화면 레이아웃 추가"`
- `git commit -m "버튼 색상 오류 수정"`
- `git commit -m "README 사용법 문서 작성"`

### 4-6. `git log`

지금까지의 커밋 기록을 확인합니다.

```bash
git log
```

짧게 볼 때:

```bash
git log --oneline
```

언제 쓰나:

- 이전 작업 기록을 확인할 때
- 커밋이 잘 저장되었는지 확인할 때

### 4-7. `git diff`

수정된 내용을 비교해서 보여 줍니다.

```bash
git diff
```

스테이징한 내용까지 확인할 때:

```bash
git diff --staged
```

언제 쓰나:

- 정확히 무엇이 바뀌었는지 보고 싶을 때
- 커밋 전에 마지막 확인을 하고 싶을 때

### 4-8. `git branch`

브랜치 목록을 확인하거나 새 브랜치를 만듭니다.

현재 브랜치 목록 확인:

```bash
git branch
```

새 브랜치 만들기:

```bash
git branch feature/login
```

### 4-9. `git switch`

브랜치를 이동합니다.

```bash
git switch feature/login
```

새 브랜치를 만들면서 바로 이동:

```bash
git switch -c feature/login
```

언제 쓰나:

- 메인 작업과 별도로 새 기능을 만들 때

### 4-10. `git merge`

다른 브랜치의 작업 내용을 현재 브랜치에 합칩니다.

```bash
git merge feature/login
```

언제 쓰나:

- 기능 개발이 끝난 브랜치를 메인 브랜치에 합칠 때

### 4-11. `git remote -v`

연결된 원격 저장소 주소를 확인합니다.

```bash
git remote -v
```

### 4-12. `git push`

로컬 커밋을 원격 저장소(GitHub)에 업로드합니다.

```bash
git push origin main
```

언제 쓰나:

- 커밋한 내용을 GitHub에 올릴 때

참고:

- 내 기본 브랜치가 `master`라면 `git push origin master`처럼 사용합니다.

### 4-13. `git pull`

원격 저장소의 최신 변경 내용을 가져와 현재 브랜치에 반영합니다.

```bash
git pull origin main
```

언제 쓰나:

- 다른 컴퓨터에서 작업한 내용을 가져올 때
- 협업 중 최신 상태를 반영할 때

참고:

- 내 기본 브랜치가 `master`라면 `git pull origin master`처럼 사용합니다.

---

## 5. 입문자 추천 학습 순서

처음부터 모든 명령어를 다 외우려고 하지 말고 아래 순서로 익히는 것을 추천합니다.

### 1단계. 로컬에서 혼자 쓰는 기본 흐름 익히기

먼저 아래 5개만 집중해서 연습합니다.

- `git init`
- `git status`
- `git add`
- `git commit`
- `git log`

이 단계의 목표:

- 파일 수정 후 커밋까지 자연스럽게 할 수 있다.

### 2단계. 변경 내용 확인하는 습관 만들기

그다음 아래 명령어를 추가합니다.

- `git diff`
- `git restore`
- `git restore --staged`

이 단계의 목표:

- 실수했을 때 되돌리는 기본 감각을 익힌다.

### 3단계. 브랜치로 작업 분리하기

이제 아래 명령어를 연습합니다.

- `git branch`
- `git switch -c`
- `git merge`

이 단계의 목표:

- 메인 브랜치를 안전하게 유지하면서 기능별 작업을 할 수 있다.

### 4단계. GitHub와 연결하기

마지막으로 아래 명령어를 익힙니다.

- `git remote -v`
- `git push`
- `git pull`
- `git clone`

이 단계의 목표:

- 로컬 작업을 GitHub와 연결해 백업하고 공유할 수 있다.

---

## 6. 가장 쉬운 실습 예제

아래 예제는 Git을 처음 써 보는 사람이 따라 하기 좋은 가장 기본적인 흐름입니다.

### 6-1. 새 폴더 만들기

```bash
mkdir git-practice
cd git-practice
```

### 6-2. Git 저장소 시작하기

```bash
git init
```

### 6-3. 파일 하나 만들기

```bash
echo "# Git Practice" > README.md
```

### 6-4. 상태 확인하기

```bash
git status
```

예상 의미:

- `README.md`가 새 파일로 보인다.
- 아직 커밋되지 않았다.

### 6-5. 스테이징하기

```bash
git add README.md
```

### 6-6. 다시 상태 확인하기

```bash
git status
```

예상 의미:

- `README.md`가 커밋할 준비가 된 상태로 보인다.

### 6-7. 첫 커밋 만들기

```bash
git commit -m "첫 README 추가"
```

### 6-8. 커밋 기록 보기

```bash
git log --oneline
```

이렇게 하면 Git의 가장 기본 흐름을 한 번 경험한 것입니다.

---

## 7. 두 번째 실습: 수정 후 다시 커밋하기

이제 기존 파일을 수정해 보고 다시 커밋해 보겠습니다.

### 7-1. 파일 수정하기

```bash
echo "Git 연습 중입니다." >> README.md
```

### 7-2. 무엇이 바뀌었는지 보기

```bash
git diff
```

### 7-3. 상태 확인하기

```bash
git status
```

### 7-4. 스테이징하고 커밋하기

```bash
git add README.md
git commit -m "README 설명 한 줄 추가"
```

### 7-5. 기록 확인하기

```bash
git log --oneline
```

이제 "처음 만들기"와 "수정 후 다시 저장하기"까지 익힌 상태입니다.

---

## 8. 세 번째 실습: 브랜치 사용하기

브랜치는 "작업을 따로 분리하는 가지"라고 생각하면 쉽습니다.

예를 들어:

- `main`: 안정적인 기본 버전
- `feature/login`: 로그인 기능 개발용 작업 공간

참고:

- 아래 예제에서는 기본 브랜치를 `main`이라고 가정합니다.
- 만약 내 저장소가 `master`를 사용 중이면 `main` 대신 `master`로 바꿔서 따라 하면 됩니다.

### 8-1. 새 브랜치 만들고 이동하기

```bash
git switch -c feature/header
```

### 8-2. 파일 수정 후 커밋하기

```bash
echo "헤더 기능 작업 중" >> README.md
git add README.md
git commit -m "헤더 기능 설명 추가"
```

### 8-3. 메인 브랜치로 돌아가기

```bash
git switch main
```

### 8-4. 브랜치 병합하기

```bash
git merge feature/header
```

이 과정을 통해:

- 메인 작업을 보호하면서
- 새 기능을 따로 실험하고
- 완료되면 합칠 수 있습니다.

---

## 9. GitHub까지 연결하는 기본 흐름

로컬에서만 작업해도 Git은 유용하지만, GitHub와 연결하면 더 편리합니다.

할 수 있는 일:

- 작업 백업
- 다른 사람과 공유
- 다른 컴퓨터에서 이어서 작업
- 협업 및 코드 리뷰

### 9-1. 원격 저장소 연결 확인

```bash
git remote -v
```

### 9-2. 첫 업로드

```bash
git push origin main
```

### 9-3. 원격의 최신 내용 가져오기

```bash
git pull origin main
```

입문자 팁:

- 작업 시작 전 `git pull`
- 작업 종료 후 `git push`

이 습관만 있어도 협업 실수를 많이 줄일 수 있습니다.

---

## 10. 자주 하는 실수와 해결 명령어

처음에는 실수해도 괜찮습니다. 아래 명령어를 알아두면 훨씬 안심하고 연습할 수 있습니다.

### 10-1. 스테이징만 취소하고 싶을 때

```bash
git restore --staged README.md
```

의미:

- `git add`한 것을 취소한다.
- 파일 내용 수정 자체는 남아 있다.

### 10-2. 작업 폴더의 수정 내용까지 되돌리고 싶을 때

```bash
git restore README.md
```

주의:

- 최근 수정 내용이 사라질 수 있으니 조심해서 사용합니다.

### 10-3. 어떤 커밋들이 있는지 짧게 보고 싶을 때

```bash
git log --oneline
```

### 10-4. 브랜치 흐름까지 한눈에 보고 싶을 때

```bash
git log --oneline --graph --all
```

### 10-5. 무엇이 바뀌었는지 모르겠을 때

```bash
git status
git diff
```

초보자에게 가장 안전한 습관:

**헷갈리면 바로 삭제하거나 덮어쓰지 말고 `git status`와 `git diff`를 먼저 확인합니다.**

---

## 11. 입문자용 실전 작업 순서

실제로는 아래 순서로 가장 많이 작업합니다.

### 혼자 작업할 때

1. 프로젝트 폴더로 이동한다.
2. `git status`로 상태를 확인한다.
3. 파일을 수정한다.
4. `git diff`로 변경 내용을 확인한다.
5. `git add`로 필요한 파일만 스테이징한다.
6. `git commit -m "메시지"`로 저장한다.
7. `git log --oneline`으로 기록을 확인한다.

예:

```bash
git status
git diff
git add README.md
git commit -m "README 설치 방법 추가"
git log --oneline
```

### GitHub까지 함께 쓸 때

1. 작업 시작 전에 `git pull`로 최신 상태를 받는다.
2. 파일을 수정한다.
3. `git add`와 `git commit`을 한다.
4. 작업이 끝나면 `git push`로 업로드한다.

예:

```bash
git pull origin main
git add .
git commit -m "문서 내용 보완"
git push origin main
```

### 기능별로 안전하게 작업할 때

1. `main`에서 새 브랜치를 만든다.
2. 기능 작업 후 커밋한다.
3. `main`으로 돌아온다.
4. 브랜치를 병합한다.

예:

```bash
git switch -c feature/footer
git add .
git commit -m "푸터 섹션 추가"
git switch main
git merge feature/footer
```

---

## 12. 입문자에게 추천하는 연습 루틴

처음에는 아래 순서로 반복 연습하면 좋습니다.

### 1일차

- `git init`
- `git status`
- `git add`
- `git commit`
- `git log --oneline`

목표:

- 파일 하나를 만들고 두 번 이상 커밋해 보기

### 2일차

- `git diff`
- `git restore`
- `git restore --staged`

목표:

- 수정 확인과 되돌리기 연습하기

### 3일차

- `git switch -c`
- `git branch`
- `git merge`

목표:

- 브랜치를 만들고 병합하기

### 4일차

- `git clone`
- `git pull`
- `git push`

목표:

- GitHub와 연결된 기본 흐름 익히기

---

## 13. 꼭 기억하면 좋은 한 줄 정리

- `git status`: 지금 상태 확인
- `git diff`: 무엇이 바뀌었는지 확인
- `git add`: 이번 커밋에 넣을 파일 선택
- `git commit`: 변경 내용 저장
- `git log --oneline`: 저장 기록 확인
- `git switch -c`: 새 브랜치 생성 후 이동
- `git merge`: 브랜치 합치기
- `git pull`: 최신 내용 가져오기
- `git push`: 내 작업 업로드하기

---

## 14. 초보자를 위한 마지막 팁

- 처음에는 명령어를 많이 외우려 하지 말고 `status -> add -> commit` 흐름부터 익히세요.
- 커밋은 작업이 끝날 때마다 작게 자주 하는 것이 좋습니다.
- 커밋 메시지는 나중에 봐도 이해되게 적는 것이 좋습니다.
- 브랜치는 "안전하게 따로 작업하는 공간"이라고 생각하면 쉽습니다.
- Git이 꼬였다고 느껴지면 무조건 `git status`부터 확인하세요.

---

## 15. 가장 먼저 외우면 좋은 최소 명령어 5개

정말 처음이라면 아래 5개부터 시작해도 충분합니다.

```bash
git init
git status
git add .
git commit -m "작업 내용"
git log --oneline
```

이 5개가 익숙해지면, 그다음에 `diff`, `branch`, `switch`, `merge`, `push`, `pull` 순서로 확장하면 됩니다.
