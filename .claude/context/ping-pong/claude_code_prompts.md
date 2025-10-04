# תבניות פרומפט לעבודה עם Claude Code

## 1. Template כללי (למילוי)

```
Working with Claude Code CLI for system automation/DevOps tasks.

Workflow:
- You break tasks into numbered phases
- I run each claude-code command you provide
- I paste FULL output back
- You analyze → write next phase based on actual system state

Requirements:
- Use exact claude-code syntax (no shortcuts)
- Preserve existing system conventions (permissions, naming, structure)
- Build on discovered reality, not assumptions
- Be specific: full paths, exact user/group names, precise commands

---

Context: [תאור המערכת/הפרויקט]

Current Task: [מה אתה רוצה לעשות]

Goal: 
- [מטרה 1]
- [מטרה 2]

System details:
- [פרטים רלוונטיים: נתיבים, משתמשים, מבנה קיים]

Start with Phase 1.
```

---

## 2. גרסה טבעית/קצרה

```
I'm building [X] with Claude Code. 

We work in phases - I run your commands, paste full output, you plan next step.

Current task: [describe what you need]

System context: [relevant paths/users/structure]

Start.
```

---

## 3. דוגמה ממולאת - משימת Tmux Detection

```
Working with Claude Code CLI for system automation/DevOps tasks.

Workflow:
- You break tasks into numbered phases
- I run each claude-code command you provide
- I paste FULL output back
- You analyze → write next phase based on actual system state

Requirements:
- Use exact claude-code syntax (no shortcuts)
- Preserve existing system conventions (permissions, naming, structure)
- Build on discovered reality, not assumptions
- Be specific: full paths, exact user/group names, precise commands

---

Context: Multi-user ComfyUI/Kohya system with user-aware commands at /opt/ai_shared/

Current Task: Modify /usr/local/bin/comfy command to detect tmux environment

Goal: 
- IF user runs "comfy up" from inside tmux → split horizontal pane (Ctrl+B ")
- IF outside tmux → keep current behavior (new tmux session)

Detection method: Check $TMUX variable

System details:
- Users: roi, shaked, daniel
- Existing script: /usr/local/bin/comfy (already has user-aware startup around line 112-122)
- Need to add tmux detection before session creation

Start with Phase 1.
```

---

## מתי להשתמש במה?

- **Template מלא**: פרויקטים מורכבים, מערכות קיימות, משימות רב-שלביות
- **טבעי קצר**: משימות חד-פעמיות, סקריפטים פשוטים
- **הנחיות פרויקט**: שמור Template בהנחיות הפרויקט, כתוב טבעי בצ'אט - Claude יזכור העקרונות
