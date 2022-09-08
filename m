Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9975B1D22
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiIHMem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiIHMeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:34:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DD2E293C;
        Thu,  8 Sep 2022 05:34:05 -0700 (PDT)
X-QQ-mid: bizesmtp91t1662640441tjm6b0jb
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:34:00 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: MoHL2FAY+uGtpeNhM1wt8GjkgmQCMDxhlvA6/rU7HOYkZIS+PibvUkF3GPX37
        CJWqP/cf7eIJSkSUznUVfgeV7ePMN7cTPTL3cm2JfOBD8KDBflFYY30gNhg/M03w+AgtdEM
        MGrOBXf166HFqHRhmcc0e9Dtl0+ZOOERQTD/e876ANcx5Bte90NNWgFLaNvXVCbqcz+GuVb
        T4mB3C68ESJJX1ZZttOuOE0PvcKoiAmfGMrBdIIC9Kpcd5cYfdkIhR2wHUq7hmgL3H1TOR5
        OPt8FAR19cILu6oXSiQUkji7JN6a0EKCl+wWUWDcHMSIbUFQ/ADQaIEBcqQlV2mXrzuZPQ8
        Z7r+KZEG0rFtegAVQ0JfW5plxcPKOH44AZzgjwGfK/EISSt99I=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] mmc/core: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:33:53 +0800
Message-Id: <20220908123353.17745-1-wangjianli@cdjrlc.com>
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

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ef53a2578824..5a82bc42d358 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -528,7 +528,7 @@ EXPORT_SYMBOL(mmc_cqe_post_req);
  * @host: MMC host to recover
  *
  * Recovery consists of stopping CQE, stopping eMMC, discarding the queue in
- * in eMMC, and discarding the queue in CQE. CQE must call
+ * eMMC, and discarding the queue in CQE. CQE must call
  * mmc_cqe_request_done() on all requests. An error is returned if the eMMC
  * fails to discard its queue.
  */
-- 
2.36.1

