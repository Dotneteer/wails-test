# Wails XMLUI Starter

A cross-platform desktop application built with [Wails](https://wails.io), combining Go backend with a React + XMLUI frontend.

## 🎯 About

This project demonstrates how to build modern desktop applications using:
- **Backend**: Go with Wails v2 runtime
- **Frontend**: React with [XMLUI](https://xmlui.dev) declarative UI framework
- **Build System**: Vite + TypeScript
- **Platforms**: macOS (Intel & Apple Silicon), Windows (x64 & ARM), Linux (x64 & ARM)

XMLUI provides a declarative, XML-like syntax for building React UIs, making component composition intuitive and maintainable.

## 🏗️ Project Structure

```
wails-test/
├── main.go              # Application entry point with Wails configuration
├── app.go               # Go backend methods exposed to frontend
├── wails.json           # Wails project configuration
├── go.mod               # Go dependencies
├── go.sum               # Go dependency checksums
├── frontend/            # XMLUI React frontend
│   ├── src/
│   │   ├── Main.xmlui   # Root XMLUI component
│   │   ├── components/  # Reusable XMLUI components
│   │   ├── themes/      # Theme definitions
│   │   ├── config.ts    # Application configuration
│   │   └── lib/         # Utility libraries
│   ├── public/          # Static assets and resources
│   ├── wailsjs/         # Auto-generated Go→TypeScript bindings
│   ├── index.html       # HTML entry point
│   ├── index.ts         # TypeScript entry point
│   ├── package.json     # Frontend dependencies
│   └── tsconfig.json    # TypeScript configuration
├── build/               # Build output directory (excluded from Git)
├── build.sh             # Build single platform
├── build-all.sh         # Build all platforms
├── run.sh               # Run built .app bundle
├── run-dev.sh           # Development mode with hot reload
└── fix-wailsjs.sh       # Fix auto-generated TypeScript files
```

## 🚀 Quick Start

### Prerequisites
- **Go 1.18+** ([install](https://go.dev/doc/install))
- **Node.js 16+** ([install](https://nodejs.org/))
- **Wails CLI**: `go install github.com/wailsapp/wails/v2/cmd/wails@latest`

### Installation

1. Clone or download this repository
2. Navigate to the project directory
3. Install frontend dependencies:
   ```bash
   cd frontend
   npm install
   cd ..
   ```

### Development Mode

Run the application with hot reload for both frontend and backend:

```bash
./run-dev.sh
```

This will:
- Start the Vite dev server for fast frontend HMR (Hot Module Replacement)
- Compile and run the Go backend with live reloading
- Open the desktop application window
- Enable browser developer tools for debugging
- Run `fix-wailsjs.sh` to clean up auto-generated files

The frontend runs on `http://localhost:5174/` and the backend on `http://localhost:34115`.

### Building for Production

#### Build for Current Platform

Build a production-ready application for your current platform:

```bash
./build.sh
```

Optional: Specify architecture for macOS:
```bash
./build.sh arm64      # Apple Silicon only
./build.sh amd64      # Intel Mac only
./build.sh universal  # Universal binary (both architectures)
```

Output: `build/bin/wails-test.app` (macOS) or equivalent for other platforms

#### Build for All Platforms

Build for multiple platforms at once:

```bash
./build-all.sh                    # All supported platforms (packaged)
./build-all.sh --nopackage        # All platforms (single binaries)
./build-all.sh windows            # Windows x64 + ARM only
./build-all.sh darwin             # macOS Intel + ARM + Universal
./build-all.sh linux              # Linux x64 + ARM (Linux host required)
./build-all.sh darwin --nopackage # macOS single binaries
```

**Note on Cross-Compilation:**
- **macOS** can build: macOS ✅, Windows ✅ (with mingw-w64), Linux ❌
- **Linux** can build: Linux ✅, Windows ✅ (with mingw-w64), macOS ❌
- **Windows** can build: Windows ✅, others require WSL/Docker

For Linux builds from macOS, use a Linux VM, Docker, or CI/CD pipeline.

### Running the Built Application

```bash
./run.sh
```

Or simply double-click `build/bin/wails-test.app` in Finder (macOS).

## 📝 Available Scripts

| Script | Purpose |
|--------|---------|
| `./run-dev.sh` | Start development mode with hot reload |
| `./build.sh [arch]` | Build for current platform (optional architecture) |
| `./build-all.sh [platform] [--nopackage]` | Build for multiple platforms |
| `./run.sh` | Run the built macOS .app bundle |
| `./fix-wailsjs.sh` | Remove TypeScript errors from auto-generated files |

## 🎨 Frontend Development with XMLUI

The frontend uses XMLUI, a declarative UI framework for React. Components are defined in `.xmlui` files using an intuitive XML-like syntax.

### Key Frontend Files

- **`src/Main.xmlui`** - Root application component
- **`src/config.ts`** - App configuration (name, theme, resources)
- **`src/components/`** - Reusable XMLUI components
- **`src/themes/`** - Custom theme definitions
- **`public/`** - Static assets (images, icons, etc.)

### Frontend Commands

From the `frontend/` directory:

```bash
npm install          # Install dependencies
npm run start        # Start XMLUI dev server (called by wails dev)
npm run build        # Build production frontend
npm run preview      # Preview production build locally
```

### Example XMLUI Component

```xml
<Component name="Home">
  <H1>Welcome to XMLUI</H1>
  <H2>This is a simple component</H2>
  <CustomButton label="Click Me" onClick="toast.success('Button clicked!')" />
</Component>
```

## 🔧 Backend Development with Go

Go methods in `app.go` are automatically exposed to the frontend via TypeScript bindings generated by Wails.

### Example: Calling Go from Frontend

**1. Define Go method in `app.go`:**
```go
func (a *App) Greet(name string) string {
    return fmt.Sprintf("Hello %s, It's show time!", name)
}
```

**2. Call from React/TypeScript:**
```typescript
import { Greet } from "../wailsjs/go/main/App";

async function greetUser() {
    const result = await Greet("World");
    console.log(result); // "Hello World, It's show time!"
}
```

**3. Use in XMLUI component:**
```xml
<Component name="MyComponent">
  <H2>Backend Integration Example</H2>
  <CustomButton 
    label="Greet" 
    onClick="toast.success(Greet('XMLUI'))" 
  />
</Component>
```

### Auto-Generated Bindings

Wails automatically generates TypeScript bindings in `frontend/wailsjs/` when you:
- Run `wails dev`
- Run `wails build`
- Add or modify Go methods in `app.go`

The `fix-wailsjs.sh` script automatically removes TypeScript linting errors from these generated files.

## 🔄 Go-to-Frontend Communication

### Calling Go from Frontend
Use the auto-generated bindings as shown above.

### Window Operations
```typescript
import { WindowMinimise, WindowMaximise } from "../wailsjs/runtime/runtime";

WindowMinimise(); // Minimize window
WindowMaximise(); // Maximize window
```

### Accessing Go Context
In `app.go`, use the context for Wails runtime operations:

```go
import "github.com/wailsapp/wails/v2/pkg/runtime"

func (a *App) OpenFile() string {
    file, _ := runtime.OpenFileDialog(a.ctx, runtime.OpenDialogOptions{
        Title: "Select File",
    })
    return file
}
```

## 🐛 Development Tips

1. **Hot Reload**: React changes reload instantly via Vite HMR. Go changes trigger automatic recompilation.
2. **Developer Tools**: Press `F12` or right-click → "Inspect Element" in dev mode.
3. **TypeScript Errors**: Run `./fix-wailsjs.sh` if you see errors in `wailsjs/` files.
4. **XMLUI Syntax**: Check [XMLUI documentation](https://xmlui.dev) for component reference.
5. **Go Basics**: If new to Go, start with [A Tour of Go](https://go.dev/tour/).

## 📦 Configuration Files

### `wails.json`
Wails project configuration. Key settings:
- `name`: Project name
- `outputfilename`: Built executable name
- `frontend:build`: Frontend build command
- `frontend:dev:watcher`: Dev server command

### `tsconfig.json`
TypeScript configuration with:
- `checkJs: false` - Disables JS file type checking
- `exclude: ["wailsjs"]` - Excludes auto-generated files

### `.vscode/settings.json`
VS Code workspace settings to suppress TypeScript errors in generated files.

## 🌐 Multi-Platform Support

This project supports building for:

| Platform | Architecture | Build Command | Cross-Compile from macOS |
|----------|-------------|---------------|-------------------------|
| macOS | Intel (amd64) | `./build.sh amd64` | ✅ Native |
| macOS | Apple Silicon (arm64) | `./build.sh arm64` | ✅ Native |
| macOS | Universal | `./build.sh universal` | ✅ Native |
| Windows | x64 (amd64) | `./build-all.sh windows` | ✅ Yes (mingw-w64) |
| Windows | ARM (arm64) | `./build-all.sh windows` | ✅ Yes (mingw-w64) |
| Linux | x64 (amd64) | `./build-all.sh linux` | ❌ No (Linux required) |
| Linux | ARM (arm64) | `./build-all.sh linux` | ❌ No (Linux required) |

### Setting Up Cross-Compilation

**For Windows builds on macOS:**
```bash
brew install mingw-w64
```

**For Linux builds:**
Use a Linux machine, VM, Docker, or CI/CD pipeline (GitHub Actions, GitLab CI).

## 📚 Resources

- **[Wails Documentation](https://wails.io/docs/introduction)** - Desktop app framework
- **[XMLUI Documentation](https://xmlui.dev)** - Declarative UI framework
- **[Go Documentation](https://go.dev/doc/)** - Go programming language
- **[React Documentation](https://react.dev)** - React library
- **[Vite Documentation](https://vitejs.dev)** - Build tool

## 🎓 Learning Path

If you're new to Go but experienced with React:

1. **Go Basics**: Complete [A Tour of Go](https://go.dev/tour/) (1-2 hours)
2. **Wails Context**: Read [Wails Runtime](https://wails.io/docs/reference/runtime/intro) documentation
3. **Go ↔ Frontend**: Study `app.go` and `wailsjs/` bindings
4. **Desktop Concepts**: Explore window management, system integration, file handling
5. **XMLUI Components**: Browse [XMLUI Components](https://xmlui.dev/components)

## ✨ Next Steps

1. **Run the app**: `./run-dev.sh` to see it in action
2. **Modify backend**: Update `Greet()` in `app.go` and see changes
3. **Modify frontend**: Edit `frontend/src/Main.xmlui` to experiment with XMLUI
4. **Add Go methods**: Create new functions in `app.go` and call them from React
5. **Build for production**: `./build.sh` to create a distributable app
6. **Multi-platform**: Try `./build-all.sh` to build for all platforms

## 📄 Project Configuration

You can configure the project by editing `wails.json`. More information about Wails project settings: https://wails.io/docs/reference/project-config

## 🤝 Contributing

This is a starter template. Feel free to customize it for your needs!

## 📜 License

This project template is provided as-is for learning and development purposes.

---

Happy coding with Wails + XMLUI! 🎉