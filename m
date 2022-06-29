Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6255FDD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiF2KwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiF2KwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:52:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA02AE29;
        Wed, 29 Jun 2022 03:52:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52E556601916;
        Wed, 29 Jun 2022 11:52:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656499937;
        bh=yJMWD0379qYfTWb2hFD7ek0Oc83E0yWUu24MTyo1EJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLRe20D8l3H6G8jkdYHFx2cBfJECQrzOKp95hd4/4S/yWA+HDDLPLBhu6UWXeF1Yi
         LY0+X3yx19nya3KgkXCslMxXV8VGtEoNsYxvfUo1md4gihRxWNlRHl/ZfTbHEfPbjo
         RqUQfJbhAnBHsPN0xctk68UMNwgKJp5ijy6COK8jAQUqfzHWMSIJI+4b+3LSi4DjsR
         WHlR2MF0eZHrb8wHaszQavr+8vWdUpKxlOkEmAnvzmkpZM8ARKTdHaoEh5OzJJmFYj
         8/UVmZ8Et7jr3yZylL29qVXstjKzfcaBJdI23weGoXouBz5gdSS+TX20fgEgISPI1f
         baqfVOh3E46fw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        rex-bc.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: reset: mt8195: Add resets for PCIE controllers
Date:   Wed, 29 Jun 2022 12:52:04 +0200
Message-Id: <20220629105205.173471-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629105205.173471-1-angelogioacchino.delregno@collabora.com>
References: <20220629105205.173471-1-angelogioacchino.delregno@collabora.com>
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

Add the reset index for PCIe P0 and P1 (PCIe0, PCIe1) on MT8195.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/dt-bindings/reset/mt8195-resets.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
index c87ba621e72e..5471468c43b7 100644
--- a/include/dt-bindings/reset/mt8195-resets.h
+++ b/include/dt-bindings/reset/mt8195-resets.h
@@ -31,6 +31,8 @@
 #define MT8195_INFRA_RST0_THERM_CTRL_SWRST     0
 #define MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST 1
 #define MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST 2
+#define MT8195_INFRA_RST2_PCIE_P0_SWRST        3
+#define MT8195_INFRA_RST2_PCIE_P1_SWRST        4
 
 /* VDOSYS1 */
 #define MT8195_VDOSYS1_SW0_RST_B_SMI_LARB2                     0
-- 
2.35.1

