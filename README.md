# TradeQuest

Flutter onboarding flow for a crypto trading simulator. The current build focuses on the real onboarding journey shown in the screenshots and keeps the main app shell ready for future feature work.

## Routes

| Screen | Route |
|---|---|
| Welcome | `/` |
| Sign Up | `/sign-up` |
| Login | `/login` |
| Set Your Goal | `/onboarding/goal` |
| First Trade | `/onboarding/first-trade` |
| Badge Unlock | `/onboarding/badge-unlock` |
| Home Shell | `/home` |
| Trade Shell | `/trade` |
| Missions Shell | `/missions` |
| Portfolio Shell | `/portfolio` |
| Profile Shell | `/profile` |

## Architecture

```
lib/
├── core/
│   ├── presentation/shell/   # main app scaffold
│   ├── router/               # route map and route constants
│   ├── theme/                # colors, spacing, typography
│   └── widgets/              # shared fallback widgets
└── features/
    ├── auth/presentation/    # welcome, login, sign up
    └── onboarding/presentation/ # goal, trade, badge unlock
```

## Sprint Plan

1. Sprint 1 - foundation: theme, route wiring, shared onboarding shell
2. Sprint 2 - auth flow: welcome, login, sign up
3. Sprint 3 - onboarding flow: goal selection, first trade, badge unlock
4. Sprint 4 - polish: route cleanup, docs, verification

## Run

```bash
flutter pub get
flutter run
```
