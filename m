Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2599753BDB8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiFBSD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbiFBSD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:03:26 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8CF207ED0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:03:17 -0700 (PDT)
X-QQ-mid: bizesmtp91t1654192965t90i47mj
Received: from localhost.localdomain ( [117.176.187.31])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Jun 2022 02:02:29 +0800 (CST)
X-QQ-SSF: 01000000000000B0G000B00A0000000
X-QQ-FEAT: 78zNK54033IVh/sGkzMPH5AfojLqoVOBle/Acwcv1UNyhgdKMA0Nw8r05ETkz
        roowVXJJAtQ3nXkhofa/+qY0i5ELLk/GcOuXMzSUL0Bu0YJ5CdBJlsE4QD1BeS6KPT4Rd8+
        dj2xl32lDLp84O7kv8Qr4C+bz1tNhShbjcr7aj37qj+O1xZJBbMb+GdeSE5OhF7BxQ7S/FV
        YFfMLb9lmKAHeVW6u0LEVBrIT0pjeroODfDr7nqINYkECANFedoX1LgwSVQstIthXp9tcZ0
        iytwDdcjYc46+hvf12n7cG6TPhPhGaAxVkRrQyXew7DgasB9lzxpKT358=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] arm64: hibernate: Fix syntax errors in comments
Date:   Fri,  3 Jun 2022 02:02:28 +0800
Message-Id: <20220602180228.4259-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/arm64/kernel/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 6328308be272..2e248342476e 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -427,7 +427,7 @@ int swsusp_arch_resume(void)
 		return rc;
 
 	/*
-	 * We need a zero page that is zero before & after resume in order to
+	 * We need a zero page that is zero before & after resume in order
 	 * to break before make on the ttbr1 page tables.
 	 */
 	zero_page = (void *)get_safe_page(GFP_ATOMIC);
-- 
2.36.1

