import hashlib
import os
from pathlib import Path
import subprocess
import sys
import time


PROJECT_DIR = Path(__file__).resolve().parent
POLL_INTERVAL = 0.3
RESTART_DELAY = 0.3
LOVE_EXECUTABLE = os.environ.get("LOVE_BIN", "love")


def source_snapshot():
    watched_files = [PROJECT_DIR / "main.lua", PROJECT_DIR / "conf.lua"]

    for directory in ("lib", "src", "assets"):
        watched_files.extend(
            path
            for path in (PROJECT_DIR / directory).rglob("*")
            if path.is_file() and not path.name.startswith(".")
        )

    digest = hashlib.sha256()
    for path in sorted(watched_files):
        digest.update(path.relative_to(PROJECT_DIR).as_posix().encode("utf-8"))
        digest.update(path.read_bytes())

    return digest.digest()


def stop_game(process):
    if process.poll() is not None:
        return

    process.terminate()
    try:
        process.wait(timeout=5)
    except subprocess.TimeoutExpired:
        process.kill()
        process.wait()


def main():
    snapshot = source_snapshot()
    print(f"[dev] Starting {LOVE_EXECUTABLE} .", flush=True)
    process = subprocess.Popen([LOVE_EXECUTABLE, "."], cwd=PROJECT_DIR)

    try:
        while True:
            time.sleep(POLL_INTERVAL)

            exit_code = process.poll()
            if exit_code is not None:
                print(f"[dev] Game exited with code {exit_code}.", flush=True)
                return exit_code

            current_snapshot = source_snapshot()
            if current_snapshot != snapshot:
                time.sleep(RESTART_DELAY)
                snapshot = source_snapshot()
                print("[dev] Change detected; restarting game.", flush=True)
                stop_game(process)
                print(f"[dev] Starting {LOVE_EXECUTABLE} .", flush=True)
                process = subprocess.Popen([LOVE_EXECUTABLE, "."], cwd=PROJECT_DIR)
    except KeyboardInterrupt:
        print("[dev] Stopping game.", flush=True)
        stop_game(process)
        return 0
    finally:
        stop_game(process)


if __name__ == "__main__":
    sys.exit(main())
