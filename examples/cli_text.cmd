@echo off
@REM ʹ��call������ִ��env.cmd�ļ�
call %~dp0env.cmd

python -m core.cli --query "������������" --config configs/cli.py