@echo off
@REM ʹ��call������ִ��env.cmd�ļ�
call %~dp0env.cmd

python -m servers.steward --config configs/backend.py