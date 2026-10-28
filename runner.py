import contextlib
import io
import json
import traceback

def run_code(code, input_text=""):
    output = io.StringIO()
    errors = io.StringIO()
    old_stdin = None
    import sys
    old_stdin = sys.stdin
    sys.stdin = io.StringIO(input_text or "")
    safe_globals = {
        "__name__": "__main__",
        "__builtins__": __builtins__,
    }
    try:
        with contextlib.redirect_stdout(output), contextlib.redirect_stderr(errors):
            exec(compile(code, "<PyCodeLab>", "exec"), safe_globals, safe_globals)
        return json.dumps({
            "stdout": output.getvalue(),
            "stderr": errors.getvalue(),
            "ok": True
        }, ensure_ascii=False)
    except Exception:
        return json.dumps({
            "stdout": output.getvalue(),
            "stderr": errors.getvalue() + traceback.format_exc(),
            "ok": False
        }, ensure_ascii=False)
    finally:
        sys.stdin = old_stdin
