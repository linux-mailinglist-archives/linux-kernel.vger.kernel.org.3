Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA86E5A7692
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiHaGaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiHaGaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:30:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A018344;
        Tue, 30 Aug 2022 23:30:05 -0700 (PDT)
X-QQ-mid: bizesmtp90t1661927397tim9ya37
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:29:55 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: xqT8U4SkSpjl2BYBjpdXeIHxB6l763bCgnuv/RMHG+IiW8h7mRfk3zCKX2TA1
        8QPD8aSRHUfhX9cbUzIIqBn6j3940Pt178XqyPBBjjG4v4kWfeC7IwOrYR4PZzTssdl+JRb
        ZQ1tl1wOvDC+B85pfcXB4EVJiDxzCNtgOrzsUg173YjUC3CzxdNNXXIn4EDSYwYisn+Swk8
        kJ6rRsfDrNuO0W3rBWgEYAV3LEWeyYGhpv/J+lKaqZtogw6HSEU4OGwOdTB6Jqi+N5dxXBe
        qFDLvsV3A1B0irj+cDLcS5WB+InPzuHQB00hpkL6Q0BlXtzslbn4xSx64yJOSx6DLRpdop/
        qdrUX9iHQFokOEF4mAjBzaAFVQykmr3TSd+pxz0x2poR9o6h9yx7kos5e0NFwYXtHxWSS6V
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tony@atomide.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ARM: OMAP2+: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:29:49 +0800
Message-Id: <20220831062949.12369-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'from'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/mach-omap2/cm33xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index d61fa06117b4..c824d4e3db63 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2011-2012 Texas Instruments Incorporated - https://www.ti.com/
  * Vaibhav Hiremath <hvaibhav@ti.com>
  *
- * Reference taken from from OMAP4 cminst44xx.c
+ * Reference taken from OMAP4 cminst44xx.c
  */
 
 #include <linux/kernel.h>
-- 
2.36.1

