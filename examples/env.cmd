if "%ENV_FILE%"=="" (
    set SILICON_FLOW_API_KEY=your_api_key
    set BEMFA_UID=your_bemfa_uid
    set BEMFA_TOPIC=your_bemfa_topic
    set LOCATION=your_location
    echo ֱ���ñ��ļ����л�����������, ���ļ�·��Ϊ: %~dp0env.cmd
) else (
    echo ��ָ������Ļ��������ļ�: %ENV_FILE%
    call %ENV_FILE%
)
