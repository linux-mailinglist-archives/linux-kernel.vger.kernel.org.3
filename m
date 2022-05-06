Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE7951CFCC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388811AbiEFDqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388787AbiEFDqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:46:06 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272B140DA;
        Thu,  5 May 2022 20:42:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VCPvNGc_1651808530;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCPvNGc_1651808530)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 May 2022 11:42:21 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dipenp@nvidia.com
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] hte: Remove unused including <linux/version.h>
Date:   Fri,  6 May 2022 11:42:09 +0800
Message-Id: <20220506034209.59848-1-jiapeng.chong@linux.alibaba.com>
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

Eliminate the follow versioncheck warning:

./drivers/hte/hte-tegra194-test.c: 8 linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hte/hte-tegra194-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index bc3ab18dfdc5..6a3e57b57a34 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -5,7 +5,6 @@
  * Author: Dipen Patel <dipenp@nvidia.com>
  */
 
-#include <linux/version.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.20.1.7.g153144c

