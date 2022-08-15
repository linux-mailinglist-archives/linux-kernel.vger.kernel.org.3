Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A79594613
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 01:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349051AbiHOWiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350686AbiHOWcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:32:05 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E712D280
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:48:50 -0700 (PDT)
X-QQ-mid: bizesmtp68t1660592909tkmnejmd
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 03:48:08 +0800 (CST)
X-QQ-SSF: 0100000000200050C000B00A0000020
X-QQ-FEAT: glnloaME82QdzR12ys9y9EVt8m7VgHAjczMhd/x+kpcWGtc3FAGJ94x61rz6W
        2mSN/AE4NljPGl4urZwtedDh2usIf0cr9c92H6/qStAt1ikY4hmtdUXk7us6vy4UQI/q+kJ
        Vc3MQerjizkxGUpm3FAopWEFnxQVGdCEIEZv01uZCUAvUcS/dzPCxfLf+tx7P28MAYLcObw
        CzCvXdhpFCcK/u0YiSZLyouUptOOxH7Dcn3njdr8AkxZZqXDJNeIM7RO9rbzbneOdpHS7+Q
        9LT3BHo1z23+q3lz9IchyW0gmqOYvtZMc7/PT3weN7vke58YvcJ8wv46jsS3lnjnSWiW7Xv
        BmsqrNUEr+X/gdW3bNkMd1DAQ8ZNA==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     gerg@linux-m68k.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] m68k: Complete variable type
Date:   Tue, 16 Aug 2022 03:48:06 +0800
Message-Id: <20220815194806.3487-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
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

Complete the variable type of line 109.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/m68k/coldfire/m520x.c | 2 +-
 arch/m68k/q40/q40ints.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/coldfire/m520x.c b/arch/m68k/coldfire/m520x.c
index d2f96b40aee1..dca89214bbc6 100644
--- a/arch/m68k/coldfire/m520x.c
+++ b/arch/m68k/coldfire/m520x.c
@@ -106,7 +106,7 @@ static struct clk * const disable_clks[] __initconst = {
 
 static void __init m520x_clk_init(void)
 {
-	unsigned i;
+	unsigned int i;
 
 	/* make sure these clocks are enabled */
 	for (i = 0; i < ARRAY_SIZE(enable_clks); ++i)
diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 100c05544c6a..fdac8a0cb75f 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -169,7 +169,7 @@ void q40_sched_init (void)
  *
 */
 
-struct IRQ_TABLE{ unsigned int mask; int irq ;};
+struct IRQ_TABLE{ unsigned int mask; int irq };
 #if 0
 static struct IRQ_TABLE iirqs[]={
   {Q40_IRQ_FRAME_MASK,Q40_IRQ_FRAME},
-- 
2.30.2

