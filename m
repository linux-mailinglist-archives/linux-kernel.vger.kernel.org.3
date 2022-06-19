Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D95507FE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiFSDL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSDLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:11:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034DE65E6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 20:11:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 68so1896015pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBakpvac0Bjkh+1/ThELj1/wzKw0fOxlqJA4HwHF5Ys=;
        b=aUE+gbedStapVwsEM+vW4y5uYUJBI1ecVnSV8OYPMmGRMot38U/fXMV91JvkYEl+Tu
         EWB5VUlLdgLv9RppHMUTFutz2QJ2HSrR5td73uyjjWBmnAiU00BllkC0GaYafanl7aM3
         wdVUyE65oFCrU1S1eTUpAz4Q6s8MMSQ/t62SCDg0TGoo1Ndg5UqBKUobMeaXG1UtrTWP
         e2pwGUBl6C/UEE4QRJWVJ04l1NX932TyK5F0F2A2NLCz/4ssyUBejFODzK39bwnAq0tg
         T0NnIjR5C5Z1l9zQ4cbOf0ilZRuyvrhdqgntM+xZGTAPnSzJLwe576GJMdKiDgma+nvT
         CVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBakpvac0Bjkh+1/ThELj1/wzKw0fOxlqJA4HwHF5Ys=;
        b=2XCGwQWVFqk9BSPKbBeu8QJLUogPltETKXgbvBarDo2E+IV19AccpUMHr6nhDfiG9O
         7qFycznFwNzDYerBl3afZ8mL8hU7aNmQAdwfhnlVNN4j2bqy0UNC7qnHxxVSq/0iqqrA
         ENc1D13iPxBDkSh03ma8td7jCXJhom1uqgsnj2f5cuZcfoUvufqcgROPtgkBKE+Jm+FG
         MK0ODrCRmaJQpGZ0FzdZLSqmz+/nujate5A8YReOT2wNmBxsrtip0RkIb16R8eMiTaSm
         PXuntAEpLGS7S72VsbOnHk18Z4nAu31IdeY3RsfJIO7dFf6bcRBsQNBsZnM5tLnT49cf
         niww==
X-Gm-Message-State: AJIora8whr1dfcPT5I9ptQQj+gnYLngzW6/7sat4B5S9fbgisN6XXN08
        mwrpj/K6BTkC7cnqhfI4y00=
X-Google-Smtp-Source: AGRyM1sKcMswpbR7PEqtVuaVGvkgXohXNUj8lxi/ii2fqU2OlJfC6JQncxRtlfHLI1dfUeJGj+vsgQ==
X-Received: by 2002:a63:3f05:0:b0:40c:25d6:6126 with SMTP id m5-20020a633f05000000b0040c25d66126mr13423080pga.347.1655608283446;
        Sat, 18 Jun 2022 20:11:23 -0700 (PDT)
Received: from localhost.localdomain ([122.167.211.160])
        by smtp.gmail.com with ESMTPSA id ix6-20020a170902f80600b001615f64aaabsm5957938plb.244.2022.06.18.20.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:11:23 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        mark.rutland@arm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        Kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/interrupt: Put braces around empty body in an 'if' statement
Date:   Sun, 19 Jun 2022 08:41:14 +0530
Message-Id: <20220619031114.92060-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot throws warning ->

arch/powerpc/kernel/interrupt.c:
In function 'interrupt_exit_kernel_prepare':

>> arch/powerpc/kernel/interrupt.c:542:55: warning: suggest
braces around empty body in an 'if' statement [-Wempty-body]
     542 |                 CT_WARN_ON(ct_state() == CONTEXT_USER);

Fix it by adding braces.

Reported-by: Kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 784ea3289c84..b8a918bab48f 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -538,8 +538,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 	 * CT_WARN_ON comes here via program_check_exception,
 	 * so avoid recursion.
 	 */
-	if (TRAP(regs) != INTERRUPT_PROGRAM)
+	if (TRAP(regs) != INTERRUPT_PROGRAM) {
 		CT_WARN_ON(ct_state() == CONTEXT_USER);
+	}
 
 	kuap = kuap_get_and_assert_locked();
 
-- 
2.25.1

