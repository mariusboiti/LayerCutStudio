$patch = @"
diff --git a/public/index.html b/public/index.html
--- a/public/index.html
+++ b/public/index.html
@@
-    .btn:disabled { opacity:.6; cursor:not-allowed; }
-    .hint { font-size:12px; color:#6b7280; margin-top:10px; }
+    .btn:disabled { opacity:.6; cursor:not-allowed; }
+    .hint { font-size:12px; color:#6b7280; margin-top:10px; }
+    /* overlay de eroare JS */
+    .error-overlay{
+      position:fixed; left:16px; bottom:16px;
+      background:#fee2e2; color:#991b1b;
+      padding:8px 10px; border-radius:8px; font-size:12px;
+      max-width:50vw; z-index:9999; box-shadow:0 6px 16px rgba(0,0,0,.15);
+      display:none;
+    }
@@
   <div class="wrap">
     <h2>Text cu 3 layere (simplu)</h2>
     <div id="app" class="row"></div>
   </div>
+  <div id="err" class="error-overlay"></div>

   <script>
-    const { useEffect, useMemo, useRef, useState } = React;
+    const { useEffect, useMemo, useRef, useState } = React;
+    // Debug overlay: prinde erorile JS ca să le vezi în pagină
+    (function(){
+      const el = () => document.getElementById('err');
+      const show = (msg) => { const e = el(); if(!e) return; e.style.display='block'; e.textContent = String(msg); };
+      window.addEventListener('error', (ev) => show(ev.message));
+      window.addEventListener('unhandledrejection', (ev) => {
+        const r = ev.reason; show((r && r.message) ? r.message : r);
+      });
+    })();
"@
$enc  = New-Object System.Text.UTF8Encoding($false)
$path = Join-Path (Get-Location) 'debug-overlay.diff'
[System.IO.File]::WriteAllText($path, $patch, $enc)

git apply --check $path
git apply $path

git add -A
git commit -m "apply debug overlay: afiseaza erorile JS in pagina"
git tag -f safe-after-debug-overlay