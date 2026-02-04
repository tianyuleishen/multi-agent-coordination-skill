# 使用多智能体协调系统技能

## 安装技能

要将多智能体协调系统作为OpenClaw技能安装，请使用以下命令：

```bash
openclaw skill install multi-agent-coordination
```

## 安装后使用

安装完成后，您可以：

1. 启动协调服务器：
```bash
cd ~/.openclaw/workspace/multi-agent-coordination-system
node examples/server.js
```

2. 连接客户端智能体：
```bash
cd ~/.openclaw/workspace/multi-agent-coordination-system
node examples/client.js
```

3. 运行集成测试：
```bash
cd ~/.openclaw/workspace/multi-agent-coordination-system
node integration_test.js
```

4. 运行系统演示：
```bash
cd ~/.openclaw/workspace/multi-agent-coordination-system
node demo.js
```

## 验证安装

您可以通过以下方式验证技能是否正确安装：

```bash
ls -la ~/.openclaw/workspace/multi-agent-coordination-system/
```

应该能看到以下关键文件：
- `central_coordinator.js` - 中央协调器
- `agent_base.js` - 智能体基类
- `coordination_system.js` - 协调系统
- `examples/` - 示例代码
- `agents/` - 专用智能体

## 卸载技能

如需卸载此技能，请使用：

```bash
openclaw skill uninstall multi-agent-coordination
```

## 系统集成

安装后，多智能体协调系统将完全集成到您的OpenClaw环境中，可以与其他技能和系统组件协同工作。