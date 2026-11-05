# HACKER PROTOCOL: CYBER WORLD

A mobile-first 3D cyberpunk world prototype by **NATIONVK**.

## Current prototype (v0.4.0 — Mission & Progression)
- Expanded 3D headquarters blockout with a main workstation, server racks, AI research pod and equipment storage
- Android touch joystick, jump, sprint, interact and camera-toggle controls
- Right-side touch-drag camera control
- Third-person / first-person camera toggle
- Fictional node-sequence workstation simulation
- Three visual lab themes: Cyan, Violet and Emerald
- Lab upgrade progression (levels 1–5)
- Interactive Server Room, AI Research and Equipment Storage stations
- Mission Board with First Contact and HQ Expansion objectives
- XP, Credits, Research Points and persistent inventory progression
- Training simulation rewards: 100 XP, 100 Credits and an Encrypted Data Shard
- Lab upgrades cost 100 Credits and award 25 XP
- Local save/load for themes, lab level, XP, credits, research points, mission state and inventory using Godot ConfigFile
- Android landscape export preset and version code 4

## Controls
- WASD: move
- Shift: sprint
- Space: jump
- Mouse: look (click the game window to capture)
- E: interact with the main workstation
- Page Up: toggle camera on desktop
- Touch: left joystick to move; swipe the open right side to look; on-screen buttons for jump, sprint, interact and camera
- Esc: release mouse

## Mission and progression
- **Mission Board:** view mission objectives and completion status
- **Inventory:** view owned equipment, research notes and data shards
- **Server Room:** inspect fictional server status
- **AI Research:** earn Research Points and NOVA Research Notes
- **Equipment Storage:** opens the inventory
- **Lab Upgrade:** costs 100 Credits and awards 25 XP

## Lab menu
- **Change Theme:** cycles Cyan, Violet and Emerald accent lighting
- **Upgrade Lab:** advances the headquarters from level 1 to level 5
- **Save Progress / Load Progress:** stores and restores the theme, upgrade level, XP, credits, research points, mission state and inventory locally on the device

## Build
Open this folder in Godot 4.4.1 or compatible Godot 4.x with Android export templates and Android SDK configured. Select the Android preset and export a debug APK.

The GitHub Actions workflow at `.github/workflows/build-cyber-world.yml` locates the Android SDK on the hosted runner, installs the required platform/build tools and NDK, validates the Godot project, exports the APK and uploads it as an artifact.

## Scope and safety
All hacking is fictional, puzzle-based simulation contained inside the game. This prototype is not a real network intrusion tool.

## Roadmap
1. Validate v0.4.0 project import, script parsing and Android APK export
2. Add functional station-specific interactions and equipment inventory
3. Build the first virtual cyberspace zone
4. Create the first streamed NOVA City district
5. Add vehicles, NPCs and story missions
6. Prototype online private co-op sessions

This is an early playable prototype, not the full commercial-scale game described in the design document. Android device testing and successful APK export must be confirmed by a green GitHub Actions run.
