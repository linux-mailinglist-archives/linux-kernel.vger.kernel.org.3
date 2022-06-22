Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D702C554C20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357673AbiFVOEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiFVOEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:04:48 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B132F66B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:04:44 -0700 (PDT)
X-QQ-mid: bizesmtp79t1655906315t7m9cd90
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 21:58:31 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000B00A0000000
X-QQ-FEAT: eTtJes0duVtiagenvj6h5EHoH3+bpCWSfJ+9c57vDG73WyQb93c0oVI0STkaS
        ubkPgSL+uJw/jZ+9rrbBqEUT0QFBkZoAS/VKZ8XLYDo04KJmEOpA3tDQW3GR5d3YizHbyId
        WMAmZsGBWN0Ow/r2yAAaZEzd8wTXy3Z/++xxPMVSiEp/YiV/jueKA1tCanj/oHX/38RGaY2
        X8KlJk2I/ckg30gaUoqq5lAOXTfhSKTKUO/62b8YTZDHELwjv0gPaGGsL6wBKeR6BAgv7QY
        2aTWUCRuhjtHGOzX++Ywq1+Eeg4jUQLPcATJHljGcXVfCZCg6lxYWDya2oM1L+b8dHWNFDx
        VQi0bavIl4u6dEgjkhyvyWRpM39lz2h603FkzCS
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        aik@ozlabs.ru, christophe.leroy@csgroup.eu, farosas@linux.ibm.com,
        jiangjian@cdjrlc.com, dja@axtens.net,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: drop unexpected word 'and' in the comments
Date:   Wed, 22 Jun 2022 21:58:28 +0800
Message-Id: <20220622135828.4568-1-jiangjian@cdjrlc.com>
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

file: arch/powerpc/kernel/exceptions-64s.S
line: 2782

* - If it was a decrementer interrupt, we bump the dec to max and and return.

changed to:

* - If it was a decrementer interrupt, we bump the dec to max and return.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b66dd6f775a4..3d0dc133a9ae 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2779,7 +2779,7 @@ EXC_COMMON_BEGIN(soft_nmi_common)
 
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
- * - If it was a decrementer interrupt, we bump the dec to max and and return.
+ * - If it was a decrementer interrupt, we bump the dec to max and return.
  * - If it was a doorbell we return immediately since doorbells are edge
  *   triggered and won't automatically refire.
  * - If it was a HMI we return immediately since we handled it in realmode
-- 
2.17.1

