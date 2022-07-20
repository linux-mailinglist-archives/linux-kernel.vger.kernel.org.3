Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9519B57BEE9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiGTTz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiGTTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:55:47 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A08567589
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:55:43 -0700 (PDT)
X-QQ-mid: bizesmtp86t1658346936tilnfd3r
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 03:55:27 +0800 (CST)
X-QQ-SSF: 0100000000200030C000C00A0000020
X-QQ-FEAT: xqT8U4SkSphJYnHyaylettPgIO47BB3yGPetCKKVCel5otGINx+MloH1vBXBj
        s4XxNQialnwY9aVHdto/kOIjYF+EY5mRauDF4Gn5XGQOGWoWFaDTI5IdFHkCGIue4ehH4XL
        61S4HwqJYgSagy6y0wr4WjIc2bVjguvR9LOphvIjTJ/mKD4k+jkAk7Q+t9sRac8JcKtpcwk
        lrbvptydA4FV7/fUEvdEIyhb/LWMIC53Lfa0MmnJKiqejYvDvkyra0VhfvDprsb+Sr/wTGK
        lgIv+kk8G8v6rUP+0o2YND8CPPPTXOI4ZCpkInggfgoAimapysKuvJRGxFgQeS3Ro0EIgty
        9GHmTkBZjZ6qKWeJBXPWfdZAyPRIGetWJqqTH7olpAhmNUl6cIXMjY+k5EcKQ==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     jim.cromie@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] mtd:do not initialise statics to 0.
Date:   Thu, 21 Jul 2022 03:55:26 +0800
Message-Id: <20220720195526.9289-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 drivers/mtd/maps/scx200_docflash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/scx200_docflash.c b/drivers/mtd/maps/scx200_docflash.c
index 8462662b7128..a565d69d28d6 100644
--- a/drivers/mtd/maps/scx200_docflash.c
+++ b/drivers/mtd/maps/scx200_docflash.c
@@ -24,7 +24,7 @@ MODULE_AUTHOR("Christer Weinigel <wingel@hack.org>");
 MODULE_DESCRIPTION("NatSemi SCx200 DOCCS Flash Driver");
 MODULE_LICENSE("GPL");
 
-static int probe = 0;		/* Don't autoprobe */
+static int probe;		/* Don't autoprobe */
 static unsigned size = 0x1000000; /* 16 MiB the whole ISA address space */
 static unsigned width = 8;	/* Default to 8 bits wide */
 static char *flashtype = "cfi_probe";
-- 
2.30.2

