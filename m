Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC754F652
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381466AbiFQLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380924AbiFQLHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:07:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917512AC7;
        Fri, 17 Jun 2022 04:07:38 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8FAF4660179B;
        Fri, 17 Jun 2022 12:07:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655464057;
        bh=wxT88oQqGVwEkp3rg/ZJOnJEaa8bNQoe2qAp5DUjU20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwOtV4QKYzMhyWoOLuoOZtDsR2x7X7Hoip5KQI4g5onHO1s2ghuqvRDlyiie0cSvT
         SOczvohcA+6oHOW9tRb0fqbubBpiZdv4V5xHknoMGGn+gBpx901ja3SuGG9KuVO+X7
         Tm8ZAl+a4BZm3ml9h7dHsKpmP57dx/kzHo2Nn8RLErPGrYft7ZdfceQstQ/+Q4bQFs
         Fu/qrghUB6OUBZUu5xQMRvKk8E1PyGsWhGEQhij6RhBLJyPGss+dyOdrMwen5JM+cS
         kEjpSh8RDhwLJnleozSTdD+U1/iEBupY1bNn6XhxTQM/cuZfSSrq+YJoGb72OMes4j
         uHM8urC7LRx3w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        johnson.wang@mediatek.com, hsin-hsiung.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: mfd: mt6397: Add compatibles for MT6331 RTC and keys
Date:   Fri, 17 Jun 2022 13:07:27 +0200
Message-Id: <20220617110728.90132-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220617110728.90132-1-angelogioacchino.delregno@collabora.com>
References: <20220617110728.90132-1-angelogioacchino.delregno@collabora.com>
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

The MT6331 PMIC provides many sub modules: regulators, audio
codec, LED controller, keys, RTC and some GPIOs.
It is always paired with a MT6332 Companion PMIC, which provides
thermistors, WLEDs (display LED backlight), secondary AP cluster
regulators, modem clocks, battery charger and fuel gauge.

Add the necessary compatibles to start implementing the basics.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 293db2a71ef2..500275d2c2b4 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -29,6 +29,7 @@ Optional subnodes:
 - rtc
 	Required properties: Should be one of follows
 		- compatible: "mediatek,mt6323-rtc"
+		- compatible: "mediatek,mt6331-rtc"
 		- compatible: "mediatek,mt6358-rtc"
 		- compatible: "mediatek,mt6397-rtc"
 	For details, see ../rtc/rtc-mt6397.txt
@@ -52,8 +53,10 @@ Optional subnodes:
 	see ../leds/leds-mt6323.txt
 
 - keys
-	Required properties:
-		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+	Required properties: Should be one of the following
+		- compatible: "mediatek,mt6323-keys"
+		- compatible: "mediatek,mt6331-keys"
+		- compatible: "mediatek,mt6397-keys"
 	see ../input/mtk-pmic-keys.txt
 
 - power-controller
-- 
2.35.1

