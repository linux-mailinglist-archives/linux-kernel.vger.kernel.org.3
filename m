Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13B757B56A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiGTL2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbiGTL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:27:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA986D9EB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:27:42 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:27:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658316461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31EwgTSePEz//oaaW/kXUV7zURoej0/Uw2BQxz2bIgU=;
        b=VebiumLGMdO9dTP2oHSfP8beuVNsGYNl1i0qT/iRJv9io1zKV6uAjmYxMV+7S36ND9V98v
        cTbXU3QHQvN5/5wTwgqtX3RsMynXokDls/wiqV3lOnZ0UKLFQoWoPZ5Vuw83KLVjbwX1/u
        F4hisEzAphWDcGliKSBwtbG6p1jyJ4O+U8gXxREwaBN8kS6Nrit3EmnUAbW5WiN3u7Wku0
        sKTw+HOmD82FWA47Y1Zdl3P8A45c4URViyJQDK6V5G/yZUYwjadzUmN8BEokzLlMekthrm
        5MSRfbkPAFPuogIq/1Sh9PfWnaUt2sZCT3Fivyi/VLROkBzatl5eMu0SF1UTDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658316461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31EwgTSePEz//oaaW/kXUV7zURoej0/Uw2BQxz2bIgU=;
        b=scPm8djTkLHHF2WvvWkv4vDAmMyNPlJM8sJfQ54KKe1m5JUBn5RHS4JYgDDhd0lLHMDH/X
        eQEqm7kR8iCrsuCQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] LoongArch: Provisionally add ACPICA data
 structures
Cc:     Marc Zyngier <maz@kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>,
        tglx@linutronix.de
In-Reply-To: <1658314292-35346-2-git-send-email-lvjianmin@loongson.cn>
References: <1658314292-35346-2-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <165831646020.15455.7763056129914310016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     af6a1cfa6859dab4a843ea07f1c2f04938f1715b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/af6a1cfa6859dab4a843ea07f1c2f04938f1715b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 20 Jul 2022 18:51:20 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 12:05:17 +01:00

LoongArch: Provisionally add ACPICA data structures

The LoongArch architecture is using ACPI, but the spec containing
the required updates still is in an unreleased state.

Instead of preventing the inclusion of the IRQ support into the
kernel, add the missing bits to the arch-specific parts of
the ACPICA support.

Once the ACPICA bits are updated to the version that supports
LoongArch, these bits can eventually be removed.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Link: https://lore.kernel.org/r/1658314292-35346-2-git-send-email-lvjianmin@loongson.cn
---
 arch/loongarch/include/asm/acpi.h | 142 +++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+)

diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 62044cd..c510821 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -31,6 +31,148 @@ static inline bool acpi_has_cpu_in_madt(void)
 
 extern struct list_head acpi_wakeup_device_list;
 
+/*
+ * Temporary definitions until the core ACPICA code gets updated (see
+ * 1656837932-18257-1-git-send-email-lvjianmin@loongson.cn and its
+ * follow-ups for the "rationale").
+ *
+ * Once the "legal reasons" are cleared and that the code is merged,
+ * this can be dropped entierely.
+ */
+#if (ACPI_CA_VERSION == 0x20220331 && !defined(LOONGARCH_ACPICA_EXT))
+
+#define LOONGARCH_ACPICA_EXT	1
+
+#define	ACPI_MADT_TYPE_CORE_PIC		17
+#define	ACPI_MADT_TYPE_LIO_PIC		18
+#define	ACPI_MADT_TYPE_HT_PIC		19
+#define	ACPI_MADT_TYPE_EIO_PIC		20
+#define	ACPI_MADT_TYPE_MSI_PIC		21
+#define	ACPI_MADT_TYPE_BIO_PIC		22
+#define	ACPI_MADT_TYPE_LPC_PIC		23
+
+/* Values for Version field above */
+
+enum acpi_madt_core_pic_version {
+	ACPI_MADT_CORE_PIC_VERSION_NONE = 0,
+	ACPI_MADT_CORE_PIC_VERSION_V1 = 1,
+	ACPI_MADT_CORE_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lio_pic_version {
+	ACPI_MADT_LIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_LIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_LIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_eio_pic_version {
+	ACPI_MADT_EIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_EIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_EIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_ht_pic_version {
+	ACPI_MADT_HT_PIC_VERSION_NONE = 0,
+	ACPI_MADT_HT_PIC_VERSION_V1 = 1,
+	ACPI_MADT_HT_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_bio_pic_version {
+	ACPI_MADT_BIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_BIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_BIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_msi_pic_version {
+	ACPI_MADT_MSI_PIC_VERSION_NONE = 0,
+	ACPI_MADT_MSI_PIC_VERSION_V1 = 1,
+	ACPI_MADT_MSI_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lpc_pic_version {
+	ACPI_MADT_LPC_PIC_VERSION_NONE = 0,
+	ACPI_MADT_LPC_PIC_VERSION_V1 = 1,
+	ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+#pragma pack(1)
+
+/* Core Interrupt Controller */
+
+struct acpi_madt_core_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u32 processor_id;
+	u32 core_id;
+	u32 flags;
+};
+
+/* Legacy I/O Interrupt Controller */
+
+struct acpi_madt_lio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[2];
+	u32 cascade_map[2];
+};
+
+/* Extend I/O Interrupt Controller */
+
+struct acpi_madt_eio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 cascade;
+	u8 node;
+	u64 node_map;
+};
+
+/* HT Interrupt Controller */
+
+struct acpi_madt_ht_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[8];
+};
+
+/* Bridge I/O Interrupt Controller */
+
+struct acpi_madt_bio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u16 id;
+	u16 gsi_base;
+};
+
+/* MSI Interrupt Controller */
+
+struct acpi_madt_msi_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 msg_address;
+	u32 start;
+	u32 count;
+};
+
+/* LPC Interrupt Controller */
+
+struct acpi_madt_lpc_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade;
+};
+
+#pragma pack()
+
+#endif
+
 #endif /* !CONFIG_ACPI */
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
