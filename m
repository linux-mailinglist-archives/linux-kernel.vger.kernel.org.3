Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7498D561A42
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiF3MXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiF3MXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:23:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69128E3C;
        Thu, 30 Jun 2022 05:23:41 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 879696601952;
        Thu, 30 Jun 2022 13:23:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656591819;
        bh=pRuI3oSvrHw82NBFcjDTrEAhu9UwJal4NerMnIQjBTM=;
        h=From:To:Cc:Subject:Date:From;
        b=eIfbfgMDXzw9VJ8gxnAYh+zc2D1jRwvoedENIECM7J6jAF935Hd3qKV/oMUB1PE7Q
         myddxKhnwr0TW4ti4Fx6JY/zCvz3ajpZGqPsLCu+B7PX8a2ocv2poiu1rELkkOEdnP
         53LyfflQ+jeM6Y6DmFLCi3j9wpjsueVqld0SKX2isDFs0N5W/sR0xbzRwgVWySi83d
         DMsiA7AOuRvjXgzBFvLJweGyZyC5sGdDXQa6G3ON5FTsz6g1/m8jC1jF6Ms5C64V+d
         W8d8pQ1Jq9+aK/Mnmfc9xzNyZkJT6T58UPzX+lnKS+nEgEJdLa2EC37o/xQr5Dawev
         RmyRgwguExezw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linus.walleij@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@mediatek.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] dt-bindings: pinctrl: mt8195: Fix name for mediatek,rsel-resistance-in-si-unit
Date:   Thu, 30 Jun 2022 14:23:34 +0200
Message-Id: <20220630122334.216903-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

When this property was introduced, it contained underscores, but
the actual code wants dashes.

Change it from mediatek,rsel_resistance_in_si_unit to
mediatek,rsel-resistance-in-si-unit.

Fixes: 91e7edceda96 ("dt-bindings: pinctrl: mt8195: change pull up/down description")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Note: No devicetree uses this property as of now.
      Even if any DT did, it wouldn't work, as the pinctrl code checks
      for 'mediatek,rsel-resistance-in-si-unit'.

 .../devicetree/bindings/pinctrl/pinctrl-mt8195.yaml    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index 15989743afd2..b0fea44403e7 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
@@ -51,7 +51,7 @@ properties:
     description: The interrupt outputs to sysirq.
     maxItems: 1
 
-  mediatek,rsel_resistance_in_si_unit:
+  mediatek,rsel-resistance-in-si-unit:
     type: boolean
     description: |
       Identifying i2c pins pull up/down type which is RSEL. It can support
@@ -144,7 +144,7 @@ patternProperties:
               "MTK_PUPD_SET_R1R0_11" define in mt8195.
               For pull down type is RSEL, it can add RSEL define & resistance
               value(ohm) to set different resistance by identifying property
-              "mediatek,rsel_resistance_in_si_unit".
+              "mediatek,rsel-resistance-in-si-unit".
               It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
               & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
               & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
@@ -163,7 +163,7 @@ patternProperties:
               };
               An example of using si unit resistance value(ohm):
               &pio {
-                mediatek,rsel_resistance_in_si_unit;
+                mediatek,rsel-resistance-in-si-unit;
               }
               pincontroller {
                 i2c0_pin {
@@ -192,7 +192,7 @@ patternProperties:
               "MTK_PUPD_SET_R1R0_11" define in mt8195.
               For pull up type is RSEL, it can add RSEL define & resistance
               value(ohm) to set different resistance by identifying property
-              "mediatek,rsel_resistance_in_si_unit".
+              "mediatek,rsel-resistance-in-si-unit".
               It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
               & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
               & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
@@ -211,7 +211,7 @@ patternProperties:
               };
               An example of using si unit resistance value(ohm):
               &pio {
-                mediatek,rsel_resistance_in_si_unit;
+                mediatek,rsel-resistance-in-si-unit;
               }
               pincontroller {
                 i2c0-pins {
-- 
2.35.1

