Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5FC5B1DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiIHNFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIHNFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:05:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF12E40E29;
        Thu,  8 Sep 2022 06:04:55 -0700 (PDT)
X-QQ-mid: bizesmtp85t1662642285t338icw9
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:04:43 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: xqT8U4SkSpheaBwLeHRIsZ+CJLd0+Sq1Wvs/GKi5K/1WUroXMoJfyLrEgZYyq
        FLcnkfkIJLtDIhbdSqiv36IQ/B0Kqfo/r8AyBK7JQ0mnyT+7hvsRqeW/jJ3fAdAQR18jRJB
        sL7nDdIn/6S75zQC2+8+V8bozaVfo9CMZBfui0LSItdJYVI1SZfb8OURvnCF6DTRP3MAAuS
        FKQXdXRPvR2YoIOW7OMuX0jvkn8vnnRP5em8ho8G3sPhUiuYi4UGPsjIr9kGTVdaXrDf5P8
        sMHs1cH2pwLXQvATrn7DUPncnQiL2KPZ/WCcvFeNx2vfPPAodwhEFVVQYWaanNes+3j4rl9
        GpEfPQ94FNoEDYgXiZwhQSEo3HWnavoPKelV+Rbc2G/RiLhgsk=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] scsi/mpt3sas: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:04:20 +0800
Message-Id: <20220908130420.33130-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 05364aa15ecd..c8443f69d15d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -836,7 +836,7 @@ struct _enclosure_node {
 /**
  * enum reset_type - reset state
  * @FORCE_BIG_HAMMER: issue diagnostic reset
- * @SOFT_RESET: issue message_unit_reset, if fails to to big hammer
+ * @SOFT_RESET: issue message_unit_reset, if fails to big hammer
  */
 enum reset_type {
 	FORCE_BIG_HAMMER,
-- 
2.36.1

