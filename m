Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B1574EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbiGNNMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiGNNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:12:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4803D58D;
        Thu, 14 Jul 2022 06:12:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k30so2334830edk.8;
        Thu, 14 Jul 2022 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Qt7itXo/cxBO1H7z7yL/zo3atoOVHa7whGaKe3mfIQ=;
        b=WaACyKkyWCMHvsbAogCRtFMzMHRTc0UN7N7JXRGvnLRxsuxzY1s/8WiMiWrbf4kNOG
         vJSEzrK/6Ja1hWR21q6lP2IyBLLbL3Ht1R87QZkDjmBSK11tsumXcIVHNmIYV7zBe3kx
         HvRL+LgkKJMlYJNpagO7TuBX8U21f9+aAJvRbuYszTcoY5VZYksmincsi5HKDiSdLZQb
         Dm+vgzFEeJYYj36rI3lE9HOzvCLk718zDc216Q5nBEJeEN9H2lMi+F5QD9Ib8YgFT99X
         8yT3OKViRPct0syq172ubDGnO86VJtr1lDSdkwQ7Bo/olm5tf/COWNEB8e3XGQpbL+j6
         EE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Qt7itXo/cxBO1H7z7yL/zo3atoOVHa7whGaKe3mfIQ=;
        b=3AnZrTh7vbtau4jjyIc3G/vTB9U5LwcYUcUvgn0gQjtcQgvhMRnTzKYZPqHvW7xx2V
         8uRSif+Lox+LoYl2BSaW9tN2Q7kMXCTKDj2111y6Q4MvX9XoWDPNFa/Enwv1jCVzkDme
         Xuh4sLasMQwAbn+iJyNkMfNQ17gcCs/jqvSiFTwISaO65J/2i42nf6wOV6vagHgmUIGU
         xIeIEX4Tm5M26W3ae/9vx/+UCrleW/TpgHyYMjLbIcugD/FhpOmFycE6gFf6u9wL/tmD
         dNQx+WgkH5YK3Ou+AB3IJ04tvKxhjnsvTJqrQlLujYP91IbJuMEnf49l1uatDM1EZk+T
         i+tQ==
X-Gm-Message-State: AJIora8PjtCb1phuD6wmIJCanMuQRGbGSqTHxlPeAzCzOTa4PHnkL4Tu
        o2g50balr/FtYKflvvlBY/F3EAVEMC60An2q
X-Google-Smtp-Source: AGRyM1sLtaEQ/MjKiAYmwJVVZSvAgImMraP9KHKDCXj4XUWvsHaHA67XenXRvfVZqbrJixpWNNZ4Yg==
X-Received: by 2002:a05:6402:b26:b0:43a:6c93:f4e3 with SMTP id bo6-20020a0564020b2600b0043a6c93f4e3mr12036681edb.327.1657804321700;
        Thu, 14 Jul 2022 06:12:01 -0700 (PDT)
Received: from junglepc.fritz.box (h081217087223.dyn.cm.kabsi.at. [81.217.87.223])
        by smtp.gmail.com with ESMTPSA id p19-20020a056402075300b0043a7cdfac46sm1019415edy.23.2022.07.14.06.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:12:01 -0700 (PDT)
From:   sndanailov@gmail.com
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, Sotir Danailov <sndanailov@gmail.com>
Subject: [PATCH v2] Documentation: process: Update email client instructions for Thunderbird
Date:   Thu, 14 Jul 2022 15:11:52 +0200
Message-Id: <20220714131152.12709-1-sndanailov@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sotir Danailov <sndanailov@gmail.com>

The instructions don't match with the current Thunderbird interface.
Clarification on using external extensions.
New information on how to avoid writing HTML emails.

Signed-off-by: Sotir Danailov <sndanailov@gmail.com>
---
Changelog since v1:
 - better external extensions explanation
 - information on avoiding HTML emails

v1: https://lore.kernel.org/linux-doc/20220713225037.1201-1-sndanailov@gmail.com/

 Documentation/process/email-clients.rst | 64 +++++++++++++++++--------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index 16586f6cc888..229cbde5b62c 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -278,35 +278,57 @@ Thunderbird is an Outlook clone that likes to mangle text, but there are ways
 to coerce it into behaving.
 
 - Allow use of an external editor:
-  The easiest thing to do with Thunderbird and patches is to use an
-  "external editor" extension and then just use your favorite ``$EDITOR``
-  for reading/merging patches into the body text.  To do this, download
-  and install the extension, then add a button for it using
-  :menuselection:`View-->Toolbars-->Customize...` and finally just click on it
-  when in the :menuselection:`Compose` dialog.
-
-  Please note that "external editor" requires that your editor must not
-  fork, or in other words, the editor must not return before closing.
-  You may have to pass additional flags or change the settings of your
-  editor. Most notably if you are using gvim then you must pass the -f
-  option to gvim by putting ``/usr/bin/gvim -f`` (if the binary is in
-  ``/usr/bin``) to the text editor field in :menuselection:`external editor`
-  settings. If you are using some other editor then please read its manual
-  to find out how to do this.
+
+  The easiest thing to do with Thunderbird and patches is to use extensions
+  which open your favorite external editor.
+
+  Here are some example extensions which are capable of doing this.
+
+  - "External Editor Revived"
+
+    https://github.com/Frederick888/external-editor-revived
+
+    https://addons.thunderbird.net/en-GB/thunderbird/addon/external-editor-revived/
+
+    It requires installing a "native messaging host".
+    Please read the wiki which can be found here:
+    https://github.com/Frederick888/external-editor-revived/wiki
+
+  - "External Editor" (for older versions of Thunderbird)
+
+    https://github.com/exteditor/exteditor
+
+    To do this, download and install the extension, then open the
+    :menuselection:`compose` window, add a button for it using
+    :menuselection:`View-->Toolbars-->Customize...` then
+    just click on the new button when you wish to use the external editor.
+
+    Please note that "External Editor" requires that your editor must not
+    fork, or in other words, the editor must not return before closing.
+    You may have to pass additional flags or change the settings of your
+    editor. Most notably if you are using gvim then you must pass the -f
+    option to gvim by putting ``/usr/bin/gvim --nofork"`` (if the binary is in
+    ``/usr/bin``) to the text editor field in :menuselection:`external editor`
+    settings. If you are using some other editor then please read its manual
+    to find out how to do this.
 
 To beat some sense out of the internal editor, do this:
 
-- Edit your Thunderbird config settings so that it won't use ``format=flowed``.
-  Go to :menuselection:`edit-->preferences-->advanced-->config editor` to bring up
+- Edit your Thunderbird config settings so that it won't use ``format=flowed``!
+  Go to your main window and find the button for your main dropdown menu.
+  :menuselection:`Main Menu-->Preferences-->General-->Config Editor...` to bring up
   the thunderbird's registry editor.
 
-- Set ``mailnews.send_plaintext_flowed`` to ``false``
+  - Set ``mailnews.send_plaintext_flowed`` to ``false``
 
-- Set ``mailnews.wraplength`` from ``72`` to ``0``
+  - Set ``mailnews.wraplength`` from ``72`` to ``0``
 
-- :menuselection:`View-->Message Body As-->Plain Text`
+- Don't write HTML messages! Go to the main window
+  :menuselection:`Main Menu-->Account Settings-->youracc@server.something-->Composition & Addressing`!
+  There you can disable the option "Compose messages in HTML format".
 
-- :menuselection:`View-->Character Encoding-->Unicode (UTF-8)`
+- Open messages only as plain text! Go to the main window
+  :menuselection:`Main Menu-->View-->Message Body As-->Plain Text`!
 
 TkRat (GUI)
 ***********
-- 
2.37.0

