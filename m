Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D344BBF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiBRSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbiBRSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16E42655;
        Fri, 18 Feb 2022 10:16:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h6so15903724wrb.9;
        Fri, 18 Feb 2022 10:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVpw/YkSpECxioHiJcwwjO5cIgkz+JQrp0Z1102tsjs=;
        b=WMEnfHw96wCX1wphCv5/NoHdkP+bH/Booqpf2gva3Qsnq1R2UY6qm8wGmfuwDem2se
         aeJSSeQe2dShQ4tJVADNkDfDAy7ySS3vbdeh0KgNLfZBiiB4Y8frX8tuRMEfltB69i/M
         sl6YxSABSWDm9MSXmAai7ccUigRl4mDbU2ODjAaRGk6Gl49Zr12BNmWxKULtOIkISX1E
         OAv8qKYoOCZ74TEetkUTK5IUOK0vNoUZOyyt4+dAzJxuZE/64ekRG2rXa0eMwOwJ1wH+
         MMoXac89ZygyNDk0YpAy82ABrk/fGmUBWQlzUWFy2DIZZxgmqScawfILyB2ir+X+5KIu
         KqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVpw/YkSpECxioHiJcwwjO5cIgkz+JQrp0Z1102tsjs=;
        b=Thpbq+l5u4RxP98XhtjvN1q7c+lPGIfbwQ26/lHVJGCULc5sXCf8J9cAuUSyJ1kO6n
         sjJ/rmyrKWPrOT0Dn39+ni4Mnk1jFX7i+TgGeJIhxK87Q7yEUS405T37QVXwP1mL8l7C
         g12uWEPiSa0XBGpvRzRyCtcbzRYAlfCco98hg8NFtxKCDN7mE51uQXsYZwWgu6blIVen
         wHFP57KCjnFwa9pfliLJ0JBWa/K2c/k4IQeyq8c0NtPu54h4FTIDbVeeGNbyJojteCoQ
         6HxyL/dsnfhHwurCp0Zg+qOL/4fwIgiCqKKqJXj+XR9xOMNyj/YUpYMW/eLEIDH5eW9W
         WTFg==
X-Gm-Message-State: AOAM530Y9ljiH0l35wt8W0c4r57LmsKguDJ6K0fDRNG9Gx4dXohR39+2
        844MxTQMmZ0ijnrLnqYviLVRJBAQKtiLbA==
X-Google-Smtp-Source: ABdhPJws4VKz76/Rj4ocyZfLWDIEslDjzDyROQuhjJG1xPu9xGMlfPjmNX7CdHYFHno8/clRALSaHw==
X-Received: by 2002:a5d:6309:0:b0:1e4:9a62:d46f with SMTP id i9-20020a5d6309000000b001e49a62d46fmr6651438wru.50.1645208205059;
        Fri, 18 Feb 2022 10:16:45 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:44 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/11] scripts: kernel-doc: Translate the "Output format selection modifier" subsection of OPTIONS
Date:   Fri, 18 Feb 2022 19:16:22 +0100
Message-Id: <20220218181628.1411551-6-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Aim: unified POD, user more happy

This section is renamed to "Output format modifiers" to make it simple.

To make it even more simple, a subsection is added:
"reStructuredText only".

Other notes:
- paragraphing correction
- article correction

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 18eca172c4b5..b926faa16b00 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,13 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output format selection modifier (affects only ReST output):
-
-  -sphinx-version	Use the ReST C domain dialect compatible with an
-			specific Sphinx Version.
-			If not specified, kernel-doc will auto-detect using
-			the sphinx-build version found on PATH.
-
 Output selection (mutually exclusive):
   -export		Only output documentation for symbols that have been
 			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
@@ -2583,4 +2576,19 @@ Do not output documentation, only warnings.
 
 =back
 
+=head2 Output format modifiers
+
+=head3 reStructuredText only
+
+=over 8
+
+=item -sphinx-version VERSION
+
+Use the ReST C domain dialect compatible with a specific Sphinx Version.
+
+If not specified, kernel-doc will auto-detect using the sphinx-build version
+found on PATH.
+
+=back
+
 =cut
-- 
2.30.2

