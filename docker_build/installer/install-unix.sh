#!/bin/bash


R2D2_ROOT_DIR=$(pwd)/../..
R2D2_ROOT_DIR=$(cd $R2D2_ROOT_DIR && pwd)

echo R2D2_ROOT_DIR=\"$R2D2_ROOT_DIR\" >> /etc/environment
echo R2D2_ROOT_DRIVE=\"\" >> /etc/environment

