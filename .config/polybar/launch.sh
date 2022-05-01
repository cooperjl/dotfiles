# Terminates already running bars
killall -q polybar

# Launch bars
polybar main 2>&1 | tee -a /tmp/polybar.log & disown
#polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown
#polybar bar3 2>&1 | tee -a /tmp/polybar3.log & disown

echo "Bars launched..."
