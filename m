Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB66510A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354851AbiDZUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354926AbiDZUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:19:10 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F12DE0E6;
        Tue, 26 Apr 2022 13:16:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1126A5C00C2;
        Tue, 26 Apr 2022 16:16:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Apr 2022 16:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1651004161; x=
        1651090561; bh=sAAoHGhPI7ze9CSknjdlGByXtZTKZzDyEEQaOUkcJi8=; b=T
        RoQehzRpXtSd70EzDmuLOTxzQBzt3e6er0BxxEuRr/dVX2TTy8R2es8GHOMwc8SG
        TpSkSIKJTQ9VH1Bu3SEgg8MM5R43DG7XN94mTi3bxVZX3QicdFL4OSr2GmpVNiKi
        QvoCEytsWDYgNAUFm50hg/AzTmCIOPy9fvf91EhpPK8v96lrlShjHVENM3ksSrO2
        6Ttgwfx7GK9FjT6Hs1GAfNkE/wj4SNfROX0TcR3hYLZYmz+KqTogZtWV56/yt3gU
        7tLILA8yYeV8G7WZxVapziwUKNCgPsTRwTPHih9M4NbVWbzjpnDoU+SZxUT3hIkD
        222Qf9TifT04CtOGeH7QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1651004161; x=1651090561; bh=sAAoHGhPI7ze9CSknjdlGByXtZTKZzDyEEQ
        aOUkcJi8=; b=OiLYO3eangi0XR7KpOmMI2G1ggbhB6HnDhZIaZTWfjqE060GcWb
        5arOXhCWXUSnzFqUkhf750PjtxN4WUVqVF/ehust5AXomj0NpakGhSVyMk532s/5
        6SnHMhL4/CoH4FuG6xZZ2w2NC5KStSP1DYsMVWQ9TamdO1IyYBNGsciSFx8CLVOp
        NrfyEBuPdavDKFKm9kUKY3lFrxkDCbKuJAsdDKW2YPf86K6L0ELFl5N7eMT/It46
        0bwSbLdG3Tp1HXPuutvGBwo6TFSWvlnPZ5H3KmM3GgAFRuG5F7yEfaz3y8n60Ip2
        SCPvKEEmKiBz0yh05nQeXyCsSZuB9HwdYCA==
X-ME-Sender: <xms:AFNoYiOZ7AcagJzaZZUoyRIlul7LMWNcJz0c8l9FwowJsAwkwpi47g>
    <xme:AFNoYg_CjL8BEcDLCdlLglyEAJDu6ti3Rpc3hW85oFzqTVq8zF1H2E9YQ-vepl0yi
    YBJTqs9tNs6ObP3_mU>
X-ME-Received: <xmr:AFNoYpRyfOSxtdXdMAidxvXnVWjp_ptUc9TDWIxmaIP0lwJR6D5XzAssOTPCrllQXHfjFzhYh8z6zqULwEuVVoThnZxgru66yHUKv7bfC4xejGb-1imWsMQ1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:AVNoYistQVVxtrSr54P3frb4_YSAstE8qPG8N1gFf5iMRYqtLYBPtg>
    <xmx:AVNoYqehPAWBAnRMGsdr5xqK_SvplCWUyQVHBQ-_dC8sYzJzAc6LIw>
    <xmx:AVNoYm165wySlHtTCoCbNMMPCuk1OoLNcIL5JGeT6evoejRF1r0Qow>
    <xmx:AVNoYl11MPduvOnBKikMENrvF54h4hwjUChzYNYI_m_W8tqG8Yc81A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 16:15:58 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH v3 4/6] soc: apple: Add SART driver
Date:   Tue, 26 Apr 2022 22:15:37 +0200
Message-Id: <20220426201539.12829-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220426201539.12829-1-sven@svenpeter.dev>
References: <20220426201539.12829-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVMe co-processor on the Apple M1 uses a DMA address filter called
SART for some DMA transactions. This adds a simple driver used to
configure the memory regions from which DMA transactions are allowed.

Unlike a real IOMMU, SART does not support any pagetables and can't be
implemented inside the IOMMU subsystem using iommu_ops.

It also can't be implemented using dma_map_ops since not all DMA
transactions of the NVMe controller are filtered by SART.
Instead, most buffers have to be registered using the integrated NVMe
IOMMU and we can't have two separate dma_map_ops implementations for a
single device.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v2 -> v3:
  - Moved more shared code between SART2 and SART3 to sart_set_entry
v1 -> v2:
  - Added explanation why this can't be an IOMMU or dma_map_ops
    implementation (Arnd Bergmann)
  - Used non-relaxed accessors everwhere since the paths aren't
    performance critical (Arnd Bergmann)
  - Fixed errno return values to be negative (Arnd Bergmann)
  - apple_sart_get -> devm_apple_sart_get to add put_device
  - Disallow using the interface without CONFIG_APPLE_SART and
    make all consumers hard-depend on that (Arnd Bergmann)

 MAINTAINERS                    |   1 +
 drivers/soc/apple/Kconfig      |  11 ++
 drivers/soc/apple/Makefile     |   3 +
 drivers/soc/apple/sart.c       | 328 +++++++++++++++++++++++++++++++++
 include/linux/soc/apple/sart.h |  57 ++++++
 5 files changed, 400 insertions(+)
 create mode 100644 drivers/soc/apple/sart.c
 create mode 100644 include/linux/soc/apple/sart.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bc8b732f129..24b94c386f33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1855,6 +1855,7 @@ F:	drivers/watchdog/apple_wdt.c
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
index 000000000000..9b60f213bbfe
--- /dev/null
+++ b/drivers/soc/apple/sart.c
@@ -0,0 +1,328 @@
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
+#include <linux/device.h>
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
+	void (*set_entry)(struct apple_sart *sart, int index, u8 flags,
+			  phys_addr_t paddr_shifted, size_t size_shifted);
+	unsigned int size_shift;
+	unsigned int paddr_shift;
+	size_t size_max;
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
+	u32 cfg = readl(sart->regs + APPLE_SART2_CONFIG(index));
+	phys_addr_t paddr_ = readl(sart->regs + APPLE_SART2_PADDR(index));
+	size_t size_ = FIELD_GET(APPLE_SART2_CONFIG_SIZE, cfg);
+
+	*flags = FIELD_GET(APPLE_SART2_CONFIG_FLAGS, cfg);
+	*size = size_ << APPLE_SART2_CONFIG_SIZE_SHIFT;
+	*paddr = paddr_ << APPLE_SART2_PADDR_SHIFT;
+}
+
+static void sart2_set_entry(struct apple_sart *sart, int index, u8 flags,
+			    phys_addr_t paddr_shifted, size_t size_shifted)
+{
+	u32 cfg;
+
+	cfg = FIELD_PREP(APPLE_SART2_CONFIG_FLAGS, flags);
+	cfg |= FIELD_PREP(APPLE_SART2_CONFIG_SIZE, size_shifted);
+
+	writel(paddr_shifted, sart->regs + APPLE_SART2_PADDR(index));
+	writel(cfg, sart->regs + APPLE_SART2_CONFIG(index));
+}
+
+static struct apple_sart_ops sart_ops_v2 = {
+	.get_entry = sart2_get_entry,
+	.set_entry = sart2_set_entry,
+	.size_shift = APPLE_SART2_CONFIG_SIZE_SHIFT,
+	.paddr_shift = APPLE_SART2_PADDR_SHIFT,
+	.size_max = APPLE_SART2_CONFIG_SIZE_MAX,
+};
+
+static void sart3_get_entry(struct apple_sart *sart, int index, u8 *flags,
+			    phys_addr_t *paddr, size_t *size)
+{
+	phys_addr_t paddr_ = readl(sart->regs + APPLE_SART3_PADDR(index));
+	size_t size_ = readl(sart->regs + APPLE_SART3_SIZE(index));
+
+	*flags = readl(sart->regs + APPLE_SART3_CONFIG(index));
+	*size = size_ << APPLE_SART3_SIZE_SHIFT;
+	*paddr = paddr_ << APPLE_SART3_PADDR_SHIFT;
+}
+
+static void sart3_set_entry(struct apple_sart *sart, int index, u8 flags,
+			    phys_addr_t paddr_shifted, size_t size_shifted)
+{
+	writel(paddr_shifted, sart->regs + APPLE_SART3_PADDR(index));
+	writel(size_shifted, sart->regs + APPLE_SART3_SIZE(index));
+	writel(flags, sart->regs + APPLE_SART3_CONFIG(index));
+}
+
+static struct apple_sart_ops sart_ops_v3 = {
+	.get_entry = sart3_get_entry,
+	.set_entry = sart3_set_entry,
+	.size_shift = APPLE_SART3_SIZE_SHIFT,
+	.paddr_shift = APPLE_SART3_PADDR_SHIFT,
+	.size_max = APPLE_SART3_SIZE_MAX,
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
+struct apple_sart *devm_apple_sart_get(struct device *dev)
+{
+	struct device_node *sart_node;
+	struct platform_device *sart_pdev;
+	struct apple_sart *sart;
+	int ret;
+
+	sart_node = of_parse_phandle(dev->of_node, "apple,sart", 0);
+	if (!sart_node)
+		return ERR_PTR(-ENODEV);
+
+	sart_pdev = of_find_device_by_node(sart_node);
+	of_node_put(sart_node);
+
+	if (!sart_pdev)
+		return ERR_PTR(-ENODEV);
+
+	sart = dev_get_drvdata(&sart_pdev->dev);
+	if (!sart) {
+		put_device(&sart_pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	ret = devm_add_action_or_reset(dev, (void (*)(void *))put_device,
+				       &sart_pdev->dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	device_link_add(dev, &sart_pdev->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
+	return sart;
+}
+EXPORT_SYMBOL(devm_apple_sart_get);
+
+static int sart_set_entry(struct apple_sart *sart, int index, u8 flags,
+			  phys_addr_t paddr, size_t size)
+{
+	if (size & ((1 << sart->ops->size_shift) - 1))
+		return -EINVAL;
+	if (paddr & ((1 << sart->ops->paddr_shift) - 1))
+		return -EINVAL;
+
+	paddr >>= sart->ops->size_shift;
+	size >>= sart->ops->paddr_shift;
+
+	if (size > sart->ops->size_max)
+		return -EINVAL;
+
+	sart->ops->set_entry(sart, index, flags, paddr, size);
+	return 0;
+}
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
+		ret = sart_set_entry(sart, i, APPLE_SART_FLAGS_ALLOW, paddr,
+				     size);
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
index 000000000000..d24b2d9b505f
--- /dev/null
+++ b/include/linux/soc/apple/sart.h
@@ -0,0 +1,57 @@
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
+#if IS_ENABLED(CONFIG_APPLE_SART)
+
+struct apple_sart;
+
+/*
+ * Get a reference to the SART attached to dev.
+ *
+ * Looks for the phandle reference in apple,sart and returns a pointer
+ * to the corresponding apple_sart struct to be used with
+ * apple_sart_add_allowed_region and apple_sart_remove_allowed_region.
+ */
+struct apple_sart *devm_apple_sart_get(struct device *dev);
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
+#endif /* IS_ENABLED(CONFIG_APPLE_SART) */
+
+#endif /* _LINUX_SOC_APPLE_SART_H_ */
-- 
2.25.1

