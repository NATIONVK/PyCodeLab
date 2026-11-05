# HACKER PROTOCOL: CYBER WORLD

**A NATIONVK project**  
A mobile-first, third-person / first-person 3D cyberpunk game prototype built with **Godot 4.4.1**.

> **Project status:** Early prototype (v0.4.0). The current build focuses on the Hacker Headquarters, fictional hacking puzzles, mobile controls and basic progression. It is not yet the complete open-world or multiplayer game.

## Game concept

Explore a hybrid cyber world that combines a physical cyberpunk city with a virtual cyberspace. Build and upgrade a personal Hacker Headquarters, complete story missions, solve fictional hacking challenges and develop your reputation.

### Planned world

**Physical world — NOVA CITY**
- Corporate District
- Underground
- Residential District
- Industrial District
- Sky District
- Personal Hacker Headquarters

**Digital world**
- Node City
- Firewall Maze
- Data Vault
- Ghost Network
- NEXUS Core

These are the planned world zones; they are not all implemented in the current prototype.

## Implemented prototype features

### Headquarters
- 3D headquarters blockout with workstation, server racks, AI research pod and equipment storage
- Three visual lab themes: Cyan, Violet and Emerald
- Lab upgrades from level 1 to level 5
- Interactive workstation, Server Room, AI Research and Equipment Storage stations

### Gameplay
- Third-person and first-person camera toggle
- Walking, running and jumping
- Fictional node-sequence hacking puzzle
- Mission Board with starter objectives
- XP, Credits, Research Points and inventory progression
- Training simulation reward: 100 XP, 100 Credits and an Encrypted Data Shard
- Lab upgrade cost: 100 Credits; reward: 25 XP
- AI Research reward is limited to one successful scan per saved progression

### Android touch controls
- Left virtual joystick for movement
- Right-side swipe to look around
- On-screen Jump, Sprint, Interact and Camera buttons
- Landscape orientation

### Save system
Progress is saved locally using Godot `ConfigFile`, including themes, lab level, XP, Credits, Research Points, mission state, inventory and AI research scan state. This is a local save; cloud synchronization is not implemented.

## Controls

| Action | Desktop | Android |
|---|---|---|
| Move | WASD | Left virtual joystick |
| Sprint | Shift | Sprint button |
| Jump | Space | Jump button |
| Look around | Mouse | Swipe right side |
| Interact | E | Use button |
| Toggle camera | Page Up | Camera button |
| Release mouse | Esc | Not applicable |

## Repository structure

```text
PyCodeLab/
├── .github/
│   └── workflows/
│       └── build-cyber-world.yml
└── cyber-world/
    ├── project.godot
    ├── export_presets.cfg
    ├── scenes/
    │   └── main.tscn
    └── scripts/
        ├── main.gd
        ├── player.gd
        ├── terminal.gd
        └── mobile_joystick.gd
```

The Python learning app in the repository root is a separate project. Game development files are isolated inside `cyber-world/`.

## Build an Android debug APK with GitHub Actions

The workflow is:

`.github/workflows/build-cyber-world.yml`

It runs on pushes that change `cyber-world/**` or the workflow file, and can also be started manually from the repository's **Actions** tab.

The workflow:
1. Checks out the repository.
2. Sets up Godot 4.4.1 and Java 17.
3. Locates the Android SDK and installs platform-tools, Android platform 35, build-tools 35.0.0 and NDK 27.2.12479018.
4. Installs matching Godot export templates and configures a CI debug keystore.
5. Imports the project and checks for script parsing/load errors.
6. Exports the Android debug APK.
7. Uploads the APK as a GitHub Actions artifact.

**Expected artifact file:** `HackerProtocol-CyberWorld-debug.apk`  
**Expected artifact name:** `HackerProtocol-CyberWorld-debug-apk`

To download it:
1. Open the repository's **Actions** tab.
2. Select the latest successful **Build HACKER PROTOCOL Cyber World APK** run.
3. Open the artifact section and download `HackerProtocol-CyberWorld-debug-apk`.
4. Extract the ZIP and install the APK on an Android device.

The workflow writes the APK to the repository workspace's `build/` directory before uploading it.

## Development requirements

- Godot 4.4.1 (Godot 4.x may work, but CI uses 4.4.1)
- GDScript
- Android export templates matching the Godot version
- Android SDK platform 35
- Android build-tools 35.0.0
- Android NDK 27.2.12479018
- Java 17

The GitHub Actions runner handles the Android build environment, so a desktop development machine is not required just to trigger the CI build.

## Roadmap

1. Confirm reliable Android debug APK export and test it on a physical Android device.
2. Improve movement, camera, touch controls and performance.
3. Add deeper workstation puzzles, station interactions and equipment systems.
4. Build the first playable cyberspace zone.
5. Create the first explorable NOVA City district with streamed world sections.
6. Add NPCs, vehicles, factions and story missions.
7. Prototype private online co-op before expanding multiplayer features.

## Scope and safety

All hacking mechanics are fictional, self-contained game puzzles. The game does not provide tools or instructions for accessing real systems or networks.

## Current limitations

- This is an early headquarters prototype, not a complete open-world game.
- NOVA City and the cyberspace zones listed above are design targets, not finished playable areas.
- Online multiplayer, cloud saves, friends, chat and live services are not implemented yet.
- Current save data is stored locally on the device.
- A successful CI build does not replace real-device testing.
- The Android APK is a debug build, not a Play Store release.

---

**Created by NATIONVK · HACKER PROTOCOL: CYBER WORLD**
