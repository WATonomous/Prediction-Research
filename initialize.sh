#!/bin/bash
FIXUID=$(id -u)
FIXGID=$(id -g)

# WandB setup
while true; do
    read -p "Do you wish to use Weights and Biases? [Y/n] " yn
    case $yn in
        [Yy]* ) WANDB_MODE="online"; read -p "Enter your WandB API key: " key ; break;;
        [Nn]* ) WANDB_MODE="offline"; echo "WandB disabled"; break;;
        * ) echo "Please answer [Yy] or [Nn].";;
    esac
done

# Setup .env
> ".env"
echo "COMPOSE_PROJECT_NAME=prediction-research-${USER}" >> ".env"
echo "FIXUID=$FIXUID" >> ".env"
echo "FIXGID=$FIXGID" >> ".env"

echo "USERNAME=${USER}" >> ".env"
echo "WANDB_MODE=${WANDB_MODE}" >> ".env"

if [ $WANDB_MODE == "online" ]; then
    echo "WANDB_KEY=${key}" >> ".env"
fi

echo "Initialized, please restart your containers if changes were made."