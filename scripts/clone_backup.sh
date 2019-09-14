#!/bin/bash

rclone sync /backup oneDrive:Backup || echo "Sync error on OneDrive..."
#rclone sync /backup googleDrive:Backup || echo "Sync error on Google Drive..."