Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688CA56D36E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGKDkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKDk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:40:29 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A34B12631
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 20:40:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIuPjwN_1657510822;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VIuPjwN_1657510822)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 11:40:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] regulator: max597x: Remove unused including <linux/version.h>
Date:   Mon, 11 Jul 2022 11:40:11 +0800
Message-Id: <20220711034011.46096-1-jiapeng.chong@linux.alibaba.com>
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

The patch makes sense but these are not compile warnings.
They come from scripts/checkversion.pl, which can be called
by 'make versioncheck', so I suppose that something in your
build system is running 'make versioncheck'.

Eliminate the follow versioncheck warning:

./drivers/regulator/max597x-regulator.c: 21 linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/regulator/max597x-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max597x-regulator.c
index f95acd1c5e3a..5e09aa4213be 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max597x-regulator.c
@@ -18,7 +18,6 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-#include <linux/version.h>
 #include <linux/platform_device.h>
 
 #include <linux/mfd/max597x.h>
-- 
2.20.1.7.g153144c

