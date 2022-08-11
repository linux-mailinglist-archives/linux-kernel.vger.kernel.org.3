Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91C058FDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiHKOAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiHKOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:00:44 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643E32AC53;
        Thu, 11 Aug 2022 07:00:42 -0700 (PDT)
X-QQ-mid: bizesmtp67t1660226438tdrfkrny
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 22:00:37 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: ao4JQgu0M3/y4UpsMilihKjTNUwcE1b8f4boSJxV/ed5VH1ecobm3s1bqGLpE
        vEC4oLlFFI2w3SCJ6xip+oLrn2CyNbJhIiOtCdBFGbforo8s0Uqx9aPlkYd2Yk2rjEs2GJ+
        EHVi6wBofUDdu0F/iUljIoSzWG728d/MHycmrmIAZEPqLaBHjudPDiKk5rp+qvFpSAMwsfy
        O5ypgpXR5KeHzBVyFrhHIwC8vXzP3nrbIAn6nPjKrHih7YVIgE5eym4yfkD7lUvDvktaseJ
        c0NAzOiiExEH2/aepHNiEZzgrWJk4j3BwTCro8IrLhgquEJlbx5w0OGvLuVA77eQQ72zSWC
        SOJsI8cOrh3bMNIoRu1r+QlK6KSky2N9YP6CFTBDz7sry9URYPCcrfCCi3l9PXsKmd671Xa
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] clk: Fix comment typo
Date:   Thu, 11 Aug 2022 22:00:30 +0800
Message-Id: <20220811140030.28886-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `to' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7fc191c15507..275a65d146b0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3462,7 +3462,7 @@ static void clk_core_reparent_orphans_nolock(void)
 
 		/*
 		 * We need to use __clk_set_parent_before() and _after() to
-		 * to properly migrate any prepare/enable count of the orphan
+		 * properly migrate any prepare/enable count of the orphan
 		 * clock. This is important for CLK_IS_CRITICAL clocks, which
 		 * are enabled during init but might not have a parent yet.
 		 */
-- 
2.36.1

