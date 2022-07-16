Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C0576E14
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGPM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:56:15 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C5D1137;
        Sat, 16 Jul 2022 05:56:09 -0700 (PDT)
X-QQ-mid: bizesmtp85t1657976161tphfkrm7
Received: from localhost.localdomain ( [182.132.179.58])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 20:55:59 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000B00A0000020
X-QQ-FEAT: ALw5QuVtm4UcbWgqO6hmD4//CKEl+Oe87vLHJieHnjDM9DWvrf9bZi4gwn/Q1
        oqqLO9ZTlDWvnrX6wZ8S8ta5k8VuUShhsxuhQBkXc5B8LsA1UTjhc9cmEJ2Ax62bNWuSUg6
        q2R5El3kqMi+2PGabw+2CcqbQSgGMCtmSc4Bzcp60u/iPEyJwV1MjAlcc4wjnQCABmfTDtW
        8rtyfROnppefWktnfKdD8vHmN+g7ACd5kbW7pxi7kr13FPfAtOV4Z3P9uQ6awJZysdRXEzd
        /1a/2gYFe4L4Aw4RHQguiF0W/aKOJlIMWkpDAPM/lstkDGa8mc7nsy/gUuBc2F4YjoP90wf
        lLbxYPm2An3CQGzp/XOb2R9SxwCtjDX3V02Z7n+SlPSid9xUKGqPsySjGnH5Q==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: qlogicpti: Remove unneeded semicolon
Date:   Sun, 17 Jul 2022 02:38:43 +0800
Message-Id: <20220716183843.65193-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon after the `}' in line 1152 is unneeded.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/qlogicpti.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 57f2f4135a06..4f777ca9730b 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -513,7 +513,7 @@ static int qlogicpti_load_firmware(struct qlogicpti *qpti)
 		       qpti->qpti_id);
 		err = 1;
 		goto out;
-	}		
+	}
 	sbus_writew(SBUS_CTRL_RESET, qpti->qregs + SBUS_CTRL);
 	sbus_writew((DMA_CTRL_CCLEAR | DMA_CTRL_CIRQ), qpti->qregs + CMD_DMA_CTRL);
 	sbus_writew((DMA_CTRL_CCLEAR | DMA_CTRL_CIRQ), qpti->qregs + DATA_DMA_CTRL);
@@ -563,7 +563,7 @@ static int qlogicpti_load_firmware(struct qlogicpti *qpti)
 		       qpti->qpti_id);
 		err = 1;
 		goto out;
-	}		
+	}
 
 	/* Load it up.. */
 	for (i = 0; i < risc_code_length; i++) {
@@ -1135,7 +1135,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 
 	if (!(sbus_readw(qpti->qregs + SBUS_STAT) & SBUS_STAT_RINT))
 		return NULL;
-		
+
 	in_ptr = sbus_readw(qpti->qregs + MBOX5);
 	sbus_writew(HCCTRL_CRIRQ, qpti->qregs + HCCTRL);
 	if (sbus_readw(qpti->qregs + SBUS_SEMAPHORE) & SBUS_SEMAPHORE_LCK) {
@@ -1149,7 +1149,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 		case COMMAND_ERROR:
 		case COMMAND_PARAM_ERROR:
 			break;
-		};
+		}
 		sbus_writew(0, qpti->qregs + SBUS_SEMAPHORE);
 	}
 
@@ -1363,7 +1363,7 @@ static int qpti_sbus_probe(struct platform_device *op)
 		printk("(FCode %s)", fcode);
 	if (of_find_property(dp, "differential", NULL) != NULL)
 		qpti->differential = 1;
-			
+
 	printk("\nqlogicpti%d: [%s Wide, using %s interface]\n",
 		qpti->qpti_id,
 		(qpti->ultra ? "Ultra" : "Fast"),
-- 
2.35.1

