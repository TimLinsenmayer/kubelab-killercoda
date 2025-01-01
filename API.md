# KubeLab API Documentation

This document describes the endpoints available in the KubeLab API for tracking participant progress and task completion.

## Base URL

```
https://kubelab.tim.it.com/
https://dhbw-kubernetes.azurewebsites.net/
```

## Endpoints

### Get Active Rounds

Retrieves all available rounds, including their tasks and completion status.

```
GET /api/rounds
```

**Response**
```typescript
interface Round {
  id: number;
  name: string;
  description: string;
  isActive: boolean;
  participantCount: number;
  tasks: {
    id: number;
    name: string;
    description: string;
    maxPoints: number;
    maxAwarding: number;
    completionCount: number;
  }[];
}

// Response: Round[]
```

### Register Participant

Registers a participant for a specific round.

```
POST /api/register
```

**Request Body**
```typescript
{
  name: string;    // Participant's name
  roundId: number; // ID of the round to register for
}
```

**Response**
```typescript
{
  participantId: number; // Unique ID for the participant
  name: string;         // Participant's name
  roundId: number;      // Round ID they registered for
}
```

**Errors**
- 400: Invalid request body
- 404: Round not found
- 409: Participant already registered for this round

### Complete Task

Records a task completion for a participant.

```
POST /api/complete
```

**Request Body**
```typescript
{
  participantId: number; // ID of the participant
  taskId: number;       // ID of the completed task
}
```

**Response**
```typescript
{
  id: number;           // Completion ID
  participantId: number;
  taskId: number;
  pointsGranted: number;  // Points awarded for this completion
  completedAt: string;    // ISO timestamp
  position: number;       // Order of completion (1st, 2nd, etc.)
}
```

**Errors**
- 400: Invalid request body
- 404: Participant or task not found
- 409: Task already completed by this participant
- 403: Task's round is not active

### Get Leaderboard

Retrieves the current leaderboard with participant scores.

```
GET /api/leaderboard
```

**Response**
```typescript
interface Participant {
  name: string;
  totalPoints: number;
  completedTasks: {
    taskName: string;
    pointsGranted: number;
    completedAt: string;
  }[];
}

// Response: Participant[]
```

### Real-time Updates (SSE)

Subscribe to real-time updates for the leaderboard.

```
GET /api/stream
```

This endpoint uses Server-Sent Events (SSE) to push updates to clients. The stream sends the following events:

1. **Connection Message**
```typescript
data: {"type":"connected"}
```

2. **Keepalive**
```
data: keepalive
```

3. **Participant Updates**
```typescript
data: Participant[] // Same format as GET /api/leaderboard response
```

**Example Client Usage**
```javascript
const eventSource = new EventSource('/api/stream');

eventSource.onmessage = (event) => {
  if (event.data === 'keepalive') return;
  
  const data = JSON.parse(event.data);
  if (data.type === 'connected') {
    console.log('Connected to SSE');
    return;
  }
  
  if (Array.isArray(data)) {
    // Handle participant updates
    updateLeaderboard(data);
  }
};
```

## Points System

- Each task has a `maxPoints` value, which is the maximum points possible for the first completion
- Tasks also have a `maxAwarding` value, which is the minimum points that can be awarded
- Points are awarded on a decreasing scale based on completion order
- Earlier completions receive more points than later ones
- Points never go below the task's `maxAwarding` value

## Best Practices

1. **Error Handling**
   - Always check response status codes
   - Handle network errors gracefully
   - Implement exponential backoff for retries

2. **Real-time Updates**
   - Use SSE for real-time leaderboard updates
   - Handle reconnection automatically
   - Process keepalive messages to maintain connection

3. **Rate Limiting**
   - Implement reasonable delays between task completions
   - Handle 429 Too Many Requests responses
   - Use exponential backoff when rate limited 