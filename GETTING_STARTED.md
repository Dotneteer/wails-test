# Wails React Starter Project

Welcome to your new Wails application! This project combines Go for the backend with React and TypeScript for the frontend.

## 🏗️ Project Structure

```
wails-test/
├── main.go              # Application entry point
├── app.go               # Main application logic with Go methods
├── wails.json           # Wails configuration
├── go.mod              # Go module dependencies
├── run-dev.sh          # Development script (added for convenience)
├── frontend/           # React frontend
│   ├── src/
│   │   ├── App.tsx     # Main React component
│   │   ├── main.tsx    # React entry point
│   │   └── assets/     # Images and static files
│   ├── package.json    # NPM dependencies
│   ├── vite.config.ts  # Vite configuration
│   └── wailsjs/        # Auto-generated Go bindings for frontend
└── build/              # Built application will appear here
```

## 🚀 Getting Started

### Development Mode
To run the application in development mode with hot reload:

```bash
./run-dev.sh
```

Or manually:
```bash
wails dev
```

This will:
- Start a Vite development server for the frontend (React)
- Compile and run the Go backend
- Open the desktop application
- Enable hot reload for both frontend and backend changes

### Building for Production
To build a production executable:

```bash
wails build
```

The built application will be in the `build/bin/` directory.

## 🧩 Key Components

### Backend (Go)
- **main.go**: Entry point that configures the Wails application
- **app.go**: Contains your application logic and methods that can be called from the frontend

### Frontend (React + TypeScript)
- **App.tsx**: Main React component that demonstrates calling Go methods
- **wailsjs/**: Auto-generated TypeScript bindings to call Go functions

## 🔄 How Frontend Communicates with Backend

The project includes an example where the React frontend calls a Go method:

1. **Go method** in `app.go`:
   ```go
   func (a *App) Greet(name string) string {
       return fmt.Sprintf("Hello %s, It's show time!", name)
   }
   ```

2. **React component** calls it via auto-generated bindings:
   ```tsx
   import {Greet} from "../wailsjs/go/main/App";
   
   function greet() {
       Greet(name).then(updateResultText);
   }
   ```

## 📚 Learning Resources

Since you're experienced with React, you'll find the frontend familiar. Focus on learning:

1. **Go basics**: Variables, functions, structs, interfaces
2. **Wails context**: How to use the `context.Context` for runtime methods
3. **Go-to-frontend communication**: How to expose Go methods to your React app
4. **Desktop app concepts**: Window management, system integration, file handling

## 🛠️ Development Tips

1. **Hot Reload**: Changes to React code reload instantly. Go changes require recompilation.
2. **Debugging**: Use browser DevTools for frontend, and Go's built-in debugging for backend.
3. **Frontend URL**: In dev mode, frontend runs on http://localhost:5173/
4. **Browser Testing**: You can also test in browser at http://localhost:34115

## ✨ Next Steps

1. Try running `./run-dev.sh` to see your app in action
2. Modify the `Greet` function in `app.go` to understand backend changes
3. Update the React component in `frontend/src/App.tsx` to experiment with the frontend
4. Add new Go methods to `app.go` and see them auto-generate in `wailsjs/`

Happy coding with Wails! 🎉