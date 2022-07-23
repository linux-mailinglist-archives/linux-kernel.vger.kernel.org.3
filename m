Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD457ED0C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiGWJZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiGWJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:25:51 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DC913D22
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 02:25:46 -0700 (PDT)
X-QQ-mid: bizesmtp72t1658568280tzvi1vyk
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 17:24:38 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: CR3LFp2JE4lL1GLCr4icph6+qQFBccuI/ZemMcyWA7bPB5CinROu62HTGBe+L
        RezNBmLkE2Kn831ezk3xivGhwn40wFxvvdawTQQ1vAW/7keeVRId81pC+TgaBC5Bz0DtpnX
        dk+wiaSta+Y2kedmDSMXUIafVbypCTjJeyAziMAxPjW7pS5qCvAzCGlF+nEXJ9cVzGut+wn
        aXonOGYNLKlMqb26Knki8ILjVmHV6QRgGRUTMD+5uhyMaak43bRvx127hZ+sV6SfN8dc8gX
        9TGUr3WgoF7rfZqCS21kGL92zLE6iUW+oZTQ0KS2iERrloNw5JnAXLV9ail3mRho/oFeVxZ
        SmHtC+mELLuBnr41bVzSqvK5FMF416bHdlsCFHcfpJXD7j26cv65hAD8mH+GAEhwQZlfyYs
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     paulus@samba.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        christophe.leroy@csgroup.eu, joel@jms.id.au, npiggin@gmail.com,
        hbathini@linux.ibm.com, lkp@intel.com, Julia.Lawall@inria.fr,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] powerpc: Remove the static variable initialisations to 0
Date:   Sat, 23 Jul 2022 17:24:36 +0800
Message-Id: <20220723092436.7149-1-wangborong@cdjrlc.com>
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

Initialise global and static variable to 0 is always unnecessary.
Remove the unnecessary initialisations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/kexec/core_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index c2bea9db1c1e..2407214e3f41 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -135,7 +135,7 @@ notrace void kexec_copy_flush(struct kimage *image)
 
 #ifdef CONFIG_SMP
 
-static int kexec_all_irq_disabled = 0;
+static int kexec_all_irq_disabled;
 
 static void kexec_smp_down(void *arg)
 {
-- 
2.35.1

