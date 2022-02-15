Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C94B603F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiBOBxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:53:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiBOBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:53:20 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DDC1405FD;
        Mon, 14 Feb 2022 17:53:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jnwang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4VVSdE_1644889961;
Received: from rsjc10526.et2sqa.tbsite.net(mailfrom:jnwang@linux.alibaba.com fp:SMTPD_---0V4VVSdE_1644889961)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Feb 2022 09:53:08 +0800
From:   James Wang <jnwang@linux.alibaba.com>
To:     don.brace@microsemi.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2] [hpsa] Fix the wrong chars in comment section
Date:   Tue, 15 Feb 2022 09:52:41 +0800
Message-Id: <1644889961-61470-1-git-send-email-jnwang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <974edf4d-37fa-b25a-d0ac-33ac502381d8@acm.org>
References: <974edf4d-37fa-b25a-d0ac-33ac502381d8@acm.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These '+' should be redundant.

Signed-off-by: James Wang <jnwang@linux.alibaba.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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
+ */
 static int hpsa_find_cfgtables(struct ctlr_info *h)
 {
 	u64 cfg_offset;
-- 
1.8.3.1

