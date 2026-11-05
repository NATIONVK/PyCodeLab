# HACKER PROTOCOL: CYBER WORLD

A mobile-first 3D cyberpunk world prototype by **NATIONVK**.

## Current prototype (v0.3.0 — Hacker HQ Expansion)
- Expanded 3D headquarters blockout with a main workstation, server racks, AI research pod and equipment storage
- Android touch joystick, jump, sprint, interact and camera-toggle controls
- Right-side touch-drag camera control
- Third-person / first-person camera toggle
- Fictional node-sequence workstation simulation
- Three visual lab themes: Cyan, Violet and Emerald
- Lab upgrade progression (levels 1–5)
- Local save/load for theme and upgrade level using Godot ConfigFile at `user://hacker_protocol_lab.cfg`
- Android landscape export preset and version code 3

## Controls
- WASD: move
- Shift: sprint
- Space: jump
- Mouse: look (click the game window to capture)
- E: interact with the main workstation
- Page Up: toggle camera on desktop
- Touch: left joystick to move; swipe the open right side to look; on-screen buttons for jump, sprint, interact and camera
- Esc: release mouse

## Lab menu
- **Change Theme:** cycles Cyan, Violet and Emerald accent lighting
- **Upgrade Lab:** advances the headquarters from level 1 to level 5
- **Save Progress / Load Progress:** stores and restores the theme and upgrade level locally on the device

## Build
Open this folder in Godot 4.4.1 or compatible Godot 4.x with Android export templates and Android SDK configured. Select the Android preset and export a debug APK.

The GitHub Actions workflow at `.github/workflows/build-cyber-world.yml` locates the Android SDK on the hosted runner, installs the required platform/build tools and NDK, validates the Godot project, exports the APK and uploads it as an artifact.

## Scope and safety
All hacking is fictional, puzzle-based simulation contained inside the game. This prototype is not a real network intrusion tool.

## Roadmap
1. Validate v0.3.0 project import and Android APK export
2. Add functional station-specific interactions and equipment inventory
3. Build the first virtual cyberspace zone
4. Create the first streamed NOVA City district
5. Add vehicles, NPCs and story missions
6. Prototype online private co-op sessions

This is an early playable prototype, not the full commercial-scale game described in the design document. Android device testing and successful APK export must be confirmed by a green GitHub Actions run.
