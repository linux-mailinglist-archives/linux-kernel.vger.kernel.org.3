Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC635A7688
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiHaG2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiHaG2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:28:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240DBD08D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:28:45 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661927313t6iknhwj
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:28:32 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: y0qVOEbMWtd4sUoroRd0eYw2vL3HGllKQl+V6JKpb2Ojby1TxdymGX3sxJv2O
        Ib6wYbCpavdfogf18RBUNEmDiYXExI2zo4nTfFYUo/ajh116L5kyKJNQwmnV2njtm6Ju13o
        0x/tQANPu0WrnZ07uY8bM+G81k/y11tMLULxF+M5H/Nb/q0yLB4C5K5fypqOImcr+fe0Qgp
        gXT33g4FVqCfmwi+FyVYqi6W8WStlkKgmrSXHFoSYlZXo8fRcrMPZLKD3qrFlKobFTDX3y8
        NSzlEukP9r9vpEag6bFkEe84wjLJZgJNcvNcS9IQi21aBuxh9uL3iN1/ZwLuExMQe5ijKfz
        S6mpHeIGpUb0lEP3PRveHUsSmb+vw2hEOosRiSQCfvri5wig14kFmVrEtCt3Q==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ARM: ux500: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:28:26 +0800
Message-Id: <20220831062826.11283-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/mach-ux500/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
index ff9c375e4277..505161bb8855 100644
--- a/arch/arm/mach-ux500/pm.c
+++ b/arch/arm/mach-ux500/pm.c
@@ -124,7 +124,7 @@ bool prcmu_pending_irq(void)
 }
 
 /*
- * This function checks if the specified cpu is in in WFI. It's usage
+ * This function checks if the specified cpu is in WFI. It's usage
  * makes sense only if the gic is decoupled with the db8500_prcmu_gic_decouple
  * function. Of course passing smp_processor_id() to this function will
  * always return false...
-- 
2.36.1

