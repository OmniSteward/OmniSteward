@echo off
@REM ʹ��call������ִ��env.cmd�ļ�
call %~dp0env.cmd

python -m core.cli --config configs/cli.py