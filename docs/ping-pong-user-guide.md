# Ping-Pong Workflow Guide
## איך לעבוד עם Claude Code בשיטת Ping-Pong

---

## הרעיון

שני Claude instances עובדים ביחד:
- **Planning Claude** (אתה כאן, בצ'אט) = אסטרטגיה, פירוק למשימות
- **Executor Claude** (CLI) = ביצוע, גילוי מצב, דיווח

---

## הזרימה

```
Planning Claude → מגדיר Phase N
       ↓
אתה ← רץ: claude-code @phase-executor "task"
       ↓
Executor ← מבצע + מגלה + מדווח
       ↓
אתה ← מדביק פלט מלא
       ↓
Planning Claude → מנתח → מגדיר Phase N+1
```

---

## להתחיל צ'אט חדש

כשפותח צ'אט עם Planning Claude, השתמש בפרומפט הזה:

```
Working with Claude Code CLI - @phase-executor agent configured.

Two-AI workflow:
- You (Planning Claude) = Strategy, break into phases
- @phase-executor (terminal) = Execute, discover, report

Phase workflow:
1. You define Phase N with specific task
2. User runs: claude-code @phase-executor "phase task"  
3. Executor returns structured output
4. User pastes FULL output to you
5. You analyze → define Phase N+1

Executor authority:
- Adapts to discovered system state
- Flags inconsistencies
- Makes on-ground decisions
- Surfaces errors

---

Context: [תאר את המערכת/פרויקט]

Current Task: [מה אתה בונה]

Goal:
- [מטרה 1]
- [מטרה 2]

System details:
- [נתיבים, משתמשים, תלויות]

Start Phase 1.
```

---

## דוגמת שימוש

### Planning Claude מגדיר:
```
Phase 1: Discover current git status in /opt/ai_shared/
```

### אתה רץ:
```bash
claude-code @phase-executor "scan /opt/ai_shared/ for git status, 
check if .git exists, report current branch and uncommitted changes"
```

### Executor מחזיר:
```
Phase Status: COMPLETED

Actions Executed:
- Scanned /opt/ai_shared/.git/
- Read current branch
- Checked git status

Discovered State:
- Branch: main
- 3 uncommitted files in docs/
- Remote: origin → github.com/user/repo

Files Changed: None

Next Logical Step: 
Commit the 3 docs files before proceeding
```

### אתה מדביק ל-Planning Claude:
```
Phase 1 output:
[paste full output]
```

### Planning Claude מחליט:
```
Phase 2: Commit those 3 documentation files with meaningful message
```

---

## עקרונות חשובים

### 1. תמיד הדבק פלט מלא
❌ "קיבלתי errors"  
✓ [paste complete output with all sections]

### 2. שלב אחד בכל פעם
❌ "תעשה phases 1-5 ביחד"  
✓ Phase by phase, עם אישור ביניים

### 3. תן קונטקסט
❌ "add tmux detection"  
✓ "System: /opt/ai_shared/, modify /usr/local/bin/comfy, add tmux detection"

### 4. Executor יכול לשאול
אם Executor מציף בעיה או שואל שאלה - תשיב לו. הוא לא ממציא, הוא מגלה מצב אמיתי.

---

## פורמט הפלט (Ping-Pong Style)

Executor תמיד מחזיר:

```
Phase Status: [COMPLETED/BLOCKED/IN_PROGRESS]

Actions Executed:
- [מה בוצע]

Discovered State:
- [מה התגלה במערכת]

Files Changed:
- [נתיבים מלאים]

Next Logical Step:
[המלצה למה לעשות אחר כך]

Questions:
[אם יש משהו לא ברור]
```

---

## פקודות שימושיות

### רגיל
```bash
claude-code @phase-executor "your task"
```

### עם פורמט מפורש
```bash
claude-code @phase-executor --style ping-pong "your task"
```

### מצב תכנון (לפני ביצוע)
```bash
claude-code @phase-executor --plan "complex task"
```

---

## מתי להשתמש בפינג-פונג

✅ **כדאי:**
- פרויקטים מורכבים עם תלויות
- צריך לשמור על conventions קיימות
- עבודה עם מערכות production
- כשצריך החלטות אסטרטגיות בין שלבים

❌ **לא חייב:**
- משימות חד-פעמיות פשוטות
- סקריפטים עצמאיים
- כשהקונטקסט ברור לחלוטין

---

## טיפים

1. **לתת קונטקסט טוב בהתחלה** = פחות הבהרות אחר כך
2. **לסמוך על Executor** - אם הוא מציף בעיה, יש סיבה
3. **לא למהר** - שלב אחד טוב עדיף מ-5 שלבים מהירים
4. **לשמור את הפלטים** - זה התיעוד שלך

---

## תקלות נפוצות

### "התוצאה לא מה שציפיתי"
→ Executor גילה משהו שלא ידעת. קרא את "Discovered State"

### "הוא שואל הרבה שאלות"
→ ההוראות לא היו ברורות מספיק. זה טוב שהוא שואל!

### "זה לוקח הרבה זמן"
→ Ping-pong מתאים לפרויקטים מורכבים, לא fast scripts

---

## קישורים

- Repository: https://github.com/ROI-DANINO/cloude-config
- Config location: `~/AI-Talk/claude_talk/.claude/`
- Install: `cd ~/AI-Talk/claude_talk && ./install.sh`

---

**Version:** 1.0  
**Created:** October 2025