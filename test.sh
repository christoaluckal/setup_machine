read -p "Enter option (b/B for Bash or z/Z for Zsh): " user_input

case "$user_input" in
  z|Z)
    echo "Configuring ROS Humble for zsh..."
    target=dump.txt
    marker="# >>> ROS Humble setup >>>"

    if ! grep -qF "$marker" "$target" 2>/dev/null; then
      cat >> "$target" <<'EOF'

# >>> ROS Humble setup >>>
# Shell: zsh
source /opt/ros/humble/setup.zsh
source /usr/share/colcon_cd/function/colcon_cd.sh
export _colcon_cd_root=/opt/ros/humble/
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh

# Ensure completion frameworks are initialized
autoload -Uz compinit; compinit
autoload -Uz +X bashcompinit; bashcompinit

# Argcomplete for ros2/colcon (if available)
if command -v register-python-argcomplete3 >/dev/null 2>&1; then
  eval "$(register-python-argcomplete3 ros2)"
  eval "$(register-python-argcomplete3 colcon)"
fi
# <<< ROS Humble setup <<<
EOF
      echo "Setup added to dump.txt. Reload with: source dump.txt"
    else
      echo "ROS Humble block already present in dump.txt (skipped)."
    fi
    ;;

  *)
    echo "Invalid input. Use 'b' for bash or 'z' for zsh."
    ;;
esac
