Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D832E471935
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 09:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhLLIDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 03:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLLIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 03:03:36 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D5C061714;
        Sun, 12 Dec 2021 00:03:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq11so9736646pjb.3;
        Sun, 12 Dec 2021 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gPsTnQJZMsZu2r6gkWp/Mtb0vvDey96yFsfoHiGrvPs=;
        b=c6HRMaT0dZPdikcxsfVfRxodgQAVxuuksgEH2t9jGWxNPQAT9rYmS578MFXd18CxGS
         Lhb+F6mXtc4z5B2axtuYVpO0IRVA3/CkPr3/tU1zIvkLdQJw8MxxMJbizBnycDgBzqbK
         Y/GYIKWPoBjFMC2NKiLiyccqUFIglhg992/pOn+f4iSaoUrCLgLERAH4pGNU1Nzv4UYI
         mRl3Be9vttfw8sc7ktTk3DvXt9CN1JzQHQce7wdavhMHWrkljqcy5v/MV8Cgniq8HuOP
         YGCigOKTOQl0LJ0g3h6nzKBC+xfx1R1FqKvJHH7Ymsf5yEe/EqUNDDceJxqoVe6Iuvud
         trtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gPsTnQJZMsZu2r6gkWp/Mtb0vvDey96yFsfoHiGrvPs=;
        b=I5C38PKFUpVFM68VlJRNFxshy8VssfiCrEG5EiVDOXjbvaQ+OYq4xPC6YFKt8azOKu
         Oa9jvOQuSsYA/Oe9E7SZSuTCow+JFExEQ/x7ny+8A3C2tz+/SH5A9r2s56VDqlkzTTGg
         JAHykbUXXfS+Xzij4SoFDh8w4WFWzPYzra327hggpHhiY1P+yIE8/4NzM9QgXlt5+5o6
         wUkNQWA0GnKY86GtpDg4QPoRFT8TLSftz65jcaRxI6g3mr8XRHDQvXYuVrbZwQeIUAZ8
         5UMp5viZNUMytPX/ZwYz03O37rObxR0x6J3qgN4ELqh70KlQwFWoWrIp7V6LdHlNTle2
         GqBQ==
X-Gm-Message-State: AOAM531/3dlRr+MxbllzzKkiH7d3oBnTL7nG+bLSR0hkCFJXRFBfGdYq
        8Sncm0u6N4R1laJ7qihPCHU=
X-Google-Smtp-Source: ABdhPJzBYRCdfnEG1ucbcE21Q4dS9Cq9WWV7B2A6rQErknvYdDGddp1zfPQZ17OLB2RJi4gC9gs2Cg==
X-Received: by 2002:a17:902:b716:b0:141:d36c:78fc with SMTP id d22-20020a170902b71600b00141d36c78fcmr87298812pls.59.1639296215919;
        Sun, 12 Dec 2021 00:03:35 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k11sm8328855pff.6.2021.12.12.00.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 00:03:35 -0800 (PST)
Subject: [PATCH 3/3] docs: sphinx/kfigure.py: Redirect warnings from inkscape
 to /dev/null
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <11d1e898-7f22-b72f-4466-31faabb9100c@gmail.com>
Date:   Sun, 12 Dec 2021 17:03:33 +0900
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

Depending on its version, distro config, and system-setup type,
inkscape(1) emits various warning messages which are harmless in
command-line uses.

List of such warning messages (incomplete, long ones wrapped):

  o Gtk-Message: hh:mm:ss.nnn: Failed to load module "canberra-gtk-module"
  o Unable to init server: Could not connect: Connection refused
  o Failed to get connection
  o ** (inkscape:xxx): CRITICAL **: hh:mm:ss.nnn: dbus_g_proxy_new_for_name:
    assertion 'connection != NULL' failed
  o ** (inkscape:xxx): CRITICAL **: hh:mm:ss.nnn: dbus_g_proxy_call:
    assertion 'DBUS_IS_G_PROXY (proxy)' failed
  o ** (inkscape:xxx): CRITICAL **: hh:mm:ss.nnn: dbus_g_connection_register_g_object:
    assertion 'connection != NULL' failed
  o ** (inkscape:xxx): WARNING **: hh:mm:ss.nnn:
    Fonts dir '/usr/share/inkscape/fonts' does not exist and will be ignored.

To avoid unnecessary anxiety, redirect warning messages from inkscape(1)
to /dev/null by default.

The redirection can be disabled by setting SPHINX_SHOW_INKSCAPE_WARN, e.g.,:

    make SPHINX_SHOW_INKSCAPE_WARN=1 pdfdocs

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 Documentation/sphinx/kfigure.py | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index 8d7c59e52ceb..d5802e3975e5 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -124,6 +124,9 @@ rsvg_convert_cmd = None
 inkscape_cmd = None
 # Inkscape prior to 1.0 uses different command options
 inkscape_ver_one = False
+# Show warning from inkscape(1), enabled by setting env var
+# SPHINX_SHOW_INKSCAPE_WARN
+inkscape_show_warn = False
 
 
 def setup(app):
@@ -173,7 +176,7 @@ def setupTools(app):
     This function is called once, when the builder is initiated.
     """
     global dot_cmd, convert_cmd, rsvg_convert_cmd   # pylint: disable=W0603
-    global inkscape_cmd, inkscape_ver_one  # pylint: disable=W0603
+    global inkscape_cmd, inkscape_ver_one, inkscape_show_warn  # pylint: disable=W0603
     kernellog.verbose(app, "kfigure: check installed tools ...")
 
     dot_cmd = which('dot')
@@ -188,12 +191,19 @@ def setupTools(app):
                        "graphviz from https://www.graphviz.org")
     if inkscape_cmd:
         kernellog.verbose(app, "use inkscape(1) from: " + inkscape_cmd)
-        inkscape_ver = subprocess.check_output([inkscape_cmd, '--version'])
+        inkscape_ver = subprocess.check_output([inkscape_cmd, '--version'],
+                                               stderr=subprocess.DEVNULL)
         ver_one_ptn = b'Inkscape 1'
         inkscape_ver_one = re.search(ver_one_ptn, inkscape_ver)
         convert_cmd = None
         rsvg_convert_cmd = None
 
+        try:
+            if os.environ['SPHINX_SHOW_INKSCAPE_WARN']:
+                inkscape_show_warn = True
+        except KeyError:
+            pass
+
     else:
         if convert_cmd:
             kernellog.verbose(app, "use convert(1) from: " + convert_cmd)
@@ -360,7 +370,11 @@ def svg2pdf(app, svg_fname, pdf_fname):
             cmd = [inkscape_cmd, '-z', '--export-pdf=%s' % pdf_fname, svg_fname]
 
     # use stdout and stderr from parent
-    exit_code = subprocess.call(cmd)
+    if inkscape_show_warn:
+        exit_code = subprocess.call(cmd)
+    else:
+        exit_code = subprocess.call(cmd, stderr=subprocess.DEVNULL)
+
     if exit_code != 0:
         kernellog.warn(app, "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
     return bool(exit_code == 0)
-- 
2.17.1


