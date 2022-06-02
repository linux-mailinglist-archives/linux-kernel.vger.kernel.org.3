Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079DA53B664
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiFBJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiFBJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:53:19 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F9F33E3E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 02:53:14 -0700 (PDT)
X-QQ-mid: bizesmtp86t1654163561tf6rfbf6
Received: from localhost.localdomain ( [117.176.187.31])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 02 Jun 2022 17:52:29 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: 7mv2T88v/OpM5Pi91uMmJzPlbWZZoGHBYo5xAVdo5omcyRlQ3IPYsnN7/hb3y
        afz9HpgUvpKAkW6dH/tnHXXAtGl3tFhMm1maWZzpb8x9xMe/RxTzlrcMkAIVznbtA1qUgyd
        j8+SzKXP6Zx7lqsdYg2O39K/Jm3ZJgVCqqC48cf6OOA5Th4MpYfkshKv3hlUdtugDdZ5oIE
        aXQAp4sayWwH97tW+wubJvKPfVs3b5XD+DLB/vKuD6g9Lmo95/aBJs6pxXX6+QyiSGoXSzd
        MpP1PVbx/HZYpvhwXMsOzyzVwmQRwszASpPmy5HsbtDXG/jZEm7gBliPYWJUnAUyw5cMqId
        RBHNv/l8jnZDsPRGOo=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] arm: Fix syntax errors in comments
Date:   Thu,  2 Jun 2022 17:52:28 +0800
Message-Id: <20220602095228.14791-1-wangxiang@cdjrlc.com>
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
 arch/arm/include/asm/unwind.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index b51f85417f58..5fc323586c7a 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according the ARM EABI documents */
 enum unwind_reason_code {
 	URC_OK = 0,			/* operation completed successfully */
 	URC_CONTINUE_UNWIND = 8,
-- 
2.36.1

