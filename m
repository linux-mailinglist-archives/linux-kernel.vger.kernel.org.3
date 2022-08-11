Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61958FC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiHKMTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiHKMTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:19:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E949923EC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:19:11 -0700 (PDT)
X-QQ-mid: bizesmtp78t1660220341t1bcf5z3
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:19:00 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: 7gMYdkq9aKh3mp00eEvh/xXEnIrbCIZ33GDkzrSNkWjJNedZfYCYg9fNt+zzf
        KLhuyyTL9U5L0WH7ekgjFD9JFH0ehNVG5iDwp1XYNgDlHJYdv2NcfrOeAwQ60MDMRfSQQHq
        qzvwW2HhV0KS/ab6rQqNqAHr+UDPXzKjXIyxEPLj4NiCQDuvSxwicaqW0dtz50TOTCVL63i
        8S2/pCtUtZtkCaxdyAehLxGumS/gEVz10hM0T+Wabql0fLzuNR3wVhnRd5thHPeqoDNbrej
        i/jvxqeH4gbB8DdJkWm83hLzUG/S1uYyPw8VDmfykdHDQUJMg8imH4U11+kbwuw3sstSSlo
        Vd2VnMTHmeYquHRmXxOjM4xZLRhrboXwcPCmJqbmoTcqhejymFrHHzgp1/pI49Sc0Hvbe3+
        9H71EqE2XVQ=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linus.walleij@linaro.org
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ARM: ux500: Fix comment typo
Date:   Thu, 11 Aug 2022 20:18:53 +0800
Message-Id: <20220811121853.27103-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `in' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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

