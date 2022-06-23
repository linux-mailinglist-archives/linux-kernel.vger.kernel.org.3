Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76B55735D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiFWGxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiFWGxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:53:42 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5477B403E4;
        Wed, 22 Jun 2022 23:53:37 -0700 (PDT)
X-QQ-mid: bizesmtp85t1655967066tj9ejmus
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 14:51:02 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: +WEp/E361GYblO3/pc21UvtZ6OSjDDsc4dVnCkwgklXM7iPTSrfatF6bfod4p
        aXkoJT/uOmmkgmA+xPzNlGri1+Sg7xxrkDb1cui1pRjZ9zhjAF4+r4Jccc+e9pJur5LkWQj
        z8qGO/loMcNpZKLoLdJHYyjZMuvXSFFRf0DebjAKxwvWfcn3Yvwk1YuMcSywWlaH6NGhfzp
        5ZrOFJN/H89oXYoZTrXPxp7FYRZ+exRBGwiPrcQfXM0Vic428NDqiydgXMJMiBZI4qQwS2C
        FwRVM5rw0JUmf8EuEQo4TjdxDZkZqKqbLqrN4NGdoNC3s7HWur6lZkllBngcgehIgbbz/Vj
        KAqj/SGv7smRyoipas=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     bcain@quicinc.com
Cc:     ebiederm@xmission.com, nathan@kernel.org, mpe@ellerman.id.au,
        keescook@chromium.org, wangkefeng.wang@huawei.com,
        jiangjian@cdjrlc.com, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hexagon: drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 14:51:00 +0800
Message-Id: <20220623065100.8268-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'a' in the comments that need to be dropped

file - arch/hexagon/kernel/traps.c
line - 262

* Precise bus errors may be recoverable with a a retry,

changed to:

* Precise bus errors may be recoverable with a retry,

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6447763ce5a9..a1f1085887aa 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -259,7 +259,7 @@ static void illegal_instruction(struct pt_regs *regs)
 }
 
 /*
- * Precise bus errors may be recoverable with a a retry,
+ * Precise bus errors may be recoverable with a retry,
  * but for now, treat them as irrecoverable.
  */
 static void precise_bus_error(struct pt_regs *regs)
-- 
2.17.1

