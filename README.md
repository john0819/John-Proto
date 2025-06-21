# Protobuf Repository

这是一个使用 [buf](https://buf.build/) 管理的 Protobuf 代码仓库，用于生成多种语言的客户端和服务端代码。

## 项目结构

```
.
├── proto/           # 存放 .proto 文件
│   ├── user.proto
│   └── product.proto
├── gen/            # 生成的代码（自动生成）
│   ├── go/         # Go 代码
│   ├── js/         # JavaScript 代码
│   ├── web/        # TypeScript/Web 代码
│   ├── python/     # Python 代码
│   ├── java/       # Java 代码
│   └── csharp/     # C# 代码
├── buf.yaml        # buf 配置文件
├── buf.gen.yaml    # 代码生成配置
├── buf.work.yaml   # 工作区配置
├── Makefile        # 便捷命令
└── README.md       # 项目文档
```

## 快速开始

### 1. 安装 buf CLI

```bash
make install
```

或者手动安装：

```bash
# macOS
brew install bufbuild/buf/buf

# Linux
curl -sSL \
  "https://github.com/bufbuild/buf/releases/latest/download/buf-$(uname -s)-$(uname -m)" \
  -o "$HOME/.local/bin/buf" && \
chmod +x "$HOME/.local/bin/buf"
```

### 2. 生成代码

```bash
make generate
```

这将根据 `buf.gen.yaml` 配置生成多种语言的代码到 `gen/` 目录。

### 3. 代码质量检查

```bash
# 格式化代码
make format

# 代码检查
make lint

# 检查破坏性变更
make breaking
```

## 常用命令

| 命令 | 描述 |
|------|------|
| `make help` | 显示所有可用命令 |
| `make generate` | 生成代码 |
| `make lint` | 代码检查 |
| `make format` | 格式化代码 |
| `make breaking` | 检查破坏性变更 |
| `make clean` | 清理生成的代码 |
| `make mod-update` | 更新依赖 |
| `make init-proto` | 创建新的 proto 文件 |

## 添加新的 Proto 文件

### 方法 1: 使用 Makefile

```bash
make init-proto
# 然后输入文件名
```

### 方法 2: 手动创建

1. 在 `proto/` 目录下创建新的 `.proto` 文件
2. 确保包含正确的包名和 go_package 选项
3. 运行 `make generate` 生成代码

示例：

```protobuf
syntax = "proto3";

package example.v1;

option go_package = "github.com/your-org/proto/gen/example/v1;examplev1";

service ExampleService {
  rpc GetExample(GetExampleRequest) returns (GetExampleResponse);
}

message GetExampleRequest {
  string id = 1;
}

message GetExampleResponse {
  string data = 1;
}
```

## 配置说明

### buf.yaml

- `name`: 项目名称
- `deps`: 依赖的外部 proto 文件
- `lint`: 代码检查规则
- `breaking`: 破坏性变更检查规则

### buf.gen.yaml

配置代码生成器，支持以下语言：

- **Go**: 生成 Go 代码和 gRPC 代码
- **JavaScript**: 生成 ES 模块和 Connect-ES 代码
- **TypeScript/Web**: 生成 Web 客户端代码
- **Python**: 生成 Python 代码
- **Java**: 生成 Java 代码
- **C#**: 生成 C# 代码

### buf.work.yaml

定义工作区，指定包含 proto 文件的目录。

## 最佳实践

1. **版本控制**: 所有 proto 文件都应该进行版本控制
2. **命名规范**: 使用有意义的包名和文件名
3. **文档**: 为每个服务和消息添加注释
4. **向后兼容**: 避免破坏性变更，使用版本号管理 API
5. **测试**: 定期运行 lint 和 breaking 检查

## 依赖管理

更新依赖：

```bash
make mod-update
```

查看当前依赖：

```bash
buf mod ls
```

## 故障排除

### 常见问题

1. **buf 命令未找到**: 确保已正确安装 buf CLI
2. **生成失败**: 检查 proto 文件语法和导入路径
3. **依赖问题**: 运行 `make mod-update` 更新依赖

### 获取帮助

```bash
buf help
buf generate --help
buf lint --help
```

## 贡献指南

1. Fork 项目
2. 创建功能分支
3. 添加或修改 proto 文件
4. 运行 `make lint` 和 `make generate`
5. 提交更改
6. 创建 Pull Request

## 许可证

[添加你的许可证信息] 