# Multi-Agent Coordination System - Installation Guide

## Prerequisites

Before installing the Multi-Agent Coordination System skill, ensure you have:

- Node.js version 14.0.0 or higher
- npm package manager
- OpenClaw system installed and running
- Internet connectivity for downloading dependencies

## Installation via OpenClaw

The easiest way to install the Multi-Agent Coordination System is through the OpenClaw skill system:

```bash
openclaw skill install multi-agent-coordination
```

This command will:
1. Download the skill from the OpenClaw skill repository
2. Execute the installation script
3. Clone the Multi-Agent Coordination System from GitHub
4. Install all required dependencies
5. Verify the installation

## Manual Installation

If you prefer to install manually, you can:

1. Clone the repository directly:
```bash
cd ~/.openclaw/workspace
git clone https://github.com/tianyuleishen/multi-agent-coordination-system.git
```

2. Install dependencies:
```bash
cd multi-agent-coordination-system
npm install
```

## Post-Installation Setup

After installation, you can verify the system is working properly:

1. Navigate to the installation directory:
```bash
cd ~/.openclaw/workspace/multi-agent-coordination-system
```

2. Run the system test:
```bash
node integration_test.js
```

3. Run the demo to see the system in action:
```bash
node demo.js
```

## Configuration

The system comes with default configurations that work out of the box. For custom configurations:

1. Copy the example configuration file:
```bash
cp config.example.json config.json
```

2. Edit the configuration values as needed

## Updating the Skill

To update to the latest version of the skill:

```bash
openclaw skill update multi-agent-coordination
```

## Uninstalling

To completely remove the skill:

```bash
openclaw skill uninstall multi-agent-coordination
```

This will remove all files associated with the Multi-Agent Coordination System.

## Troubleshooting

### Common Issues

**Issue**: Installation fails due to network connectivity
**Solution**: Ensure you have internet connectivity and can access GitHub

**Issue**: Node.js version is too old
**Solution**: Update Node.js to version 14.0.0 or higher

**Issue**: Permission denied errors
**Solution**: Ensure you have write permissions to the OpenClaw workspace directory

**Issue**: Dependencies fail to install
**Solution**: Clear npm cache with `npm cache clean --force` and retry installation

### Verification Steps

To verify the installation worked correctly:

1. Check that the directory exists:
```bash
ls -la ~/.openclaw/workspace/multi-agent-coordination-system/
```

2. Verify key files are present:
```bash
ls -la ~/.openclaw/workspace/multi-agent-coordination-system/ | grep -E "(central_coordinator|agent_base|coordination_system)"
```

3. Test basic functionality:
```bash
node -e "console.log('Import test:', require('./multi-agent-coordination-system/package.json').name)"
```

## Getting Started

After successful installation, start with the examples:

1. Start the central coordinator:
```bash
cd ~/.openclaw/workspace/multi-agent-coordination-system
node examples/server.js
```

2. In a separate terminal, connect a client:
```bash
cd ~/.openclaw/workspace/multi-agent-coordination-system
node examples/client.js
```

See the USAGE.md file for more detailed usage instructions.