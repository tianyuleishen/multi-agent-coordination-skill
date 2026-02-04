#!/bin/bash

# Multi-Agent Coordination System - Client Installer
# This script automates the installation of a client for multi-agent coordination system

echo "🤖 Multi-Agent Coordination Client - Quick Setup"
echo "================================================"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js (version 14.0.0 or higher) first."
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v | sed 's/v//')
MIN_VERSION="14.0.0"

if [[ $(printf '%s\n' "$MIN_VERSION" "$NODE_VERSION" | sort -V | head -n1) != "$MIN_VERSION" ]]; then
    echo "❌ Node.js version is too old. Required: $MIN_VERSION+, Current: $NODE_VERSION"
    exit 1
fi

echo "✅ Node.js version $NODE_VERSION detected"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm."
    exit 1
fi

echo "✅ npm is available"

# Create project directory
PROJECT_DIR="multi-agent-client"
if [ -d "$PROJECT_DIR" ]; then
    echo "⚠️  Directory $PROJECT_DIR already exists. Removing..."
    rm -rf "$PROJECT_DIR"
fi

echo "📁 Creating project directory: $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Initialize npm project
echo "📦 Initializing npm project..."
npm init -y > /dev/null 2>&1

# Install dependencies
echo "📥 Installing required dependencies..."
npm install axios express ws cors > /dev/null 2>&1

# Create the client JavaScript file
cat > multi-agent-client.js << 'EOF'
const axios = require('axios');
const WebSocket = require('ws');

class MultiAgentClient {
  constructor(options = {}) {
    this.id = options.id || `multi-agent-client-${Date.now()}`;
    this.name = options.name || 'Multi-Agent-Client';
    this.coordinatorUrl = options.coordinatorUrl || 'http://8.130.18.239:3000';
    this.capabilities = options.capabilities || ['communication', 'information-processing', 'task-execution'];
    this.status = 'offline';
    this.heartbeatInterval = null;
    
    console.log(`🤖 Multi-Agent Client initialized: ${this.name} (${this.id})`);
  }
  
  async register() {
    try {
      console.log('📡 Registering with coordinator...');
      
      const response = await axios.post(`${this.coordinatorUrl}/agents/register`, {
        id: this.id,
        name: this.name,
        capabilities: this.capabilities,
        endpoint: `${this.coordinatorUrl}/agents/${this.id}`
      });
      
      if (response.data.success) {
        this.status = 'online';
        console.log(`✅ Registration successful! Agent ID: ${response.data.agentId}`);
        
        // Start heartbeat to maintain connection
        this.startHeartbeat();
        
        return true;
      } else {
        console.error('❌ Registration failed:', response.data.message);
        return false;
      }
    } catch (error) {
      console.error('❌ Registration error:', error.message);
      return false;
    }
  }
  
  async deregister() {
    try {
      console.log('📤 Deregistering from coordinator...');
      
      const response = await axios.delete(`${this.coordinatorUrl}/agents/${this.id}`);
      
      if (response.data.success) {
        this.status = 'offline';
        if (this.heartbeatInterval) {
          clearInterval(this.heartbeatInterval);
        }
        console.log('✅ Deregistration successful!');
        return true;
      } else {
        console.error('❌ Deregistration failed:', response.data.message);
        return false;
      }
    } catch (error) {
      console.error('❌ Deregistration error:', error.message);
      return false;
    }
  }
  
  startHeartbeat() {
    // Send heartbeat every 30 seconds to maintain connection
    this.heartbeatInterval = setInterval(async () => {
      try {
        const response = await axios.post(`${this.coordinatorUrl}/agents/${this.id}/heartbeat`);
        console.log('💓 Heartbeat sent, coordinator response:', response.data.agentStatus);
        
        // Process any pending tasks received from coordinator
        if (response.data.pendingTasks && response.data.pendingTasks.length > 0) {
          console.log(`📋 Processing ${response.data.pendingTasks.length} pending tasks`);
          for (const task of response.data.pendingTasks) {
            await this.executeTask(task);
          }
        }
      } catch (error) {
        console.error('💔 Heartbeat failed:', error.message);
      }
    }, 30000); // 30秒心跳间隔
  }
  
  async executeTask(task) {
    console.log(`⚙️ Executing task: ${task.type} (ID: ${task.id})`);
    
    let result, error;
    
    try {
      switch (task.type) {
        case 'communication':
          result = await this.handleCommunicationTask(task.data);
          break;
        case 'information-query':
          result = await this.handleInformationQuery(task.data);
          break;
        case 'coordination':
          result = await this.handleCoordinationTask(task.data);
          break;
        case 'general-task':
          result = await this.handleGeneralTask(task.data);
          break;
        default:
          result = await this.handleUnknownTask(task);
          break;
      }
      
      // Report task completion
      await this.reportTaskCompletion(task.id, result, null);
    } catch (taskError) {
      console.error(`❌ Task execution failed: ${taskError.message}`);
      error = taskError.message;
      await this.reportTaskCompletion(task.id, null, error);
    }
  }
  
  async handleCommunicationTask(data) {
    console.log(`💬 Handling communication task: ${data.message || data.content}`);
    
    // 这里可以处理通信相关的任务
    const response = {
      handledBy: this.name,
      taskType: 'communication',
      processedAt: new Date().toISOString(),
      result: `Processed communication task: ${data.message || data.content}`
    };
    
    return response;
  }
  
  async handleInformationQuery(data) {
    console.log(`🔍 Handling information query: ${data.query}`);
    
    // 这里可以处理信息查询任务
    const response = {
      handledBy: this.name,
      taskType: 'information-query',
      processedAt: new Date().toISOString(),
      result: `Processed information query: ${data.query}`,
      data: {
        source: 'Multi-Agent Client knowledge base',
        confidence: 0.95,
        timestamp: new Date().toISOString()
      }
    };
    
    return response;
  }
  
  async handleCoordinationTask(data) {
    console.log(`🤝 Handling coordination task: ${data.description || data.action}`);
    
    // 这里可以处理协调相关的任务
    const response = {
      handledBy: this.name,
      taskType: 'coordination',
      processedAt: new Date().toISOString(),
      result: `Coordinated task: ${data.description || data.action}`,
      coordinationResult: {
        participants: ['Multi-Agent-Client'],
        status: 'coordinated',
        timestamp: new Date().toISOString()
      }
    };
    
    return response;
  }
  
  async handleGeneralTask(data) {
    console.log(`⚙️ Handling general task: ${JSON.stringify(data)}`);
    
    // 这里可以处理一般性任务
    const response = {
      handledBy: this.name,
      taskType: 'general-task',
      processedAt: new Date().toISOString(),
      result: `Processed general task`,
      data: data
    };
    
    return response;
  }
  
  async handleUnknownTask(task) {
    console.log(`❓ Handling unknown task type: ${task.type}`);
    
    const response = {
      handledBy: this.name,
      taskType: 'unknown',
      processedAt: new Date().toISOString(),
      result: `Handled unknown task type: ${task.type}`,
      originalTask: task
    };
    
    return response;
  }
  
  async reportTaskCompletion(taskId, result, error) {
    try {
      const response = await axios.put(`${this.coordinatorUrl}/tasks/${taskId}/complete`, {
        result: result,
        error: error
      });
      
      console.log(`✅ Task ${taskId} completion reported successfully`);
    } catch (error) {
      console.error(`❌ Failed to report task completion: ${error.message}`);
    }
  }
  
  async submitTask(type, data, options = {}) {
    const taskId = options.id || `task-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
    
    try {
      const response = await axios.post(`${this.coordinatorUrl}/tasks`, {
        id: taskId,
        type: type,
        data: data,
        priority: options.priority || 'normal',
        requiredCapabilities: options.requiredCapabilities || []
      });
      
      console.log(`📤 Task submitted: ${taskId}, Type: ${type}`);
      return response.data;
    } catch (error) {
      console.error(`❌ Task submission failed: ${error.message}`);
      throw error;
    }
  }
  
  async getStatus() {
    try {
      const response = await axios.get(`${this.coordinatorUrl}/agents`);
      const agentInfo = response.data.agents.find(agent => agent.id === this.id);
      
      return {
        status: this.status,
        agentInfo: agentInfo || null,
        coordinatorConnected: !!agentInfo
      };
    } catch (error) {
      console.error('❌ Status check failed:', error.message);
      return {
        status: this.status,
        error: error.message
      };
    }
  }
  
  async start() {
    console.log('🚀 Starting Multi-Agent Client...');
    
    const registered = await this.register();
    if (registered) {
      console.log(`✅ Multi-Agent Client is now online and connected to coordinator at ${this.coordinatorUrl}`);
      
      // 设置优雅退出
      process.on('SIGINT', async () => {
        console.log('\\n🛑 Shutting down Multi-Agent Client...');
        await this.deregister();
        process.exit(0);
      });
      
      return true;
    } else {
      console.error('❌ Failed to start Multi-Agent Client');
      return false;
    }
  }
}

// 使用示例
async function main() {
  // 创建多智能体协调客户端实例
  const multiAgentClient = new MultiAgentClient({
    id: `multi-agent-client-${Date.now()}`,
    name: 'Multi-Agent-Client',
    coordinatorUrl: 'http://8.130.18.239:3000', // 中央协调服务器地址
    capabilities: [
      'communication',           // 通信能力
      'information-processing',  // 信息处理能力
      'task-execution',         // 任务执行能力
      'coordination',           // 协调能力
      'natural-language-understanding' // 自然语言理解
    ]
  });
  
  // 启动客户端
  const started = await multiAgentClient.start();
  
  if (started) {
    console.log('\\n🎉 Multi-Agent Client is running and connected to the multi-agent coordination system!');
    console.log('The client will now listen for tasks from the coordinator and participate in coordination activities.');
    
    // 示例：提交一个通信任务
    setTimeout(async () => {
      try {
        await multiAgentClient.submitTask(
          'communication', 
          { 
            message: 'Hello from Multi-Agent Client! Ready to coordinate with other agents.',
            sender: 'Multi-Agent-Client',
            timestamp: new Date().toISOString()
          },
          { priority: 'high' }
        );
      } catch (error) {
        console.error('Failed to submit example task:', error.message);
      }
    }, 5000); // 5秒后提交示例任务
  }
}

// 如果此文件被直接运行，则启动主函数
if (require.main === module) {
  main().catch(console.error);
}

module.exports = MultiAgentClient;
EOF

# Create package.json
cat > package.json << 'EOF'
{
  "name": "multi-agent-client",
  "version": "1.0.0",
  "description": "Multi-Agent client for multi-agent coordination system",
  "main": "multi-agent-client.js",
  "scripts": {
    "start": "node multi-agent-client.js",
    "dev": "nodemon multi-agent-client.js"
  },
  "dependencies": {
    "axios": "^1.6.0",
    "express": "^4.18.2",
    "ws": "^8.14.2",
    "cors": "^2.8.5"
  },
  "keywords": [
    "multi-agent",
    "coordination",
    "ai",
    "communication",
    "collaboration"
  ],
  "author": "Multi-Agent Coordination Team",
  "license": "MIT"
}
EOF

# Make the client script executable
chmod +x multi-agent-client.js

echo "✅ Multi-Agent Coordination Client has been set up successfully!"
echo ""
echo "📋 Next steps:"
echo "1. cd multi-agent-client"
echo "2. node multi-agent-client.js"
echo ""
echo "🌐 The client will connect to the coordinator server at http://8.130.18.239:3000"
echo "🔄 Once connected, the client will participate in multi-agent coordination"
echo ""
echo "💡 Tip: You can also run 'npm start' to launch the client"
EOF
