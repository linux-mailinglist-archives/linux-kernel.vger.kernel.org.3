Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28AB55FE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiF2LDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiF2LDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:03:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977AAE6B;
        Wed, 29 Jun 2022 04:03:06 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08A216601926;
        Wed, 29 Jun 2022 12:03:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656500585;
        bh=P9UdeMfvdocwSYEK3BgmHPMoe3+XGYTsf9T1eCUavWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wz3WdKpoZhI7Nbhmo8UCUElcF57WxJzsP8VnpZquedVOYi/4IJHy8Q8N/e+58fimt
         BOSQQdf3fBYorVsy9phzPXzqLW4SKZDvYlyGsONvfE/8CBSf4Ac+SNncyGgyHX+aIx
         5+vWl2sWteeoMTMl5CQWWRPhIJz9uiALf6LMAe62hz35osPqY+bM3KefKCWhBS75dC
         9aroCYJUtAINIioshoKJIPYJJUDZ2J06czUHK8nFVpAUR3fsksBweGPK9W6HCiYx1f
         d/VuiWSk/ussZB+hr5kUhZVYtacDNiDahRvE1qmjJ6ifSmz6how6jjWIjZ1NW02iGU
         WeFm9+MLbkRWA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 3/7] dt-bindings: reset: Add bindings for MT6795 Helio X10 reset controllers
Date:   Wed, 29 Jun 2022 13:02:50 +0200
Message-Id: <20220629110254.184213-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629110254.184213-1-angelogioacchino.delregno@collabora.com>
References: <20220629110254.184213-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset controller bindings for MT6795.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../reset/mediatek,mt6795-resets.h            | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6795-resets.h

diff --git a/include/dt-bindings/reset/mediatek,mt6795-resets.h b/include/dt-bindings/reset/mediatek,mt6795-resets.h
new file mode 100644
index 000000000000..0a6514884eae
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6795-resets.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT6795
+#define _DT_BINDINGS_RESET_CONTROLLER_MT6795
+
+/* INFRACFG resets */
+#define MT6795_INFRA_SCPSYS_RST			0
+#define MT6795_INFRA_PMIC_WRAP_RST		1
+
+/* MMSYS resets */
+#define MT6795_MMSYS_SW0_RST_B_SMI_COMMON	0
+#define MT6795_MMSYS_SW0_RST_B_SMI_LARB		1
+#define MT6795_MMSYS_SW0_RST_B_CAM_MDP		2
+#define MT6795_MMSYS_SW0_RST_B_MDP_RDMA0	3
+#define MT6795_MMSYS_SW0_RST_B_MDP_RDMA1	4
+#define MT6795_MMSYS_SW0_RST_B_MDP_RSZ0		5
+#define MT6795_MMSYS_SW0_RST_B_MDP_RSZ1		6
+#define MT6795_MMSYS_SW0_RST_B_MDP_RSZ2		7
+#define MT6795_MMSYS_SW0_RST_B_MDP_TDSHP0	8
+#define MT6795_MMSYS_SW0_RST_B_MDP_TDSHP1	9
+#define MT6795_MMSYS_SW0_RST_B_MDP_WDMA		10
+#define MT6795_MMSYS_SW0_RST_B_MDP_WROT0	11
+#define MT6795_MMSYS_SW0_RST_B_MDP_WROT1	12
+#define MT6795_MMSYS_SW0_RST_B_MDP_CROP		13
+
+/*  PERICFG resets */
+#define MT6795_PERI_NFI_SW_RST			0
+#define MT6795_PERI_THERM_SW_RST		1
+#define MT6795_PERI_MSDC1_SW_RST		2
+
+/* TOPRGU resets */
+#define MT6795_TOPRGU_INFRA_SW_RST		0
+#define MT6795_TOPRGU_MM_SW_RST			1
+#define MT6795_TOPRGU_MFG_SW_RST		2
+#define MT6795_TOPRGU_VENC_SW_RST		3
+#define MT6795_TOPRGU_VDEC_SW_RST		4
+#define MT6795_TOPRGU_IMG_SW_RST		5
+#define MT6795_TOPRGU_DDRPHY_SW_RST		6
+#define MT6795_TOPRGU_MD_SW_RST			7
+#define MT6795_TOPRGU_INFRA_AO_SW_RST		8
+#define MT6795_TOPRGU_MD_LITE_SW_RST		9
+#define MT6795_TOPRGU_APMIXED_SW_RST		10
+#define MT6795_TOPRGU_PWRAP_SPI_CTL_RST		11
+#define MT6795_TOPRGU_SW_RST_NUM		12
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT6795 */
-- 
2.35.1

