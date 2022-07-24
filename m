Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC56857F3B4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiGXH2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiGXH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:28:07 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95E19013;
        Sun, 24 Jul 2022 00:28:02 -0700 (PDT)
X-QQ-mid: bizesmtp85t1658647669t2eb7jb0
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:27:47 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: CR3LFp2JE4m+cA6As1WTJN3MqtKgoAYIFGvnwUwmm1Iz1hA89/9aNdIuSZFQI
        ZZ/4Lsz1LQEP6gTlQ5SkW43JE9QSDhA6s5hKZSmKkoi1cbRGdRNrlAz4GbZn+PLjqHBN+gi
        oJLCVMNCdicS+KrHuWYpMMWHR9z6Vu8UjfSZuJDIMm7fr6AHGudCdfmhvZerIgLj/qkXu2f
        nthRy6KszSLbapI6WFSP1DsciUtXhbDtxMd7V4XcqEI4KDjapDwHC03Ii93Zw8BraC6Jugm
        Kp+oSQKfZdCWUo1iqQ44MVhiCl8fn3eiDu95HCJ8B3flyPWNP0gOUmbEo0CMmG3rQnwaIKT
        68wfK+Avj3SiqvvxrN27fxpGyiyH4MI6glDbrHW//JfAXWAWWk=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     oliver@neukum.org, aliakc@web.de, lenehan@twibble.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/scsi: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:27:41 +0800
Message-Id: <20220724072741.13662-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/wd33c93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index 3fe562047d85..a087e681805d 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -821,7 +821,7 @@ wd33c93_intr(struct Scsi_Host *instance)
 /* After starting a DMA transfer, the next interrupt
  * is guaranteed to be in response to completion of
  * the transfer. Since the Amiga DMA hardware runs in
- * in an open-ended fashion, it needs to be told when
+ * an open-ended fashion, it needs to be told when
  * to stop; do that here if D_DMA_RUNNING is true.
  * Also, we have to update 'this_residual' and 'ptr'
  * based on the contents of the TRANSFER_COUNT register,
-- 
2.36.1

