Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5565C563450
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiGANYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiGANYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:24:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE6C65D72;
        Fri,  1 Jul 2022 06:24:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m184so1321271wme.1;
        Fri, 01 Jul 2022 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCsu5nTltZvrxQcakbJG/TYyfcvUxSLQOPrTEC979XE=;
        b=hPXw9wi45Jq+arDVBkzYXEDYk149c2YgiBFmxmolwDpQG3zJhXd+AFLEg1BsuUo0cJ
         otgEsiQQ4ehJ1SeAkJkv6lkusnCrewY5MF4ZBJlWalxY+AneBmvtGxOIJlO5Jb/qHEZ/
         4tkImjo7eFp79ufFTp5ktdidum76Mo6+yaLOzMF18hFt4M/ySkV8AxCgdvENYHAk3+SH
         0aXKMQA9MMKHb4MIBTUF/GOWpfGPzp+OrZZn1XgYhFGyGN2Ser6Z+hOZnXYpOw2ZR+Ii
         eAM6kAZcM4ve83RyMOMLVD1E/gngo2RJjZ6H4ApFwTMNf2V32LTRvCkjCqDDjjB4qr4x
         bVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yCsu5nTltZvrxQcakbJG/TYyfcvUxSLQOPrTEC979XE=;
        b=qt6c8LoTnRMCyei0LJg68HqS+IXfi+Q2IPzfYJ1pX8g6LOAijTLro/XzEERQaBwZDn
         C8d8F6l92Vq0KpxE3kpOWVAcLPQHHV+8q7kmPuDmf0E3p/c4mHp7Dmk7ocXScZvmYhGF
         hxJmzJpKuXVN3qiQb0jObXYTfOS+Jyhbz+N81tlS2RRqSCthwJzSPq6+gGUqI5Gffh6G
         3RkZXrwbDBvyy3ClqTfZCyYZwKaQU+sBVw5IBQztB4raXSN+Z1bmE+guiNym3vxAqic/
         fjzv6Gmp7mMEBKnWCSae3VVbgWDh/IVNTnIWzZ6XPXgi4p4SNW3mh8z2XdoTqBSgC0wf
         3WcQ==
X-Gm-Message-State: AJIora++p/twAA9f+wrR0RhL2Q9TK5kYh1omm+Z0G6dh16pJLlHkgJFJ
        Mmj8loS5q7DUMMvSbNPlgI8=
X-Google-Smtp-Source: AGRyM1tl2dPEcNdZXVz8rQKwcLanUvAu52ufPOsF58HfkiGvT3YbFZVCoT/I4ainVOwie0UuR+a50A==
X-Received: by 2002:a05:600c:6020:b0:39c:96ec:5014 with SMTP id az32-20020a05600c602000b0039c96ec5014mr18722775wmb.57.1656681884316;
        Fri, 01 Jul 2022 06:24:44 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003973ea7e725sm8669247wmq.0.2022.07.01.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 06:24:43 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Fix repeated use of "the the" in Kconfig
Date:   Fri,  1 Jul 2022 14:24:43 +0100
Message-Id: <20220701132443.364906-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Fix a couple of uses of "the the" in the Kconfig, replace with "the"

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e86948d66415..56a52496fc62 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1637,7 +1637,7 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 	bool "Extend with bootloader kernel arguments"
 	help
 	  The command-line arguments provided by the boot loader will be
-	  appended to the the device tree bootargs property.
+	  appended to the device tree bootargs property.
 
 endchoice
 
@@ -1795,7 +1795,7 @@ config DMI
 	  continue to boot on existing non-UEFI platforms.
 
 	  NOTE: This does *NOT* enable or encourage the use of DMI quirks,
-	  i.e., the the practice of identifying the platform via DMI to
+	  i.e., the practice of identifying the platform via DMI to
 	  decide whether certain workarounds for buggy hardware and/or
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
-- 
2.35.3

