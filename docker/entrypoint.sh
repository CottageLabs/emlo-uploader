#!/bin/bash

./wait-for-it.sh postgres:5432 -t 0 -- ./wait-for-it.sh rabbitmq:5672 -t 0 -- python main.py
