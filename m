Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED0655E3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbiF1Mp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345810AbiF1Mpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD7F1D0DC;
        Tue, 28 Jun 2022 05:45:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so25492228ejc.10;
        Tue, 28 Jun 2022 05:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUvTBZSvTkQG8k5ahx+vCE8pnavlPjrhJsWTl2v7qY4=;
        b=YUsA1imIhupuf9Wojjd9t1tkr06B/Q5S+154aH/XHbZiBawjU/E3OSL0UxsAjaTQSq
         2Ttr42qCSlo9mEQGVAEd7GFglPPvmNBMTDfpZ4Np4BSsCmSm4lltW8n0WAZgY4Tl7j6n
         oOGDhXVfcxu4RL5rhr/VynR6l7ATR5G7koin5wvSdPynWfmgUzEMouVgCIwuF3bZlnHN
         pYPE9fYeE1mCy7z7AkDBi5LV0Kl6de/fqQ6yZib5eMkINF4h/QJS1b7zCFrX6RX8nQXf
         DWHLqxAoYTHHbO8yBlxzMzVzVFOprF5e+duPfuyyB+obihpjp1V6Pl9W+Fz2Pher7Jmi
         TjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUvTBZSvTkQG8k5ahx+vCE8pnavlPjrhJsWTl2v7qY4=;
        b=Ln30lMjp66Ap7wnOlQClsfvcDAjen2P7OOjl+iol17zrWqYb9oLtSGQz782NqmDeZZ
         gpigUGJEXQccuDr15JSunJndXqdiWDgpWs3Rnp24K60doEVILCME3WgiMrdPgAr6wZB6
         1vrpvajNF1GxCV8BQrlnl5bi1MlX7igI9e7XFMEGqPW7kpTUXxLV6BDzfEMcy3vyu2p9
         PK4kVtn0ZoDCQJcexKWd+/Rss3tnsfLXJzNkVFEiSPqy27wfsUFYO/YIZMN+E87adGq+
         jsX27kafbaf8QJ5o03ItGPeJ6fTYpn3x0zcstxE3iW5WF95Li0ZswRKFonFr9oQDVmh3
         U8ug==
X-Gm-Message-State: AJIora+07xdsgbjEHNV2O5pEgjzlUS91/kGrOthp2eFq7Icx8Ni9ZXhB
        Lw4CAuURQIib7NCqyvxbg5M=
X-Google-Smtp-Source: AGRyM1uyuIl2+iwMosBXcvxSsRRQMisrWpqCTCRI2n8Z/h8yD5HhzesYWyv9VyZ3X2v8ii8N8r1Org==
X-Received: by 2002:a17:907:3ea6:b0:726:3554:cf7a with SMTP id hs38-20020a1709073ea600b007263554cf7amr17753304ejc.384.1656420324011;
        Tue, 28 Jun 2022 05:45:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:23 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 8/9] reset: lantiq: Remove driver as it has been replaced by reset-intel-gw
Date:   Tue, 28 Jun 2022 14:44:40 +0200
Message-Id: <20220628124441.2385023-9-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have replaced the reset-lantiq driver with the
reset-intel-gw driver we can remove the old code.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/reset/Kconfig        |   6 -
 drivers/reset/Makefile       |   1 -
 drivers/reset/reset-lantiq.c | 210 -----------------------------------
 3 files changed, 217 deletions(-)
 delete mode 100644 drivers/reset/reset-lantiq.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index fb49c465078f..22e28f5cf154 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -103,12 +103,6 @@ config RESET_K210
 	  Say Y if you want to control reset signals provided by this
 	  controller.
 
-config RESET_LANTIQ
-	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
-	default SOC_TYPE_XWAY
-	help
-	  This enables the reset controller driver for Lantiq / Intel XWAY SoCs.
-
 config RESET_LPC18XX
 	bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
 	default ARCH_LPC18XX
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index a80a9c4008a7..9cb37e7890f1 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
 obj-$(CONFIG_RESET_K210) += reset-k210.o
-obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
deleted file mode 100644
index b936cfe85641..000000000000
--- a/drivers/reset/reset-lantiq.c
+++ /dev/null
@@ -1,210 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *
- *  Copyright (C) 2010 John Crispin <blogic@phrozen.org>
- *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
- *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
- */
-
-#include <linux/mfd/syscon.h>
-#include <linux/module.h>
-#include <linux/regmap.h>
-#include <linux/reset-controller.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/property.h>
-
-#define LANTIQ_RCU_RESET_TIMEOUT	10000
-
-struct lantiq_rcu_reset_priv {
-	struct reset_controller_dev rcdev;
-	struct device *dev;
-	struct regmap *regmap;
-	u32 reset_offset;
-	u32 status_offset;
-};
-
-static struct lantiq_rcu_reset_priv *to_lantiq_rcu_reset_priv(
-	struct reset_controller_dev *rcdev)
-{
-	return container_of(rcdev, struct lantiq_rcu_reset_priv, rcdev);
-}
-
-static int lantiq_rcu_reset_status(struct reset_controller_dev *rcdev,
-				   unsigned long id)
-{
-	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
-	unsigned int status = (id >> 8) & 0x1f;
-	u32 val;
-	int ret;
-
-	ret = regmap_read(priv->regmap, priv->status_offset, &val);
-	if (ret)
-		return ret;
-
-	return !!(val & BIT(status));
-}
-
-static int lantiq_rcu_reset_status_timeout(struct reset_controller_dev *rcdev,
-					   unsigned long id, bool assert)
-{
-	int ret;
-	int retry = LANTIQ_RCU_RESET_TIMEOUT;
-
-	do {
-		ret = lantiq_rcu_reset_status(rcdev, id);
-		if (ret < 0)
-			return ret;
-		if (ret == assert)
-			return 0;
-		usleep_range(20, 40);
-	} while (--retry);
-
-	return -ETIMEDOUT;
-}
-
-static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
-				   unsigned long id, bool assert)
-{
-	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
-	unsigned int set = id & 0x1f;
-	u32 val = assert ? BIT(set) : 0;
-	int ret;
-
-	ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set),
-				 val);
-	if (ret) {
-		dev_err(priv->dev, "Failed to set reset bit %u\n", set);
-		return ret;
-	}
-
-
-	ret = lantiq_rcu_reset_status_timeout(rcdev, id, assert);
-	if (ret)
-		dev_err(priv->dev, "Failed to %s bit %u\n",
-			assert ? "assert" : "deassert", set);
-
-	return ret;
-}
-
-static int lantiq_rcu_reset_assert(struct reset_controller_dev *rcdev,
-			     unsigned long id)
-{
-	return lantiq_rcu_reset_update(rcdev, id, true);
-}
-
-static int lantiq_rcu_reset_deassert(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	return lantiq_rcu_reset_update(rcdev, id, false);
-}
-
-static int lantiq_rcu_reset_reset(struct reset_controller_dev *rcdev,
-			    unsigned long id)
-{
-	int ret;
-
-	ret = lantiq_rcu_reset_assert(rcdev, id);
-	if (ret)
-		return ret;
-
-	return lantiq_rcu_reset_deassert(rcdev, id);
-}
-
-static const struct reset_control_ops lantiq_rcu_reset_ops = {
-	.assert = lantiq_rcu_reset_assert,
-	.deassert = lantiq_rcu_reset_deassert,
-	.status = lantiq_rcu_reset_status,
-	.reset	= lantiq_rcu_reset_reset,
-};
-
-static int lantiq_rcu_reset_of_parse(struct platform_device *pdev,
-			       struct lantiq_rcu_reset_priv *priv)
-{
-	struct device *dev = &pdev->dev;
-	const __be32 *offset;
-
-	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
-	if (IS_ERR(priv->regmap)) {
-		dev_err(&pdev->dev, "Failed to lookup RCU regmap\n");
-		return PTR_ERR(priv->regmap);
-	}
-
-	offset = of_get_address(dev->of_node, 0, NULL, NULL);
-	if (!offset) {
-		dev_err(&pdev->dev, "Failed to get RCU reset offset\n");
-		return -ENOENT;
-	}
-	priv->reset_offset = __be32_to_cpu(*offset);
-
-	offset = of_get_address(dev->of_node, 1, NULL, NULL);
-	if (!offset) {
-		dev_err(&pdev->dev, "Failed to get RCU status offset\n");
-		return -ENOENT;
-	}
-	priv->status_offset = __be32_to_cpu(*offset);
-
-	return 0;
-}
-
-static int lantiq_rcu_reset_xlate(struct reset_controller_dev *rcdev,
-				  const struct of_phandle_args *reset_spec)
-{
-	unsigned int status, set;
-
-	set = reset_spec->args[0];
-	status = reset_spec->args[1];
-
-	if (set >= rcdev->nr_resets || status >= rcdev->nr_resets)
-		return -EINVAL;
-
-	return (status << 8) | set;
-}
-
-static int lantiq_rcu_reset_probe(struct platform_device *pdev)
-{
-	struct lantiq_rcu_reset_priv *priv;
-	int err;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->dev = &pdev->dev;
-	platform_set_drvdata(pdev, priv);
-
-	err = lantiq_rcu_reset_of_parse(pdev, priv);
-	if (err)
-		return err;
-
-	priv->rcdev.ops = &lantiq_rcu_reset_ops;
-	priv->rcdev.owner = THIS_MODULE;
-	priv->rcdev.of_node = pdev->dev.of_node;
-	priv->rcdev.nr_resets = 32;
-	priv->rcdev.of_xlate = lantiq_rcu_reset_xlate;
-	priv->rcdev.of_reset_n_cells = 2;
-
-	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
-}
-
-static const struct of_device_id lantiq_rcu_reset_dt_ids[] = {
-	{ .compatible = "lantiq,danube-reset", },
-	{ .compatible = "lantiq,xrx200-reset", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, lantiq_rcu_reset_dt_ids);
-
-static struct platform_driver lantiq_rcu_reset_driver = {
-	.probe	= lantiq_rcu_reset_probe,
-	.driver = {
-		.name		= "lantiq-reset",
-		.of_match_table	= lantiq_rcu_reset_dt_ids,
-	},
-};
-module_platform_driver(lantiq_rcu_reset_driver);
-
-MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
-MODULE_DESCRIPTION("Lantiq XWAY RCU Reset Controller Driver");
-MODULE_LICENSE("GPL");
-- 
2.36.1

