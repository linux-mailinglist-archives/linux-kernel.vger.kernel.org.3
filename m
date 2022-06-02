Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696353B64E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiFBJnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFBJns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:43:48 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097161CF90E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 02:43:43 -0700 (PDT)
X-QQ-mid: bizesmtp75t1654162988tlh0cgn9
Received: from localhost.localdomain ( [117.176.187.31])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 02 Jun 2022 17:43:01 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: Lg5IqoGaTUj1+eGfn8AVxxtWBKyAxdcou0v03CZgNghMJAYAIPPpV3JuOv1NJ
        RPpL3Zwe766SjvVV2c95dRRgBOSgbo+4j1X/+Qtg5H25bvrLzm2BnvoL/MYw8rglA8VbUwn
        b4Swez1TfZDl987MVEhXBrpX2m5qJwZFL+QD97bNhh42ffmO3v8pOz5qgEpY4YcT/eCJK1m
        AAmpIGSqugi1gIUkXXcvD4iPW5WG10CHBp6G8wVUzVS28mJdthGFq+B9Q9Jc2o8qovS1cuw
        QOvU3hMtfUjz2mOA4CGXoiD/SST7HPxsrOad+8PLAHeyp/O4iSaGxhUpnK04PIe5EjOlnBb
        zJ+Az7YKuySOV29iYs=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     nsekhar@ti.com
Cc:     brgl@bgdev.pl, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] ARM: davinci: Fix syntax errors in comments
Date:   Thu,  2 Jun 2022 17:42:48 +0800
Message-Id: <20220602094248.13625-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 9adcb5879d14..87bbc36ca5ef 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -535,7 +535,7 @@ static struct vpbe_enc_mode_info dm365evm_enc_preset_timing[] = {
 #define VENC_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
 
 /*
- * The outputs available from VPBE + ecnoders. Keep the
+ * The outputs available from VPBE + ecnoders. Keep
  * the order same as that of encoders. First those from venc followed by that
  * from encoders. Index in the output refers to index on a particular
  * encoder.Driver uses this index to pass it to encoder when it supports more
-- 
2.36.1

