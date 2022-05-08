Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4D51EB16
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 04:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442529AbiEHCsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 22:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiEHCsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 22:48:00 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B91CF6;
        Sat,  7 May 2022 19:44:08 -0700 (PDT)
X-QQ-mid: bizesmtp84t1651977835toz3i6hn
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 10:43:53 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000B00A0000000
X-QQ-FEAT: ddlUhmC0HYv31os6JCMuyNg6UWY11sUcY1bEz988HHnpUOW5ZTfNwv4ebUPFd
        SP1IpQu6703GBlH5R56FhyGgR/ZxscS0NQ54nbH7Tov+Z96PQG6R4SaWT2OjPrEp0BlBgvn
        KxAUO0fIJWL5y/rob+5qUS6t3lZMRdQrpesNWN2KpmguJpfb/zT7xQ/dkDAuVqItxUAxsX1
        Ccl3qYe1Puls4NejOU4yzDL2pQiibpeM99jyQA8pujRgM1lQ+Vzi/eH6uHUOGUgDXVkd0Sw
        zmyLGN+2uAD3rNSHvEHtz2EbqufN2GjuedWgX1Rk4ViJb9TgLMpb8o9avxSs9kjiOCx27/v
        w3lZMIpSP1twZ4rq44=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     wangborong@cdjrlc.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sparc32: srmmu: Fix typo in a comment
Date:   Sun,  8 May 2022 10:43:51 +0800
Message-Id: <20220508024351.110391-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `hush' in the comment in line 1186 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/sparc/mm/srmmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index a9aa6a92c7fe..da6fd141662b 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1183,7 +1183,7 @@ static void __init init_swift(void)
 		srmmu_modtype = Swift_lots_o_bugs;
 		hwbug_bitmask |= (HWBUG_KERN_ACCBROKEN | HWBUG_KERN_CBITBROKEN);
 		/*
-		 * Gee george, I wonder why Sun is so hush hush about
+		 * Gee george, I wonder why Sun is so hush about
 		 * this hardware bug... really braindamage stuff going
 		 * on here.  However I think we can find a way to avoid
 		 * all of the workaround overhead under Linux.  Basically,
-- 
2.35.1

