Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB155768BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiGOVOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:14:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B32B186;
        Fri, 15 Jul 2022 14:14:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ss3so11006791ejc.11;
        Fri, 15 Jul 2022 14:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jnwaKSFrPbXm7tPbqUxltJNzUOl5SncKSIZVs8IUH8=;
        b=MIxtPAOXNa3uDXY0po8014F6W7nVRoyldH4pwU/j7Kbxvo1E59SnG2+ky8TFIVwaIG
         Ka+yFnIM4OwmPsd6fllxxWBjgu/DiVxR0zyYT9F+Dx7rhSvQAefgq516sW+l6nKceZYp
         SuNvicXRj8hEZUHBxPHzB88PASocLl6Xy4jDd4fnh/z0IiiGnKoghc0J5e9woTauaxxn
         sGvOX0YVuo/DnEoTkt1It7FRYhPxsC1BBFbJrpmLD6B6OcFITsieVYYdknu0qj/iJdnB
         QEkSYc+vYh41gHeKI2BH+d93PQD4HT8Ocsty2jWV23gmVx5FMo7++QHZy/WCF1aoL4Bl
         obLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jnwaKSFrPbXm7tPbqUxltJNzUOl5SncKSIZVs8IUH8=;
        b=ZGYM1ClpF99Y1zM7KDCtdti2luS26LgdQfRc1wwb+2Via7mGa22pjMHFTWlHO1oLS5
         XKE+On/ViKi6dbjMAx5pRegBSxWx9+VbAXoflfTPaAVJJKDE1Euv1zt6pgtO5s6CwLZA
         8CkgAWTNyBFw4KogMHtIRgVGsCZ0KGMB6nwZz/H9fwhPvDxoXEsIRu4CG1/JawzTBsT1
         HsGGOC+VZ9/E/d1uwjmq/BTrrmH+nWxWILG729R4p4XJ0E6+1cz7fphWtaWagk+Dz2Ee
         KNfw8BzR4T47QTlf9ItdS4VZSpnZaDBirdAEPHYZTN7Eu115F6v8YBXMf+DfJGUwwhbD
         6WtA==
X-Gm-Message-State: AJIora9RZHi/cSj/UmU286bAvTSBpIE/FSsDtgjyHRIQ6aVW2852U5en
        2w++8+Vc7vJKIZ8TAEL5ZxE=
X-Google-Smtp-Source: AGRyM1ulZ1t7kEN0uGVJ52lXzet5jxCPqjmayE79wtwiZYAxUE/4rkT527PV0ow3/GrOcaywwPDQWA==
X-Received: by 2002:a17:907:7d8b:b0:726:aad6:f421 with SMTP id oz11-20020a1709077d8b00b00726aad6f421mr15046466ejc.80.1657919665403;
        Fri, 15 Jul 2022 14:14:25 -0700 (PDT)
Received: from junglepc.fritz.box (h081217087223.dyn.cm.kabsi.at. [81.217.87.223])
        by smtp.gmail.com with ESMTPSA id ez7-20020a056402450700b0043a87e6196esm3488624edb.6.2022.07.15.14.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 14:14:25 -0700 (PDT)
From:   Sotir Danailov <sndanailov@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, rdunlap@infradead.org,
        Sotir Danailov <sndanailov@gmail.com>
Subject: [PATCH v3] Documentation: process: Update email client instructions for Thunderbird
Date:   Fri, 15 Jul 2022 23:13:07 +0200
Message-Id: <20220715211307.9358-1-sndanailov@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The instructions don't match with the current Thunderbird interface.
Clarification on using external extensions.
New information on how to avoid writing HTML emails.
Tell user to restart Thunderbird after modifications.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sotir Danailov <sndanailov@gmail.com>
---
Changelog since v2:
 - tell user to restart Thunderbird after modifications
 - unnecessary comment on older versions for "External Editor"

Changelog since v1:
 - better external extensions explanation
 - information on avoiding HTML emails

v2: https://lore.kernel.org/linux-doc/20220714131152.12709-1-sndanailov@gmail.com/
v1: https://lore.kernel.org/linux-doc/20220713225037.1201-1-sndanailov@gmail.com/

 Documentation/process/email-clients.rst | 69 +++++++++++++++++--------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index 16586f6cc888..fc2c46f3f82d 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -277,36 +277,61 @@ Thunderbird (GUI)
 Thunderbird is an Outlook clone that likes to mangle text, but there are ways
 to coerce it into behaving.
 
+After doing the modifications, this includes installing the extensions,
+you need to restart Thunderbird.
+
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
+  - "External Editor"
+
+    https://github.com/exteditor/exteditor
+
+    To do this, download and install the extension, then open the
+    :menuselection:`compose` window, add a button for it using
+    :menuselection:`View-->Toolbars-->Customize...`
+    then just click on the new button when you wish to use the external editor.
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
-  the thunderbird's registry editor.
+- Edit your Thunderbird config settings so that it won't use ``format=flowed``!
+  Go to your main window and find the button for your main dropdown menu.
+  :menuselection:`Main Menu-->Preferences-->General-->Config Editor...`
+  to bring up the thunderbird's registry editor.
 
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

