Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A04A53BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiBAAFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiBAAFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:05:44 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C95C061714;
        Mon, 31 Jan 2022 16:05:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 192so14303900pfz.3;
        Mon, 31 Jan 2022 16:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GLOHoY1dKulHTeMDIa0XS5wbWpIlVfyrhIiTKyT03qg=;
        b=q13L8wwtqt32L9uGLqVXs2KNtcJGVvTB6VKIKNcAoCOmWkgxB1MB+wCnu3POczUwXu
         I8DOk85GMeAOq1Sgr4iAk1hPOJ7De8neoCHDCJh/6l1lYnZ5bCqQvL9tqsoKL5IVFaxA
         eZq6531/CB5WRIkmfm1u9xsRAX4edqKg93PqzDrm+zlTKcr9A9dJ2Q0tWjRieFhIxIAE
         qsG+BNgW69TnFeO9m+b0BVGIYWbn13sCRmgItldelS95cCK//y405GalDzIZRdSadtIW
         jMMlMUOm3p8dU14iZAxtZxgC2yW5u0gZrGbTUQbJroX5l2FNI7QZfG6P8O0JkTlL5A+Q
         9QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GLOHoY1dKulHTeMDIa0XS5wbWpIlVfyrhIiTKyT03qg=;
        b=CwataCMMWyh8NRdLzprPYTXFSeVMsQMO3ngtaAgxbzGQ6c9QqBpAU4lnXiflaR3WfR
         jryCJI1E97511LzYJIiyLjqT/xEw1SRDP3lFbovnssDZzpL4tBbEEUMWJw9qzsTW628+
         9Uky4ycqkdbBc1SCoJC8A+b1t6cEqwaW9Zdv31nd+oerhBiaNcyVe3WNXXS7lt3jn6Pd
         PYv4CK/M9/kMF2TgXBt/9yyr8VOXYdYZZhj1p8e8zK1ELz4xutncYLA4UsKLoxYyyTyf
         N7KFapleAoQJR4FsvToj/wC/OuEl4oZBryDggwklusYKTHVUuC3Gxl+CS4L3+n42MdXi
         TDAA==
X-Gm-Message-State: AOAM530lYScyvPkUV8xj6QSMR64l7xhJ/q+UjwJeT9PDmvc2b/qg2lAF
        GrjTJhHsXGI1nHMGWDOWDhI=
X-Google-Smtp-Source: ABdhPJxSdamC98Zh+YnclIb1u+vrcJxU9V4blRZhMAhtigz4WcS96lW2O+vzJ7L0dvnvR/NanR/CYQ==
X-Received: by 2002:a62:3303:: with SMTP id z3mr22193512pfz.54.1643673943707;
        Mon, 31 Jan 2022 16:05:43 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k3sm20828742pfu.180.2022.01.31.16.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 16:05:43 -0800 (PST)
Message-ID: <eb87790a-03f4-9f29-c8a3-ef2c3e78ca18@gmail.com>
Date:   Tue, 1 Feb 2022 09:05:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: [PATCH 5/5] docs: pdfdocs: Move CJK monospace font setting to main
 conf.py
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As LaTeX macros for CJK font settings can have Latin-script font
settings as well, settings under Documentation/translations/ can
be moved to the main conf.py.

By this change, translations.pdf built by top-level "make pdfdocs"
can have properly aligned ascii-art diagrams except for Korean
ones.

For the reason of remaining misalignment in Korean diagrams, see
changelog of commit a90dad8f610a ("docs: pdfdocs: Add conf.py
local to translations for ascii-art alignment").

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py              |  8 ++++++++
 Documentation/translations/conf.py | 12 ------------
 2 files changed, 8 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/translations/conf.py

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 62cd0e472b3b..fb8f69fc4d38 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -521,6 +521,8 @@ latex_elements['preamble']  += '''
 	    \\renewcommand{\\CJKsfdefault}{SCsans}%
 	    \\renewcommand{\\CJKttdefault}{SCmono}%
 	    \\xeCJKsetup{CJKspace = false}%
+	    % For CJK ascii-art alignment
+	    \\setmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]%
 	}
 	\\newcommand{\\kerneldocEndSC}{\\endgroup}
 	\\newcommand{\\kerneldocBeginTC}{%
@@ -532,6 +534,8 @@ latex_elements['preamble']  += '''
 	    \\renewcommand{\\CJKsfdefault}{TCsans}%
 	    \\renewcommand{\\CJKttdefault}{TCmono}%
 	    \\xeCJKsetup{CJKspace = false}%
+	    % For CJK ascii-art alignment
+	    \\setmonofont{Noto Sans Mono CJK TC}[AutoFakeSlant]%
 	}
 	\\newcommand{\\kerneldocEndTC}{\\endgroup}
 	\\newcommand{\\kerneldocBeginKR}{%
@@ -541,6 +545,8 @@ latex_elements['preamble']  += '''
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
 	    \\renewcommand{\\CJKttdefault}{KRmono}%
 	    % \\xeCJKsetup{CJKspace = true} % true by default
+	    % For CJK ascii-art alignment (still misaligned for Hangul)
+	    \\setmonofont{Noto Sans Mono CJK KR}[AutoFakeSlant]%
 	}
 	\\newcommand{\\kerneldocEndKR}{\\endgroup}
 	\\newcommand{\\kerneldocBeginJP}{%
@@ -550,6 +556,8 @@ latex_elements['preamble']  += '''
 	    \\renewcommand{\\CJKsfdefault}{JPsans}%
 	    \\renewcommand{\\CJKttdefault}{JPmono}%
 	    \\xeCJKsetup{CJKspace = false}%
+	    % For CJK ascii-art alignment
+	    \\setmonofont{Noto Sans Mono CJK JP}[AutoFakeSlant]%
 	}
 	\\newcommand{\\kerneldocEndJP}{\\endgroup}
 	% Single spacing in literal blocks
diff --git a/Documentation/translations/conf.py b/Documentation/translations/conf.py
deleted file mode 100644
index 92cdbba74229..000000000000
--- a/Documentation/translations/conf.py
+++ /dev/null
@@ -1,12 +0,0 @@
-# -*- coding: utf-8 -*-
-# SPDX-License-Identifier: GPL-2.0
-
-# -- Additinal options for LaTeX output ----------------------------------
-# font config for ascii-art alignment
-
-latex_elements['preamble']  += '''
-    \\IfFontExistsTF{Noto Sans CJK SC}{
-	% For CJK ascii-art alignment
-	\\setmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]
-    }{}
-'''
-- 
2.17.1


