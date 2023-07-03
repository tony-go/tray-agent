open dist/Debug/TrayAgent.app

if [ $? -eq 0 ]; then
    echo "TrayAgent.app is running"
else
    echo "TrayAgent.app is not running"
    exit 1
fi

killall TrayAgent


