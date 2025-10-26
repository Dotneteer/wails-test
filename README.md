# Wails React Starter with XMLUI

A desktop application built with [Wails](https://wails.io) combining Go backend with a React + XMLUI frontend.

## About

This project demonstrates how to build cross-platform desktop applications using:
- **Backend**: Go with Wails runtime
- **Frontend**: React with [XMLUI](https://xmlui.dev) declarative UI components
- **Build System**: Vite + TypeScript

You can configure the project by editing `wails.json`. More information about Wails project settings can be found here: https://wails.io/docs/reference/project-config

## Project Structure

```
wails-test/
├── main.go              # Application entry point
├── app.go               # Go backend methods exposed to frontend
├── wails.json           # Wails configuration
├── go.mod               # Go dependencies
├── frontend/            # XMLUI React frontend
│   ├── src/
│   │   ├── Main.xmlui   # Root component
│   │   ├── components/  # XMLUI components
│   │   ├── themes/      # Theme definitions
│   │   └── config.ts    # App configuration
│   ├── public/          # Static assets
│   ├── wailsjs/         # Auto-generated Go bindings
│   ├── index.ts         # Frontend entry point
│   └── package.json     # Frontend dependencies
├── build.sh             # Build script for macOS
├── run.sh               # Run built application
└── run-dev.sh           # Development mode
```

## Quick Start

### Prerequisites
- Go 1.18+ installed
- Node.js 16+ installed
- Wails CLI: `go install github.com/wailsapp/wails/v2/cmd/wails@latest`

### Development Mode

Run the application with hot reload (frontend and backend):

```bash
./run-dev.sh
```

This starts:
- Vite dev server for the frontend (fast HMR)
- Go backend with live reloading
- Desktop window with developer tools

### Building

Build a production-ready macOS application bundle:

```bash
./build.sh
```

Optional: Build for specific architecture:
```bash
./build.sh arm64    # Apple Silicon
./build.sh amd64    # Intel Mac
```

Output: `build/bin/wails-xmlui.app`

### Running the Built App

```bash
./run.sh
```

Or double-click `build/bin/wails-xmlui.app` in Finder.

## Available Scripts

| Script | Purpose |
|--------|---------|
| `./run-dev.sh` | Start development mode with hot reload |
| `./build.sh` | Build production macOS .app bundle |
| `./run.sh` | Run the built application |

## Frontend Development

The frontend uses XMLUI, a declarative UI framework for React. Components are defined in `.xmlui` files using XML-like syntax.

### Key Frontend Files

- **`src/Main.xmlui`** - Root application component
- **`src/config.ts`** - App configuration (name, theme, resources)
- **`src/components/`** - Reusable XMLUI components
- **`src/themes/`** - Theme definitions

### Frontend Commands

From the `frontend/` directory:

```bash
npm install          # Install dependencies
npm run start        # Start XMLUI dev server
npm run build        # Build production frontend
```

## Backend Development

Go methods in `app.go` are automatically exposed to the frontend via TypeScript bindings.

### Example: Calling Go from React

**Go (app.go):**
```go
func (a *App) Greet(name string) string {
    return fmt.Sprintf("Hello %s!", name)
}
```

**React (TypeScript):**
```typescript
import { Greet } from "../wailsjs/go/main/App";

Greet("World").then(result => console.log(result));
```

Bindings are auto-generated when you run `wails dev` or `wails build`.

## Building for Other Platforms

Future platform-specific build scripts:
- `build-windows.sh` - Windows build script (planned)
- `build-linux.sh` - Linux build script (planned)

For manual cross-platform builds, see: https://wails.io/docs/guides/manual-builds

## Resources

- [Wails Documentation](https://wails.io/docs/introduction)
- [XMLUI Documentation](https://xmlui.dev)
- [Go Documentation](https://go.dev/doc/)
- [React Documentation](https://react.dev)

## License

This project template is provided as-is for learning and development purposes.
