#!/usr/bin/env bash
set -e

# Change to your repo directory
cd ~/GPTX-Terminal || exit 1

# Create README.md
cat <<'EOF' > README.md
# GPTX Terminal

A lightweight, cross-platform GPT chat client for the terminal. Works on Debian/Ubuntu, Arch/Manjaro, and Fedora/RHEL Linux.

---

## Features

- Terminal-based GPT client  
- Cross-platform Linux support  
- Isolated Python environment using `pipx`  
- Easy installation via a single script  

---

## Installation

### 1. Download the installer script

\`\`\`bash
curl -o ~/install-gptx.sh https://raw.githubusercontent.com/paulblazevic/GPTX-Terminal/main/install-gptx.sh
\`\`\`

---

### 2. Make the script executable

\`\`\`bash
chmod +x ~/install-gptx.sh
\`\`\`

---

### 3. Run the installer

\`\`\`bash
./install-gptx.sh
\`\`\`

The script will:

1. Detect your Linux distro  
2. Install Python 3, pip, and git if needed  
3. Install `pipx` for isolated Python package management  
4. Clone GPTX from GitHub  
5. Install GPTX in a pipx environment  
6. Add a launcher in \$HOME/bin/gptx  

---

### 4. Ensure \$HOME/bin is in your PATH

\`\`\`bash
export PATH="\$HOME/bin:\$PATH"
\`\`\`

To make this permanent:

\`\`\`bash
echo 'export PATH="\$HOME/bin:\$PATH"' >> ~/.bashrc
source ~/.bashrc
\`\`\`

---

### 5. Set your OpenAI API key

Before using GPTX:

\`\`\`bash
export OPENAI_API_KEY="your_openai_api_key_here"
\`\`\`

To make it permanent:

\`\`\`bash
echo 'export OPENAI_API_KEY="your_openai_api_key_here"' >> ~/.bashrc
source ~/.bashrc
\`\`\`

---

### 6. Run GPTX

\`\`\`bash
gptx "Hello GPT from my Linux distro!"
\`\`\`

---

### 7. Update GPTX

To update GPTX to the latest version:

\`\`\`bash
./install-gptx.sh
\`\`\`

---

## Supported Linux Distros

- Debian / Ubuntu  
- Arch / Manjaro  
- Fedora / RHEL  

---

## Notes

- GPTX uses **pipx** to keep the Python environment isolated.  
- \$HOME/bin/gptx is the launcher command.  
- Works in any terminal emulator (Alacritty, GNOME Terminal, Konsole, etc.).  

---

## License

MIT License
EOF

# Add, commit, and push to GitHub
git add README.md
git commit -m "Add GitHub-ready README"
git push origin main

echo "✅ README.md added and pushed to GitHub"
