# Coursewright SMS Agent: Technical Specification
**Date:** January 6, 2026
**Status:** Draft

---

## Overview

The SMS ordering channel is a core differentiator—enabling golfers to order a briefing in under 5 minutes via text message. This document specifies the conversational AI agent that powers this experience.

**The Promise:** Text a number, answer a few questions, tap Apple Pay, and your personalized briefing arrives before your round.

---

## 1. Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        SMS AGENT ARCHITECTURE                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                              ┌──────────────┐                               │
│                              │   GOLFER     │                               │
│                              │   (Phone)    │                               │
│                              └──────┬───────┘                               │
│                                     │                                       │
│                                     │ SMS                                   │
│                                     ▼                                       │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                         TWILIO                                        │  │
│  │            (Programmable SMS + Phone Numbers)                         │  │
│  └──────────────────────────────────┬───────────────────────────────────┘  │
│                                     │ Webhook                              │
│                                     ▼                                       │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                    SMS AGENT SERVICE                                  │  │
│  │  ┌────────────────────────────────────────────────────────────────┐  │  │
│  │  │                  CONVERSATION ENGINE                            │  │  │
│  │  │  ┌────────────┐  ┌────────────┐  ┌────────────┐              │  │  │
│  │  │  │   State    │  │    NLU     │  │  Response  │              │  │  │
│  │  │  │  Manager   │  │  (Claude)  │  │ Generator  │              │  │  │
│  │  │  └────────────┘  └────────────┘  └────────────┘              │  │  │
│  │  └────────────────────────────────────────────────────────────────┘  │  │
│  │                                                                       │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                   │  │
│  │  │   Course    │  │   Payment   │  │   Order     │                   │  │
│  │  │   Lookup    │  │   (Stripe)  │  │   Service   │                   │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘                   │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│                                     │                                       │
│                                     ▼                                       │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                         REDIS                                         │  │
│  │            (Conversation State + Session Cache)                       │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Conversation State Machine

### 2.1 States

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        CONVERSATION STATES                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│    ┌─────────┐                                                             │
│    │  IDLE   │◄─────────────────────────────────────────────────────┐      │
│    └────┬────┘                                                      │      │
│         │ New message                                               │      │
│         ▼                                                           │      │
│    ┌──────────────┐                                                 │      │
│    │ PARSE_INTENT │──────────┐                                      │      │
│    └──────────────┘          │                                      │      │
│         │                    │ (Gift intent)                        │      │
│         │ (Order intent)     ▼                                      │      │
│         │               ┌──────────┐                                │      │
│         │               │ GIFT_    │                                │      │
│         │               │ FLOW     │───────────────────────┐        │      │
│         ▼               └──────────┘                       │        │      │
│    ┌──────────────┐                                        │        │      │
│    │ COLLECT_     │                                        │        │      │
│    │ COURSE       │                                        │        │      │
│    └──────┬───────┘                                        │        │      │
│           │                                                │        │      │
│           ▼                                                │        │      │
│    ┌──────────────┐                                        │        │      │
│    │ COLLECT_     │                                        │        │      │
│    │ DATE_TIME    │                                        │        │      │
│    └──────┬───────┘                                        │        │      │
│           │                                                │        │      │
│           ▼                                                │        │      │
│    ┌──────────────┐                                        │        │      │
│    │ COLLECT_     │                                        │        │      │
│    │ HANDICAP     │                                        │        │      │
│    └──────┬───────┘                                        │        │      │
│           │                                                │        │      │
│           ▼                                                │        │      │
│    ┌──────────────┐                                        │        │      │
│    │ COLLECT_     │                                        │        │      │
│    │ DISTANCES    │ (optional)                             │        │      │
│    └──────┬───────┘                                        │        │      │
│           │                                                │        │      │
│           ▼                                                │        │      │
│    ┌──────────────┐                                        │        │      │
│    │ COLLECT_     │                                        │        │      │
│    │ TENDENCY     │                                        │        │      │
│    └──────┬───────┘                                        │        │      │
│           │                                                │        │      │
│           ▼                                                │        │      │
│    ┌──────────────┐                                        │        │      │
│    │ CONFIRM_     │                                        │        │      │
│    │ ORDER        │                                        │        │      │
│    └──────┬───────┘                                        │        │      │
│           │                                                │        │      │
│           ▼                                                │        │      │
│    ┌──────────────┐                                        │        │      │
│    │ AWAIT_       │◄───────────────────────────────────────┘        │      │
│    │ PAYMENT      │                                                 │      │
│    └──────┬───────┘                                                 │      │
│           │ Payment webhook                                         │      │
│           ▼                                                         │      │
│    ┌──────────────┐                                                 │      │
│    │ ORDER_       │                                                 │      │
│    │ CONFIRMED    │─────────────────────────────────────────────────┘      │
│    └──────────────┘                                                        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.2 State Schema (Redis)

```json
{
  "phone_number": "+14155551234",
  "state": "COLLECT_HANDICAP",
  "created_at": "2026-01-06T14:30:00Z",
  "updated_at": "2026-01-06T14:32:15Z",
  "expires_at": "2026-01-06T15:30:00Z",

  "collected_data": {
    "course_id": "pebble-beach",
    "course_name": "Pebble Beach Golf Links",
    "tee_date": "2026-01-15",
    "tee_time": "08:30",
    "handicap": null,
    "distances": {},
    "tendency": null
  },

  "order": {
    "tier": null,
    "price": null,
    "payment_link": null,
    "stripe_session_id": null
  },

  "context": {
    "is_gift": false,
    "recipient_phone": null,
    "message_count": 4,
    "last_intent": "PROVIDE_TEE_TIME"
  }
}
```

---

## 3. Natural Language Understanding

### 3.1 Claude API Integration

The NLU layer uses Claude to parse unstructured text into structured intents and entities.

**Prompt Template:**

```
You are a helpful assistant parsing golf booking requests. Extract structured data from the user's message.

Context:
- Current state: {{state}}
- Data collected so far: {{collected_data}}
- Available courses: {{available_courses}}

User message: "{{user_message}}"

Extract and return JSON with:
{
  "intent": "ORDER_NEW|PROVIDE_COURSE|PROVIDE_DATE|PROVIDE_TIME|PROVIDE_HANDICAP|PROVIDE_DISTANCES|PROVIDE_TENDENCY|SELECT_TIER|GIFT_ORDER|HELP|CANCEL|UNCLEAR",
  "entities": {
    "course_name": string or null,
    "course_match_confidence": 0.0-1.0,
    "date": "YYYY-MM-DD" or null,
    "time": "HH:MM" or null,
    "handicap": number or null,
    "average_score": number or null,
    "seven_iron_distance": number or null,
    "driver_distance": number or null,
    "tendency": "fade|draw|straight|random" or null,
    "tier": "digital|leather|black" or null
  },
  "clarification_needed": string or null
}

Be flexible with input formats:
- "next Tuesday" → resolve to actual date
- "mid-80s" → handicap ~15 or average_score 85
- "155 7 iron" or "7 iron goes 155" → seven_iron_distance: 155
- Course names can be partial: "Pebble" → "Pebble Beach Golf Links"
```

### 3.2 Intent Examples

```yaml
ORDER_NEW:
  - "Pebble Beach Jan 15"
  - "Need a briefing for tomorrow"
  - "Playing Pinehurst next week"
  - "Hi I want to order"

PROVIDE_COURSE:
  - "Pebble Beach"
  - "Bandon Dunes - the original one"
  - "TPC Sawgrass stadium course"

PROVIDE_DATE:
  - "January 15th"
  - "Next Tuesday"
  - "This Saturday"
  - "The 20th"

PROVIDE_TIME:
  - "8am"
  - "2:30 in the afternoon"
  - "Morning, probably around 9"
  - "Early - 7:12 tee time"

PROVIDE_HANDICAP:
  - "14"
  - "About 14"
  - "I usually shoot mid-80s"
  - "I'm a bogey golfer"
  - "Around a 20"

PROVIDE_DISTANCES:
  - "155 7 iron"
  - "My 7 goes 155, driver about 240"
  - "7 iron: 160, driver: 260"
  - "Average distances I guess"

PROVIDE_TENDENCY:
  - "Fade"
  - "I slice it"
  - "Draw usually, sometimes hook"
  - "Pretty straight"
  - "All over the place honestly"

SELECT_TIER:
  - "D"
  - "Digital"
  - "The $29 one"
  - "Cheapest option"
  - "Black"

GIFT_ORDER:
  - "Gift for my buddy"
  - "Want to buy this for my dad"
  - "Can I send this to someone else?"

HELP:
  - "What is this?"
  - "Help"
  - "How does this work?"
  - "?"

CANCEL:
  - "Nevermind"
  - "Cancel"
  - "Stop"
```

### 3.3 Entity Extraction Examples

**Input:** "Playing Pebble next Tuesday, 8:30 tee time. 14 handicap, hit my 7 iron 155."

**Output:**
```json
{
  "intent": "ORDER_NEW",
  "entities": {
    "course_name": "Pebble Beach Golf Links",
    "course_match_confidence": 0.95,
    "date": "2026-01-14",
    "time": "08:30",
    "handicap": 14,
    "average_score": null,
    "seven_iron_distance": 155,
    "driver_distance": null,
    "tendency": null
  },
  "clarification_needed": null
}
```

**Input:** "I usually shoot around 90"

**Output:**
```json
{
  "intent": "PROVIDE_HANDICAP",
  "entities": {
    "handicap": 18,
    "average_score": 90
  },
  "clarification_needed": null
}
```

---

## 4. Response Generation

### 4.1 Response Templates

```yaml
GREETING:
  first_time: |
    Hey! I'm Coursewright—your AI caddie for destination golf.

    Tell me where you're playing and when, and I'll build you a personalized briefing with hole-by-hole strategy.

    Where are you headed?

  returning: |
    Welcome back! Ready for another round?

    Where are you playing this time?

COURSE_CONFIRMED:
  template: |
    {{course_name}}—great choice!

    When's your tee time? (date and time, e.g., "Jan 15 at 8am")

COURSE_CLARIFICATION:
  template: |
    I found a few matches for "{{query}}":
    {{#courses}}
    {{index}}. {{name}} ({{location}})
    {{/courses}}

    Which one? (Reply with the number)

DATE_TIME_CONFIRMED:
  template: |
    Got it—{{formatted_date}} at {{formatted_time}}.

    Now let's personalize your briefing.
    What's your handicap? (or just tell me what you usually shoot)

HANDICAP_CONFIRMED:
  template: |
    {{handicap}} handicap—noted.

    Quick question: Do you tend to miss:
    1. Right (fade/slice)
    2. Left (draw/hook)
    3. Straight
    4. It varies

    (Reply 1-4, or skip by replying "skip")

TENDENCY_CONFIRMED:
  template: |
    Perfect! Here's your order:

    📍 {{course_name}}
    📅 {{formatted_date}} at {{formatted_time}}
    👤 {{handicap}} handicap, {{tendency}} tendency

    Digital Briefing: ${{price}}

    Tap to pay: {{payment_link}}

    (Or reply EMAIL for an invoice link)

ORDER_CONFIRMED:
  template: |
    You're all set! ⛳

    Your briefing for {{course_name}} will be ready within {{eta}}.
    I'll text you the link as soon as it's done.

    Playing with friends? Forward them this number and they can get their own briefing!

BRIEFING_READY:
  template: |
    Your {{course_name}} briefing is ready!

    🔗 {{briefing_url}}

    Quick tips:
    • Save the link—works offline once loaded
    • Audio briefing included (great for the drive)
    • Weather updates if conditions change

    Play well!

ERROR_COURSE_NOT_FOUND:
  template: |
    Hmm, I don't have {{query}} in my system yet.

    I currently cover:
    {{#courses}}
    • {{name}}
    {{/courses}}

    See any of these? Or tell me where you're playing and I'll add it to my list.

HELP:
  template: |
    I help you prepare for destination golf rounds.

    Here's how it works:
    1. Tell me where you're playing and when
    2. Share your handicap and any details about your game
    3. I create a personalized hole-by-hole strategy
    4. You get a mobile briefing + audio before your round

    Price: $29.99 per briefing

    Ready to start? Just tell me the course you're playing!
```

### 4.2 Response Personalization

Responses adapt based on:
- **Time context:** "Your 8am round is early! I'll have your briefing ready by 6pm tonight so you can review it over dinner."
- **Course difficulty:** "Bethpage Black is a beast. I'll make sure to highlight where to play safe."
- **Weather preview:** "Looks windy for your round—I'll factor that into club recommendations."

---

## 5. Payment Integration

### 5.1 Stripe Payment Links

Use Stripe Payment Links for frictionless mobile payment:

```javascript
// Create payment link for SMS
async function createPaymentLink(order) {
  const paymentLink = await stripe.paymentLinks.create({
    line_items: [{
      price: process.env.STRIPE_PRICE_DIGITAL, // $29.99 price ID
      quantity: 1,
    }],
    metadata: {
      order_id: order.id,
      phone_number: order.phone_number,
      course_id: order.course_id,
    },
    after_completion: {
      type: 'redirect',
      redirect: {
        url: `${process.env.BASE_URL}/order-confirmed?order=${order.id}`,
      },
    },
    // Enable Apple Pay / Google Pay
    payment_method_types: ['card', 'apple_pay', 'google_pay'],
  });

  return paymentLink.url;
}
```

### 5.2 Payment Webhook Handling

```javascript
// Webhook handler for payment completion
app.post('/webhooks/stripe', async (req, res) => {
  const event = stripe.webhooks.constructEvent(
    req.body,
    req.headers['stripe-signature'],
    process.env.STRIPE_WEBHOOK_SECRET
  );

  if (event.type === 'checkout.session.completed') {
    const session = event.data.object;
    const orderId = session.metadata.order_id;
    const phoneNumber = session.metadata.phone_number;

    // Update order status
    await orderService.markPaid(orderId);

    // Update conversation state
    await conversationEngine.transition(phoneNumber, 'ORDER_CONFIRMED');

    // Send confirmation SMS
    await smsService.send(phoneNumber, templates.ORDER_CONFIRMED({
      course_name: order.course_name,
      eta: '4 hours',
    }));

    // Queue briefing generation
    await briefingQueue.add({ orderId });
  }

  res.json({ received: true });
});
```

### 5.3 Alternative: Email Invoice

For users who prefer not to tap a payment link:

```javascript
async function sendInvoice(order, email) {
  const invoice = await stripe.invoices.create({
    customer: await getOrCreateCustomer(email),
    collection_method: 'send_invoice',
    days_until_due: 1,
    metadata: { order_id: order.id },
  });

  await stripe.invoiceItems.create({
    customer: invoice.customer,
    invoice: invoice.id,
    price: process.env.STRIPE_PRICE_DIGITAL,
    description: `Coursewright Briefing: ${order.course_name}`,
  });

  await stripe.invoices.sendInvoice(invoice.id);
}
```

---

## 6. Conversation Examples

### 6.1 Happy Path (Power User)

```
USER: Pebble Beach Jan 15 8:30am, 14 handicap, 155 7-iron, fade

AGENT: Perfect! Got all the details:

📍 Pebble Beach Golf Links
📅 Wednesday, January 15 at 8:30 AM
👤 14 handicap, 155y 7-iron, fade tendency

Digital Briefing: $29.99

Tap to pay: https://pay.coursewright.com/abc123

USER: [taps, completes Apple Pay]

AGENT: You're all set! ⛳

Your briefing will be ready within 4 hours. I'll text you the link.

Playing with friends? They can text this number to get their own briefing!
```

### 6.2 Guided Flow (New User)

```
USER: Hi

AGENT: Hey! I'm Coursewright—your AI caddie for destination golf.

Tell me where you're playing and when, and I'll build you a personalized briefing with hole-by-hole strategy.

Where are you headed?

USER: Pinehurst

AGENT: Pinehurst—great choice! Which course?

1. Pinehurst No. 2
2. Pinehurst No. 4
3. Pinehurst No. 8

(Reply 1, 2, or 3)

USER: 2

AGENT: Pinehurst No. 2—legendary.

When's your tee time? (date and time, e.g., "Jan 20 at 9am")

USER: Next Saturday afternoon

AGENT: Got it—Saturday, January 11 in the afternoon.

What time is your tee? (e.g., "2pm" or "1:30")

USER: 2:15

AGENT: Perfect—Saturday, January 11 at 2:15 PM.

Now let's personalize your briefing.
What's your handicap? (or just tell me what you usually shoot)

USER: I usually shoot around 90

AGENT: Got it—roughly an 18 handicap. I'll calibrate your strategy accordingly.

Quick question: Do you tend to miss:
1. Right (fade/slice)
2. Left (draw/hook)
3. Straight
4. It varies

(Reply 1-4)

USER: 1

AGENT: Noted—you favor a fade.

Here's your order:

📍 Pinehurst No. 2
📅 Saturday, January 11 at 2:15 PM
👤 ~18 handicap, fade tendency

Digital Briefing: $29.99

Tap to pay: https://pay.coursewright.com/xyz789

(Or reply EMAIL to receive an invoice)

USER: [completes payment]

AGENT: You're all set! ⛳

Your Pinehurst No. 2 briefing will be ready within 4 hours. I'll text you the link.

Enjoy the Cradle while you're there—it's a blast!
```

### 6.3 Gift Flow

```
USER: Want to buy this for my dad, he's playing Bandon Feb 10

AGENT: Great gift idea! I'll set up a briefing for your dad.

Which Bandon course is he playing?
1. Bandon Dunes
2. Pacific Dunes
3. Bandon Trails
4. Old Macdonald
5. Sheep Ranch

USER: Pacific Dunes

AGENT: Pacific Dunes—beautiful choice.

What time is his tee?

USER: 10am

AGENT: Got it—Monday, February 10 at 10:00 AM.

For the briefing, I'll need a bit about his game. Do you know:
- His handicap?
- Does he slice, hook, or hit it straight?

(Any info helps, or I can send a general briefing)

USER: He's about a 12 handicap, draws the ball

AGENT: Perfect! Here's the gift:

🎁 Gift for Dad
📍 Pacific Dunes
📅 Monday, February 10 at 10:00 AM
👤 12 handicap, draw tendency

Digital Briefing: $29.99

How should I deliver it?

1. Send me a gift card to forward to him
2. Text it directly to his phone
3. Email it to him

USER: 2

AGENT: What's his phone number?

USER: 415-555-9876

AGENT: I'll text the briefing to (415) 555-9876 on February 9—the day before his round.

Ready to complete the gift?
Tap to pay: https://pay.coursewright.com/gift456

USER: [completes payment]

AGENT: Gift purchased! 🎁

Your dad will receive his Pacific Dunes briefing on February 9.

Want me to send you a preview link so you can see what he'll get?
```

---

## 7. Error Handling

### 7.1 Course Not Available

```
USER: Augusta National next week

AGENT: Augusta National—now that would be something!

Unfortunately, I don't have Augusta in my system (it's invite-only for a reason 😉).

I currently cover these destination courses:
• Pebble Beach Golf Links
• Pinehurst No. 2
• Bandon Dunes (all courses)
• TPC Sawgrass
• Whistling Straits
[+ more]

Playing any of these? Or tell me where you're headed and I'll add it to my list!
```

### 7.2 Ambiguous Input

```
USER: Bandon

AGENT: Bandon is incredible! Which course are you playing?

1. Bandon Dunes (the original)
2. Pacific Dunes
3. Bandon Trails
4. Old Macdonald
5. Sheep Ranch

(Reply 1-5)
```

### 7.3 Payment Issues

```
[Payment link expires or fails]

AGENT: Looks like the payment didn't go through.

Here's a fresh link: https://pay.coursewright.com/retry123

Having trouble? Reply EMAIL and I'll send an invoice instead.
```

### 7.4 Timeout / Session Expiry

```
[User hasn't responded in 60 minutes]

AGENT: Still there? Your order for Pebble Beach is ready to go.

Tap to pay: https://pay.coursewright.com/abc123

Or reply CANCEL if you've changed your mind.

[After 24 hours, session expires silently. New message starts fresh conversation.]
```

---

## 8. Operational Considerations

### 8.1 Phone Number Strategy

- Use a memorable vanity number if possible (e.g., +1-XXX-CADDIE or +1-XXX-GOLF-PRO)
- Consider multiple numbers for different regions/campaigns
- SMS short codes are expensive but more reliable for high volume

### 8.2 Rate Limiting

```javascript
const rateLimits = {
  perPhone: {
    maxMessages: 30,
    windowMinutes: 60,
  },
  global: {
    maxMessages: 1000,
    windowMinutes: 60,
  },
};
```

### 8.3 Compliance

- Include opt-out instructions: "Reply STOP to unsubscribe"
- Don't send marketing without consent
- Retain message logs for compliance
- Follow TCPA guidelines for transactional vs. marketing messages

### 8.4 Monitoring

Key metrics to track:
- Messages per conversation (target: <10)
- Time to payment (target: <5 min)
- Drop-off by state (identify friction points)
- NLU confidence scores (retrain if <0.8 average)
- Payment conversion rate

---

## 9. Future Enhancements

### 9.1 WhatsApp Integration

Same agent, different channel:
- Richer media (images of course holes)
- Location sharing for automatic course detection
- Payment via WhatsApp Pay (where available)

### 9.2 Voice (Phone Call)

Extend to voice with Twilio Voice + speech-to-text:
- "Call us and tell us where you're playing"
- Same conversation flow, spoken
- Useful for less tech-savvy customers

### 9.3 Proactive Outreach

For returning customers:
- "Hey [Name], you played Pebble Beach 6 months ago. Planning another trip?"
- Weather alerts: "Wind picked up for your round tomorrow—I've updated your briefing"
- Trip suggestions: "Playing Bandon? Don't miss Pacific Dunes—want a briefing?"

### 9.4 Group Ordering

```
USER: Playing with 3 buddies at Pebble, can they all get briefings?

AGENT: Absolutely! Here's how:

1. Share this number with your group
2. Each person texts me their details
3. Everyone gets their own personalized briefing

Or, if you want to buy for everyone:
Reply GROUP to set up a 4-pack ($99.99—25% off!)
```

---

## 10. Implementation Phases

### Phase 1: MVP (Weeks 1-4)
- Basic state machine with 5-6 courses
- Claude NLU integration
- Stripe Payment Links
- Manual briefing generation triggered by webhook

### Phase 2: Polish (Weeks 5-8)
- Improved NLU with more training examples
- Gift flow
- Returning user recognition
- Weather preview in confirmation

### Phase 3: Scale (Months 3-6)
- WhatsApp integration
- Automated briefing generation
- Group ordering
- Proactive messaging for returning customers

---

*This specification provides the foundation for the SMS agent—Coursewright's most differentiating channel.*
