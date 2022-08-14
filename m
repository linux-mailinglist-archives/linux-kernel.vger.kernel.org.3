Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1C591F52
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 11:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiHNJkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 05:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 05:40:01 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF175186EE
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 02:39:59 -0700 (PDT)
X-QQ-mid: bizesmtp69t1660469989t2nfg6p0
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 14 Aug 2022 17:39:48 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: ThitmV5dBHUWvgTGemLqdruU2HhCwDaB/lvYalANNNO5Cg1Sw6QRBScwgjL1f
        TpvL+PJeD3UqUVQaFt5bTEfY04iRSACe8AT4y/BwoP06UIi2a1IgBlgzQR5+ro4+DZIRZzo
        kg/3aJ2bog0pGTbFd822JsOUyoMqYm4ewlaUBcMvdoP5icfhWwGYt3Zkxqyb5tqbmvHXpl/
        fhn6zqQZ/KVzCor6jhLwjZJNvOLiOzlEqdRQBnpHgCotLsxCHuesex1nH/ZZIq8P171ix5a
        gZEEkAk37uYsh4H484F/64b1DUDaATvN0hOpQuZ8Q1vSG8knIM7O/XnhBMZj969yiJQr/58
        LsTzuuL/yz6X3hk5ZUbi8O5m8MilZLZXFf1Tzsvo9j91HVgmFo=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] kernel: fix repeated words in comments
Date:   Sun, 14 Aug 2022 17:39:41 +0800
Message-Id: <20220814093941.63227-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'doesn't'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index f3a2abd6d1a1..00d6e5130c24 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1858,7 +1858,7 @@ void __audit_free(struct task_struct *tsk)
 
 	/* We are called either by do_exit() or the fork() error handling code;
 	 * in the former case tsk == current and in the latter tsk is a
-	 * random task_struct that doesn't doesn't have any meaningful data we
+	 * random task_struct that doesn't have any meaningful data we
 	 * need to log via audit_log_exit().
 	 */
 	if (tsk == current && !context->dummy) {
-- 
2.36.1

