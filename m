Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1EF554898
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiFVJQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiFVJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:16:11 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A1DF61
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:16:07 -0700 (PDT)
X-QQ-mid: bizesmtp87t1655889299tll4wh1k
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 17:14:51 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: dpyQmELDBxHCWtPo1ikKZ0kQ0LupjxvcLzQESGpcA3n9BCLNPevSMMLohT8/q
        Isz62sRowKrAub4/Oav2jJZ1hTzpqjC7+B9ixzdqt9JatjjIo8hx+moVo9u7GiCc2B6ySgU
        ch1SCsAvXz3am6mGXp/GpQsZC+scVFVqj1aArH/4dRhOBduoAGxht2QNDidTvw+o9rCJIR9
        tUI3GYblz4ppwVvigpgYt8YhucFf2exJrsIYOu83wN5sxmoedNWGP3vw3SuA/oNXpSyp9DG
        ASFe7w9RxPsCzsqGtNHmNRzAAY2XyFKnqrV0CJ8WncE2w8AjJFocvu5gPtcMMFPKWua/0E2
        4YAzi3NFXHrGBFL6THKvBbQdb12AQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     broonie@kernel.org, maz@kernel.org, bigeasy@linutronix.de,
        geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] arm64:kernel:Fix typo in comment
Date:   Wed, 22 Jun 2022 17:14:43 +0800
Message-Id: <20220622091443.51062-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm64/kernel/fpsimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 819979398127..f1d476fa50a9 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -331,7 +331,7 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
  *    trapping to the kernel.
  *
  *    When stored, Z0-Z31 (incorporating Vn in bits[127:0] or the
- *    corresponding Zn), P0-P15 and FFR are encoded in in
+ *    corresponding Zn), P0-P15 and FFR are encoded in
  *    task->thread.sve_state, formatted appropriately for vector
  *    length task->thread.sve_vl or, if SVCR.SM is set,
  *    task->thread.sme_vl.
-- 
2.36.1

