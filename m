Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7832D57914E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiGSD1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiGSD1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:27:00 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D933026F8;
        Mon, 18 Jul 2022 20:26:55 -0700 (PDT)
X-QQ-mid: bizesmtp72t1658201210t3fcvvvw
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 11:26:37 +0800 (CST)
X-QQ-SSF: 0100000000000030C000000A0000020
X-QQ-FEAT: z5nQAcCNimAMKBwS6s3YR2MurZGCDjCcKv0NKudQzye3syuOnjIEC/DjuS657
        BzBY0PECuWO/0hc85OwxIxcDRapjSzJ7+vX2APXQoBKK+i7o7fmlQbezkHLweibyLghEMIs
        HNTttnWJXOOY+KYGNgCymdhN/hFT5FEz1JRaafHXss+9zecqolxhhWURxqrf7hUqLXJAlCP
        6iSBbRWFVpxv2u2ZbhXsp5dB66XzOE8HY9BSujeP3EAWIqlbeYwProIBJa0VKa4DSF8m7at
        rXEhmxW6LtS1rR4OnRmwPwrNWOkKkB1OCDQiHY2VhZZJ14/1XEh0COI5n+x+pOyF/EHnZ9z
        ikHYIuxO0qILkKb2pI7T5gthumjzjhKenoIOPDGIPh6OY4wBTK2p6rkn2hh+w==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] scsi:Unneeded semicolon
Date:   Tue, 19 Jul 2022 11:26:35 +0800
Message-Id: <20220719032635.5271-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unneeded semicolon

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 drivers/scsi/qlogicpti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 57f2f4135a06..59c82d740139 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1149,7 +1149,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 		case COMMAND_ERROR:
 		case COMMAND_PARAM_ERROR:
 			break;
-		};
+		}
 		sbus_writew(0, qpti->qregs + SBUS_SEMAPHORE);
 	}
 
-- 
2.30.2

