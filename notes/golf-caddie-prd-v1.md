# Golf Concierge Caddie: Product Requirements Document V1
**Date:** January 6, 2026
**Status:** Draft
**Brand Name Candidate:** Coursewright

---

## Table of Contents
1. [Executive Summary](#1-executive-summary)
2. [Product Vision & Positioning](#2-product-vision--positioning)
3. [User Channels & Interfaces](#3-user-channels--interfaces)
4. [User Data Collection Requirements](#4-user-data-collection-requirements)
5. [APIs & Data Sources](#5-apis--data-sources)
6. [Platform Architecture](#6-platform-architecture)
7. [MVP Scope & Features](#7-mvp-scope--features)
8. [User Flows](#8-user-flows)
9. [Technical Requirements](#9-technical-requirements)
10. [Success Metrics](#10-success-metrics)
11. [Appendices](#11-appendices)

---

## 1. Executive Summary

### The Concept
A premium, pre-round golf strategy service that delivers personalized course briefings combining digital intelligence with optional physical luxury products. The core insight: golfers at destination courses already pay $100-250 for human caddies, validating willingness to pay for course-specific strategic advice.

### Core Value Proposition
**"Not an app—a ritual."** We deliver confidence and preparation before the first tee, transforming the anxiety of playing an unfamiliar high-stakes course into excitement and readiness.

### Revenue Model
- **Digital Tier:** $29.99/pack
- **Leather Tier:** $119.99/pack (digital + leather yardage book)
- **Black Tier:** $279.99/pack (full unboxing experience)
- **Trip Pack:** $59.99 (3 digital packs)
- **Season Pass:** $99.99/year (unlimited digital)

### Target Market
- Primary: Destination golfers playing bucket-list courses (12M+ Americans travel for golf annually)
- Secondary: Competitive amateurs, business travelers, affluent club members

---

## 2. Product Vision & Positioning

### Positioning Statement
> For the discerning golfer playing the world's most exceptional courses, Coursewright is the definitive pre-round strategy partner. We provide a bespoke, intelligence-driven briefing that delivers the confidence and narrative of a Tour-level caddie through a fusion of digital insight and physical craftsmanship.

### Key Differentiators
1. **Preparation, Not Reaction** — Value delivered before the round, not during
2. **Analog Soul, Digital Brain** — Physical luxury meets data intelligence
3. **Concierge, Not Tool** — High-touch service, not self-serve utility

### Brand Archetypes
- **The Sage:** Wisdom, knowledge, strategic intelligence
- **The Magician:** Transforming anxiety into confidence

---

## 3. User Channels & Interfaces

### Channel Strategy Overview

The platform operates across multiple touchpoints to meet users where they are. The goal is frictionless ordering regardless of context—whether planning at a desktop, on-the-go via mobile, or wanting instant service via text.

```
┌─────────────────────────────────────────────────────────────────────┐
│                        COURSEWRIGHT PLATFORM                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌───────────┐ │
│   │   WEB APP   │  │ MOBILE APP  │  │  SMS/TEXT   │  │   AGENT   │ │
│   │  (Primary)  │  │   (iOS/    │  │  ORDERING   │  │   API     │ │
│   │             │  │  Android)   │  │             │  │           │ │
│   └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └─────┬─────┘ │
│          │                │                │               │       │
│          └────────────────┴────────────────┴───────────────┘       │
│                                    │                               │
│                         ┌──────────▼──────────┐                    │
│                         │   UNIFIED BACKEND   │                    │
│                         │   (Order Engine +   │                    │
│                         │   Content Gen)      │                    │
│                         └─────────────────────┘                    │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 3.1 Web Application (Primary Channel)

**Purpose:** Full-featured platform for discovery, purchase, and content delivery.

**Key Functions:**
- Course discovery and browsing
- Player profile creation and management
- Full purchase flow (all tiers)
- Briefing delivery and consumption
- Account management
- Gift purchasing flow

**User Experience:**
- Mobile-first responsive design
- Premium, editorial aesthetic (think luxury travel magazine)
- Course pages with preview content (teaser strategy, imagery)
- Seamless Stripe/Apple Pay checkout

**Priority:** MVP Launch

---

### 3.2 Mobile Application (iOS/Android)

**Purpose:** On-the-go access to briefings, push notifications, offline access.

**Key Functions:**
- All web app functions in native experience
- Push notifications for:
  - "Your briefing is ready"
  - "Weather update for tomorrow's round"
  - "24 hours until your tee time"
- Offline briefing access (downloaded before round)
- Audio briefing playback with lock-screen controls
- Apple Watch/Wear OS companion for quick reference

**Unique Features:**
- GPS detection at course → surface relevant briefing
- Quick-add to Apple/Google Wallet (booking confirmation + briefing link)
- Siri/Google Assistant integration ("Hey Siri, play my Pebble Beach briefing")

**Priority:** Post-MVP (Month 4-6)

---

### 3.3 SMS/Text Ordering (Instant Concierge)

**Purpose:** Frictionless, instant ordering for users who want immediate service. The "text a number and it just happens" experience.

**How It Works:**

```
USER: [texts to +1-XXX-CADDIE]
      "Pebble Beach, Jan 15, 8am tee time"

SYSTEM: "Got it! I'll prep your Coursewright briefing for Pebble Beach
        on Jan 15. Quick questions:

        1. Handicap? (e.g., '12' or 'around 90')
        2. How far do you hit your 7-iron? (optional)
        3. Miss tendency? (slice/hook/straight)"

USER: "14 handicap, 155 7-iron, slight fade"

SYSTEM: "Perfect. Your briefing will be ready in 2 hours.

        Which tier?
        • DIGITAL ($29.99) - Reply 'D'
        • LEATHER ($119.99) - Reply 'L'
        • BLACK ($279.99) - Reply 'B'

        Or reply 'INFO' for details on each."

USER: "D"

SYSTEM: "Tap to pay: [Apple Pay link]
        Or reply with your email for invoice."

USER: [Completes Apple Pay]

SYSTEM: "You're all set! I'll text you the briefing link
        when it's ready (usually ~2 hours).

        Playing with friends? Forward them this number
        and they can order their own briefing."
```

**Technical Implementation:**
- **Provider:** Twilio for SMS/MMS
- **Payment:** Stripe Payment Links with Apple Pay/Google Pay
- **NLP:** Claude API for natural language understanding of requests
- **State Management:** Conversation context stored per phone number

**Gifting via SMS:**
```
USER: "Gift for my buddy Mike, he's playing Bandon Dunes Feb 2"

SYSTEM: "Great gift! I'll create a Golden Ticket for Mike.
        What tier? (D/L/B)

        I'll send you a beautiful digital gift card to forward,
        or I can text it directly to Mike's number."
```

**Key Metrics:**
- Time from first text to payment: target <5 minutes
- Conversion rate: texts → purchases

**Priority:** MVP Launch (core differentiator)

---

### 3.4 Agent/API Integration

**Purpose:** Enable third-party integrations—resort booking systems, concierge services, tee time platforms.

**Use Cases:**

1. **Resort Concierge Systems**
   - Hotel front desk can order briefings on behalf of guests
   - Triggered automatically when golf is booked
   - White-label delivery with resort branding

2. **Tee Time Platforms (GolfNow, etc.)**
   - Post-checkout upsell: "Add a Coursewright Briefing?"
   - Automatic pre-population of course/date from booking

3. **Corporate Event Planners**
   - Bulk ordering for group outings
   - Customized branding for corporate gifts

4. **Travel Advisors/Agents**
   - Commission-based referral system
   - Embedded ordering in trip itineraries

**API Endpoints (Conceptual):**

```
POST /api/v1/orders
{
  "course_id": "pebble-beach",
  "tee_date": "2026-01-15",
  "tee_time": "08:00",
  "tier": "digital",
  "player_profile": {
    "handicap": 14,
    "seven_iron_distance": 155,
    "miss_tendency": "fade"
  },
  "delivery": {
    "method": "email",
    "address": "golfer@email.com"
  },
  "partner_id": "resort-pebble-beach",
  "metadata": {
    "reservation_id": "PB-12345"
  }
}

Response:
{
  "order_id": "cw-abc123",
  "status": "processing",
  "estimated_delivery": "2026-01-14T10:00:00Z",
  "briefing_url": null, // populated when ready
  "webhook_url": "https://partner.com/webhook"
}
```

**Partner Dashboard:**
- View all orders placed through their integration
- Revenue share tracking
- White-label customization settings
- Analytics on conversion and engagement

**Priority:** Phase 2 (Month 4-6), with early manual partnerships

---

### 3.5 Channel Interconnection

All channels feed into a unified order/fulfillment system:

```
                    ┌─────────────────────┐
                    │    ORDER ENGINE     │
                    │  (Central Queue)    │
                    └─────────┬───────────┘
                              │
        ┌─────────┬───────────┼───────────┬─────────┐
        │         │           │           │         │
        ▼         ▼           ▼           ▼         ▼
    ┌───────┐ ┌───────┐ ┌─────────┐ ┌─────────┐ ┌───────┐
    │  Web  │ │Mobile │ │   SMS   │ │Partner  │ │Manual │
    │ Order │ │ Order │ │  Order  │ │   API   │ │Concge │
    └───────┘ └───────┘ └─────────┘ └─────────┘ └───────┘
```

**Shared Capabilities:**
- Single player profile across all channels
- Order history accessible everywhere
- Consistent pricing and availability
- Unified notification system

---

## 4. User Data Collection Requirements

### 4.1 Required Data (Minimum for Briefing Generation)

| Data Point | Purpose | Collection Method |
|------------|---------|-------------------|
| **Course** | Generate course-specific strategy | Selection from database |
| **Tee Date** | Weather conditions, course setup | Date picker |
| **Handicap/Avg Score** | Calibrate strategy aggressiveness | Number input or "I usually shoot around X" |
| **Delivery Email** | Send briefing link | Text input |

### 4.2 Recommended Data (Enhances Personalization)

| Data Point | Purpose | Collection Method |
|------------|---------|-------------------|
| **Club Distances** | Specific club recommendations | Distance inputs (Driver, 7i, PW) or "carry distance profile" |
| **Miss Tendency** | "Where to miss" guidance | Choice: Fade/Slice, Draw/Hook, Straight, Random |
| **Playing Style** | Conservative vs aggressive strategy | Choice: Play safe, Balanced, Attack |
| **Tee Time** | Timing-specific conditions | Time picker |
| **Group Context** | Social vs competitive advice | Choice: Casual round, Money game, Tournament |

### 4.3 Optional Data (Premium Personalization)

| Data Point | Purpose | Collection Method |
|------------|---------|-------------------|
| **Shot Tracker Sync** | Import actual distances and tendencies | OAuth with Arccos, Shot Scope |
| **Specific Concerns** | Address known weaknesses | Free text: "I struggle with long par 3s" |
| **Previous Rounds** | Reference past experience | Link to prior Coursewright briefings |

### 4.4 Data Collection UX Philosophy

**Progressive Disclosure:**
- MVP form shows only required fields
- "Personalize further" expands to recommended fields
- Profile saves for returning users

**Conversational Alternative:**
- SMS channel collects data through natural conversation
- "What's your handicap, or what do you usually shoot?"
- More forgiving/flexible than structured forms

**Trust Building:**
- Explain WHY each data point improves the briefing
- "Your 7-iron distance helps us recommend the right club off the tee on the par-3 7th"

### 4.5 Player Profile Schema

```json
{
  "player_id": "uuid",
  "created_at": "timestamp",
  "updated_at": "timestamp",

  "basics": {
    "handicap": 14,
    "handicap_type": "official|estimated",
    "average_score": 86,
    "experience_level": "intermediate"
  },

  "distances": {
    "driver": { "carry": 230, "total": 245 },
    "three_wood": { "carry": 205, "total": 215 },
    "five_iron": { "carry": 175, "total": 180 },
    "seven_iron": { "carry": 155, "total": 160 },
    "pitching_wedge": { "carry": 125, "total": 125 },
    "source": "manual|arccos|shotscope"
  },

  "tendencies": {
    "miss_direction": "fade",
    "miss_severity": "slight|moderate|severe",
    "under_pressure": "pull|push|fat|thin"
  },

  "preferences": {
    "strategy_style": "conservative|balanced|aggressive",
    "round_type": "casual|competitive|tournament",
    "cadence_preference": "detailed|concise"
  },

  "integrations": {
    "arccos_connected": false,
    "shotscope_connected": false
  }
}
```

---

## 5. APIs & Data Sources

### 5.1 Data Source Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                      DATA LAYER ARCHITECTURE                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────┐ │
│  │  COURSE DATA    │  │  CONDITIONS     │  │  PLAYER DATA        │ │
│  │                 │  │                 │  │                     │ │
│  │ • Layout/Maps   │  │ • Weather       │  │ • Profile (owned)   │ │
│  │ • Distances     │  │ • Wind          │  │ • Shot history      │ │
│  │ • Hazards       │  │ • Elevation     │  │   (imported)        │ │
│  │ • Green shapes  │  │ • Pin positions │  │ • Handicap          │ │
│  │ • Typical setups│  │ • Course setup  │  │                     │ │
│  └────────┬────────┘  └────────┬────────┘  └──────────┬──────────┘ │
│           │                    │                      │            │
│           └────────────────────┼──────────────────────┘            │
│                                │                                   │
│                    ┌───────────▼───────────┐                       │
│                    │   BRIEFING ENGINE     │                       │
│                    │   (Content Gen AI)    │                       │
│                    └───────────────────────┘                       │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 5.2 Course Data Sources

| Source | Coverage | Quality | Cost | MVP Viability |
|--------|----------|---------|------|---------------|
| **Manual Collection** | 10-20 courses | High (curated) | Time-intensive | YES - MVP |
| **GolfLogix** | 40,000+ courses | Excellent | $$$ (license) | Scale phase |
| **iGolf Solutions** | 40,000 courses | Excellent | $$$ (license) | Scale phase |
| **GolfAPI.io** | 42,000 courses | Good | $$ (API) | Scale phase |
| **GolfCourseAPI** | 30,000 courses | Basic | Free | Backup/supplement |

**MVP Strategy:**
- Manually research 10-20 destination courses (Pebble Beach, Bandon, Pinehurst, etc.)
- Create detailed course profiles from:
  - Official course websites
  - Flyover videos (YouTube, course marketing)
  - Existing yardage books (for research reference)
  - User-generated content (reviews, forums)
- Store in structured database for briefing generation

**Course Data Schema:**
```json
{
  "course_id": "pebble-beach-golf-links",
  "name": "Pebble Beach Golf Links",
  "location": {
    "city": "Pebble Beach",
    "state": "CA",
    "country": "USA",
    "coordinates": { "lat": 36.5681, "lng": -121.9486 },
    "elevation_ft": 100,
    "timezone": "America/Los_Angeles"
  },

  "course_info": {
    "par": 72,
    "rating": 75.5,
    "slope": 145,
    "tees": [
      { "name": "Tournament", "distance": 7075, "rating": 75.5, "slope": 145 },
      { "name": "Blue", "distance": 6828, "rating": 74.1, "slope": 143 },
      { "name": "White", "distance": 6345, "rating": 71.8, "slope": 138 }
    ],
    "grass_type": { "fairways": "poa_annua", "greens": "poa_annua" },
    "prevailing_wind": "NW",
    "typical_conditions": "morning_fog_burns_off"
  },

  "holes": [
    {
      "number": 1,
      "par": 4,
      "distances": { "tournament": 381, "blue": 373, "white": 334 },
      "handicap_index": 8,
      "features": {
        "hazards": [
          { "type": "bunker", "location": "left_fairway", "distance_from_tee": 245 },
          { "type": "ocean", "location": "right", "in_play": false }
        ],
        "green": {
          "shape": "kidney",
          "slope": "back_to_front",
          "size_sqft": 4200,
          "typical_pin_positions": ["front_left", "back_right"]
        },
        "elevation_change_ft": -15,
        "doglegs": null,
        "key_strategy_notes": [
          "Opening hole, ease into round",
          "Fairway bunker left catches pulled drives",
          "Green slopes significantly toward ocean"
        ]
      }
    }
    // ... holes 2-18
  ],

  "signature_holes": [7, 8, 18],
  "most_difficult": [8, 6, 18],
  "birdie_opportunities": [2, 6, 14],

  "local_knowledge": {
    "morning_conditions": "Fog common, burns off by 10am, greens slower",
    "afternoon_wind": "Typically picks up 12-15mph from NW",
    "green_speed": "Usually 10-11 on stimp, 12+ for tournaments",
    "caddie_tips": [
      "Take extra club on ocean holes, ball doesn't fly as far in marine air",
      "Grain on greens runs toward ocean",
      "18th plays longer than yardage due to uphill approach"
    ]
  }
}
```

### 5.3 Weather & Conditions APIs

| API | Use Case | Cost | Integration |
|-----|----------|------|-------------|
| **OpenWeather** | Temperature, precipitation, wind | Free tier sufficient for MVP | REST API |
| **Tomorrow.io** | Hour-by-hour precision | $$ | REST API |
| **Google Elevation API** | Course/shot elevation data | Pay-per-use (generous free tier) | REST API |
| **FLASH Weather AI** | Golf-specific forecasts | $$$ | Premium partnership |

**Weather Data Needed:**
```json
{
  "tee_time": "2026-01-15T08:00:00-08:00",
  "conditions": {
    "temperature_f": 58,
    "feels_like_f": 54,
    "humidity_pct": 72,
    "precipitation_chance_pct": 10,
    "wind": {
      "speed_mph": 12,
      "gusts_mph": 18,
      "direction": "NW",
      "direction_degrees": 315
    },
    "visibility_miles": 10,
    "uv_index": 4
  },
  "forecast_confidence": 0.85,
  "conditions_impact": {
    "ball_flight": "Wind will affect exposed holes, especially 6-10",
    "green_speed": "Morning dew, slightly slower than afternoon",
    "club_selection": "+1 club into wind, -1 with wind"
  }
}
```

### 5.4 Player Data Integrations

**Arccos Integration (Future):**
- OAuth connection to pull:
  - Actual club distances (not estimates)
  - Strokes Gained data by club/shot type
  - Miss patterns and tendencies
- Requires Arccos partnership/API access

**Shot Scope Integration (Future):**
- Similar to Arccos
- Pull performance data for personalization

**Manual Import:**
- Allow users to paste stats from other apps
- CSV upload for power users

### 5.5 Third-Party Service APIs

| Service | Purpose | Priority |
|---------|---------|----------|
| **Twilio** | SMS ordering, notifications | MVP |
| **Stripe** | Payments, subscriptions | MVP |
| **SendGrid/Postmark** | Transactional email | MVP |
| **AWS S3/CloudFront** | Asset storage, briefing delivery | MVP |
| **Eleven Labs / Play.ht** | AI audio briefing generation | MVP |
| **Claude API** | NLP for SMS, content generation assist | MVP |
| **GolfNow Partner API** | Tee time integration (future) | Phase 2 |

---

## 6. Platform Architecture

### 6.1 High-Level System Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           COURSEWRIGHT PLATFORM                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  PRESENTATION LAYER                                                         │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────────────┐   │
│  │   Web App   │ │ Mobile Apps │ │  SMS Bot    │ │  Partner Portal     │   │
│  │  (Next.js)  │ │(React Nat.) │ │  (Twilio)   │ │    (Dashboard)      │   │
│  └──────┬──────┘ └──────┬──────┘ └──────┬──────┘ └──────────┬──────────┘   │
│         │               │               │                   │              │
│         └───────────────┴───────────────┴───────────────────┘              │
│                                    │                                        │
│  ─────────────────────────────────┼─────────────────────────────────────   │
│                                    │                                        │
│  API LAYER                         ▼                                        │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         API Gateway                                  │   │
│  │                   (Authentication, Rate Limiting)                    │   │
│  └─────────────────────────────────┬───────────────────────────────────┘   │
│                                    │                                        │
│  ─────────────────────────────────┼─────────────────────────────────────   │
│                                    │                                        │
│  SERVICE LAYER                     ▼                                        │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────────────┐   │
│  │   Order     │ │  Briefing   │ │   Player    │ │    Notification     │   │
│  │  Service    │ │   Engine    │ │   Service   │ │      Service        │   │
│  └──────┬──────┘ └──────┬──────┘ └──────┬──────┘ └──────────┬──────────┘   │
│         │               │               │                   │              │
│  ─────────────────────────────────────────────────────────────────────────  │
│                                    │                                        │
│  DATA LAYER                        ▼                                        │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                          PostgreSQL                                  │   │
│  │     (Orders, Players, Courses, Briefings, Partners)                  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐                           │
│  │    Redis    │ │  S3/CDN     │ │   Queue     │                           │
│  │   (Cache)   │ │  (Assets)   │ │  (Bull/SQS) │                           │
│  └─────────────┘ └─────────────┘ └─────────────┘                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 6.2 Core Services

#### Order Service
- Create and manage orders
- Process payments via Stripe
- Handle gift orders and redemptions
- Track fulfillment status
- Partner attribution

#### Briefing Engine
- Core intelligence: generates personalized briefings
- Inputs: course data + weather + player profile
- Outputs: structured briefing content
- Triggers audio generation
- Templates for different tiers

#### Player Service
- Profile management
- Authentication (email magic links, social auth)
- Preferences and settings
- Order history

#### Notification Service
- Email delivery (briefing ready, receipts)
- SMS notifications (status updates)
- Push notifications (mobile app)
- Webhook delivery (partners)

### 6.3 Briefing Generation Pipeline

```
┌──────────────────────────────────────────────────────────────────────────┐
│                      BRIEFING GENERATION PIPELINE                        │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  1. ORDER RECEIVED                                                       │
│     └─► Validate inputs, create order record                             │
│                                                                          │
│  2. DATA ASSEMBLY                                                        │
│     ├─► Fetch course data from DB                                        │
│     ├─► Fetch weather forecast for tee time                              │
│     ├─► Load player profile                                              │
│     └─► Calculate plays-like distances (weather + elevation)             │
│                                                                          │
│  3. STRATEGY GENERATION                                                  │
│     ├─► For each hole:                                                   │
│     │   ├─► Determine optimal tee shot (club, target, danger zones)      │
│     │   ├─► Calculate approach strategy                                  │
│     │   ├─► Identify "safe miss" areas                                   │
│     │   └─► Note key considerations (wind, hazards, green read)          │
│     ├─► Identify key scoring holes (birdie chances, bogey risks)         │
│     └─► Generate overall round strategy narrative                        │
│                                                                          │
│  4. CONTENT FORMATTING                                                   │
│     ├─► Generate mobile-optimized HTML briefing                          │
│     ├─► Generate PDF version (for Leather/Black tiers)                   │
│     └─► Generate audio script                                            │
│                                                                          │
│  5. AUDIO PRODUCTION                                                     │
│     ├─► Send script to TTS API (Eleven Labs)                             │
│     ├─► Generate 2-4 minute audio briefing                               │
│     └─► Store audio file on CDN                                          │
│                                                                          │
│  6. DELIVERY                                                             │
│     ├─► Create unique briefing URL                                       │
│     ├─► Send notification (email/SMS)                                    │
│     └─► (Leather/Black) Trigger physical fulfillment                     │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

### 6.4 Technology Stack (Recommended)

| Layer | Technology | Rationale |
|-------|------------|-----------|
| **Frontend (Web)** | Next.js 14+ | SSR, great DX, Vercel deployment |
| **Frontend (Mobile)** | React Native / Expo | Code sharing with web, rapid development |
| **API** | Node.js + Express or Fastify | Fast iteration, JavaScript ecosystem |
| **Database** | PostgreSQL | Relational data, proven reliability |
| **Cache** | Redis | Session management, rate limiting |
| **Queue** | Bull (Redis-based) or AWS SQS | Background job processing |
| **Storage** | AWS S3 + CloudFront | Asset storage and CDN delivery |
| **Auth** | Clerk or Auth0 | Managed auth, magic links |
| **Payments** | Stripe | Industry standard, Apple Pay support |
| **SMS** | Twilio | Reliable, programmable SMS |
| **Email** | Postmark or SendGrid | Transactional email |
| **AI/TTS** | Eleven Labs, Claude API | Voice generation, NLP |
| **Hosting** | Vercel (web) + Railway/Render (API) | Simple deployment, scaling |

---

## 7. MVP Scope & Features

### 7.1 MVP Definition

**Goal:** Validate demand and product-market fit with minimum investment. Prove that golfers will pay for pre-round preparation and find it valuable.

**Timeline:** 8-12 weeks to launch

**Scope:**
- 10-15 destination courses
- Web + SMS channels
- Digital tier only (no physical products)
- Manual/semi-automated briefing generation

### 7.2 MVP Feature Set

#### Must Have (MVP Launch)

| Feature | Channel | Description |
|---------|---------|-------------|
| **Course Selection** | Web | Browse and select from available courses |
| **Player Profile Form** | Web | Collect handicap, distances, tendencies |
| **Checkout Flow** | Web | Stripe payment with Apple Pay |
| **Briefing Delivery** | Web | Mobile-optimized briefing page |
| **Audio Briefing** | Web | 2-4 minute audio summary |
| **SMS Ordering** | SMS | Text-based order flow |
| **SMS Payment** | SMS | Stripe Payment Link integration |
| **Order Confirmation** | Email/SMS | Receipt and briefing link delivery |
| **Basic Admin** | Internal | Order management, briefing approval |

#### Should Have (MVP+)

| Feature | Channel | Description |
|---------|---------|-------------|
| **Account Creation** | Web | Save profile, view order history |
| **Gift Purchase** | Web | Buy for someone else |
| **Trip Pack** | Web | Bundle of 3 briefings |
| **Weather Updates** | SMS | Day-before conditions update |
| **Referral Tracking** | Web | "Shared by friend" attribution |

#### Nice to Have (Post-MVP)

| Feature | Channel | Description |
|---------|---------|-------------|
| **Mobile App** | iOS/Android | Native app experience |
| **Subscription** | Web | Season pass unlimited access |
| **Partner API** | API | Third-party integrations |
| **Physical Tiers** | Web | Leather and Black tier ordering |
| **Shot Tracker Sync** | Web | Import from Arccos/Shot Scope |

### 7.3 MVP Course Selection

Initial courses (manual data collection):

**Tier 1 - Launch Courses (5)**
1. Pebble Beach Golf Links
2. Pinehurst No. 2
3. Bandon Dunes (any 3 courses)
4. TPC Sawgrass (Stadium)
5. Whistling Straits (Straits)

**Tier 2 - Fast Follow (5-10)**
- Bethpage Black
- Torrey Pines (South)
- Kiawah Island (Ocean)
- Streamsong (Red or Black)
- Sand Valley

### 7.4 MVP Briefing Content Structure

```markdown
# Your Pebble Beach Briefing
## Prepared for: [Player Name]
## Tee Time: January 15, 2026 at 8:00 AM

---

### Conditions Overview
- Temperature: 58°F, light morning fog
- Wind: 12 mph from NW, gusting to 18
- Greens: Receptive early, firming by afternoon

### Your Strategy Profile
- Handicap: 14
- Driver: 230 carry
- 7-iron: 155 carry
- Tendency: Slight fade

### Key Themes for Today
1. **Wind holes (6-10)**: Take extra club, aim for center of greens
2. **Scoring opportunities**: Holes 2, 6, 14 are your birdie chances
3. **Damage control**: 8 and 18 are your bogey-is-fine holes

---

## Hole-by-Hole Strategy

### Hole 1 | Par 4 | 373 yards
**The Opener - Ease In**

**Tee Shot:** 3-wood to the right-center of fairway
- Why: Fairway bunker at 245 catches pulled drivers
- Target: Right edge of the bunker, ball will feed center
- Miss here: Right side, never left

**Approach:** Full 7-iron to center-right of green
- Green slopes hard toward ocean (left)
- Pin is front-left today—don't chase it
- Miss here: Long and right, chip back toward hole

**Par is a good score here.**

[Continue for all 18 holes...]

---

### Your Birdie Holes
1. **#2** - Short par 5, reachable in 2 if drive is in fairway
2. **#6** - Downhill par 5, wedge in for your third
3. **#14** - Short par 5, just get on in regulation

### Bogey-is-Fine Holes
1. **#8** - The famous par 4, one of hardest in golf. Par is birdie.
2. **#18** - Pressure hole, long, into wind. Make bogey and celebrate.

---

### Quick Reference Card
[Condensed 1-page version for on-course use]
```

---

## 8. User Flows

### 8.1 Web Purchase Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          WEB PURCHASE FLOW                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌──────────────────┐                                                       │
│  │   Landing Page   │                                                       │
│  │  "Play smarter"  │                                                       │
│  └────────┬─────────┘                                                       │
│           │                                                                 │
│           ▼                                                                 │
│  ┌──────────────────┐     ┌──────────────────┐                             │
│  │  Course Browser  │────►│   Course Page    │                             │
│  │  (Grid/List)     │     │ (Details/Preview)│                             │
│  └──────────────────┘     └────────┬─────────┘                             │
│                                    │                                        │
│                                    ▼                                        │
│                           ┌──────────────────┐                             │
│                           │  "Get Briefing"  │                             │
│                           │     Button       │                             │
│                           └────────┬─────────┘                             │
│                                    │                                        │
│                                    ▼                                        │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                       PLAYER PROFILE FORM                            │   │
│  │  ┌───────────────────────────────────────────────────────────────┐  │   │
│  │  │  When are you playing?  [Date Picker] [Time Picker]           │  │   │
│  │  │                                                                │  │   │
│  │  │  Your Game:                                                    │  │   │
│  │  │  • Handicap: [___] or "I usually shoot around [___]"          │  │   │
│  │  │  • 7-iron distance: [___] yards (optional)                    │  │   │
│  │  │  • Driver distance: [___] yards (optional)                    │  │   │
│  │  │  • Miss tendency: [Fade] [Draw] [Straight] [Random]           │  │   │
│  │  │                                                                │  │   │
│  │  │  [+ Add more details for better personalization]              │  │   │
│  │  └───────────────────────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                    │                                        │
│                                    ▼                                        │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         CHECKOUT                                     │   │
│  │  ┌───────────────────────────────────────────────────────────────┐  │   │
│  │  │  Your Order:                                                   │  │   │
│  │  │  Pebble Beach Briefing - Jan 15, 8am                          │  │   │
│  │  │                                                                │  │   │
│  │  │  Select Tier:                                                  │  │   │
│  │  │  ○ Digital - $29.99                                           │  │   │
│  │  │    Mobile briefing + audio                                    │  │   │
│  │  │  ○ Leather - $119.99 [FUTURE]                                 │  │   │
│  │  │  ○ Black - $279.99 [FUTURE]                                   │  │   │
│  │  │                                                                │  │   │
│  │  │  Email: [________________________]                            │  │   │
│  │  │                                                                │  │   │
│  │  │  [Apple Pay]  [Pay with Card]                                 │  │   │
│  │  └───────────────────────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                    │                                        │
│                                    ▼                                        │
│  ┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐   │
│  │  Confirmation    │────►│  Email: "Your    │────►│  Briefing Ready  │   │
│  │  "We're on it"   │     │  briefing is     │     │  (2-24 hrs)      │   │
│  │                  │     │  being prepared" │     │                  │   │
│  └──────────────────┘     └──────────────────┘     └──────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 8.2 SMS Ordering Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           SMS ORDERING FLOW                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  USER                                    COURSEWRIGHT                       │
│  ────                                    ────────────                       │
│                                                                             │
│  "Pebble Beach next                                                         │
│   Tuesday morning"          ─────────►   [NLP parses: Course, Date]         │
│                                                                             │
│                             ◄─────────   "Got it! Pebble Beach on           │
│                                          Tuesday, Jan 21.                   │
│                                                                             │
│                                          What time is your tee?             │
│                                          (e.g., '8am' or '2:30pm')"         │
│                                                                             │
│  "8:30"                     ─────────►   [Parse time]                       │
│                                                                             │
│                             ◄─────────   "8:30 AM - perfect.                │
│                                                                             │
│                                          To personalize your briefing:      │
│                                          What's your handicap?              │
│                                          (or typical score)"                │
│                                                                             │
│  "14, I usually hit my                                                      │
│   7 iron 155"               ─────────►   [Parse: handicap + distance]       │
│                                                                             │
│                             ◄─────────   "Great - 14 handicap,              │
│                                          155y 7-iron.                       │
│                                                                             │
│                                          Do you tend to miss:               │
│                                          1. Fade/slice (right for RH)       │
│                                          2. Draw/hook (left for RH)         │
│                                          3. Straight                        │
│                                          4. Random                          │
│                                                                             │
│                                          (Reply 1, 2, 3, or 4)"             │
│                                                                             │
│  "1"                        ─────────►   [Parse: fade tendency]             │
│                                                                             │
│                             ◄─────────   "Perfect! Here's your order:       │
│                                                                             │
│                                          📍 Pebble Beach                    │
│                                          📅 Tue Jan 21, 8:30 AM             │
│                                          👤 14 hcp, fade                    │
│                                                                             │
│                                          Digital Briefing: $29.99           │
│                                                                             │
│                                          Tap to pay:                        │
│                                          [stripe.link/xyz]                  │
│                                                                             │
│                                          (Or reply EMAIL for invoice)"      │
│                                                                             │
│  [Taps link, Apple Pay]     ─────────►   [Payment completes]                │
│                                                                             │
│                             ◄─────────   "You're all set! ⛳                 │
│                                                                             │
│                                          Your briefing will be ready        │
│                                          within 4 hours. I'll text          │
│                                          you the link.                      │
│                                                                             │
│                                          Playing with friends?              │
│                                          Forward them this number!"         │
│                                                                             │
│  ═══════════════════════════════════════════════════════════════════════   │
│                                                                             │
│  [4 hours later...]                                                         │
│                                                                             │
│                             ◄─────────   "Your Pebble Beach briefing        │
│                                          is ready!                          │
│                                                                             │
│                                          🔗 coursewright.com/b/xyz123       │
│                                                                             │
│                                          Quick tips:                        │
│                                          • Save the link for easy access    │
│                                          • Works offline once loaded        │
│                                          • Audio briefing included          │
│                                                                             │
│                                          Play well!"                        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 8.3 Gift Flow

```
Web Flow:
1. User clicks "Give as Gift"
2. Enters recipient name and optional message
3. Chooses delivery method:
   a. "Golden Ticket" - Digital card with redemption code (email or download)
   b. "Send directly" - Enters recipient email, we handle delivery
4. If trip details known: enters course/date
   If unknown: recipient enters when redeeming
5. Completes payment
6. Receives confirmation + gift card/link

Recipient Redemption:
1. Receives gift notification (email/text from giver or from us)
2. Clicks redemption link
3. Enters their player profile (handicap, etc.)
4. If course/date not set: selects from available courses
5. Briefing is generated and delivered
```

---

## 9. Technical Requirements

### 9.1 Performance Requirements

| Metric | Target | Rationale |
|--------|--------|-----------|
| **Page Load (Web)** | < 2s | Premium experience expectation |
| **SMS Response Time** | < 3s | Conversational flow |
| **Briefing Generation** | < 4 hours | Same-day delivery for most orders |
| **Audio Generation** | < 10 minutes | Part of overall briefing pipeline |
| **Payment Processing** | < 5s | Standard Stripe performance |
| **API Response (P95)** | < 500ms | Smooth UX |

### 9.2 Scalability Requirements

| Milestone | Expected Load | Infrastructure |
|-----------|---------------|----------------|
| **MVP Launch** | 100 orders/week | Single server, managed DB |
| **6 Months** | 500 orders/week | Horizontal scaling, queue workers |
| **12 Months** | 2000 orders/week | Multiple regions, CDN, autoscaling |

### 9.3 Security Requirements

- **Payment Data:** Never stored; handled entirely by Stripe
- **Personal Data:** Encrypted at rest (AES-256)
- **API Authentication:** JWT tokens with short expiry
- **Partner API:** API keys with rate limiting
- **Briefing URLs:** Unguessable tokens, optional expiry

### 9.4 Availability Requirements

| System | Target Uptime | Rationale |
|--------|---------------|-----------|
| **Web App** | 99.9% | Customer-facing |
| **SMS Gateway** | 99.9% | Critical ordering channel |
| **Briefing Delivery** | 99.5% | Can tolerate brief delays |
| **Admin Tools** | 99% | Internal use |

---

## 10. Success Metrics

### 10.1 MVP Validation Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Landing Page → Signup** | > 5% | Google Analytics |
| **Signup → Purchase** | > 10% | Order funnel |
| **Briefing Usefulness (Survey)** | > 70% rate 4-5/5 | Post-round survey |
| **Would Purchase Again** | > 50% | Post-round survey |
| **Net Promoter Score** | > 40 | Post-round survey |

### 10.2 Business Metrics (Post-MVP)

| Metric | Definition | Target |
|--------|------------|--------|
| **Monthly Revenue** | Total revenue | $10K by Month 6 |
| **Average Order Value** | Revenue / Orders | > $35 |
| **Customer Acquisition Cost** | Marketing spend / New customers | < $15 |
| **Repeat Purchase Rate** | Customers with 2+ orders / Total | > 20% |
| **Gift Conversion** | Gift recipients who later purchase | > 30% |

### 10.3 Engagement Metrics

| Metric | Definition | Target |
|--------|------------|--------|
| **Briefing Completion Rate** | % who view full briefing | > 80% |
| **Audio Listen Rate** | % who play audio | > 50% |
| **Time in Briefing** | Average session duration | > 5 minutes |
| **Day-Before Access** | % who access within 24h of round | > 60% |

---

## 11. Appendices

### Appendix A: Competitor Analysis Summary

| Competitor | Focus | Price | Our Differentiator |
|------------|-------|-------|-------------------|
| **Arccos** | Shot tracking + AI caddie | $199 + $155/yr | Pre-round vs in-round |
| **SwingU** | GPS + Club rec | $100/yr | Narrative briefing vs data points |
| **Hole19** | GPS + Scoring | $70/yr | Personalized strategy vs utility |
| **StrackaLine** | Green reading | $55/book | Full course strategy vs greens only |
| **Human Caddie** | Full service | $100-250/round | Accessible price, preparation focus |

### Appendix B: Course Data Template

See Section 5.2 for full schema. Key fields:
- Basic info (par, rating, slope, tees)
- Hole-by-hole (distances, hazards, green details)
- Local knowledge (conditions, caddie tips)
- Signature/difficult holes

### Appendix C: SMS NLP Intent Examples

```
Intent: ORDER_NEW
- "Pebble Beach Jan 15"
- "I need a briefing for Pinehurst tomorrow"
- "Playing Bandon Dunes next week"

Intent: PROVIDE_TEE_TIME
- "8am"
- "2:30 in the afternoon"
- "morning, probably around 9"

Intent: PROVIDE_HANDICAP
- "14"
- "I usually shoot mid-80s"
- "about a 20 handicap"

Intent: PROVIDE_DISTANCE
- "155 7 iron"
- "my 7 goes 155, driver about 240"
- "not sure, pretty average I guess"

Intent: GIFT_ORDER
- "Gift for my buddy Mike"
- "Want to buy this for someone else"
- "Can I send this to a friend?"
```

### Appendix D: Audio Briefing Script Template

```
[INTRO - 20 seconds]
"Welcome to your Pebble Beach briefing. I'm going to walk you through
a strategy tailored to your game—a 14 handicap with a fade tendency—
and today's conditions. Let's get you ready to play the round of your life."

[CONDITIONS - 30 seconds]
"You're teeing off at 8:30 tomorrow morning. Expect temperatures in the
upper 50s with light morning fog that should burn off by the turn.
The key factor today is wind—12 to 18 miles per hour out of the northwest.
This will be in your face on the ocean holes, especially 6 through 10.
Plan to take one extra club on exposed shots."

[STRATEGY OVERVIEW - 45 seconds]
"Here's your game plan in three parts..."

[HOLE-BY-HOLE HIGHLIGHTS - 2 minutes]
"Let's walk through the key holes..."

[CLOSING - 15 seconds]
"Remember: on a course like Pebble, par is a great score.
Don't chase. Trust your plan. And most importantly—enjoy it.
This is one of the great rounds of your life. Play well."

[TOTAL: ~3.5 minutes]
```

### Appendix E: Pricing Sensitivity Analysis

| Price Point | Expected Conversion | Revenue/1000 visitors | Notes |
|-------------|---------------------|----------------------|-------|
| $19.99 | 3.5% | $700 | Higher volume, margin pressure |
| $24.99 | 3.0% | $750 | Sweet spot for testing |
| $29.99 | 2.5% | $750 | Launch price, premium signal |
| $39.99 | 1.8% | $720 | Test with high-value courses |

Recommendation: Launch at $29.99, test $24.99 and $39.99 variants.

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 0.1 | 2026-01-06 | [Draft] | Initial PRD based on strategy documents |

---

*This document synthesizes the Premium Strategy & Physical-Digital Fusion document and the Discovery and Viability Report into actionable product requirements for V1.*
