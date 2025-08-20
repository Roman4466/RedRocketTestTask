## You need to implement a mini app with two screens:

1. Login Screen
- Fields: email, password.
- Use `Form` and `FormField` with validation:
  - Email must be valid,
  - Password must be at least 6 characters.
- The login button should only be active when the form is valid.
- On invalid input, error messages should be displayed (e.g., “password too short”, “invalid email”, etc.).
- On submission, a request to a mock API is made.
- On success — navigate to the second screen.
- On error — display an error message.

2. Home Screen
- A message "Welcome, {username}".
- A Logout button.
- On click, a request to the mock API is sent and tokens are cleared.
- Then the user is redirected back to the login screen.

## Architecture and Technical Expectations:
A **clean architecture** with layer separation is expected:
- `data` — API handling, models (`DTO/Model`)
- `domain` — use cases, entities (`Entity`)
- `presentation` — UI, BLoC/Cubit
- `di` — dependency injection (via `injectable + get_it`)

## Required Technologies:

| Category           | Library                          |
|--------------------|----------------------------------|
|   Navigation       | `go_router` or `auto_route`      |
|   State Management | `bloc` or `cubit`                |
|   Networking       | `dio` + `retrofit`               |
|   DI               | `get_it` + `injectable`          |
|   Token Storage    | `flutter_secure_storage`         |
|   Parsing          | `freezed` + `json_serializable`  |
|   Config/env       | `flutter_dotenv`                 |
|   Responsiveness   | `flutter_screenutil`             |
|   Equality         | `equatable`                      |
|   Mock API         | Any                              |

## What Matters:
- Clean architecture
- The token should be stored in `flutter_secure_storage` after login and used during logout.
- Redirection logic in `GoRouter`/`AutoRoute` should take into account the auth state (if token exists — Home, if not — Login).
- The code should have clear layer separation and understandable structure.

## What to Submit:
- A link to a GitHub/GitLab/Bitbucket repo (public or with access).
- A brief project description (`README.md`).
- The app should run on both Android and iOS.
- (Optional) Screenshots, videos, etc.