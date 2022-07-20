Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298DC57B489
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiGTK2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbiGTK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:28:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D375A2D1C7;
        Wed, 20 Jul 2022 03:28:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F154E6601A56;
        Wed, 20 Jul 2022 11:28:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658312910;
        bh=BnFrL3fAmMZM58jLVM0qi6FjJFvFVKJ01t/0qCtXjLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoVOhXojlkLtRRZKUa3g7ks0wAd9pmmkSlMhw0ti/sB8K4fybJlGMza50IuSxrw4A
         96su7qg98OwGwWlsIqeLz5m2ZmexKJLcm1UkJKBkCSJNWC8v1IzJ2VcOqViJ5ORXJz
         +8CvsPsSTmXvT0eRy8yxTteFpsqQEecJTn45IUtrhlY3Tn3CXhUu4N2rmYBb+pkDyO
         6Le6g1DTqKG6wjYS2TkPYcWullp9WbQkbSfLG6M4ZohT2+lVb6bNfIS/SwwmUAS21p
         SXCPEZ3QSP6OrovZwhUVVraoqA9uANYoU45MONuniDNONrSN+rvgQP3bJNpVIL5OYj
         lmjUjYWamOgfQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: reset: mt8195: Add resets for USB/PCIe t-phy port 1
Date:   Wed, 20 Jul 2022 12:28:16 +0200
Message-Id: <20220720102817.237483-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720102817.237483-1-angelogioacchino.delregno@collabora.com>
References: <20220720102817.237483-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset index for USBSIF P1 (T-PHY port 1), used as either USB
or PCI-Express PHY reset.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/dt-bindings/reset/mt8195-resets.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
index 5471468c43b7..e61660438d61 100644
--- a/include/dt-bindings/reset/mt8195-resets.h
+++ b/include/dt-bindings/reset/mt8195-resets.h
@@ -33,6 +33,7 @@
 #define MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST 2
 #define MT8195_INFRA_RST2_PCIE_P0_SWRST        3
 #define MT8195_INFRA_RST2_PCIE_P1_SWRST        4
+#define MT8195_INFRA_RST2_USBSIF_P1_SWRST      5
 
 /* VDOSYS1 */
 #define MT8195_VDOSYS1_SW0_RST_B_SMI_LARB2                     0
-- 
2.35.1

