#SCREEN起動
if [ $TERM != "screen" ]; then
  exec screen -S main -RR
fi
