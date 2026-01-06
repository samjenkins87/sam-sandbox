# Claude Design Skill: Linear-Style UI Implementation

## Overview

This skill document provides instructions for AI agents implementing UI/UX for the Pitchback CreativeOS platform. The design language is based on Linear's UI with the **Crisp Azure** accent color theme.

**Key Design Identity:**
- Linear's layout patterns and density
- Crisp Azure blue (`#3B82F6`) as primary accent (replaces Linear's purple)
- Deep graphite backgrounds in dark mode
- Clean whites/light grays in light mode
- Light mode as default

---

## Quick Reference: Design Tokens

### Colors (Copy-Paste Ready)

```typescript
// Light Mode (DEFAULT)
const lightTheme = {
  // Backgrounds - Linear's exact light mode palette
  bgPrimary: '#FFFFFF',
  bgSecondary: '#FAFAFA',
  bgTertiary: '#F5F5F5',
  bgHover: '#F0F0F0',

  // Text
  textPrimary: '#1A1A1A',
  textSecondary: '#6B6B6B',
  textTertiary: '#9B9B9B',

  // Borders
  borderPrimary: '#E5E5E5',
  borderSecondary: '#EFEFEF',

  // Accent - CRISP AZURE (replaces Linear purple)
  accent: '#3B82F6',           // Blue-500 - Primary brand
  accentHover: '#2563EB',      // Blue-600 - Hover state
  accentLight: '#60A5FA',      // Blue-400 - Text highlights
  accentSubtle: 'rgba(59, 130, 246, 0.10)',  // Selection backgrounds

  // Status
  statusProgress: '#F2C94C',   // Yellow/amber
  statusComplete: '#6FCF97',   // Green
  statusError: '#EB5757',      // Red
  statusMuted: '#828282',      // Gray
}

// Dark Mode - CRISP AZURE GRAPHITE THEME
const darkTheme = {
  // Backgrounds - Deep Graphite palette
  bgPrimary: '#0B0F14',        // Deepest graphite - main background
  bgSecondary: '#14181F',      // Sidebars, cards, panels
  bgTertiary: '#1E293B',       // Elevated surfaces
  bgHover: '#1E293B',          // Hover states

  // Text
  textPrimary: '#E5E7EB',      // Gray-200 - High legibility
  textSecondary: '#94A3B8',    // Slate-400 - Muted text
  textTertiary: '#64748B',     // Slate-500 - Disabled/placeholder

  // Borders
  borderPrimary: '#27272A',    // Zinc-800 - Subtle structure
  borderSecondary: '#1F1F1F',  // Even subtler

  // Accent - CRISP AZURE
  accent: '#3B82F6',           // Blue-500 - Primary brand
  accentHover: '#60A5FA',      // Blue-400 - Hover/light variant
  accentSubtle: 'rgba(59, 130, 246, 0.15)',  // Selection backgrounds
  accentForeground: '#60A5FA', // Text on accent backgrounds

  // Status (same as light)
  statusProgress: '#EAB308',   // Yellow-500
  statusComplete: '#22C55E',   // Green-500
  statusError: '#EF4444',      // Red-500
  statusMuted: '#6B6B6B',
}
```

### The "Azure Glow" Effects

```css
/* Focus Ring / Active Border */
.azure-focus {
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.35);
}

/* Soft Outer Glow (selected items) */
.azure-glow {
  box-shadow: 0 0 24px rgba(59, 130, 246, 0.25);
}

/* Active Item Background */
.azure-active {
  background-color: rgba(59, 130, 246, 0.10);
  color: #60A5FA;
}
```

### Typography

```typescript
const typography = {
  fontFamily: '"Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif',
  fontDisplay: '"Inter Display", "Inter", sans-serif',
  fontMono: '"SF Mono", "Fira Code", monospace',

  sizes: {
    xs: '11px',
    sm: '12px',
    base: '13px',  // DEFAULT - Linear uses 13px not 14px!
    md: '14px',
    lg: '16px',
    xl: '18px',
    '2xl': '24px',
    '3xl': '32px',
  },

  weights: {
    normal: 400,
    medium: 500,
    semibold: 600,
    bold: 700,
  },

  lineHeight: {
    tight: 1.2,
    normal: 1.5,
    relaxed: 1.6,
  },
}
```

### Spacing

```typescript
const spacing = {
  0: '0px',
  1: '4px',
  2: '8px',
  3: '12px',
  4: '16px',
  5: '20px',
  6: '24px',
  8: '32px',
  10: '40px',
  12: '48px',
}
```

### Border Radius

```typescript
const radius = {
  sm: '4px',
  md: '6px',   // DEFAULT for buttons, inputs
  lg: '8px',   // DEFAULT for cards
  xl: '12px',
  full: '9999px',
}
```

---

## CSS Variables (Complete Theme)

```css
:root {
  /* Light Mode (Default) - Linear exact + Azure accent */
  --primary: #3B82F6;
  --primary-foreground: #FFFFFF;

  --background: #FFFFFF;
  --foreground: #1A1A1A;

  --card: #FAFAFA;
  --card-foreground: #1A1A1A;

  --popover: #FFFFFF;
  --popover-foreground: #1A1A1A;

  --secondary: #F5F5F5;
  --secondary-foreground: #1A1A1A;

  --muted: #F5F5F5;
  --muted-foreground: #6B6B6B;

  --accent: rgba(59, 130, 246, 0.10);
  --accent-foreground: #2563EB;

  --destructive: #EF4444;
  --destructive-foreground: #FFFFFF;

  --border: #E5E5E5;
  --input: #E5E5E5;
  --ring: rgba(59, 130, 246, 0.5);

  /* Chart Colors */
  --chart-1: #3B82F6;
  --chart-2: #60A5FA;
  --chart-3: #2563EB;
  --chart-4: #93C5FD;
  --chart-5: #1D4ED8;
}

.dark {
  /* Dark Mode - Crisp Azure Graphite Theme */
  --primary: #3B82F6;
  --primary-foreground: #FFFFFF;

  /* Deep Graphite Backgrounds */
  --background: #0B0F14;
  --foreground: #E5E7EB;

  --card: #14181F;
  --card-foreground: #E5E7EB;

  --popover: #14181F;
  --popover-foreground: #E5E7EB;

  --secondary: #1E293B;
  --secondary-foreground: #F8FAFC;

  --muted: #1E293B;
  --muted-foreground: #94A3B8;

  --accent: rgba(59, 130, 246, 0.15);
  --accent-foreground: #60A5FA;

  --destructive: #7F1D1D;
  --destructive-foreground: #FECACA;

  --border: #27272A;
  --input: #27272A;
  --ring: rgba(59, 130, 246, 0.5);

  /* Chart Colors */
  --chart-1: #3B82F6;
  --chart-2: #60A5FA;
  --chart-3: #2563EB;
  --chart-4: #93C5FD;
  --chart-5: #1D4ED8;
}
```

---

## Priority Implementation: Three-Panel Layout

### RULE 1: Overall Layout Structure

```tsx
<div className="flex h-screen bg-background text-foreground">
  {/* Left Sidebar - 200px, collapsible */}
  <aside className="w-[200px] bg-card border-r border-border flex-shrink-0 flex flex-col">
    {/* Sidebar content */}
  </aside>

  {/* Main Content Area */}
  <div className="flex-1 flex flex-col min-w-[400px]">
    {/* Top Nav/Header */}
    <header className="h-12 border-b border-border flex items-center px-4">
      {/* Header content */}
    </header>

    {/* Content */}
    <main className="flex-1 overflow-auto">
      {/* Page content */}
    </main>
  </div>

  {/* Right Panel - 300px, properties/context */}
  <aside className="w-[300px] bg-card border-l border-border flex-shrink-0">
    {/* Properties panel */}
  </aside>
</div>
```

---

## Left Sidebar Implementation

### Structure
```tsx
<aside className="w-[200px] bg-card border-r border-border flex flex-col">
  {/* Workspace Switcher */}
  <div className="h-12 px-3 flex items-center border-b border-border">
    <button className="flex items-center gap-2 px-2 py-1.5 rounded-md hover:bg-secondary w-full">
      <div className="w-5 h-5 rounded bg-primary flex items-center justify-center">
        <span className="text-[10px] font-bold text-primary-foreground">M</span>
      </div>
      <span className="text-[13px] font-medium text-foreground">Momentus</span>
      <ChevronDown className="w-4 h-4 text-muted-foreground ml-auto" />
    </button>
  </div>

  {/* Navigation Sections */}
  <nav className="flex-1 overflow-y-auto py-2 px-2">
    {/* Primary Nav */}
    <div className="space-y-0.5">
      <NavItem icon={Inbox} label="Inbox" />
      <NavItem icon={User} label="My issues" />
      <NavItem icon={Zap} label="Pulse" />
    </div>

    {/* Section Divider */}
    <div className="my-3 px-2">
      <span className="text-[11px] font-semibold text-muted-foreground uppercase tracking-wide">
        Workspace
      </span>
    </div>

    {/* Workspace Nav */}
    <div className="space-y-0.5">
      <NavItem icon={Target} label="Initiatives" />
      <NavItem icon={Folder} label="Projects" />
      <NavItem icon={Eye} label="Views" />
    </div>

    {/* Favorites Section */}
    <div className="my-3 px-2">
      <span className="text-[11px] font-semibold text-muted-foreground uppercase tracking-wide">
        Favorites
      </span>
    </div>
    <div className="space-y-0.5">
      <NavItem icon={Star} label="Pitchback CreativeOS" active />
    </div>

    {/* Teams Section */}
    <div className="my-3 px-2">
      <span className="text-[11px] font-semibold text-muted-foreground uppercase tracking-wide">
        Your teams
      </span>
    </div>
    <div className="space-y-0.5">
      <NavItem icon={Users} label="Momentus" expandable>
        <NavItem icon={CircleDot} label="Issues" indent />
        <NavItem icon={Folder} label="Projects" indent />
        <NavItem icon={Eye} label="Views" indent />
      </NavItem>
    </div>
  </nav>

  {/* Bottom Actions */}
  <div className="p-2 border-t border-border">
    <NavItem icon={Plus} label="Invite people" />
  </div>
</aside>
```

### NavItem Component
```tsx
interface NavItemProps {
  icon: LucideIcon;
  label: string;
  active?: boolean;
  indent?: boolean;
  expandable?: boolean;
  children?: React.ReactNode;
}

function NavItem({ icon: Icon, label, active, indent, expandable, children }: NavItemProps) {
  return (
    <>
      <button
        className={cn(
          "flex items-center gap-2 w-full rounded-md transition-colors duration-100",
          indent ? "px-2 py-1 pl-7" : "px-2 py-1.5",
          active
            ? "bg-[rgba(59,130,246,0.10)] text-accent-foreground"
            : "text-muted-foreground hover:bg-secondary hover:text-foreground"
        )}
      >
        <Icon className={cn("w-4 h-4", active ? "text-primary" : "opacity-70")} />
        <span className="text-[13px] flex-1 text-left">{label}</span>
        {expandable && <ChevronRight className="w-3 h-3 opacity-50" />}
      </button>
      {children}
    </>
  );
}
```

---

## Top Navigation/Header Implementation

### Structure
```tsx
<header className="h-12 border-b border-border flex items-center justify-between px-4 bg-background">
  {/* Left: Breadcrumb / Page Title */}
  <div className="flex items-center gap-2">
    <span className="text-[13px] text-muted-foreground">Projects</span>
    <ChevronRight className="w-3 h-3 text-muted-foreground" />
    <div className="flex items-center gap-2">
      <div className="w-4 h-4 rounded bg-muted flex items-center justify-center">
        <FileText className="w-3 h-3 text-muted-foreground" />
      </div>
      <span className="text-[13px] font-medium text-foreground">Pitchback CreativeOS</span>
    </div>
    <Star className="w-4 h-4 text-yellow-500 fill-yellow-500 ml-1" />
  </div>

  {/* Center: Tab Navigation */}
  <div className="flex items-center gap-1">
    <TabButton active>Overview</TabButton>
    <TabButton>Updates</TabButton>
    <TabButton>Issues</TabButton>
    <TabButton icon={Settings} />
  </div>

  {/* Right: Actions */}
  <div className="flex items-center gap-2">
    <button className="p-1.5 rounded-md hover:bg-secondary text-muted-foreground">
      <Bell className="w-4 h-4" />
    </button>
    <button className="p-1.5 rounded-md hover:bg-secondary text-muted-foreground">
      <Link className="w-4 h-4" />
    </button>
    <button className="p-1.5 rounded-md hover:bg-secondary text-muted-foreground">
      <PanelRight className="w-4 h-4" />
    </button>
  </div>
</header>
```

### TabButton Component
```tsx
function TabButton({ children, active, icon: Icon }: {
  children?: React.ReactNode;
  active?: boolean;
  icon?: LucideIcon
}) {
  return (
    <button
      className={cn(
        "px-3 py-1.5 rounded-md text-[13px] transition-colors duration-100",
        active
          ? "bg-secondary text-foreground font-medium"
          : "text-muted-foreground hover:bg-secondary hover:text-foreground"
      )}
    >
      {Icon ? <Icon className="w-4 h-4" /> : children}
    </button>
  );
}
```

---

## Right Panel (Properties) Implementation

### Structure
```tsx
<aside className="w-[300px] bg-card border-l border-border flex flex-col">
  {/* Panel Header */}
  <div className="h-12 px-4 flex items-center justify-between border-b border-border">
    <span className="text-[13px] font-medium text-foreground">Properties</span>
    <button className="p-1 rounded hover:bg-secondary">
      <Plus className="w-4 h-4 text-muted-foreground" />
    </button>
  </div>

  {/* Properties List */}
  <div className="flex-1 overflow-y-auto p-4 space-y-1">
    <PropertyRow label="Status" value={<StatusBadge status="in-progress" />} />
    <PropertyRow label="Priority" value={<PriorityIndicator level="high" />} />
    <PropertyRow label="Lead" value={<UserAvatar name="jenko" />} />
    <PropertyRow label="Members" value="Add members" muted />
    <PropertyRow label="Start date" value="Jan 1" icon={Calendar} />
    <PropertyRow label="Target date" value="Jan 8" icon={Calendar} highlight />
    <PropertyRow label="Teams" value="Momentus" />
    <PropertyRow label="Labels" value="Add label" muted />
  </div>

  {/* Collapsible Sections */}
  <div className="border-t border-border">
    <CollapsibleSection title="Milestones" />
    <CollapsibleSection title="Progress" defaultOpen>
      <ProgressChart />
    </CollapsibleSection>
    <CollapsibleSection title="Activity" defaultOpen>
      <ActivityFeed />
    </CollapsibleSection>
  </div>
</aside>
```

### PropertyRow Component
```tsx
function PropertyRow({
  label,
  value,
  icon: Icon,
  muted,
  highlight
}: {
  label: string;
  value: React.ReactNode;
  icon?: LucideIcon;
  muted?: boolean;
  highlight?: boolean;
}) {
  return (
    <div className="flex items-center justify-between py-2">
      <span className="text-[12px] text-muted-foreground min-w-[100px]">
        {label}
      </span>
      <div className={cn(
        "flex items-center gap-1.5 text-[13px]",
        muted ? "text-muted-foreground" : "text-foreground",
        highlight && "text-destructive"
      )}>
        {Icon && <Icon className="w-3.5 h-3.5" />}
        {value}
      </div>
    </div>
  );
}
```

### StatusBadge Component
```tsx
function StatusBadge({ status }: { status: 'in-progress' | 'completed' | 'backlog' }) {
  const styles = {
    'in-progress': 'bg-yellow-500/15 text-yellow-500',
    'completed': 'bg-green-500/15 text-green-500',
    'backlog': 'bg-muted text-muted-foreground',
  };

  const labels = {
    'in-progress': 'In Progress',
    'completed': 'Completed',
    'backlog': 'Backlog',
  };

  return (
    <span className={cn(
      "inline-flex items-center gap-1.5 px-2 py-0.5 rounded text-[12px] font-medium",
      styles[status]
    )}>
      <span className="w-1.5 h-1.5 rounded-full bg-current" />
      {labels[status]}
    </span>
  );
}
```

---

## Do's and Don'ts

### DO:
- Use 13px as base font size
- Use Inter font family
- Keep border-radius at 6-8px
- Use subtle background color changes for elevation (not shadows)
- Keep animations under 200ms
- Use Crisp Azure `#3B82F6` as primary accent
- Use the "Azure Glow" effect for focus states
- Use `rgba(59, 130, 246, 0.10)` for active/selected backgrounds
- Use high contrast text (Gray-200 `#E5E7EB` in dark mode)

### DON'T:
- Use Linear's purple `#5E6AD2` - we use Azure blue
- Use drop shadows for elevation - use background color changes
- Use bright/saturated status colors - keep them subtle
- Use font sizes smaller than 11px
- Use thick borders (keep at 1px with `#27272A` in dark mode)
- Use slow animations (300ms+)
- Mix warm and cool grays - stick to Slate/Zinc

---

## Tailwind CSS Configuration

```javascript
// tailwind.config.js
module.exports = {
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))',
        },
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))',
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))',
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))',
        },
        popover: {
          DEFAULT: 'hsl(var(--popover))',
          foreground: 'hsl(var(--popover-foreground))',
        },
        card: {
          DEFAULT: 'hsl(var(--card))',
          foreground: 'hsl(var(--card-foreground))',
        },
      },
      fontFamily: {
        sans: ['Inter', '-apple-system', 'BlinkMacSystemFont', 'sans-serif'],
        display: ['Inter Display', 'Inter', 'sans-serif'],
        mono: ['SF Mono', 'Fira Code', 'monospace'],
      },
      fontSize: {
        xs: '11px',
        sm: '12px',
        base: '13px',
        md: '14px',
        lg: '16px',
        xl: '18px',
        '2xl': '24px',
        '3xl': '32px',
      },
      borderRadius: {
        sm: '4px',
        DEFAULT: '6px',
        md: '6px',
        lg: '8px',
        xl: '12px',
      },
    },
  },
}
```

---

## Implementation Checklist for Single Screen

When implementing the three-panel layout, verify:

### Left Sidebar
- [ ] Width is 200px with `bg-card` background
- [ ] Workspace switcher at top with team icon
- [ ] Section headers are 11px uppercase with `text-muted-foreground`
- [ ] Nav items use 13px font, 4px gap between icon and label
- [ ] Active items have `rgba(59, 130, 246, 0.10)` background
- [ ] Active items have `#60A5FA` text color (dark mode)
- [ ] Hover states use `bg-secondary`
- [ ] Icons are 16px with 0.7 opacity when inactive

### Top Navigation
- [ ] Height is 48px (h-12)
- [ ] Breadcrumb uses 13px with muted color for parent items
- [ ] Tab buttons use 13px font
- [ ] Active tab has `bg-secondary` and `font-medium`
- [ ] Icon buttons are 24px touch target with 16px icons

### Right Panel
- [ ] Width is 300px with `bg-card` background
- [ ] Property labels are 12px `text-muted-foreground`
- [ ] Property values are 13px `text-foreground`
- [ ] Status badges use 15% opacity background colors
- [ ] Collapsible sections have proper expand/collapse icons

---

*Version: 2.0 | Crisp Azure Theme*
*For: Pitchback CreativeOS Platform*
