Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554E85A255B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbiHZKCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343551AbiHZKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:20 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89296D87E9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx304.security-mail.net (Postfix) with ESMTP id C6676627E2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508074;
        bh=zPiuLmkBvrE9gNyds2FdhvvxO2NhLocol7hPD7SCqjc=;
        h=From:To:Cc:Subject:Date;
        b=3KySO66EBKos31lRAzoehuM9rIqve8i9fwttNUXPpw5Pd07QMnJyZDvRrMkPRxiNH
         QWisWub2/oo5O9Q2wiwxUzd3Sf+r2OuH870cboDCC53nVgDmq21f+YQZwURfVX7Nuf
         pyTjVRyfQGwDFizrLoeqhUpd0F8L/84kQ/S8G2oE=
Received: from fx304 (localhost [127.0.0.1])
        by fx304.security-mail.net (Postfix) with ESMTP id 710A36273B;
        Fri, 26 Aug 2022 12:01:14 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <b01e.630899e9.ed9f2.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx304.security-mail.net (Postfix) with ESMTPS id EE115627BC;
        Fri, 26 Aug 2022 12:01:13 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id D2BAF27E0396;
        Fri, 26 Aug 2022 12:01:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id BCB9E27E0392;
        Fri, 26 Aug 2022 12:01:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu BCB9E27E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508072;
        bh=IkfsX32OzPGlUwQqHuM2c7LduVbNSM/5tgddX+vf+c4=;
        h=From:To:Date:Message-Id;
        b=H/hNnkGw129zkHzW5411T9xglnGpap8ThLMJlavC3rhVSP3CqQioZeJHxsvA+EQHV
         2BACI+v7uS/EMTVpGgrHuVgexu0XfalYF0IhDQTct0wMRio5JkqrlPKLomnVz+eAQd
         1I7YOHmc3auIgCna9XinAPC8WBjbQPqyDK7a1E9E=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gy2FuiwpetCd; Fri, 26 Aug 2022 12:01:12 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id A265927E02FA;
        Fri, 26 Aug 2022 12:01:12 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:39 +0200
Message-Id: <20220826100052.22945-11-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 arch/arm/Kconfig                  | 4 ++--
 arch/arm/include/asm/unwind.h     | 2 +-
 arch/arm/mach-pxa/hx4700-pcmcia.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..9f0e37bd36e0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1654,7 +1654,7 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 	bool "Extend with bootloader kernel arguments"
 	help
 	  The command-line arguments provided by the boot loader will be
-	  appended to the the device tree bootargs property.
+	  appended to the device tree bootargs property.
 
 endchoice
 
@@ -1812,7 +1812,7 @@ config DMI
 	  continue to boot on existing non-UEFI platforms.
 
 	  NOTE: This does *NOT* enable or encourage the use of DMI quirks,
-	  i.e., the the practice of identifying the platform via DMI to
+	  i.e., the practice of identifying the platform via DMI to
 	  decide whether certain workarounds for buggy hardware and/or
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index b51f85417f58..5fc323586c7a 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according the ARM EABI documents */
 enum unwind_reason_code {
 	URC_OK = 0,			/* operation completed successfully */
 	URC_CONTINUE_UNWIND = 8,
diff --git a/arch/arm/mach-pxa/hx4700-pcmcia.c b/arch/arm/mach-pxa/hx4700-pcmcia.c
index e2331dfe427d..860b78aed18c 100644
--- a/arch/arm/mach-pxa/hx4700-pcmcia.c
+++ b/arch/arm/mach-pxa/hx4700-pcmcia.c
@@ -30,7 +30,7 @@ static int hx4700_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	/*
 	 * IRQ type must be set before soc_pcmcia_hw_init() calls request_irq().
 	 * The asic3 default IRQ type is level trigger low level detect, exactly
-	 * the the signal present on GPIOD4_CF_nCD when a CF card is inserted.
+	 * the signal present on GPIOD4_CF_nCD when a CF card is inserted.
 	 * If the IRQ type is not changed, the asic3 interrupt handler will loop
 	 * repeatedly because it is unable to clear the level trigger interrupt.
 	 */
-- 
2.17.1

