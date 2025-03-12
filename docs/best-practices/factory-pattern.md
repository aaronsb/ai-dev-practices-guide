# Factory Pattern Implementation Guide for MCP Servers with REST API

## Core Design Principles

1. **Entity-Centric Organization**: Structure your tools around domain entities rather than individual operations.
   
2. **Operation Grouping**: Each entity tool should support multiple related operations (list, get, create, update, delete).
   
3. **Factory-Based Creation**: Implement a central factory that creates and configures entity tools.
   
4. **Registry-Based Management**: Use a tool registry to manage registration, discovery, and execution.
   
5. **Declarative Schema Definition**: Define operation parameters using declarative schemas for validation and documentation.

## Implementation Components

### 1. Abstract Base Class
```typescript
abstract class EntityTool {
  protected operations: Record<string, Function> = {};
  protected schemas: Record<string, Schema> = {};
  
  // Register operations with their validation schemas
  protected registerOperation(name: string, handler: Function, schema: Schema): void {
    this.operations[name] = handler;
    this.schemas[name] = schema;
  }
  
  // Execute operations with validation
  public async execute(args: any): Promise<any> {
    const operation = args.operation;
    const params = args[`${operation}Params`];
    
    // Validate params using schema
    const validParams = this.schemas[operation].parse(params);
    
    // Execute operation
    return this.operations[operation](validParams);
  }
  
  // Generate documentation
  public getDocumentation(): Documentation {
    // Implementation
  }
}
```

### 2. Entity Tool Factory
```typescript
class EntityToolFactory {
  // Create instance of UsersTool
  static createUsersTool(apiClient: ApiClient): UsersTool {
    return new UsersTool(apiClient);
  }
  
  // Create instance of ResourcesTool
  static createResourcesTool(apiClient: ApiClient): ResourcesTool {
    return new ResourcesTool(apiClient);
  }
  
  // Other factory methods...
}
```

### 3. Entity-Specific Tools
```typescript
class UsersTool extends EntityTool {
  private apiClient: ApiClient;

  constructor(apiClient: ApiClient) {
    super();
    this.apiClient = apiClient;
    
    // Register operations
    this.registerOperation('list', this.listUsers, listSchema);
    this.registerOperation('get', this.getUser, getSchema);
    this.registerOperation('create', this.createUser, createSchema);
    this.registerOperation('update', this.updateUser, updateSchema);
    this.registerOperation('delete', this.deleteUser, deleteSchema);
  }
  
  private async listUsers(params: ListUsersParams): Promise<User[]> {
    const response = await this.apiClient.get('/users', params);
    return response.data.map(userData => this.mapToUser(userData));
  }
  
  private async getUser(params: GetUserParams): Promise<User> {
    const response = await this.apiClient.get(`/users/${params.userId}`);
    return this.mapToUser(response.data);
  }
  
  private async createUser(params: CreateUserParams): Promise<User> {
    const response = await this.apiClient.post('/users', params);
    return this.mapToUser(response.data);
  }
  
  private async updateUser(params: UpdateUserParams): Promise<User> {
    const response = await this.apiClient.put(`/users/${params.userId}`, params);
    return this.mapToUser(response.data);
  }
  
  private async deleteUser(params: DeleteUserParams): Promise<void> {
    await this.apiClient.delete(`/users/${params.userId}`);
  }
  
  private mapToUser(data: any): User {
    // Convert API response to User entity
    return {
      id: data.id,
      username: data.username,
      email: data.email,
      role: data.role,
      properties: data.properties || {}
    };
  }
}
```

### 4. Tool Registry
```typescript
class ToolRegistry {
  private tools: Map<string, EntityTool> = new Map();
  
  constructor(apiClient: ApiClient) {
    // Initialize and register tools
    this.registerTool('users', EntityToolFactory.createUsersTool(apiClient));
    this.registerTool('resources', EntityToolFactory.createResourcesTool(apiClient));
    // Register other tools...
  }
  
  public registerTool(name: string, tool: EntityTool): void {
    this.tools.set(name, tool);
  }
  
  public async executeTool(name: string, args: any): Promise<any> {
    const tool = this.tools.get(name);
    
    if (!tool) {
      throw new Error(`Tool '${name}' not found`);
    }
    
    try {
      return await tool.execute(args);
    } catch (error) {
      // Enhanced error handling
      throw this.enhanceError(error, name, args);
    }
  }
  
  public getToolNames(): string[] {
    return Array.from(this.tools.keys());
  }
  
  public getToolDocumentation(name: string): Documentation {
    const tool = this.tools.get(name);
    
    if (!tool) {
      throw new Error(`Tool '${name}' not found`);
    }
    
    return tool.getDocumentation();
  }
  
  private enhanceError(error: any, toolName: string, args: any): Error {
    // Add context to error
    error.toolName = toolName;
    error.args = args;
    return error;
  }
}
```

## REST API Integration

### ApiClient Implementation
```typescript
class ApiClient {
  private baseUrl: string;
  private authToken: string;
  
  constructor(baseUrl: string, authToken: string) {
    this.baseUrl = baseUrl;
    this.authToken = authToken;
  }
  
  async get(path: string, queryParams?: object): Promise<any> {
    return this.request('GET', path, queryParams);
  }
  
  async post(path: string, data?: object): Promise<any> {
    return this.request('POST', path, null, data);
  }
  
  async put(path: string, data?: object): Promise<any> {
    return this.request('PUT', path, null, data);
  }
  
  async delete(path: string): Promise<any> {
    return this.request('DELETE', path);
  }
  
  private async request(method: string, path: string, queryParams?: object, data?: object): Promise<any> {
    try {
      const url = new URL(this.baseUrl + path);
      
      // Add query parameters
      if (queryParams) {
        Object.entries(queryParams).forEach(([key, value]) => {
          url.searchParams.append(key, String(value));
        });
      }
      
      const response = await fetch(url.toString(), {
        method,
        headers: {
          'Authorization': `Bearer ${this.authToken}`,
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: data ? JSON.stringify(data) : undefined
      });
      
      if (!response.ok) {
        throw await this.handleErrorResponse(response);
      }
      
      return await response.json();
    } catch (error) {
      throw this.enhanceNetworkError(error, method, path);
    }
  }
  
  private async handleErrorResponse(response: Response): Promise<Error> {
    let errorData: any;
    
    try {
      errorData = await response.json();
    } catch {
      errorData = { message: 'Unknown error' };
    }
    
    const error = new Error(errorData.message || `HTTP Error ${response.status}`);
    error.statusCode = response.status;
    error.responseData = errorData;
    
    return error;
  }
  
  private enhanceNetworkError(error: any, method: string, path: string): Error {
    error.request = { method, path };
    return error;
  }
}
```

### Pagination Support
```typescript
class PaginationHelper {
  static async fetchAllPages<T>(fetchPage: (page: number) => Promise<{data: T[], totalPages: number}>): Promise<T[]> {
    const result: T[] = [];
    let currentPage = 1;
    let totalPages = 1;
    
    do {
      const response = await fetchPage(currentPage);
      result.push(...response.data);
      totalPages = response.totalPages;
      currentPage++;
    } while (currentPage <= totalPages);
    
    return result;
  }
}
```

## Schema Definition Examples

### Zod Schema Examples
```typescript
import { z } from 'zod';

// User schemas
const listUsersSchema = z.object({
  page: z.number().int().positive().optional(),
  pageSize: z.number().int().positive().max(100).optional(),
  filter: z.string().optional()
});

const getUserSchema = z.object({
  userId: z.string().uuid()
});

const createUserSchema = z.object({
  username: z.string().min(3).max(50),
  email: z.string().email(),
  role: z.enum(['admin', 'user', 'guest']).optional(),
  properties: z.record(z.string(), z.any()).optional()
});

const updateUserSchema = z.object({
  userId: z.string().uuid(),
  username: z.string().min(3).max(50).optional(),
  email: z.string().email().optional(),
  role: z.enum(['admin', 'user', 'guest']).optional(),
  properties: z.record(z.string(), z.any()).optional()
});

const deleteUserSchema = z.object({
  userId: z.string().uuid()
});
```

## Complete System Initialization

```typescript
function initializeSystem(baseUrl: string, authToken: string) {
  // Create API client
  const apiClient = new ApiClient(baseUrl, authToken);
  
  // Create tool registry and register tools
  const toolRegistry = new ToolRegistry(apiClient);
  
  return {
    // Execute a tool operation
    async execute(toolName: string, operation: string, params: any) {
      return toolRegistry.executeTool(toolName, {
        operation,
        [`${operation}Params`]: params
      });
    },
    
    // Get list of available tools
    getToolNames() {
      return toolRegistry.getToolNames();
    },
    
    // Get documentation for a tool
    getToolDocumentation(toolName: string) {
      return toolRegistry.getToolDocumentation(toolName);
    }
  };
}

// Usage example
const system = initializeSystem('https://api.example.com', 'auth-token-123');

// List users
const users = await system.execute('users', 'list', { page: 1, pageSize: 10 });

// Create a user
const newUser = await system.execute('users', 'create', {
  username: 'johndoe',
  email: 'john@example.com',
  role: 'user'
});
```

## Benefits of This Architecture

1. **Reduced Complexity**: Instead of dozens of individual tools (one per operation), you have a handful of entity tools with multiple operations.

2. **Intuitive Organization**: Tools are organized by the entities they operate on, making them more discoverable and easier to understand.

3. **Consistent Interface**: All entity tools follow the same pattern for operations and parameters, providing a consistent user experience.

4. **Better Error Handling**: Each entity tool can handle errors specific to its domain, providing more meaningful error messages.

5. **Enhanced Documentation**: Entity tools can provide rich documentation with examples and operation-specific descriptions.

6. **Simplified Maintenance**: Adding new operations to an entity is easier than creating entirely new tools.

7. **Testability**: The architecture lends itself well to unit testing and dependency injection.

## Implementation Guidelines

When implementing this pattern:

1. **Start with Domain Entities**: Identify the key entities in your domain (Users, Resources, etc.).

2. **Define Operations**: For each entity, define the operations it supports (list, get, create, etc.).

3. **Create Base Class**: Implement a base class with common functionality for all entity tools.

4. **Implement Factory**: Create a factory class with methods to create each entity tool.

5. **Create Registry**: Implement a registry to manage tool registration and execution.

6. **Add Documentation**: Provide rich documentation with examples and operation-specific descriptions.

7. **Handle Errors**: Implement comprehensive error handling with meaningful error messages.

This architectural pattern provides a maintainable, user-friendly, and robust approach to implementing MCP servers with REST API integration.
