Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29774E2E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351462AbiCUQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351472AbiCUQxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:53:36 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E4C17708B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:52:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2696832004ED;
        Mon, 21 Mar 2022 12:52:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Mar 2022 12:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=rr03hFF2bNF2sz
        Mfr4QL+Usn5E1acu59izxNNk0mufA=; b=fGhrsuc/rO74iNobTJtrnOJTvJW6eO
        bsrdOUyBfe/pc7HzfL9tWgdbZz5aP00ujEktoe69QwdTSoI5steIUpe9vKf4x+BB
        cNxPfDRXnRnCXTKUBbC8N13bLyBkyAynvKjEQMR5ugEp0+d69lrkC+Xx4IsTxk1s
        srcbkoTKl4txzSUq4FUF/TmCcbWEkozNLddKzPD4cU8iEZ5y+BmM2Yd5xflRWuoQ
        yzdV3pzNW1zp7sacrdnpBso7SKsU+AJsPTIaCthJZ8QlKjc6LQe/0oV7sItUpkPp
        CsYQ0Mm1a7JNs0MNN9Yu4HcrGaT5t5Gs461/sawWUJagaBgevUVuP0ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rr03hF
        F2bNF2szMfr4QL+Usn5E1acu59izxNNk0mufA=; b=ZGqjaCjzgP5RwV0eEqpuWo
        rUM042tt5dRkxbFqXLo6gzxARruBnMcjVUpyd5zDuEGiNTyqSsdPSj3iIwqHXV3z
        q5NWfhNMgk4ShLqmwFCAyEPgV7xapVPIWR1PgZoErrY9DQ7bthOABsDTQzlwQIk3
        MMd8BAWIRI2tqhmIQqIxzNIjISh6EEcw6SoC5h2kOrsQQdFHwSRdlunGO26Pbwoo
        g6QB5SsN8U9jttHC6VZq4WimlZCCYfnIa0m7ZTiwsPBSaeLGSpLKJZpj6zoWVcds
        f1Kmk/0iBRlsO2zcxhSwt/S1ED8WaG+l5sWncT/g42MJ8HYlz4o8eZYZPTE2TXRQ
        ==
X-ME-Sender: <xms:N604Yh_II3LjmQX1Z9bGysXHAfS2a4A5DCLhS54LSJinQ_7OVcMLdA>
    <xme:N604YlsrkmWYYZIf7comLkWnuBSutwKNhcDbMJHrAxyP1KgPwUlApV6I5CY2rHXFA
    kDR1n4tYRRuTBS6BPY>
X-ME-Received: <xmr:N604YvCPdGswDJ0uZQ5ZWO1D6tCNHxUoOm_Of3BXu35DulCVAwM_hcki8a2bfVeF6CIfvWFIE2W_2gojjn1rvx5iSGf_14szet1JephE7x-gm_nu5DlhKVOoFf9IvmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegoteeftdduqddtudculdduhedm
    necujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnh
    curfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthht
    vghrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfe
    ejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhv
    vghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:N604YldVFpC3Sqvs5Y05cllhIl3qr_pvYn-pAKyYsT1HTWwcKltvmg>
    <xmx:N604YmNEpsRs31JvbWmrxJwxU4HWetGsut8RCgfEg_gFKGVo29sk9A>
    <xmx:N604YnmsZoJ7Iq8dnOWBOz6RBEZFagy-NywMB1txsM1I4G6ibFlvxQ>
    <xmx:N604YimQWb0zLkK4uoO9T13DoLDNOP7yfMWZ58HOUoLQswgto8Dj2g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:52:05 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 4/9] soc: apple: Add SART driver
Date:   Mon, 21 Mar 2022 17:50:44 +0100
Message-Id: <20220321165049.35985-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220321165049.35985-1-sven@svenpeter.dev>
References: <20220321165049.35985-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVMe co-processor on the Apple M1 uses a DMA address filter called
SART for some DMA transactions. This adds a simple driver used to
configure the memory regions from which DMA transactions are allowed.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS                    |   1 +
 drivers/soc/apple/Kconfig      |  11 ++
 drivers/soc/apple/Makefile     |   3 +
 drivers/soc/apple/sart.c       | 318 +++++++++++++++++++++++++++++++++
 include/linux/soc/apple/sart.h |  77 ++++++++
 5 files changed, 410 insertions(+)
 create mode 100644 drivers/soc/apple/sart.c
 create mode 100644 include/linux/soc/apple/sart.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 027c3b4ad61c..3d37fe7a0408 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1787,6 +1787,7 @@ F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 F:	include/dt-bindings/pinctrl/apple.h
 F:	include/linux/apple-mailbox.h
+F:	include/linux/soc/apple/*
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
index 9b8de31d6a8f..8c37ffd53fbd 100644
--- a/drivers/soc/apple/Kconfig
+++ b/drivers/soc/apple/Kconfig
@@ -17,6 +17,17 @@ config APPLE_PMGR_PWRSTATE
 	  controls for SoC devices. This driver manages them through the
 	  generic power domain framework, and also provides reset support.
 
+config APPLE_SART
+	tristate "Apple SART DMA address filter"
+	depends on ARCH_APPLE || COMPILE_TEST
+	default ARCH_APPLE
+	help
+	  Apple SART is a simple DMA address filter used on Apple SoCs such
+	  as the M1. It is usually required for the NVMe coprocessor which does
+	  not use a proper IOMMU.
+
+	  Say 'y' here if you have an Apple SoC.
+
 endmenu
 
 endif
diff --git a/drivers/soc/apple/Makefile b/drivers/soc/apple/Makefile
index c114e84667e4..c83c66317098 100644
--- a/drivers/soc/apple/Makefile
+++ b/drivers/soc/apple/Makefile
@@ -1,2 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_APPLE_PMGR_PWRSTATE)	+= apple-pmgr-pwrstate.o
+
+obj-$(CONFIG_APPLE_SART) += apple-sart.o
+apple-sart-y = sart.o
diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
new file mode 100644
index 000000000000..836ea68db2fc
--- /dev/null
+++ b/drivers/soc/apple/sart.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple SART device driver
+ * Copyright (C) The Asahi Linux Contributors
+ *
+ * Apple SART is a simple address filter for some DMA transactions.
+ * Regions of physical memory must be added to the SART's allow
+ * list before any DMA can target these. Unlike a proper
+ * IOMMU no remapping can be done and special support in the
+ * consumer driver is required since not all DMA transactions of
+ * a single device are subject to SART filtering.
+ */
+
+#include <linux/soc/apple/sart.h>
+#include <linux/atomic.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#define APPLE_SART_MAX_ENTRIES 16
+
+/* This is probably a bitfield but the exact meaning of each bit is unknown. */
+#define APPLE_SART_FLAGS_ALLOW 0xff
+
+/* SARTv2 registers */
+#define APPLE_SART2_CONFIG(idx)	      (0x00 + 4 * (idx))
+#define APPLE_SART2_CONFIG_FLAGS      GENMASK(31, 24)
+#define APPLE_SART2_CONFIG_SIZE	      GENMASK(23, 0)
+#define APPLE_SART2_CONFIG_SIZE_SHIFT 12
+#define APPLE_SART2_CONFIG_SIZE_MAX   GENMASK(23, 0)
+
+#define APPLE_SART2_PADDR(idx)	(0x40 + 4 * (idx))
+#define APPLE_SART2_PADDR_SHIFT 12
+
+/* SARTv3 registers */
+#define APPLE_SART3_CONFIG(idx) (0x00 + 4 * (idx))
+
+#define APPLE_SART3_PADDR(idx)	(0x40 + 4 * (idx))
+#define APPLE_SART3_PADDR_SHIFT 12
+
+#define APPLE_SART3_SIZE(idx)  (0x80 + 4 * (idx))
+#define APPLE_SART3_SIZE_SHIFT 12
+#define APPLE_SART3_SIZE_MAX   GENMASK(29, 0)
+
+struct apple_sart_ops {
+	void (*get_entry)(struct apple_sart *sart, int index, u8 *flags,
+			  phys_addr_t *paddr, size_t *size);
+	int (*set_entry)(struct apple_sart *sart, int index, u8 flags,
+			 phys_addr_t paddr, size_t size);
+};
+
+struct apple_sart {
+	struct device *dev;
+	void __iomem *regs;
+
+	const struct apple_sart_ops *ops;
+
+	unsigned long protected_entries;
+	unsigned long used_entries;
+};
+
+static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
+			    phys_addr_t *paddr, size_t *size)
+{
+	u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
+	u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));
+	u32 size_ = FIELD_GET(APPLE_SART2_CONFIG_SIZE, cfg);
+
+	*flags = FIELD_GET(APPLE_SART2_CONFIG_FLAGS, cfg);
+	*size = (size_t)size_ << APPLE_SART2_CONFIG_SIZE_SHIFT;
+	*paddr = (phys_addr_t)paddr_ << APPLE_SART2_PADDR_SHIFT;
+}
+
+static int sart2_set_entry(struct apple_sart *sart, int index, u8 flags,
+			   phys_addr_t paddr, size_t size)
+{
+	u32 cfg;
+
+	if (size & ((1 << APPLE_SART2_CONFIG_SIZE_SHIFT) - 1))
+		return -EINVAL;
+	if (paddr & ((1 << APPLE_SART2_PADDR_SHIFT) - 1))
+		return -EINVAL;
+
+	size >>= APPLE_SART2_CONFIG_SIZE_SHIFT;
+	paddr >>= APPLE_SART2_PADDR_SHIFT;
+
+	if (size > APPLE_SART2_CONFIG_SIZE_MAX)
+		return -EINVAL;
+
+	cfg = FIELD_PREP(APPLE_SART2_CONFIG_FLAGS, flags);
+	cfg |= FIELD_PREP(APPLE_SART2_CONFIG_SIZE, size);
+
+	writel_relaxed(paddr, sart->regs + APPLE_SART2_PADDR(index));
+	writel_relaxed(cfg, sart->regs + APPLE_SART2_CONFIG(index));
+
+	return 0;
+}
+
+static struct apple_sart_ops sart_ops_v2 = {
+	.get_entry = sart2_get_entry,
+	.set_entry = sart2_set_entry,
+};
+
+static void sart3_get_entry(struct apple_sart *sart, int index, u8 *flags,
+			    phys_addr_t *paddr, size_t *size)
+{
+	u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART3_PADDR(index));
+	u32 size_ = readl_relaxed(sart->regs + APPLE_SART3_SIZE(index));
+
+	*flags = readl_relaxed(sart->regs + APPLE_SART3_CONFIG(index));
+	*size = (size_t)size_ << APPLE_SART3_SIZE_SHIFT;
+	*paddr = (phys_addr_t)paddr_ << APPLE_SART3_PADDR_SHIFT;
+}
+
+static int sart3_set_entry(struct apple_sart *sart, int index, u8 flags,
+			   phys_addr_t paddr, size_t size)
+{
+	if (size & ((1 << APPLE_SART3_SIZE_SHIFT) - 1))
+		return -EINVAL;
+	if (paddr & ((1 << APPLE_SART3_PADDR_SHIFT) - 1))
+		return -EINVAL;
+
+	paddr >>= APPLE_SART3_PADDR_SHIFT;
+	size >>= APPLE_SART3_SIZE_SHIFT;
+
+	if (size > APPLE_SART3_SIZE_MAX)
+		return -EINVAL;
+
+	writel_relaxed(paddr, sart->regs + APPLE_SART3_PADDR(index));
+	writel_relaxed(size, sart->regs + APPLE_SART3_SIZE(index));
+	writel_relaxed(flags, sart->regs + APPLE_SART3_CONFIG(index));
+
+	return 0;
+}
+
+static struct apple_sart_ops sart_ops_v3 = {
+	.get_entry = sart3_get_entry,
+	.set_entry = sart3_set_entry,
+};
+
+static int apple_sart_probe(struct platform_device *pdev)
+{
+	int i;
+	struct apple_sart *sart;
+	struct device *dev = &pdev->dev;
+
+	sart = devm_kzalloc(dev, sizeof(*sart), GFP_KERNEL);
+	if (!sart)
+		return -ENOMEM;
+
+	sart->dev = dev;
+	sart->ops = of_device_get_match_data(dev);
+
+	sart->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sart->regs))
+		return PTR_ERR(sart->regs);
+
+	for (i = 0; i < APPLE_SART_MAX_ENTRIES; ++i) {
+		u8 flags;
+		size_t size;
+		phys_addr_t paddr;
+
+		sart->ops->get_entry(sart, i, &flags, &paddr, &size);
+
+		if (!flags)
+			continue;
+
+		dev_dbg(sart->dev,
+			"SART bootloader entry: index %02d; flags: 0x%02x; paddr: %pa; size: 0x%zx\n",
+			i, flags, &paddr, size);
+		set_bit(i, &sart->protected_entries);
+	}
+
+	platform_set_drvdata(pdev, sart);
+	return 0;
+}
+
+struct apple_sart *apple_sart_get(struct device *dev)
+{
+	struct device_node *sart_node;
+	struct platform_device *sart_pdev;
+	struct apple_sart *sart;
+
+	sart_node = of_parse_phandle(dev->of_node, "apple,sart", 0);
+	if (!sart_node)
+		return ERR_PTR(ENODEV);
+
+	sart_pdev = of_find_device_by_node(sart_node);
+	of_node_put(sart_node);
+
+	if (!sart_pdev)
+		return ERR_PTR(ENODEV);
+
+	sart = dev_get_drvdata(&sart_pdev->dev);
+	if (!sart)
+		return ERR_PTR(EPROBE_DEFER);
+
+	device_link_add(dev, &sart_pdev->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
+	return sart;
+}
+EXPORT_SYMBOL(apple_sart_get);
+
+int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
+				  size_t size)
+{
+	int i, ret;
+
+	for (i = 0; i < APPLE_SART_MAX_ENTRIES; ++i) {
+		if (test_bit(i, &sart->protected_entries))
+			continue;
+		if (test_and_set_bit(i, &sart->used_entries))
+			continue;
+
+		ret = sart->ops->set_entry(sart, i, APPLE_SART_FLAGS_ALLOW,
+					   paddr, size);
+		if (ret) {
+			dev_dbg(sart->dev,
+				"unable to set entry %d to [%pa, 0x%zx]\n",
+				i, &paddr, size);
+			clear_bit(i, &sart->used_entries);
+			return ret;
+		}
+
+		dev_dbg(sart->dev, "wrote [%pa, 0x%zx] to %d\n", &paddr, size,
+			i);
+		return 0;
+	}
+
+	dev_warn(sart->dev,
+		 "no free entries left to add [paddr: 0x%llx, size: 0x%zx]\n",
+		 paddr, size);
+
+	return -EBUSY;
+}
+EXPORT_SYMBOL(apple_sart_add_allowed_region);
+
+int apple_sart_remove_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
+				     size_t size)
+{
+	int i;
+
+	dev_dbg(sart->dev,
+		"will remove [paddr: %pa, size: 0x%zx] from allowed regions\n",
+		&paddr, size);
+
+	for (i = 0; i < APPLE_SART_MAX_ENTRIES; ++i) {
+		u8 eflags;
+		size_t esize;
+		phys_addr_t epaddr;
+
+		if (test_bit(i, &sart->protected_entries))
+			continue;
+
+		sart->ops->get_entry(sart, i, &eflags, &epaddr, &esize);
+
+		if (epaddr != paddr || esize != size)
+			continue;
+
+		sart->ops->set_entry(sart, i, 0, 0, 0);
+
+		clear_bit(i, &sart->used_entries);
+		dev_dbg(sart->dev, "cleared entry %d\n", i);
+		return 0;
+	}
+
+	dev_warn(sart->dev, "entry [paddr: 0x%llx, size: 0x%zx] not found\n",
+		 paddr, size);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(apple_sart_remove_allowed_region);
+
+static void apple_sart_shutdown(struct platform_device *pdev)
+{
+	struct apple_sart *sart = dev_get_drvdata(&pdev->dev);
+	int i;
+
+	for (i = 0; i < APPLE_SART_MAX_ENTRIES; ++i) {
+		if (test_bit(i, &sart->protected_entries))
+			continue;
+
+		sart->ops->set_entry(sart, i, 0, 0, 0);
+	}
+}
+
+static const struct of_device_id apple_sart_of_match[] = {
+	{
+		.compatible = "apple,t6000-sart",
+		.data = &sart_ops_v3,
+	},
+	{
+		.compatible = "apple,t8103-sart",
+		.data = &sart_ops_v2,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, apple_sart_of_match);
+
+static struct platform_driver apple_sart_driver = {
+	.driver = {
+		.name = "apple-sart",
+		.of_match_table = apple_sart_of_match,
+	},
+	.probe = apple_sart_probe,
+	.shutdown = apple_sart_shutdown,
+};
+module_platform_driver(apple_sart_driver);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Apple SART driver");
diff --git a/include/linux/soc/apple/sart.h b/include/linux/soc/apple/sart.h
new file mode 100644
index 000000000000..4e3d4960be5a
--- /dev/null
+++ b/include/linux/soc/apple/sart.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Apple SART device driver
+ * Copyright (C) The Asahi Linux Contributors
+ *
+ * Apple SART is a simple address filter for DMA transactions.
+ * Regions of physical memory must be added to the SART's allow
+ * list before any DMA can target these. Unlike a proper
+ * IOMMU no remapping can be done.
+ */
+
+#ifndef _LINUX_SOC_APPLE_SART_H_
+#define _LINUX_SOC_APPLE_SART_H_
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/types.h>
+
+struct apple_sart;
+
+#if IS_ENABLED(CONFIG_APPLE_SART)
+
+/*
+ * Get a reference to the SART attached to dev.
+ *
+ * Looks for the phandle reference in apple,sart and returns a pointer
+ * to the corresponding apple_sart struct to be used with
+ * apple_sart_add_allowed_region and apple_sart_remove_allowed_region.
+ */
+struct apple_sart *apple_sart_get(struct device *dev);
+
+/*
+ * Adds the region [paddr, paddr+size] to the DMA allow list.
+ *
+ * @sart: SART reference
+ * @paddr: Start address of the region to be used for DMA
+ * @size: Size of the region to be used for DMA.
+ */
+int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
+				  size_t size);
+
+/*
+ * Removes the region [paddr, paddr+size] from the DMA allow list.
+ *
+ * Note that exact same paddr and size used for apple_sart_add_allowed_region
+ * have to be passed.
+ *
+ * @sart: SART reference
+ * @paddr: Start address of the region no longer used for DMA
+ * @size: Size of the region no longer used for DMA.
+ */
+int apple_sart_remove_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
+				     size_t size);
+
+#else
+
+static inline struct apple_sart *apple_sart_get(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline int apple_sart_add_allowed_region(struct apple_sart *sart,
+						phys_addr_t paddr, size_t size)
+{
+	return -ENODEV;
+}
+
+static inline int apple_sart_remove_allowed_region(struct apple_sart *sart,
+						   phys_addr_t paddr,
+						   size_t size)
+{
+	return -ENODEV;
+}
+
+#endif /* IS_ENABLED(CONFIG_APPLE_SART) */
+
+#endif /* _LINUX_SOC_APPLE_SART_H_ */
-- 
2.25.1

