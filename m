Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F995B1E15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiIHNJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiIHNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:09:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9112A9B;
        Thu,  8 Sep 2022 06:09:27 -0700 (PDT)
X-QQ-mid: bizesmtp73t1662642558tg2cq26p
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:09:17 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 6PjtIMncaiwmKVTo6w918fLuDawz/6DFkUjTkTsG0vV4FeLmKKjSulxKyEIP2
        t7HH0qEDCCTExfCS5Tgskv8JdVi6q3EA8dQtrlSvNRaaJ2UM17UlnIjf87Qu+SkGkojSlXu
        WRXgfEpo/f/NIoM9RnR6Os5upZuvb1sjrIvjj45csIYj6r3cye8kt481Qw23cp+lmyjnGPZ
        70Q5PKjj4Ll+Qvq5iBbi+pvpUaqwc5F+OUKqRS8Ky64ti6HM0szrpueIJdIHX7PBUg03Xzt
        Q3OXtOL36SXgW1i00eZymk63XiW3bSm7rluxexzgZSsUUJfY7PKqA3VudPucWQD0CvvDCmG
        PE8hxQk47R6bgD2qSPBkTGnODyWKdlvaiOUzgwRLXZ1gM3cGVnwEfwfB4itGg==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] scsi/ibmvscsi_tgt: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:09:10 +0800
Message-Id: <20220908130910.35680-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index eee1a24f7e15..e8770310a64b 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -444,7 +444,7 @@ static void ibmvscsis_disconnect(struct work_struct *work)
 		break;
 
 	/*
-	 * Can transition from this state to to unconfiguring
+	 * Can transition from this state to unconfiguring
 	 * or err disconnect.
 	 */
 	case ERR_DISCONNECT_RECONNECT:
-- 
2.36.1

