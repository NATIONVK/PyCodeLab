# PyCode Lab

An Android-first, offline Python learning and coding app built with Java, WebView, HTML/CSS/JavaScript, and Chaquopy Python 3.12.

## Features
- Offline lessons for Python fundamentals
- Python execution in the Android app
- `input()` support using the Input values box (one response per line)
- Output and traceback display
- Offline quiz
- Notes saved locally on the device
- GitHub Actions workflow to build a debug APK

## Build an APK with GitHub Actions
1. Create a GitHub repository named `PyCodeLab`.
2. Upload **all contents of this project**, including the hidden `.github` directory and workflow.
3. Ensure the default branch is `main` or `master`.
4. Open the repository's **Actions** tab.
5. Select **Build PyCode Lab APK**, then click **Run workflow**. A push to main/master also starts a build.
6. Open the successful run and download the `PyCodeLab-debug-apk` artifact.
7. Extract the downloaded ZIP. Install `app-debug.apk` on an Android device (allow installation from that source if Android asks).

## Build locally
Requirements: JDK 17, Android SDK 35, Android NDK 27.0.12077973, Gradle 8.9.
Run:
```bash
gradle :app:assembleDebug
```

## Important limitations
- This is a starter learning app, not a secure sandbox. Python code runs inside the app process with normal app permissions. Only run code you trust.
- Infinite loops or very long programs can freeze the runner. Stop/close the app if this happens.
- `input()` reads from the Input values box, not a live interactive console.
- This workflow creates a debug APK, not a Play Store release.
- Internet is not required by the app after installation; Gradle needs internet during the GitHub build.
- Build workflow and source have not been executed in a real Android device in this environment. If GitHub reports a build failure, share the failed log so it can be fixed.
