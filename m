Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470CD53B5AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiFBJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiFBJFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:05:33 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592222A7AA3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 02:05:27 -0700 (PDT)
X-QQ-mid: bizesmtp74t1654160624t6oe71rk
Received: from localhost.localdomain ( [117.176.187.31])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 02 Jun 2022 17:03:37 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000000A0000000
X-QQ-FEAT: ipjz9r0KCw46HErCwIHeHJtjVzdYPfSfvP6XyxJ6zNiZ0jh12TySssVwsJ5Xt
        MfsfJFOTx7LyJDdoQ59yHPHR0nCMWM3Tl/W/SRjzJrrwqPZOtotlptCF2k8qeUSMQhVTy95
        1FR8w8Zg8Bw3wU3I6zB0bvxhd1rtqye7jN9/XbPl+fawsGKlHNvJ+GV47JRdN6S8AcVD5Ye
        N3NoLZx2qj6hBkI/Nvo7Q/vZHggVLm2NY6Se8CG/hVZ8bnvC36S/2I+jUoyK2G7EStmFYEA
        4p1ADDqlr7bFhONYOitQpI7JRJTO9Le0f9fbXfKN7FhRpGnrkI5aGWCMI2VA+Rrb1Et09FO
        dCMXBmYmxhRAEC1nQzUHVEipi0q3g==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     nsekhar@ti.com
Cc:     brgl@bgdev.pl, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] ARM: davinci: Fix syntax errors in comments
Date:   Thu,  2 Jun 2022 17:03:35 +0800
Message-Id: <20220602090335.13104-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index f7c56f662d4c..e56f8ea5eb56 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -294,7 +294,7 @@ static struct vpbe_enc_mode_info dm355evm_enc_preset_timing[] = {
 #define VENC_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
 
 /*
- * The outputs available from VPBE + ecnoders. Keep the
+ * The outputs available from VPBE + ecnoders. Keep
  * the order same as that of encoders. First those from venc followed by that
  * from encoders. Index in the output refers to index on a particular encoder.
  * Driver uses this index to pass it to encoder when it supports more than
-- 
2.36.1

