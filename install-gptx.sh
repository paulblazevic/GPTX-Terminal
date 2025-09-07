#!/bin/bash
# Cross-Distro GPTX Installer
# Works on Debian/Ubuntu, Arch/Manjaro, Fedora

set -e

echo "🚀 Starting GPTX installation..."

# 1️⃣ Detect package manager and install python3 & pip
if command -v apt &> /dev/null; then
    sudo apt update
    sudo apt install -y python3 python3-venv python3-pip
elif command -v pacman &> /dev/null; then
    sudo pacman -Sy --noconfirm python python-pip
elif command -v dnf &> /dev/null; then
    sudo dnf install -y python3 python3-venv python3-pip
else
    echo "Unsupported Linux distro. Please install Python3 manually."
    exit 1
fi

# 2️⃣ Create virtual environment
VENV_DIR="$HOME/gptx-venv"
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

# 3️⃣ Install Python dependencies
pip install --upgrade pip
pip install --upgrade openai rich

# 4️⃣ Create GPTX script
GPTX_SCRIPT="$HOME/gptx.py"
cat <<'EOF' > "$GPTX_SCRIPT"
#!/usr/bin/env python3
from openai import OpenAI
import os, sys

api_key = os.environ.get("OPENAI_API_KEY")
if not api_key:
    print("Set your OPENAI_API_KEY environment variable first.")
    sys.exit(1)

client = OpenAI(api_key=api_key)
prompt = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else input("Prompt: ")
resp = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": prompt}]
)
print(resp.choices[0].message.content)
EOF

chmod +x "$GPTX_SCRIPT"

# 5️⃣ Create launcher in ~/bin
mkdir -p "$HOME/bin"
cat <<EOF > "$HOME/bin/gptx"
#!/bin/bash
source "$VENV_DIR/bin/activate"
python "$GPTX_SCRIPT" "\$@"
EOF
chmod +x "$HOME/bin/gptx"

# 6️⃣ Add ~/bin to PATH
if ! grep -q 'export PATH=$HOME/bin:$PATH' ~/.bashrc; then
    echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
    export PATH=$HOME/bin:$PATH
fi

# 7️⃣ Instructions for API key
echo "✅ GPTX installed successfully!"
echo "1. Add your OpenAI API key:"
echo '   echo '\''export OPENAI_API_KEY="sk-yourkeyhere"'\'' >> ~/.bashrc'
echo "2. Reload bash:"
echo "   source ~/.bashrc"
echo "3. Run GPTX:"
echo "   gptx 'Hello from your Linux!'"
#!/bin/bash
# Cross-Distro GPTX Installer
# Works on Debian/Ubuntu, Arch/Manjaro, Fedora

set -e

echo "🚀 Starting GPTX installation..."

# 1️⃣ Detect package manager and install python3 & pip
if command -v apt &> /dev/null; then
    sudo apt update
    sudo apt install -y python3 python3-venv python3-pip
elif command -v pacman &> /dev/null; then
    sudo pacman -Sy --noconfirm python python-pip
elif command -v dnf &> /dev/null; then
    sudo dnf install -y python3 python3-venv python3-pip
else
    echo "Unsupported Linux distro. Please install Python3 manually."
    exit 1
fi

# 2️⃣ Create virtual environment
VENV_DIR="$HOME/gptx-venv"
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

# 3️⃣ Install Python dependencies
pip install --upgrade pip
pip install --upgrade openai rich

# 4️⃣ Create GPTX script
GPTX_SCRIPT="$HOME/gptx.py"
cat <<'EOF' > "$GPTX_SCRIPT"
#!/usr/bin/env python3
from openai import OpenAI
import os, sys

api_key = os.environ.get("OPENAI_API_KEY")
if not api_key:
    print("Set your OPENAI_API_KEY environment variable first.")
    sys.exit(1)

client = OpenAI(api_key=api_key)
prompt = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else input("Prompt: ")
resp = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": prompt}]
)
print(resp.choices[0].message.content)
EOF

chmod +x "$GPTX_SCRIPT"

# 5️⃣ Create launcher in ~/bin
mkdir -p "$HOME/bin"
cat <<EOF > "$HOME/bin/gptx"
#!/bin/bash
source "$VENV_DIR/bin/activate"
python "$GPTX_SCRIPT" "\$@"
EOF
chmod +x "$HOME/bin/gptx"

# 6️⃣ Add ~/bin to PATH
if ! grep -q 'export PATH=$HOME/bin:$PATH' ~/.bashrc; then
    echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
    export PATH=$HOME/bin:$PATH
fi

# 7️⃣ Instructions for API key
echo "✅ GPTX installed successfully!"
echo "1. Add your OpenAI API key:"
echo '   echo '\''export OPENAI_API_KEY="sk-yourkeyhere"'\'' >> ~/.bashrc'
echo "2. Reload bash:"
echo "   source ~/.bashrc"
echo "3. Run GPTX:"
echo "   gptx 'Hello from your Linux!'"
