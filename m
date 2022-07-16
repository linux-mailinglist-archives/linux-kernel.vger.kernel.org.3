Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6844579DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbiGSM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241951AbiGSMyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:54:51 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0FB98214;
        Tue, 19 Jul 2022 05:21:54 -0700 (PDT)
X-QQ-mid: bizesmtp68t1658233309t5ae3mc0
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:21:48 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: ALw5QuVtm4Ut9H1MQOekS1gHiDjaVHLMusmvCSq24eY6Ocv0aKodqpF2O5tcb
        l/pc4Z/7lHIcHEKqW/i19CcDrxrUwE6Bf8nFZ7FJx8m+dkejxsOVcZUMAMX4v0MlKX7Y1Gl
        OBC4SnPk9ecXf46PpQmzTjn9hBH4+SrxN+H5Z6wN79cMoq1m6SLOyAVzx5QsdCJ2r6P1vhp
        PiHxvU2rFO2iECTLewMo77iR8cKCowEKNFSmZcHGirsZeYidhE/9fO/DFSP8KeebShwF7t/
        fKo03zTOrAzHztd62rYLZnn4z3TGChlq54I6OLBLGmNaIa8/d2k0Z79g0bedDw7s7gQ1ixU
        YYGJrkLX8nO3dmpaBt0rWsq3aN5CqzvhZAns7w97T8Zl+Q9lf2wesSLgXveILxtf8dAjb2v
        7hGLx+q4RV8=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] watchdog: dw_wdt: Fix comment typo
Date:   Sat, 16 Jul 2022 12:19:51 +0800
Message-Id: <20220716041951.34714-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `have' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/watchdog/dw_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index cd578843277e..3208ce305335 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -218,7 +218,7 @@ static int dw_wdt_set_timeout(struct watchdog_device *wdd, unsigned int top_s)
 
 	/*
 	 * Set the new value in the watchdog.  Some versions of dw_wdt
-	 * have have TOPINIT in the TIMEOUT_RANGE register (as per
+	 * have TOPINIT in the TIMEOUT_RANGE register (as per
 	 * CP_WDT_DUAL_TOP in WDT_COMP_PARAMS_1).  On those we
 	 * effectively get a pat of the watchdog right here.
 	 */
-- 
2.35.1

