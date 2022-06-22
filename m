Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1665546F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356699AbiFVLPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354579AbiFVLP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:15:29 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78F23A71C;
        Wed, 22 Jun 2022 04:15:23 -0700 (PDT)
X-QQ-mid: bizesmtp82t1655896451ts8iyooo
Received: from ubuntu.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 19:14:05 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000B00A0000000
X-QQ-FEAT: DHpJGCbtM4nBmAWYzX6NaNhkYQbXDPKYhFBXaRdc/3+DB0CP/7je1x84gYVPy
        6m1CPCTdb9SUh05FKda9aw9kDH+CbglNQIiAeCaVryjitrnkAHUW3NuFHoJ31r/qhUVJ5a9
        Mno3k2Tnuer41AKg21GHAnF9cmMApZK257xypaCzBh3neGfNnAmi6S6Q2OPRl8wdSyVjFVc
        X2iZIerPtDBK4g2vTyA0VCyXJwFcCDB5Q26cpDggz7+c0IfyMtL5p8nF7WdSPxGNDjIv1Ve
        RIUE02YsHgRJQrAs7ZmyvzQDYFMzlaO+3ExhOTIFqMlcqTsa46LmjvaXP8Lt3MkNJ13D2/Q
        rPAzoG9OIhi3xWUjrhixrBGRkI3ag==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: lpfc: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 19:14:03 +0800
Message-Id: <20220622111403.11203-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/scsi/lpfc/lpfc_attr.c
line: 2463

  * @phba: pointer the the adapter structure.

changed to:

  * @phba: pointer the adapter structure.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 3caaa7c4af48..fc8133b0ba9a 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -2460,7 +2460,7 @@ lpfc_sriov_hw_max_virtfn_show(struct device *dev,
 
 /**
  * lpfc_enable_bbcr_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
-- 
2.17.1

