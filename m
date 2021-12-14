Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B55473AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbhLNCek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLNCek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:34:40 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6F6C06173F;
        Mon, 13 Dec 2021 18:34:39 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b11so12528512pld.12;
        Mon, 13 Dec 2021 18:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7JoIY6oUJ0zBsCLhP/nsE2AFGgRPq3Re0+GEf3kHWmU=;
        b=oteFQPRRL3zrtEXyXM7j32VaLTs5731jYrEwIeBviSX3oG3PYXiqN51Q0DzZ/1PjeP
         wftN6d+1eqyw9YfixGdCNEgigrqd3dnaftboGAjZVrHzwmnuN3ZSu4BAXnbLETMgZLtY
         3l81YKyCKbFbEHAfELfSFHAfK7mwgPui3kyr1SjqoZq2aVI8J+sn8umiV4FoulAguRIV
         mCtObZkYGU4w4sHEB4RXy5v5lMrLeBlhC/K8hTChV8y6sQCCBKJ5BQNLhAENuQ2f6/Bl
         cVsklA35+k2Qz5qlbpYy/eqN+WU2rnwhg0rhmD9UhB076oZXdaPJH3h0RJnlBZMyVCZQ
         JXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7JoIY6oUJ0zBsCLhP/nsE2AFGgRPq3Re0+GEf3kHWmU=;
        b=BVrojJYJiO1YrlLvpBw5gtpqVjnNMzniQIPXtzlO5Cqeh9kTy42Pi1LBOk6lMSMFXO
         xBHGyK4pwxuMxSS69hmT2SSRuzZzWvAKTd8mUMW5+VBEkkVwLG0IJ+3vshjbgEaFwTGQ
         OmXgWUeN+uOiDVpaVRnUwReDsp+hBzrFrqlhoI1v1SMWQB8q4OSeo+BvujTKt7CJqPxM
         Vtk68Q3am+GNw9E6l7K2yebwssqiJDyL/tk+ZvCkDEd4UjzcbEQUt8zOvgsTjJQjsnTA
         KsAB2S2DYhq8gUS620UJuCcJgBwe8UH/WJeXpiKuV30bruIjosPVavSDIGL9RX2UeXSy
         WxdA==
X-Gm-Message-State: AOAM530RXtrwr8lwMYdpBcCmi+CCpf3mwBmAu5XA5JxJnkfVbHAjXo/S
        6KOLDKIk1W6zIOOu8qD0Rp8=
X-Google-Smtp-Source: ABdhPJzQzbStbuGMWTr+zZcjpQH7q21rvxe70VtkljKniN2g47H4jrCDxzMTql7upQmu31Ox8STkFQ==
X-Received: by 2002:a17:902:bc43:b0:148:9109:c60e with SMTP id t3-20020a170902bc4300b001489109c60emr424702plz.9.1639449279246;
        Mon, 13 Dec 2021 18:34:39 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id lp12sm418422pjb.24.2021.12.13.18.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 18:34:38 -0800 (PST)
Subject: [PATCH 5/3] docs: sphinx/kfigure.py: Delegate inkscape msgs to
 kernellog
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ea41dd96-124a-9132-7659-1ae04d82188b@gmail.com>
Date:   Tue, 14 Dec 2021 11:34:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of redirecting to /dev/null, capture inkscape messages and
output them via kernelloc.verbose or kerneldoc.warn depending on the
exit code.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
Hi Mauro,

On second thought, I took the path of delegating inkscape warnings
to kernellog.

Now you can see those warning messages by "SPHINXOPTS=-v".

Does this approach sound reasonable to you?

        Thanks, Akira
--
 Documentation/sphinx/kfigure.py | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index dbe75ee8ae61..a275ee0fec02 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -126,9 +126,6 @@ rsvg_convert_cmd = None
 inkscape_cmd = None
 # Inkscape prior to 1.0 uses different command options
 inkscape_ver_one = False
-# Show warning from inkscape(1), enabled by setting env var
-# SPHINX_SHOW_INKSCAPE_WARN
-inkscape_show_warn = False
 
 
 def setup(app):
@@ -178,7 +175,7 @@ def setupTools(app):
     This function is called once, when the builder is initiated.
     """
     global dot_cmd, dot_Tpdf, convert_cmd, rsvg_convert_cmd   # pylint: disable=W0603
-    global inkscape_cmd, inkscape_ver_one, inkscape_show_warn  # pylint: disable=W0603
+    global inkscape_cmd, inkscape_ver_one  # pylint: disable=W0603
     kernellog.verbose(app, "kfigure: check installed tools ...")
 
     dot_cmd = which('dot')
@@ -211,12 +208,6 @@ def setupTools(app):
         rsvg_convert_cmd = None
         dot_Tpdf = False
 
-        try:
-            if os.environ['SPHINX_SHOW_INKSCAPE_WARN']:
-                inkscape_show_warn = True
-        except KeyError:
-            pass
-
     else:
         if convert_cmd:
             kernellog.verbose(app, "use convert(1) from: " + convert_cmd)
@@ -384,14 +375,21 @@ def svg2pdf(app, svg_fname, pdf_fname):
         else:
             cmd = [inkscape_cmd, '-z', '--export-pdf=%s' % pdf_fname, svg_fname]
 
-    # use stdout and stderr from parent
-    if inkscape_show_warn:
-        exit_code = subprocess.call(cmd)
-    else:
-        exit_code = subprocess.call(cmd, stderr=subprocess.DEVNULL)
+    try:
+        warning_msg = subprocess.check_output(cmd, stderr=subprocess.STDOUT)
+        exit_code = 0
+    except subprocess.CalledProcessError as err:
+        warning_msg = err.output
+        exit_code = 1
+        pass
 
     if exit_code != 0:
         kernellog.warn(app, "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
+        kernellog.warn(app, "Warning msg from inkscape: %s" % str(warning_msg, 'utf-8'))
+    if warning_msg:
+        kernellog.verbose(app, "Warning msg from inkscape (likely harmless):\n%s"
+                          % str(warning_msg, 'utf-8'))
+
     return bool(exit_code == 0)
 
 def svg2pdf_by_rsvg(app, svg_fname, pdf_fname):
-- 
2.17.1


