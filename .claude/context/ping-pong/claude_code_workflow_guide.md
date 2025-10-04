# Claude Code Workflow Guide

## תבניות פרומפט לעבודה עם Claude Code CLI

---

## Template 1: מבנה מלא (לפרויקטים מורכבים)

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
- [מטרה 3]

System details:
- [פרטים רלוונטיים: נתיבים, משתמשים, מבנה קיים]
- [תלויות קיימות]
- [קונבנציות במערכת]

Start with Phase 1.
```

---

## Template 2: גרסה טבעית/קצרה (למשימות פשוטות)

```
I'm building [X] with Claude Code. 

We work in phases - I run your commands, paste full output, you plan next step.

Current task: [describe what you need]

System context: [relevant paths/users/structure]

Start.
```

---

## דוגמה מלאה: Tmux Detection Feature

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

### Template מלא (מבנה מורכב)
**השתמש כאשר:**
- פרויקט רב-שלבי עם תלויות
- מערכת קיימת עם conventions מוגדרות
- צריך לשמור על עקביות עם מבנה קיים
- משימה שמשפיעה על מספר קומפוננטות

**דוגמאות:**
- בניית מערכת multi-user
- העברת infrastructure
- אינטגרציה עם מערכות קיימות
- תיקון ושיפור קוד מורכב

### Template טבעי (גרסה קצרה)
**השתמש כאשר:**
- משימה חד-פעמית
- סקריפט עצמאי פשוט
- אין תלות במערכות קיימות
- הקשר ברור ופשוט

**דוגמאות:**
- יצירת סקריפט backup פשוט
- כתיבת כלי CLI עצמאי
- אוטומציה בסיסית
- תיקון קטן וממוקד

---

## עקרונות מרכזיים לעבודה עם Claude Code

### 1. עבודה בשלבים (Phases)
- כל משימה מתחלקת ל-Phase 1, 2, 3...
- כל phase מתמקד במטרה אחת ברורה
- לא ממשיכים לשלב הבא לפני אישור התוצאה

### 2. זרימת מידע דו-כיוונית
```
אתה → פקודה לקלוד קוד
קלוד קוד → סורק מערכת + מבצע
קלוד קוד → מחזיר פלט מלא
אתה → מדביק פלט ל-Claude
Claude → מנתח + מתכנן שלב הבא
```

### 3. Discovery לפני Action
- תמיד לסרוק את המערכת לפני שינויים
- לא להניח - לגלות מה באמת קיים
- לשמור על conventions קיימות
- לתעד מה שנמצא

### 4. Syntax מדויק
**נכון:**
```bash
claude-code "Task description here"
claude-code --plan "Planning task"
```

**לא נכון:**
```
[tool: query]
[claude-code: do something]
Run: command
```

### 5. Backup ו-Validation
- תמיד לגבות לפני שינוי
- לוודא הרשאות אחרי כל שינוי
- לבדוק שהשינוי עובד לפני המשך
- לתעד מה שונה

---

## טיפים לשימוש בהנחיות פרויקט

אם אתה שומר template בהנחיות הפרויקט של Claude:

1. **שמור את Template 1** במלואו בהנחיות
2. **בצ'אט הראשון** פשוט תאר את המשימה טבעי
3. Claude יזכור את העקרונות מההנחיות
4. **רענן הקשר** אם הצ'אט ארוך: "Following our Claude Code workflow from project instructions..."

---

## דוגמאות למשימות נפוצות

### הוספת feature למערכת קיימת
```
Working with Claude Code CLI.

Context: ComfyUI multi-user system at /opt/ai_shared/
Users: roi, shaked, daniel

Current Task: Add tmux detection to /usr/local/bin/comfy command

Goal: Auto-detect if running inside tmux and split pane instead of new session

Existing behavior: Always creates new tmux session
Desired: Check $TMUX → split if inside, new session if outside

Start.
```

### יצירת מבנה תיקיות חדש
```
Working with Claude Code CLI.

Task: Create shared models directory for AI tools

Structure needed:
/opt/ai_shared/models/
├── checkpoints/
├── loras/
├── vae/
└── [20 more model types]

Requirements:
- Permissions: 2775
- Group: ai_team
- Users: roi, shaked, daniel all need write access

Start with Phase 1: Discovery of current state.
```

### תיקון הרשאות במערכת קיימת
```
Working with Claude Code CLI.

Issue: Users can't write to /opt/ai_shared/outputs/

Goal: Fix permissions while preserving privacy per user

Context:
- 3 users: roi, shaked, daniel
- Group: ai_team
- Need: Private outputs per user (700) but shared read for workflows

Analyze current permissions and suggest fix.
```

---

## שגיאות נפוצות ואיך להימנע

### ❌ לא מספק פלט מלא
```
User: "Got some errors"
```
**✅ במקום:**
```
User: [paste complete 50-line output including errors]
```

### ❌ מדלג על שלבים
```
User: "Just do phases 1-5 at once"
```
**✅ במקום:**
```
Phase by phase with output verification each time
```

### ❌ לא מזכיר קונטקסט
```
User: "Add tmux detection"
```
**✅ במקום:**
```
System: /opt/ai_shared with comfy command at /usr/local/bin/comfy
Add tmux detection to existing user-aware startup
```

### ❌ משתמש ב-shortcuts
```
[web_search: something]
```
**✅ במקום:**
```
claude-code "proper command syntax"
```

---

## סיכום מהיר

**לפני שמתחילים:**
1. תאר את המערכת הקיימת
2. הגדר מטרה ברורה
3. ציין conventions/constraints

**תוך כדי עבודה:**
1. הרץ phase אחד בכל פעם
2. הדבק פלט מלא
3. המתן להוראות לשלב הבא

**בסוף:**
1. תיעוד מה שונה
2. וידוא שהכל עובד
3. עדכון documentation

---

**Version:** 1.0  
**Date:** October 2025  
**Use Case:** Claude Code CLI automation workflows
