Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085757C267
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiGUCpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGUCpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:45:24 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4713112AA2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 19:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Jvs/F
        ekoVyVZhM7qchxckpfuiLqSJtAEP+SAWLMykUI=; b=UiwxFEXVKdlBanHVbMmZ4
        0EWMP6chIpzzaemTPHyPqBY8e+2GHSlq43MXwxw5DQWgGdh5GMHtuqOoMevHZNOn
        nfANdnIpkw88b+vkwEqYYbiZ+qpyu/vfY8IU3qCjUJdM0mK4LMObluZmfub+1EZW
        MCVk6X4W0N70C/VEZgUEl8=
Received: from localhost.localdomain (unknown [223.104.68.243])
        by smtp11 (Coremail) with SMTP id D8CowAAHXgqHvdhi+eOZAA--.93S2;
        Thu, 21 Jul 2022 10:44:32 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] ARM: Fix typo in comment
Date:   Thu, 21 Jul 2022 10:44:22 +0800
Message-Id: <20220721024422.21629-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAHXgqHvdhi+eOZAA--.93S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15XFykAF15Xr4fKFW3Wrg_yoW8Kw13p3
        ykuw4vyrn5uFySg345J34Dur48Awn0qa15KrW0g34UAryrZ34kZF48trnrC3WDZ397Ca1r
        uryS9ryDWF1kWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEnmiZUUUUU=
X-Originating-IP: [223.104.68.243]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQhFZGBbEawkPwAAsB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 arch/arm/Kconfig                  | 4 ++--
 arch/arm/include/asm/unwind.h     | 2 +-
 arch/arm/mach-pxa/hx4700-pcmcia.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 35ef69fc2f3f..db124fdbb996 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1638,7 +1638,7 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 	bool "Extend with bootloader kernel arguments"
 	help
 	  The command-line arguments provided by the boot loader will be
-	  appended to the the device tree bootargs property.
+	  appended to the device tree bootargs property.
 
 endchoice
 
@@ -1796,7 +1796,7 @@ config DMI
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
2.25.1

