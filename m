Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1498D557392
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiFWHHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFWHHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:07:43 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D945516;
        Thu, 23 Jun 2022 00:07:36 -0700 (PDT)
X-QQ-mid: bizesmtp78t1655968019ta68ekx6
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 15:06:53 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: UldK9Jsj7VOmQ2cIaotYCceBjTzflJSXNO/wOhM2BXMXKEBCGfYWRj7Workzo
        MCXEcszpizkMWAwOtIiKvv91EDmfTQ94AX/qJrl0DFVmb3fRLcscz+AevmF3LRt0IHXJCVd
        K4kVAx2SGRPZUat6b6g+s0lbQbPrjaHVOYkWJNY3PyTjWGC2LXth799Rw8Bh+Ovzg5QVTZ1
        BGG1nh2ZZzchZdP6rKr73Ambk+jgWsbsfackfV5EPvizmpsYIx3bEiXEq0s2yaQOkdJRpRW
        Ub7aJgeayeKRYVibFkGSc0s2fsGysJPy58lLOXZtVr0hZpUwBNX1bi2vBHwGGoS7yjzxcXk
        MQ9n7C6e88n+/0nShyNjZsrILs2Xw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     manoj@linux.ibm.com, mrochs@linux.ibm.com, ukrishn@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: cxlflash: drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 15:06:52 +0800
Message-Id: <20220623070652.11136-1-jiangjian@cdjrlc.com>
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

there is an unexpected word 'a' in the comments that need to be dropped

file - drivers/scsi/cxlflash/superpipe.c
line - 741

* This routine is safe to be called with a a non-initialized context.

changed to:

* This routine is safe to be called with a non-initialized context.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/cxlflash/superpipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index df0ebabbf387..fc8526f7f036 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -738,7 +738,7 @@ int cxlflash_disk_release(struct scsi_device *sdev,
  * @cfg:	Internal structure associated with the host.
  * @ctxi:	Context to release.
  *
- * This routine is safe to be called with a a non-initialized context.
+ * This routine is safe to be called with a non-initialized context.
  * Also note that the routine conditionally checks for the existence
  * of the context control map before clearing the RHT registers and
  * context capabilities because it is possible to destroy a context
-- 
2.17.1

