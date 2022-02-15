Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7D4B5FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiBOAzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:55:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiBOAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:55:19 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525BB40;
        Mon, 14 Feb 2022 16:55:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4VOuCZ_1644886507;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V4VOuCZ_1644886507)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Feb 2022 08:55:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mpm@selenic.com
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] hwrng: core: Remove duplicated include in core.c
Date:   Tue, 15 Feb 2022 08:55:05 +0800
Message-Id: <20220215005505.80430-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./drivers/char/hw_random/core.c: linux/random.h is included more than
once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/char/hw_random/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index be2953aa5145..94626f533361 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -21,7 +21,6 @@
 #include <linux/sched/signal.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
-#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-- 
2.20.1.7.g153144c

