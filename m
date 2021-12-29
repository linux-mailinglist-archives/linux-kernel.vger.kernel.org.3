Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925FD481249
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhL2LsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhL2LsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:48:00 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72150C061574;
        Wed, 29 Dec 2021 03:48:00 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h1so12495152pls.11;
        Wed, 29 Dec 2021 03:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VS8dZScsobOHgg+VVvoCG/RijOVYncvgh5RyiPUBnwc=;
        b=VxteG+e/Gz2n6+V+42PZ3AULJQARAm4X6hnKAJHrUjpPVqZb3lv+X2bGbnziMEVbG6
         vpH6k/fbAeaiydf+WElEAChIWmgFyalO6Zk2NQXJIoOrW8rmvXnruFx1agbAEjvyU4uw
         g77o7g3UEPX8JLbQncZMrmE2oE3lv2iPKVVby6QxZ/DtpCaJv0lGSOHcnqk3tJpqoBBB
         MFtawarA0zJn5y9is0YGmaVEZvRUpLtpZH4qyWSsQy+rkIu0oxMyOfsC2D6wjvIA05eX
         BhF67480JfFVP9ehFomy2mI0FWGrFlegB9xbdmIzr4ERZtZqeyY4pVjJzDJ2oVtxeFEg
         Xu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VS8dZScsobOHgg+VVvoCG/RijOVYncvgh5RyiPUBnwc=;
        b=PHqq8QsPzgT7gapj4Si+L54InUTKdrrPgWGQpVDZ/A2pI5q5B3go1LVnfUCv53VM3K
         rx3IGBNH5c0zSqvF9vFSelEgOrIyrCHtJeBo55DIKoiGiM07fH0e+jr3XNvYFoXtE1Ht
         bqaN5zhXj17UVtOYUsb5jM5kTnyKblZwkixjDt9tZcJ3ucThZp8KC+SUMo5eLkoxr7bN
         vp+PhlvTV+CrUnEjaKX8uj2jYGNqcDpKiLgMnZC/sTzDYUNa5XCj63KwVM9MXu8ebair
         XUswD7nqhiD/Vg9oVETj7Ecn6wKHfNzLYPhmDp/Lv6ne8/DJL8/JmjulS13bpDkdnJ1W
         +jfg==
X-Gm-Message-State: AOAM532qDqSGsn/qm9B6rp9bFN2f1H+uBMXXb4shOn/Zfq75rQX8hTNP
        TREKYIFoynmlbyyXxqXk/Tg=
X-Google-Smtp-Source: ABdhPJzY9X0XG2MXEAW681YpBuCyzd7YZIBQeNAu92YexU37mb1iV/w3LeB16of0mbg4RNb0Ly6AZA==
X-Received: by 2002:a17:90a:fa6:: with SMTP id 35mr31075010pjz.165.1640778480046;
        Wed, 29 Dec 2021 03:48:00 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b22sm26713297pfv.107.2021.12.29.03.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 03:47:59 -0800 (PST)
Subject: [PATCH v2 4/4] docs: sphinx/kfigure.py: Delegate inkscape msg to
 kernellog.verbose
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <e26a7b53-9155-8394-4a31-6006379b65a5@gmail.com>
Date:   Wed, 29 Dec 2021 20:47:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH v2 4/4] docs: sphinx/kfigure.py: Delegate inkscape msg to kernellog.verbose

Depending on its version, distro config, and system-setup type,
inkscape(1) emits various warning messages which are harmless in
command-line uses.

List of such warning messages (incomplete, long ones wrapped):

  - Gtk-Message: hh:mm:ss.nnn: Failed to load module "canberra-gtk-module"
  - Unable to init server: Could not connect: Connection refused
  - Failed to get connection
  - ** (inkscape:xxx): CRITICAL **: hh:mm:ss.nnn: dbus_g_proxy_new_for_name:
    assertion 'connection != NULL' failed
  - ** (inkscape:xxx): CRITICAL **: hh:mm:ss.nnn: dbus_g_proxy_call:
    assertion 'DBUS_IS_G_PROXY (proxy)' failed
  - ** (inkscape:xxx): CRITICAL **: hh:mm:ss.nnn: dbus_g_connection_register_g_object:
    assertion 'connection != NULL' failed
  - ** (inkscape:xxx): WARNING **: hh:mm:ss.nnn:
    Fonts dir '/usr/share/inkscape/fonts' does not exist and will be ignored.

To avoid unnecessary anxiety, capture the message and output it via
kernellog.verbose or kernellog.warn depending on the exit code.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/sphinx/kfigure.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index e616e49669eb..24d2b2addcce 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -200,7 +200,8 @@ def setupTools(app):
                        "graphviz from https://www.graphviz.org")
     if inkscape_cmd:
         kernellog.verbose(app, "use inkscape(1) from: " + inkscape_cmd)
-        inkscape_ver = subprocess.check_output([inkscape_cmd, '--version'])
+        inkscape_ver = subprocess.check_output([inkscape_cmd, '--version'],
+                                               stderr=subprocess.DEVNULL)
         ver_one_ptn = b'Inkscape 1'
         inkscape_ver_one = re.search(ver_one_ptn, inkscape_ver)
         convert_cmd = None
@@ -373,17 +374,32 @@ def svg2pdf(app, svg_fname, pdf_fname):
 
     """
     cmd = [convert_cmd, svg_fname, pdf_fname]
+    cmd_name = 'convert(1)'
 
     if inkscape_cmd:
+        cmd_name = 'inkscape(1)'
         if inkscape_ver_one:
             cmd = [inkscape_cmd, '-o', pdf_fname, svg_fname]
         else:
             cmd = [inkscape_cmd, '-z', '--export-pdf=%s' % pdf_fname, svg_fname]
 
-    # use stdout and stderr from parent
-    exit_code = subprocess.call(cmd)
+    try:
+        warning_msg = subprocess.check_output(cmd, stderr=subprocess.STDOUT)
+        exit_code = 0
+    except subprocess.CalledProcessError as err:
+        warning_msg = err.output
+        exit_code = err.returncode
+        pass
+
     if exit_code != 0:
         kernellog.warn(app, "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
+        if warning_msg:
+            kernellog.warn(app, "Warning msg from %s: %s"
+                           % (cmd_name, str(warning_msg, 'utf-8')))
+    elif warning_msg:
+        kernellog.verbose(app, "Warning msg from %s (likely harmless):\n%s"
+                          % (cmd_name, str(warning_msg, 'utf-8')))
+
     return bool(exit_code == 0)
 
 def svg2pdf_by_rsvg(app, svg_fname, pdf_fname):
-- 
2.17.1


