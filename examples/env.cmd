if "%ENV_FILE%"=="" (
    set OPENAI_API_BASE=your_api_base
    set OPENAI_API_KEY=your_api_key
    set SILICON_FLOW_API_KEY=your_api_key
    set BEMFA_UID=your_bemfa_uid
    set BEMFA_TOPIC=your_bemfa_topic
    set LOCATION=your_location
    set LLM_MODEL=Qwen2.5-7B-Instruct
    echo ֱ���ñ��ļ����л�����������, ���ļ�·��Ϊ: %~dp0env.cmd
) else (
    echo ��ָ������Ļ��������ļ�: %ENV_FILE%
    call %ENV_FILE%
)
