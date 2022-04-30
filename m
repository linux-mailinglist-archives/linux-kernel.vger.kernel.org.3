Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00931515FF8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbiD3TKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiD3TKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:10:48 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DCB8E1AA;
        Sat, 30 Apr 2022 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8DTrblqO8J3paPSDxJvJXQCLzUNcAKq9ZyxmqPsm0+A=;
  b=RGm5RjvmrcjgEkV06vTcWvy2eiN3fVg/IVMEgE1C9fo7xQqUngSZpXCw
   BDXlPqbLdynn+MhaLjI6Do692PaD+Yn4weCR4Ve37/tCKb3eoeq00YgVu
   yr24SCLiNrwwprip40K2xlm4LBsvVKB3w6awL7SDQ9Rrdc1D0n9HYTyeU
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,188,1647298800"; 
   d="scan'208";a="12857821"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:07:23 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Helge Deller <deller@gmx.de>
Cc:     kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: fix typos in comments
Date:   Sat, 30 Apr 2022 21:07:18 +0200
Message-Id: <20220430190718.8046-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/parisc/kernel/kprobes.c |    2 +-
 arch/parisc/kernel/time.c    |    2 +-
 arch/parisc/kernel/traps.c   |    2 +-
 arch/parisc/math-emu/dfadd.c |    2 +-
 arch/parisc/math-emu/dfsub.c |    2 +-
 arch/parisc/math-emu/sfadd.c |    2 +-
 arch/parisc/math-emu/sfsub.c |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/kernel/kprobes.c b/arch/parisc/kernel/kprobes.c
index 3343d2fb7889..6e0b86652f30 100644
--- a/arch/parisc/kernel/kprobes.c
+++ b/arch/parisc/kernel/kprobes.c
@@ -152,7 +152,7 @@ int __kprobes parisc_kprobe_ss_handler(struct pt_regs *regs)
 	/* for absolute branch instructions we can copy iaoq_b. for relative
 	 * branch instructions we need to calculate the new address based on the
 	 * difference between iaoq_f and iaoq_b. We cannot use iaoq_b without
-	 * modificationt because it's based on our ainsn.insn address.
+	 * modifications because it's based on our ainsn.insn address.
 	 */
 
 	if (p->post_handler)
diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index bb27dfeeddfc..cafd3ad20272 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -251,7 +251,7 @@ void __init time_init(void)
 static int __init init_cr16_clocksource(void)
 {
 	/*
-	 * The cr16 interval timers are not syncronized across CPUs, even if
+	 * The cr16 interval timers are not synchronized across CPUs, even if
 	 * they share the same socket.
 	 */
 	if (num_online_cpus() > 1 && !running_on_qemu) {
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index a6e61cf2cad0..b78f1b9d45c1 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -469,7 +469,7 @@ void parisc_terminate(char *msg, struct pt_regs *regs, int code, unsigned long o
 	 * panic notifiers, and we should call panic
 	 * directly from the location that we wish. 
 	 * e.g. We should not call panic from
-	 * parisc_terminate, but rather the oter way around.
+	 * parisc_terminate, but rather the other way around.
 	 * This hack works, prints the panic message twice,
 	 * and it enables reboot timers!
 	 */
diff --git a/arch/parisc/math-emu/dfadd.c b/arch/parisc/math-emu/dfadd.c
index ec487e07f004..00e561d4aa55 100644
--- a/arch/parisc/math-emu/dfadd.c
+++ b/arch/parisc/math-emu/dfadd.c
@@ -253,7 +253,7 @@ dbl_fadd(
 	    return(NOEXCEPTION);
 	    }
 	right_exponent = 1;	/* Set exponent to reflect different bias
-				 * with denomalized numbers. */
+				 * with denormalized numbers. */
 	}
     else
 	{
diff --git a/arch/parisc/math-emu/dfsub.c b/arch/parisc/math-emu/dfsub.c
index c4f30acf2d48..4f03782284bd 100644
--- a/arch/parisc/math-emu/dfsub.c
+++ b/arch/parisc/math-emu/dfsub.c
@@ -256,7 +256,7 @@ dbl_fsub(
 	    return(NOEXCEPTION);
 	    }
 	right_exponent = 1;	/* Set exponent to reflect different bias
-				 * with denomalized numbers. */
+				 * with denormalized numbers. */
 	}
     else
 	{
diff --git a/arch/parisc/math-emu/sfadd.c b/arch/parisc/math-emu/sfadd.c
index 838758279d5b..9b98c874dfac 100644
--- a/arch/parisc/math-emu/sfadd.c
+++ b/arch/parisc/math-emu/sfadd.c
@@ -249,7 +249,7 @@ sgl_fadd(
 	    return(NOEXCEPTION);
 	    }
 	right_exponent = 1;	/* Set exponent to reflect different bias
-				 * with denomalized numbers. */
+				 * with denormalized numbers. */
 	}
     else
 	{
diff --git a/arch/parisc/math-emu/sfsub.c b/arch/parisc/math-emu/sfsub.c
index 583d3ace4634..29d9eed09d12 100644
--- a/arch/parisc/math-emu/sfsub.c
+++ b/arch/parisc/math-emu/sfsub.c
@@ -252,7 +252,7 @@ sgl_fsub(
 	    return(NOEXCEPTION);
 	    }
 	right_exponent = 1;	/* Set exponent to reflect different bias
-				 * with denomalized numbers. */
+				 * with denormalized numbers. */
 	}
     else
 	{

