Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B604A578266
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiGRMfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiGRMfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:35:37 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F265C1;
        Mon, 18 Jul 2022 05:35:31 -0700 (PDT)
X-QQ-mid: bizesmtp65t1658147718tnnfcad5
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:35:16 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: DoD8xN2rKoy4KxEtW1/GxhANRbHFlo9pFXGP3x67oSPlCUa3hAjx41NXbAcY0
        Z11m4PtlKrEWfWciILzge3FQQ8oR90FjEGuvgK/Q4TinZ0ZmUZE+T98BeCWJqhnPoKzsguo
        bLcskR/g3GjNMXELuMAQgdp6ay/Ohrf1KjNN96LQjPKd+PHM3R8m1OQyBW9uZApcfDDMPcs
        KmrOkSCfkjUvt1mgR0Cb+5QRL0WbcRs6rbzE7cN3PJSNjDEKEE8lwlbEDIdjiVvVsL6N8Kj
        C60DnvyAxyP/idClq/a/5NMiFH6pzktNe0uALGG1BbRJq4k6Fp/hst4jHjLUfSwGmCpGRns
        FBKQLGgPtp5QYGQPMvs7FWQ4ZyL39KXTdolckF+GFHO1RogYsboG7BquHsu25MQLXMc3+2k
        0VOSyElFZwI=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ink@jurassic.park.msu.ru
Cc:     rth@twiddle.net, mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] alpha: Fix comment typo
Date:   Fri, 15 Jul 2022 12:33:04 +0800
Message-Id: <20220715043304.16551-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `and' is duplicated in line 150, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/alpha/kernel/irq_i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
index 1dcf0d9038fd..db574dcd6675 100644
--- a/arch/alpha/kernel/irq_i8259.c
+++ b/arch/alpha/kernel/irq_i8259.c
@@ -147,7 +147,7 @@ isa_no_iack_sc_device_interrupt(unsigned long vector)
 	 */
 	/* 
 	 *  The first read of gives you *all* interrupting lines.
-	 *  Therefore, read the mask register and and out those lines
+	 *  Therefore, read the mask register and out those lines
 	 *  not enabled.  Note that some documentation has 21 and a1 
 	 *  write only.  This is not true.
 	 */
-- 
2.35.1

