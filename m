Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9DF55FA03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiF2IGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiF2IGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:06:41 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C35E13B3FE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:06:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 43AF11E80D11;
        Wed, 29 Jun 2022 16:05:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tUf8Lkw4g-75; Wed, 29 Jun 2022 16:05:26 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 0029D1E80CDC;
        Wed, 29 Jun 2022 16:05:25 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     oss@buserror.net, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] powerpc: platforms: 85xx: Fix spelling mistake
Date:   Wed, 29 Jun 2022 16:06:34 +0800
Message-Id: <20220629080634.29571-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'wont' to 'won't'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 arch/powerpc/platforms/85xx/sgy_cts1000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index 98ae64075193..a920852703ba 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -29,7 +29,7 @@ static const struct of_device_id child_match[] = {
 
 static void gpio_halt_wfn(struct work_struct *work)
 {
-	/* Likely wont return */
+	/* Likely won't return */
 	orderly_poweroff(true);
 }
 static DECLARE_WORK(gpio_halt_wq, gpio_halt_wfn);
@@ -51,7 +51,7 @@ static void __noreturn gpio_halt_cb(void)
 
 	printk(KERN_INFO "gpio-halt: triggering GPIO.\n");
 
-	/* Probably wont return */
+	/* Probably won't return */
 	gpio_set_value(gpio, trigger);
 
 	panic("Halt failed\n");
@@ -147,7 +147,7 @@ static int gpio_halt_remove(struct platform_device *pdev)
 
 static const struct of_device_id gpio_halt_match[] = {
 	/* We match on the gpio bus itself and scan the children since they
-	 * wont be matched against us. We know the bus wont match until it
+	 * won't be matched against us. We know the bus won't match until it
 	 * has been registered too. */
 	{
 		.compatible = "fsl,qoriq-gpio",
-- 
2.34.1

