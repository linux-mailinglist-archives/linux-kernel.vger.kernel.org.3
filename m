Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D479B4E4D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbiCWHwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbiCWHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:52:08 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043F74DCB;
        Wed, 23 Mar 2022 00:50:32 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 23 Mar
 2022 15:50:34 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 23 Mar
 2022 15:50:30 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <santoshkumar.yadav@barco.com>, <peter.korsgaard@barco.com>,
        <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH V2] platform/x86: barco-p50-gpio: Fix duplicate included inux/io.h
Date:   Wed, 23 Mar 2022 15:50:25 +0800
Message-ID: <1648021825-6182-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:
drivers/platform/x86/barco-p50-gpio.c: linux/io.h is included more than once.

No functional change.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: drop the io.h include higher up to keep the (almost) alphabetical ordering.

 drivers/platform/x86/barco-p50-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
index f5c72e3..0553428 100644
--- a/drivers/platform/x86/barco-p50-gpio.c
+++ b/drivers/platform/x86/barco-p50-gpio.c
@@ -10,7 +10,6 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
-#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
-- 
2.7.4

