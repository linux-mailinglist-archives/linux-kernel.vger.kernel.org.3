Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3896E576E67
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiGPOE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPOE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:04:26 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4A1AD87;
        Sat, 16 Jul 2022 07:04:19 -0700 (PDT)
X-QQ-mid: bizesmtp89t1657980255twldwjal
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 22:04:08 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: LE7C6P2vL8Sxi14gZa1VtAgWnFdun8nS9UxUCU9+c71cbT6FzsB1O0EVMzOry
        5b43Z3srwbLOuR7x7GPHZjvwuAPpk+NF5aqj5yhJiOGa1f1giAJf33wdmDBeIUOleeJ4qQo
        cV3cwmrYVkp+ab4q94ueFKzUBzaxnwZjzxsJipXRp6w0L4jPNGuEjGCHvAfVofuGPCX4ZDV
        k2Bmn4ZbEszAn+Wp3ShmF9A/r+LqCytW2AXi8yPkf0CWukQVBTXhmMUTx5GkS8cnz2asW6C
        G6xKM1S37CZDjxJZJJ2nw5tYfWjHugyIs8w3KrV16Gau15STETWkWq7DDPxf1tuYFccgb2e
        RW5XlsYLAIsPvKP6K10hrHte2u4Ip8bqbOMkWoMwB0/bBFR9h0FSVH68pvhyl7jpGhQ/rLt
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mmc/core: fix repeated words in comments
Date:   Sat, 16 Jul 2022 22:04:01 +0800
Message-Id: <20220716140401.55494-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'it'.
 Delete the redundant word 'in'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mmc/core/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4b70cbfc6d5d..e4a555a2f202 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -56,7 +56,7 @@ static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 /*
  * Enabling software CRCs on the data blocks can be a significant (30%)
  * performance cost, and for other reasons may not always be desired.
- * So we allow it it to be disabled.
+ * So we allow it to be disabled.
  */
 bool use_spi_crc = 1;
 module_param(use_spi_crc, bool, 0);
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

