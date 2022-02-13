Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2359B4B3A6A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 10:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiBMJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 04:00:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiBMJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 04:00:13 -0500
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF745BD25;
        Sun, 13 Feb 2022 01:00:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jnwang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4H7VRM_1644742790;
Received: from rsjc10526.et2sqa.tbsite.net(mailfrom:jnwang@linux.alibaba.com fp:SMTPD_---0V4H7VRM_1644742790)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 13 Feb 2022 17:00:03 +0800
From:   James Wang <jnwang@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, don.brace@microchip.com
Subject: [PATCH] [hpsa] Fix the wrong chars in comment section
Date:   Sun, 13 Feb 2022 16:59:50 +0800
Message-Id: <1644742790-87210-1-git-send-email-jnwang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These '+' should be redundant.

Signed-off-by: James Wang <jnwang@linux.alibaba.com>
---
 drivers/scsi/hpsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a47bcce..34cd6c8 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7641,8 +7641,8 @@ static void hpsa_free_cfgtables(struct ctlr_info *h)
 }
 
 /* Find and map CISS config table and transfer table
-+ * several items must be unmapped (freed) later
-+ * */
+ * several items must be unmapped (freed) later
+ * */
 static int hpsa_find_cfgtables(struct ctlr_info *h)
 {
 	u64 cfg_offset;
-- 
1.8.3.1

