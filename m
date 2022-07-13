Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B103F573FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiGMWvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGMWvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:51:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D52322508;
        Wed, 13 Jul 2022 15:51:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf4so320693ejc.3;
        Wed, 13 Jul 2022 15:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YrRHsclYAmYjQUGPGUPTa41F8QUV3giK/bxQrlXoyFg=;
        b=kJQAk/SayfcLlqN5iCohGaDkfrcIO5YDctXgoijvMRrtx6raJ5zinSdwfx5daQW0YB
         bR2eN6fq7yLGTf9TZX7hYVvr8d7ffhYssK6yPylVPUNRNxmTbaqlK6wWuNOemR23hEbi
         HJhMHcgHSlicjEihW53hX60En5oTI6tuR/OLjA9qkgIWX1/k5HZE2bc5FikrVVSelplt
         3Dhs4zhAyzseGIr04qvQ1V5iZKV/1HSqAYzLH0P2K+aO+h47V+iZhaeN8Q0Jke2Sm9dJ
         osnvaTecHMqFW9uSZPwzKv3pkb8q6alhnLii3dlbhqX+4sVQ4RBNPK/rNwS58MImfmCB
         EpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YrRHsclYAmYjQUGPGUPTa41F8QUV3giK/bxQrlXoyFg=;
        b=tdUZgE1zKvBtR2MBBZ1gykjAFNPWpegKf6FxU1WXLwPc2MvMA/dZZYExogVMASReh3
         utCSUaecimjtz1vY5gC2xF+xQfGdz1Xi53LfPUtl3t/8tqP8Z8WvKwMTVSnN3e9aXf8p
         ShccYh75Z7aMfv2WTEJpEl59LGKtk4+1S58Z1aG+5vMHfUVDUejEy/uCvwIa8GIVbxDk
         6+cdjZujvRQOKzWTeS4XHWl58j21AzFEMKdzL7OE7wznCfcxNrnRQOXebHo/0FmWWT4F
         F3sy2VyojhRWwPGXVA2x3YAdNvR7Ihi7gWB/02kjfIWqkFXzU3TBZTRKljjjITCiw3mA
         2A7w==
X-Gm-Message-State: AJIora9qJ2kH/MdAA4JFhkADxAXDun3PU6UJFHFHHvkpwCEHv+A/AIKe
        SXsj/HglTAb6QR2WgzbhU6ejtIK0Xvygig==
X-Google-Smtp-Source: AGRyM1twELZS2yy7vhdj4iMfY+k/yal/ZTV0lykHX+1VszeqFgDnfbi7uIX8FqPg3kwu32eYHSd8aQ==
X-Received: by 2002:a17:907:9606:b0:70a:e140:6329 with SMTP id gb6-20020a170907960600b0070ae1406329mr5772604ejc.471.1657752667983;
        Wed, 13 Jul 2022 15:51:07 -0700 (PDT)
Received: from junglepc.fritz.box (h081217087223.dyn.cm.kabsi.at. [81.217.87.223])
        by smtp.gmail.com with ESMTPSA id fg16-20020a1709069c5000b006fec27575f1sm5445281ejc.123.2022.07.13.15.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 15:51:07 -0700 (PDT)
From:   sndanailov@gmail.com
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sotir Danailov <sndanailov@gmail.com>
Subject: [PATCH] Documentation: process: Update email client instructions for Thunderbird
Date:   Thu, 14 Jul 2022 00:50:37 +0200
Message-Id: <20220713225037.1201-1-sndanailov@gmail.com>
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

Signed-off-by: Sotir Danailov <sndanailov@gmail.com>
---
 Documentation/process/email-clients.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index 16586f6cc888..243203d73272 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -280,10 +280,10 @@ to coerce it into behaving.
 - Allow use of an external editor:
   The easiest thing to do with Thunderbird and patches is to use an
   "external editor" extension and then just use your favorite ``$EDITOR``
-  for reading/merging patches into the body text.  To do this, download
-  and install the extension, then add a button for it using
-  :menuselection:`View-->Toolbars-->Customize...` and finally just click on it
-  when in the :menuselection:`Compose` dialog.
+  for reading/merging patches into the body text. To do this, download
+  and install the extension, then open :menuselection:`Write` and add a button
+  for it using :menuselection:`View-->Toolbars-->Customize...` and finally
+  just click on the new button when you wish to use the external editor.
 
   Please note that "external editor" requires that your editor must not
   fork, or in other words, the editor must not return before closing.
@@ -297,7 +297,8 @@ to coerce it into behaving.
 To beat some sense out of the internal editor, do this:
 
 - Edit your Thunderbird config settings so that it won't use ``format=flowed``.
-  Go to :menuselection:`edit-->preferences-->advanced-->config editor` to bring up
+  Go to your main window and find the button for your main dropdown menu.
+  :menuselection:`Menu-->Preferences-->General-->Config Editor...` to bring up
   the thunderbird's registry editor.
 
 - Set ``mailnews.send_plaintext_flowed`` to ``false``
@@ -306,8 +307,6 @@ To beat some sense out of the internal editor, do this:
 
 - :menuselection:`View-->Message Body As-->Plain Text`
 
-- :menuselection:`View-->Character Encoding-->Unicode (UTF-8)`
-
 TkRat (GUI)
 ***********
 
-- 
2.37.0

