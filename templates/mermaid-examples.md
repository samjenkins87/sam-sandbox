# Mermaid Diagram Templates

Quick-copy templates for common diagrams. View rendered versions on GitHub or in Cursor (Cmd+Shift+V).

---

## Flowchart (Top-Down)

```mermaid
flowchart TD
    A[Start] --> B{Decision}
    B -->|Yes| C[Action 1]
    B -->|No| D[Action 2]
    C --> E[End]
    D --> E
```

## Flowchart (Left-Right)

```mermaid
flowchart LR
    Input --> Process --> Output
```

---

## Architecture Diagram

```mermaid
flowchart TB
    subgraph Cloud["Cloud Services"]
        API[API Server]
        DB[(Database)]
        Cache[(Redis)]
    end

    subgraph Client["Client Apps"]
        Web[Web App]
        Mobile[Mobile App]
    end

    Web --> API
    Mobile --> API
    API --> DB
    API --> Cache
```

---

## Sequence Diagram

```mermaid
sequenceDiagram
    participant U as User
    participant C as Claude
    participant G as GitHub

    U->>C: Start task
    C->>G: Read files
    G-->>C: File contents
    C->>C: Process
    C->>G: Commit changes
    G-->>U: Push notification
```

---

## Git Flow

```mermaid
gitGraph
    commit id: "initial"
    branch feature/auth
    checkout feature/auth
    commit id: "add login"
    commit id: "add logout"
    checkout main
    merge feature/auth
    commit id: "deploy"
```

---

## State Diagram

```mermaid
stateDiagram-v2
    [*] --> Draft
    Draft --> InReview: Submit PR
    InReview --> Approved: Approve
    InReview --> Draft: Request Changes
    Approved --> Merged: Merge
    Merged --> [*]
```

---

## Entity Relationship

```mermaid
erDiagram
    USER ||--o{ PROJECT : owns
    PROJECT ||--|{ TASK : contains
    USER ||--o{ TASK : assigned

    USER {
        string id PK
        string email
        string name
    }
    PROJECT {
        string id PK
        string name
        string user_id FK
    }
    TASK {
        string id PK
        string title
        string status
    }
```

---

## Timeline

```mermaid
timeline
    title Project Phases
    section Planning
        Week 1 : Requirements gathering
        Week 2 : Architecture design
    section Development
        Week 3-4 : Core features
        Week 5-6 : UI/UX
    section Launch
        Week 7 : Testing
        Week 8 : Deploy
```

---

## Pie Chart

```mermaid
pie title Time Allocation
    "Coding" : 45
    "Planning" : 20
    "Review" : 15
    "Meetings" : 10
    "Other" : 10
```

---

## Dark Theme Styling

Add this at the top of any diagram for dark-friendly colors:

```mermaid
%%{init: {'theme': 'dark', 'themeVariables': { 'primaryColor': '#4a9eff', 'primaryTextColor': '#fff', 'primaryBorderColor': '#4a9eff', 'lineColor': '#f5a623', 'secondaryColor': '#1a1a1a', 'tertiaryColor': '#2d2d2d'}}}%%
flowchart TD
    A[Styled Box] --> B[Another Box]
```

---

## Your Workflow Diagram

```mermaid
%%{init: {'theme': 'dark'}}%%
flowchart TB
    subgraph Linear["LINEAR"]
        Issues[Issues & Projects]
    end

    subgraph GitHub["GITHUB"]
        Repo[Repository]
        PR[Pull Requests]
    end

    subgraph Local["LOCAL - Cursor"]
        Tab1[Session 1: Architect]
        Tab2[Session 2: Implement]
        Tab3[Session 3: Test]
    end

    subgraph Cloud["CLOUD - claude.ai"]
        Research[Research]
        Planning[PRD Planning]
        Review[Code Review]
    end

    subgraph Deploy["DEPLOY"]
        Vercel[Vercel]
        Supabase[Supabase]
    end

    Issues --> Repo
    Repo --> Local
    Repo --> Cloud
    Local <--> Cloud
    PR --> Vercel
    Repo --> Supabase
```

---

## Tips

1. **View in GitHub**: Push any .md file with mermaid blocks - GitHub renders them
2. **View in Cursor**: `Cmd+Shift+V` to open markdown preview
3. **Export to image**: Use `mmdc -i file.mmd -o file.png` (needs mermaid-cli)
4. **Live editor**: https://mermaid.live - paste code, see results instantly
