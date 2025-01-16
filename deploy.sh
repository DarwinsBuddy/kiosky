source ./src/env.sh
ssh ${USERNAME}@${HOST} "mkdir -p $KIOSKY_DIR"
rsync -aP ./src/* "${USERNAME}@${HOST}:$KIOSKY_DIR"
ssh ${USERNAME}@${HOST} "cd $KIOSKY_DIR && nohup ./setup.sh"