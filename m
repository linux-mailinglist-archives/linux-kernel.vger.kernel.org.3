Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170E55549D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiFVMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243716AbiFVMQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:16:45 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991383D482
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:16:37 -0700 (PDT)
X-QQ-mid: bizesmtp80t1655900185tjv9mfxl
Received: from ubuntu.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 20:16:21 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8eNRc6LoVbd8diuEGcYexDvpPzXtcbLFF5CF2z03xtRuZyndWyz4
        oyvWu7GZ0JEPtFyn2kMI/3K061US4zBX6B1Ul+J+qQ/He3n6ZwOPn/2GddDHa9gGb9aNp9b
        sn9cXopr1iLpDFbdC0ixcsYOhhqVJ6j2y7JS7uZKnEy+/nAgwYm7jqvW/ulcAGz/KhD9zuk
        bD/3Mp3wmGTp4179mEAj1wKe/EWLgm8ThwViPcWcrvpJC/XO/WNcLom6JMxI2/mBx7TS+be
        Uvpn6JCSSfAcNxCEZr+gEgg3CcPgxQ+8kFbSG9p6izMDvIad4+TrYpi8V/fZaeKJj5k3sSM
        VjF3wKMWA99CHAT7/6uh3Jkz42d/Q==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, jiangjian@cdjrlc.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ptrace: drop unexpected word 'and' in the comments
Date:   Wed, 22 Jun 2022 20:16:16 +0800
Message-Id: <20220622121616.16243-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'and' in the comments that need to be dropped

file & line:
arch/powerpc/kernel/ptrace/ptrace-vsx.c:74:

* Currently to set and and get all the vsx state, you need to call
changed to:
* Currently to set and get all the vsx state, you need to call

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/powerpc/kernel/ptrace/ptrace-vsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace-vsx.c b/arch/powerpc/kernel/ptrace/ptrace-vsx.c
index 1da4303128ef..7df08004c47d 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-vsx.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-vsx.c
@@ -71,7 +71,7 @@ int fpr_set(struct task_struct *target, const struct user_regset *regset,
 }
 
 /*
- * Currently to set and and get all the vsx state, you need to call
+ * Currently to set and get all the vsx state, you need to call
  * the fp and VMX calls as well.  This only get/sets the lower 32
  * 128bit VSX registers.
  */
-- 
2.17.1

