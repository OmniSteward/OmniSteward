@echo off
@REM ʹ��call������ִ��env.cmd�ļ�
call %~dp0env.cmd

python -m core.cli --query "��ӡ ���" --config configs/cli_custom_tool.py