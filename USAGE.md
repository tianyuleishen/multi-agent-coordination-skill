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

## 高级用法

### 创建自定义智能体

您可以基于提供的智能体基类创建自己的智能体：

```javascript
const AgentBase = require('./agent_base');

class CustomAgent extends AgentBase {
  constructor(name, capabilities) {
    super(name, capabilities);
  }

  async executeTask(task) {
    // 实现您的自定义任务逻辑
    console.log(`${this.name} 执行任务: ${task.type}`);
    return { status: 'completed', result: 'success' };
  }
}
```

### 配置协调器

中央协调器可以配置各种参数：

```javascript
const coordinator = new CentralCoordinator({
  port: 3000,
  maxAgents: 10,
  taskTimeout: 30000,
  healthCheckInterval: 5000
});
```

## 故障排除

如果遇到问题，请检查：

1. Node.js 版本是否 ≥ 14.0.0
2. 网络连接是否正常
3. 端口是否被其他程序占用
4. 权限是否足够执行相关操作