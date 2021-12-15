Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31896474F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhLOAqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbhLOAqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:49 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28A5C061574;
        Tue, 14 Dec 2021 16:46:48 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z26so27283443iod.10;
        Tue, 14 Dec 2021 16:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyQwYfGkQ8cnhxcnBRBIiFiQQ6uqIZv5tFNwIu243ek=;
        b=q3axeGrkZpJt7GmwxMn/RktTXym/WMql11C2mkwxfLGSnheGNU+0p84Sr2Sc4J5Hir
         6gIQQjd8GwxUGV6RXmVwE7hLsPVLoxaf20zciJQJ6I9aOia9cwjkkIu6psK7G9NA6kOS
         5/gG3NMl8smNb1ainbLUEbLoEpSy03klyqVDUnw0qajde1Nh2vf25z57U07pwnlJGIvk
         NK9st6NoR+EFyfwvRboKZ/LBSLmI+sAt3QjVrvVz7jV5WBcgWk28DeaVsheI1VgWdW90
         EZkWWsh2PfygXa2WKTJ9TODZVI1R2jo6RZkU242qVU+KZmfgx/S/aLOguxSAYMwEJj8R
         8B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyQwYfGkQ8cnhxcnBRBIiFiQQ6uqIZv5tFNwIu243ek=;
        b=pSmhEu6qb8t2x+GVaBo0e4AIUGnZQ2fwtww6RUanmQIrmA/4XqlNyjLQYGnmYnXuio
         KfrC4J1mhWAK2aghMj7+W++1yigCtLdKCg3I3LvUNs2ugivCpzil+BhBmr+mvk/GhHyz
         NXkcfH8Wl6fZoiHwGjucRiq769MJjmc/kGZi1204Zl8L+bsaB+veeOEn8JnZXXtMVfT2
         DjExtlKy0Fd9zDc6G+e/vl9fmTur8ybMachPpY6R12TXVAjwSjKc3GS1m53mtZLOD/LA
         UHayFKSrC394LvdnW2T+W9itd+mKSpqUX1HGNNvaZulbrjk5AYlIzVxYyfiiNJUJL3/m
         a82g==
X-Gm-Message-State: AOAM5324C8KM5Dz3xBvfAX6B6AQnenzv7FaiyMCEkY96LrHSsnSa4ZAd
        59eMY0eN6ud04+zzhbyVrdI=
X-Google-Smtp-Source: ABdhPJznPx6aE9/mE4mECSuNgO6yzS/2SqotAFtixRDe7zxVFUQrQhDLc6JUbcloqz/SxEjwzESVLQ==
X-Received: by 2002:a05:6638:11cb:: with SMTP id g11mr4624990jas.139.1639529208227;
        Tue, 14 Dec 2021 16:46:48 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:47 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 5/9] soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
Date:   Tue, 14 Dec 2021 18:46:22 -0600
Message-Id: <20211215004626.2241839-6-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the description for the i.MX8MN disp blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index c2f076b56e24..511e74f0db8a 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
+#include <dt-bindings/power/imx8mn-power.h>
 
 #define BLK_SFT_RSTN	0x0
 #define BLK_CLK_EN	0x4
@@ -517,6 +518,77 @@ static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
 	.num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
 };
 
+
+static int imx8mn_disp_power_notifier(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
+		return NOTIFY_OK;
+
+	/* Enable bus clock and deassert bus reset */
+	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
+	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
+
+	/*
+	 * On power up we have no software backchannel to the GPC to
+	 * wait for the ADB handshake to happen, so we just delay for a
+	 * bit. On power down the GPC driver waits for the handshake.
+	 */
+	if (action == GENPD_NOTIFY_ON)
+		udelay(5);
+
+
+	return NOTIFY_OK;
+}
+
+static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
+	[IMX8MN_DISPBLK_PD_MIPI_DSI] = {
+		.name = "dispblk-mipi-dsi",
+		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
+		.num_clks = 2,
+		.gpc_name = "mipi-dsi",
+		.rst_mask = BIT(0) | BIT(1),
+		.clk_mask = BIT(0) | BIT(1),
+		.mipi_phy_rst_mask = BIT(17),
+	},
+	[IMX8MN_DISPBLK_PD_MIPI_CSI] = {
+		.name = "dispblk-mipi-csi",
+		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi",
+		.rst_mask = BIT(2) | BIT(3),
+		.clk_mask = BIT(2) | BIT(3),
+		.mipi_phy_rst_mask = BIT(16),
+	},
+	[IMX8MN_DISPBLK_PD_LCDIF] = {
+		.name = "dispblk-lcdif",
+		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
+		.num_clks = 3,
+		.gpc_name = "lcdif",
+		.rst_mask = BIT(4) | BIT(5),
+		.clk_mask = BIT(4) | BIT(5),
+	},
+	[IMX8MN_DISPBLK_PD_ISI] = {
+		.name = "dispblk-isi",
+		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
+						"disp_apb_root"},
+		.num_clks = 4,
+		.gpc_name = "isi",
+		.rst_mask = BIT(6) | BIT(7),
+		.clk_mask = BIT(6) | BIT(7),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
+	.max_reg = 0x84,
+	.power_notifier_fn = imx8mn_disp_power_notifier,
+	.domains = imx8mn_disp_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
+};
+
 static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	{
 		.compatible = "fsl,imx8mm-vpu-blk-ctrl",
@@ -524,7 +596,10 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	}, {
 		.compatible = "fsl,imx8mm-disp-blk-ctrl",
 		.data = &imx8mm_disp_blk_ctl_dev_data
-	} ,{
+	}, {
+		.compatible = "fsl,imx8mn-disp-blk-ctrl",
+		.data = &imx8mn_disp_blk_ctl_dev_data
+	}, {
 		/* Sentinel */
 	}
 };
-- 
2.32.0

