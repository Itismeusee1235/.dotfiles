#!/usr/bin/env python3
import subprocess
import sys

if len(sys.argv) < 2:
    print('Usage: ask [--file filename.py] "your question"')
    sys.exit(1)

# Handle --file option
if sys.argv[1] == "--file":
    if len(sys.argv) < 4:
        print('Usage: ask --file filename.py "your question"')
        sys.exit(1)
    filename = sys.argv[2]
    prompt = " ".join(sys.argv[3:])
    output_to_file = True
else:
    prompt = " ".join(sys.argv[1:])
    filename = None
    output_to_file = False

# Strict system prompt
final_prompt = f"""
You are a computational physics assistant.
The user will give you a physics or math problem. 
You must return ONLY executable Python code (no explanations, no markdown).
Allowed libraries: numpy, scipy.
Do not import anything else.
If possible, prefer numpy over scipy unless a SciPy solver is required.
Problem: {prompt}
"""

# Run Ollama
result = subprocess.run(
    ["ollama", "run", "llama3"],
    input=final_prompt.encode("utf-8"),
    stdout=subprocess.PIPE,
)

answer = result.stdout.decode("utf-8")

if output_to_file:
    with open(filename, "w") as f:
        f.write(answer.strip() + "\n")
    print(f"✅ Code written to {filename}")
else:
    print(answer.strip())
