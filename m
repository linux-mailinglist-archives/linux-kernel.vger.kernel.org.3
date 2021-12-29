Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF86481214
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbhL2LmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhL2LmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:42:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C2C061574;
        Wed, 29 Dec 2021 03:42:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so19668360pjb.5;
        Wed, 29 Dec 2021 03:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5kkyBqd7r5jEQ9Ifcx7DSJAmQrYgKqb01w/N1SI9nWU=;
        b=kdtF3ZOZum68cXGtmkR5+9SatxORoSrTMPdoJj6bg/XdzdN32+2IZ1G+rZrTY8D1hS
         3RYuVUjW7+7WobnabPEvzT/3oCKUU7fRvvOpjGoe6e7vAi46v/mk+uvN9YGNML9w1QQw
         UzQsGdE1i0BQum8L6DxKp8BYQQ0YOBJv11XuNmiCG0MEb5woaggDjBoKD5iYYRgqxMuh
         ifxuU7Id5QXxDgu2JvmMuI6gv7zS/JJsIgmedVGGzWtAQaCl6PIahpCoMj/g5je/Vk0S
         W7987EKB+yJwpVQr+OfzS3rNwPqEPUztfhL6LvKkX+HrrztMTI/AiC0kvxFJOrkGm/Zh
         gOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5kkyBqd7r5jEQ9Ifcx7DSJAmQrYgKqb01w/N1SI9nWU=;
        b=JDzzlJMdFth2mbMaep4xMLdOSkO/Zp41rwVYuSUhbDnz3QoqMGg8GrYFafmssD7QQ6
         fIypZkU0Wx9Ri+nZfNl/9i1y7oV9YcwyqiKizaoauJL2KprJQ6YpTAphYoP6G+OJGP7b
         mXqp2/yzsn4u5jp7xr/0f0u1U57CgEaNwOV1OyKufW7bp3qHg+0/jxm8kiX/VCADB18F
         PKE6fGoZBy9G/f35dy5o0eqYpVxAjUycLYuaH6IGJ949CT+BKLSwxBJk52LiG5zEE7mO
         PBsetRXH8LPpjbLBq5RrlerR9WWDXfXsSOCUUXyIFQ09WgeV1gcEA9GmjCa9dCZ6OTUv
         i7IQ==
X-Gm-Message-State: AOAM531xsYz/o/tA6jd/kB5KTpGV0IpOBJ9CKM3t5USDCAoIfT/vD+f5
        DVNx+hIuKIjg6AnLAhMGSEU=
X-Google-Smtp-Source: ABdhPJyw6DObtEatI3bzBWZuUW71yEDUkDIfwKuGFACn3EjgX5WxNRhDvYCtBKOMT2ctXiMXUf8uUA==
X-Received: by 2002:a17:90b:1e43:: with SMTP id pi3mr31539494pjb.61.1640778124206;
        Wed, 29 Dec 2021 03:42:04 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d1sm19405446pge.62.2021.12.29.03.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 03:42:03 -0800 (PST)
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
Message-ID: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
Date:   Wed, 29 Dec 2021 20:42:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set improves conversions of DOT -> PDF and SVG -> PDF
for PDF docs.

* DOT -> PDF conversion

Current scheme uses "dot -Tpdf" (of graphviz).

Cons:
  - openSUSE's dot(1) does not support -Tpdf.
  - Other distro's dot(1) generates PDFs with unnecessarily wide
    margins for inclusion into LaTeX docs.

Patch 1/4 changes the route to the following two steps:

  1. DOT -> SVG by "dot -Tsvg"
  2. SVG -> PDF by "rsvg-convert -f pdf" with fallback to convert(1)

Pros:
  - Improved portability across distros
  - Less space around graphs in final PDF documents

Con:
  - On systems without rsvg-convert, generated PDF will be of raster
    image.

Patch 2/4 avoids raster-image PDF by using "dot -Tpdf" on systems where
the option is available.

* SVG -> PDF conversion

Current scheme uses convert(1) (of ImageMagick)

Cons:
  - Generated PDFs are of raster image.  Some of them look blurry.
  - Raster images tend to be large in size.
  - convert(1) delegates SVG decoding to rsvg-convert(1).
    It doesn't cover full range of Inkscape-specific SVG features
    and fails to convert some of SVG figures properly.

Improper conversions are observed with SVGs listed below (incomplete,
conversion quality depends on the version of rsvg-convert):
  - Documentation/userspace-api/media/v4l/selection.svg
  - Documentation/userspace-api/media/v4l/vbi_525.svg
  - Documentation/userspace-api/media/v4l/vbi_625.svg
  - Documentation/userspace-api/media/v4l/vbi_hsync.svg
  - Documentation/admin-guide/blockdev/drbd/DRBD-8.3-data-packets.svg
  - Documentation/admin-guide/blockdev/drbd/DRBD-data-packages.svg

If you have Inkscape installed as well, convert(1) delegates SVG
decoding to inkscape(1) rather than to rsvg-convert(1) and SVGs listed
above can be rendered properly.

So if Inkscape is required for converting those SVGs properly, why not
use it directly in the first place?

Patches 3/4 and 4/4 add code to utilize inkscape(1) for SVG -> PDF
conversion when it is available.  They don't modify any existing
requirements for kernel-doc.

Patch 3/4 adds the alternative route of SVG -> PDF conversion by
inkscape(1).
Patch 4/4 delegates warning messages from inkscape(1) to kernellog.verbose
as they are likely harmless in command-line uses.

Pros:
  - Generated PDFs are of vector graphics.
  - Vector graphics tends to be smaller in size and looks nicer when
    zoomed in.
  - SVGs drawn by Inkscape are fully supported.

On systems without Inkscape, no regression is expected by these two
patches.

Changes since v1 (as of Patch 5/3) [1]:

- Reorder and merge patches to reduce/eliminate regression windows of
  raster-image PDF and stderr redirection.
    v1        v2
    1/3       1/4
    4/3       2/4
    2/3       3/4
    3/3+5/3   4/4

- Massage kernellog.verbose/warn messages. They now show command(s)
  used in DOT -> PDF conversion.

- Pass actual exit code of inkscape(1) to kernellog.warn.

FWIW, diff of v1 vs. v2 follows:

--------------------------------------------------------------
diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index a275ee0fec02..24d2b2addcce 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -220,10 +220,16 @@ def setupTools(app):
 
         if rsvg_convert_cmd:
             kernellog.verbose(app, "use rsvg-convert(1) from: " + rsvg_convert_cmd)
+            kernellog.verbose(app, "use 'dot -Tsvg' and rsvg-convert(1) for DOT -> PDF conversion")
             dot_Tpdf = False
         else:
-            kernellog.verbose(app, "rsvg-convert(1) not found, "
-                              "falling back to raster image conversion")
+            kernellog.verbose(app,
+                "rsvg-convert(1) not found.\n"
+                "  SVG rendering of convert(1) is done by ImageMagick-native renderer.")
+            if dot_Tpdf:
+                kernellog.verbose(app, "use 'dot -Tpdf' for DOT -> PDF conversion")
+            else:
+                kernellog.verbose(app, "use 'dot -Tsvg' and convert(1) for DOT -> PDF conversion")
 
 
 # integrate conversion tools
@@ -368,8 +374,10 @@ def svg2pdf(app, svg_fname, pdf_fname):
 
     """
     cmd = [convert_cmd, svg_fname, pdf_fname]
+    cmd_name = 'convert(1)'
 
     if inkscape_cmd:
+        cmd_name = 'inkscape(1)'
         if inkscape_ver_one:
             cmd = [inkscape_cmd, '-o', pdf_fname, svg_fname]
         else:
@@ -380,15 +388,17 @@ def svg2pdf(app, svg_fname, pdf_fname):
         exit_code = 0
     except subprocess.CalledProcessError as err:
         warning_msg = err.output
-        exit_code = 1
+        exit_code = err.returncode
         pass
 
     if exit_code != 0:
         kernellog.warn(app, "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
-        kernellog.warn(app, "Warning msg from inkscape: %s" % str(warning_msg, 'utf-8'))
-    if warning_msg:
-        kernellog.verbose(app, "Warning msg from inkscape (likely harmless):\n%s"
-                          % str(warning_msg, 'utf-8'))
+        if warning_msg:
+            kernellog.warn(app, "Warning msg from %s: %s"
+                           % (cmd_name, str(warning_msg, 'utf-8')))
+    elif warning_msg:
+        kernellog.verbose(app, "Warning msg from %s (likely harmless):\n%s"
+                          % (cmd_name, str(warning_msg, 'utf-8')))
 
     return bool(exit_code == 0)
 
--------------------------------------------------------------

[1] v1: https://lkml.kernel.org/r/de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com

        Thanks, Akira
--
Akira Yokosawa (4):
  docs: sphinx/kfigure.py: Use rsvg-convert(1) for DOT -> PDF conversion
  docs: sphinx/kfigure.py: Add check of 'dot -Tpdf'
  docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion
  docs: sphinx/kfigure.py: Delegate inkscape msg to kernellog.verbose

 Documentation/sphinx/kfigure.py | 134 ++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 13 deletions(-)


base-commit: b36064425a18e29a3bad9c007b4dd1223f8aadc5
-- 
2.17.1

