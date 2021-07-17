% { shopt -s nullglob; for file in chapters/*.tex; do echo "\\input{\"$file\"}"; done; }
