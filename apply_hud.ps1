$patch = @"
diff --git a/public/index.html b/public/index.html
--- a/public/index.html
+++ b/public/index.html
@@
     .btn:disabled { opacity:.6; cursor:not-allowed; }
     .hint { font-size:12px; color:#6b7280; margin-top:10px; }
+    /* HUD vizibil in frontend */
+    .hud {
+      position: fixed; right: 16px; bottom: 16px;
+      background:#111827; color:#fff; padding:10px 12px;
+      border-radius:10px; font-size:14px; box-shadow:0 6px 16px rgba(0,0,0,.15);
+      z-index:9999;
+    }
   </style>
 </head>
 <body>
   <div class="wrap">
     <h2>Text cu 3 layere (simplu)</h2>
     <div id="app" class="row"></div>
   </div>
+
+  <!-- HUD vizibil în colț pentru confirmare patch -->
+  <div id="hud" class="hud">HUD v1 instalat</div>

   <script>
-    const { useEffect, useMemo, useRef, useState } = React;
+    const { useEffect, useMemo, useRef, useState } = React;
+    // helper HUD global
+    window.__setHUD = (t) => { const el = document.getElementById('hud'); if (el) el.textContent = t; };
     const DESIGN_W = 1200, DESIGN_H = 700;
@@
-      const [text, setText]   = useState("Blake");
-      const [text2, setText2] = useState("");
-      const [text3, setText3] = useState("");
+      const [text, setText]   = useState("Blake");
+      const [text2, setText2] = useState("");
+      const [text3, setText3] = useState("");

+      // HUD: arată fontul curent, mărimea și numărul de rânduri
+      const hudFontLabel = useMemo(() => {
+        const it = fonts.find(f => (f.id ?? f.file) === fontId);
+        return it?.label || it?.id || it?.file || "(fără font)";
+      }, [fonts, fontId]);
+      useEffect(() => {
+        const linesCount = [text, text2, text3].filter(Boolean).length;
+        if (window.__setHUD) window.__setHUD(`🎛️ Font: ${hudFontLabel} • Size: ${fontSize}px • Linii: ${linesCount}`);
+      }, [hudFontLabel, fontSize, text, text2, text3]);
"@
$enc  = New-Object System.Text.UTF8Encoding($false)
$path = Join-Path (Get-Location) 'KC-HUD.diff'
[System.IO.File]::WriteAllText($path, $patch, $enc)

git apply --check $path
git apply $path

git add -A
git commit -m "apply KC-HUD: overlay vizibil cu status"
git tag -f safe-after-KC-HUD