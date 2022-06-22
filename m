Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664DB554F56
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358565AbiFVPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiFVPbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:31:33 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7D38D9F;
        Wed, 22 Jun 2022 08:31:27 -0700 (PDT)
X-QQ-mid: bizesmtp72t1655911843trynz47q
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 23:30:31 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000E00A0000000
X-QQ-FEAT: Mzskoac49OhJzI5Pv8Mj9o2FIj6xOcNrBDvWJ3hTpBVkV722THm8ctn7nR7Yg
        0XIja2PyZBaM3+xY19y9b1mL/ANmV8kEMyoK72Auoi4R/rLePZUVkn6/3tXgWxVjtL5/8/5
        1o+E21YbV38vSSqM7rCP0kSbt45HVhIGk/mb7qXkdbCmIXdAQgEeHa02uVvXx51T+qniteD
        /uQTIIwP6CTXT/mYBBxPTzI8E59mk60pYBt8StL/QbI29dwCwqmX4ZuVwgFoAUsNT13I8zw
        DNBh2DRdnCOF1vEKTiFa1noGQnhXNxpICCEDoeq2jtS1oWos0zvSZDLdS+Y3qvSB/R9KBTY
        C3eFAl2VE2w0c/LqadH67PYETNEPOIvZD7lKGZF
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: sg: Fix typo in comments
Date:   Wed, 22 Jun 2022 23:30:29 +0800
Message-Id: <20220622153029.4137-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'is' in the comments that need to be dropped

file: drivers/scsi/sg.c
line: 697

* but is is possible that the app intended SG_DXFER_TO_DEV, because there

changed to:

* but is possible that the app intended SG_DXFER_TO_DEV, because there

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 118c7b4a8af2..047761f62b23 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -694,7 +694,7 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	}
 	/*
 	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
-	 * but is is possible that the app intended SG_DXFER_TO_DEV, because there
+	 * but is possible that the app intended SG_DXFER_TO_DEV, because there
 	 * is a non-zero input_size, so emit a warning.
 	 */
 	if (hp->dxfer_direction == SG_DXFER_TO_FROM_DEV) {
-- 
2.17.1

