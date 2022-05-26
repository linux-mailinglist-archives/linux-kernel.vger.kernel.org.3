Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E91534FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiEZNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiEZNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:20:42 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B723D682B;
        Thu, 26 May 2022 06:20:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VEST7R4_1653571236;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VEST7R4_1653571236)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 May 2022 21:20:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     vireshk@kernel.org
Cc:     nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] opp: Fix some kernel-doc comments
Date:   Thu, 26 May 2022 21:20:35 +0800
Message-Id: <20220526132035.112026-1-yang.lee@linux.alibaba.com>
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

Make @freq to @bw in dev_pm_opp_find_bw_ceil() and
dev_pm_opp_find_bw_floor() kernel-doc comment to
remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

drivers/opp/core.c:753: warning: Function parameter or member 'bw' not
described in 'dev_pm_opp_find_bw_ceil'
drivers/opp/core.c:753: warning: Excess function parameter 'freq'
description in 'dev_pm_opp_find_bw_ceil'
drivers/opp/core.c:812: warning: Function parameter or member 'bw' not
described in 'dev_pm_opp_find_bw_floor'
drivers/opp/core.c:812: warning: Excess function parameter 'freq'
description in 'dev_pm_opp_find_bw_floor'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/opp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 84063eaebb91..e44b73af2824 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -732,7 +732,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
 /**
  * dev_pm_opp_find_bw_ceil() - Search for a rounded ceil bandwidth
  * @dev:	device for which we do this operation
- * @freq:	start bandwidth
+ * @bw:	start bandwidth
  * @index:	which bandwidth to compare, in case of OPPs with several values
  *
  * Search for the matching floor *available* OPP from a starting bandwidth
@@ -791,7 +791,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_ceil);
 /**
  * dev_pm_opp_find_bw_floor() - Search for a rounded floor bandwidth
  * @dev:	device for which we do this operation
- * @freq:	start bandwidth
+ * @bw:	start bandwidth
  * @index:	which bandwidth to compare, in case of OPPs with several values
  *
  * Search for the matching floor *available* OPP from a starting bandwidth
-- 
2.20.1.7.g153144c

