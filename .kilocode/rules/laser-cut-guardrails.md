# Guardrails pentru proiectul „Aplicatie Laser CUt”

## Scope
- Editează **doar** fișierul `public/index.html` pentru taskurile curente.
- Nu crea fișiere noi și nu muta cod între fișiere.

## Comportament
- Înainte de orice modificare: prezintă un **plan în 3 pași**.
- Propune **un singur patch** (unified git diff) și **oprește-te**.
- Nu rula comenzi în terminal. Nu folosi Browser sau tooluri externe.
- Nu modifica configurația proiectului (npm, server, fonts); editează doar codul din `public/index.html`.
- Respectă mediul actual: React 18 UMD + `<script>` inline, fără bundler.
- Evită redenumirea variabilelor existente; dacă e necesar, explică și cere acordul înainte.

## Tehnic
- Patch-urile trebuie să fie **unified diff** și să modifice **doar** calea `public/index.html`.
- Nu folosi ghilimele „smart”; doar ASCII.
- Păstrează stilul existent (hooks React: `useState`, `useEffect`, etc.).
- Nu introduce dependențe noi (fără librării externe).
