Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6185B1CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiIHM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiIHM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:27:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3996E5800;
        Thu,  8 Sep 2022 05:27:22 -0700 (PDT)
X-QQ-mid: bizesmtp84t1662640035tmpac29j
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:27:14 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: xqT8U4SkSph6l9lNGy1RzrnprUWRUbAh++gyNgtQGnbyBotsZCotqOTSVf2vg
        eek3kjIXZ+5Rhhv097gzvf5mPzb4pD1g2G/23PGbmt3lNtjm6WjsCCk2R/omaE6mUQsOkvK
        jpNj6bfm2IER39XLhbROKDCQPSQf9SO1gt3XR2qqHxga6Ejamz6EjZIIlEkCjS/YI2xT03o
        nsB4eG2TiZXHXtSLAF93U+H27rK6D3X1ZOWHHqGc1QbedGz5VQkqJGCoSi5LgOaAfhOuGEE
        0kqcrOPR8kox8c5/mH8vM2C8qB8YAEGy7n5PPNqHsJnXuvYGt9p0Nsx7ETR0S2aW57UjmWU
        F44SVjdqDj7RbJnXC4+8ij5Cq2SrDtr9IrI6aGknRqCchjhLmWoZ0LOfHCqoQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/scsi: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:27:07 +0800
Message-Id: <20220908122707.13222-1-wangjianli@cdjrlc.com>
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

