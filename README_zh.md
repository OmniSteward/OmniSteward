
![OmniSteward 全能管家](./assets/logo.png)

[English Version](README.md)

**注意：本项目仍在积极开发中，部分功能可能不稳定，文档内容也在不断更新中**

这是一个基于LLM Agent的全能管家系统，可以通过语音或文字与用户交互，帮助控制智能家居设备和电脑程序。

## 演示视频
![多轮对话演示GIF](./assets/multi-round.gif)

我们准备了一系列演示视频，请观看[演示视频](https://youtube.com/playlist?list=PLB-gnx_vrV9nFWHbZbxfktOPmHv7llkQZ&si=ZcZVOO6mfteR120a)了解系统的主要功能和使用方法。

## 新闻

- 2024-12-18: 支持HomeAssistant，可以控制HomeAssistant/米家（通过HomeAssistant）智能家居设备，请查看[omni-ha](https://github.com/OmniSteward/omni-ha)项目

## 亮点

- 支持多轮对话，可以连续回答用户问题
- 支持工具调用，可以在电脑上执行复杂的任务
- 支持多种LLM模型，可以根据需要切换
- 拓展性强，你可以很方便地自定义和分享自己的工具

## 主要功能

- 🎤 语音识别与交互
- 🏠 智能家居控制（HomeAssistant/巴法云设备/米家（通过HomeAssistant））
- 💻 电脑程序管理（启动/关闭程序）
- 🔍 在线信息检索（通过阶跃星辰开放平台自带的[step_web_search](https://platform.stepfun.com/docs/guide/web_search)工具/Kimi AI）
- ⌨️ 命令行操作
- 📂 文件管理（文件检索/读写文件/压缩文件夹/列出文件夹内容）


## 系统要求

- Python 3.8+
- Chrome浏览器（用于Kimi AI功能）
- Windows操作系统（部分功能仅支持Windows，Linux和Mac未测试）

## 安装

1. 克隆仓库
```bash
git clone https://github.com/OmniSteward/OmniSteward.git
cd OmniSteward
```

2. 安装依赖
```bash
pip install -r requirements.txt
```

## 环境变量配置
参见[examples/env.cmd](examples/env.cmd)文件
```
OPENAI_API_BASE=your_api_base # OpenAI格式API基础URL
OPENAI_API_KEY=your_api_key   # OpenAI格式API密钥
SILICON_FLOW_API_KEY=your_api_key   # Silicon Flow API密钥，用于ASR, ReRank, 获取方式参见[大语言模型平台](docs/PLATFORM.md)
KIMI_PROFILE_PATH=path_to_chrome_profile    # Chrome用户数据目录（可选，用于Kimi AI功能，不填则使用默认路径）
LOCATION=your_location                     # 你的地理位置（可选，用于系统提示词）
LLM_MODEL=your_llm_model                   # 使用的LLM模型，可选，默认使用Qwen2.5-7B-Instruct
```

不同工具还可能需要其他配置，请参见[工具列表](docs/TOOL_LIST.md)

获取OPENAI格式的API密钥和API基础URL参见[大语言模型平台](docs/PLATFORM.md)

其他参考链接:
- [阶跃星辰开放平台](https://platform.stepfun.com/)
- [Silicon Flow官网](https://siliconflow.cn/zh-cn/siliconcloud)
- [巴法云 官网](https://bemfa.com/)
- [Kimi AI 官网](https://kimi.moonshot.cn/)


## 启动

本项目支持两种使用方式：
- 命令行模式(CLI)： 通过命令行与用户交互，直接使用。
- Web模式：需要配合前端项目，通过WebUI与用户交互，可以在手机、平板、电脑上远程使用，管理智能家居设备

### 命令行模式(CLI)

请先在`examples/env.cmd`文件中配置环境变量(详见[环境变量配置](#环境变量配置))


#### 麦克风语音输入模式

首先启动VAD服务：
```cmd
python -m servers.vad_rpc
```

然后新开一个命令行窗口，运行：

```cmd
call examples\env.cmd # 使环境变量生效
python -m core.cli --config configs/cli.py # 运行CLI
```
参见[examples/cli_voice.cmd](examples/cli_voice.cmd)以查看更多细节

#### 文字输入模式

```cmd
call examples\env.cmd # 使环境变量生效
python -m core.cli --query "打开网易云音乐" --config configs/cli.py
```

#### 简单添加自定义工具
```cmd
call examples\env.cmd # 使环境变量生效
python -m core.cli --query "打印 你好" --config configs/cli_custom_tool.py
```
这个例子在[configs/cli_custom_tool.py](configs/cli_custom_tool.py)中添加了一个简单的打印工具，可以打印任意字符串, 查看该文件以了解如何简单地添加自定义工具

更多自定义工具的例子参见[steward-utils](https://github.com/OmniSteward/steward-utils)项目


### Web模式

- 需要搭配前端WebUI使用，前端项目为[OmniSteward-Frontend](https://github.com/OmniSteward/OmniSteward-Frontend)。
- 需要配置环境变量，尤其是Silicon Flow API密钥，否则无法使用
- 前端WebUI应在`http://localhost:3000`运行，当后端服务启动后，后端会将请求转发到前端
- 后端服务应在`http://localhost:8000`运行

#### 启动后端服务

请先在`examples/env.cmd`文件中配置环境变量(详见[环境变量配置](#环境变量配置))，然后在项目根目录下运行：
```cmd
call examples\env.cmd # 使环境变量生效
python -m servers.steward --config configs/backend.py
```

#### 启动前端服务

详见[OmniSteward-Frontend](https://github.com/OmniSteward/OmniSteward-Frontend)项目。

#### 使用
使用Chrome/Edge浏览器，打开`http://localhost:8000`，即可开始使用。

注：外网使用时，由于Chrome/Edge默认禁止HTTP下的麦克风，我们需要设置`chrome://flags/#unsafely-treat-insecure-origin-as-secure`为`http://ip:port`，否则无法使用，点此查看[参考教程](https://blog.csdn.net/zwj1030711290/article/details/125425877)。

手机上也可以使用Chrome或者Edge浏览器，打开`http://ip:port`，即可开始使用，也需要如上设置。


## 可用工具和自定义工具

详见[TOOL_LIST.md](docs/TOOL_LIST.md)


## 注意事项

- 部分功能需要特定的API密钥和环境配置
- 命令行工具执行前会要求用户确认
- 智能家居控制功能需要相应的硬件支持

## 贡献

目前此项目主要由[ElliottZheng](https://github.com/ElliottZheng)维护，欢迎提交Issue和Pull Request！

## 感谢

感谢[阶跃星辰开放平台【繁星计划】](https://wvixbzgc0u7.feishu.cn/wiki/XaMYwpqA1iI5rnkavDbcY9Jtnhd)对本项目的支持。

## 许可证

[MIT License](LICENSE)

Copyright (c) 2024-present [ElliottZheng](https://github.com/ElliottZheng)
