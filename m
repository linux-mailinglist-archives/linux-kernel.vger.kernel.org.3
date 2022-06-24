Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6901B5596CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiFXJfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiFXJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:35:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C0B6E7A4;
        Fri, 24 Jun 2022 02:35:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C459666017FD;
        Fri, 24 Jun 2022 10:35:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656063333;
        bh=dVpnFJPWijR0G8zrYTyz0cKQZgjOoyAvap7TVzXSsS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4Co0gSCm0tLPLO0JQxtcFV863Ms2LHq6GOUqvDjLYgkEr9I6nhNvlVdshi+ORkhm
         H5EP+1RCILLBpsV+6DeKxjd7aDPXVZ4eWvleI/ZDl+ypyq0HYdVF6l7MTf/mZ9bITo
         nwRAAs/KrEvkh2iB77yDpmUQ6e8Rzl6nqXXykY30Uk/+SBkBIICxeHYfHDUK9nseEe
         9pdjxTZ+w2Z/o7kIr4USrxYk5YFtWgQecU2aGZ2UfpaoCwfKXuzHPqtqfRDaYuUl7M
         T1ri4mHUQu/68OWkoLPT6MA/CREKlchF5fNscBAS4hM78CX94FQi2cqNUUQfrqhJMN
         lH+NMw7yd/5zw==
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
Subject: [PATCH v3 1/7] dt-bindings: mediatek: Document MT6795 system controllers bindings
Date:   Fri, 24 Jun 2022 11:35:19 +0200
Message-Id: <20220624093525.243077-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
References: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
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

Document the MediaTek Helio X10 (MT6795) bindings for the apmixedsys,
infracfg, topckgen, pericfg and mmsys system controllers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml     | 2 ++
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml      | 1 +
 .../devicetree/bindings/clock/mediatek,apmixedsys.yaml          | 1 +
 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml  | 1 +
 5 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
index 8681b785ed6d..1d7c837d9378 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
@@ -23,6 +23,7 @@ properties:
               - mediatek,mt2701-infracfg
               - mediatek,mt2712-infracfg
               - mediatek,mt6765-infracfg
+              - mediatek,mt6795-infracfg
               - mediatek,mt6779-infracfg_ao
               - mediatek,mt6797-infracfg
               - mediatek,mt7622-infracfg
@@ -60,6 +61,7 @@ if:
         enum:
           - mediatek,mt2701-infracfg
           - mediatek,mt2712-infracfg
+          - mediatek,mt6795-infracfg
           - mediatek,mt7622-infracfg
           - mediatek,mt7986-infracfg
           - mediatek,mt8135-infracfg
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index 6ad023eec193..597ef18f3c5f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -25,6 +25,7 @@ properties:
               - mediatek,mt2712-mmsys
               - mediatek,mt6765-mmsys
               - mediatek,mt6779-mmsys
+              - mediatek,mt6795-mmsys
               - mediatek,mt6797-mmsys
               - mediatek,mt8167-mmsys
               - mediatek,mt8173-mmsys
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
index 611f666f359d..c518ed3c4153 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
@@ -21,6 +21,7 @@ properties:
               - mediatek,mt2701-pericfg
               - mediatek,mt2712-pericfg
               - mediatek,mt6765-pericfg
+              - mediatek,mt6795-pericfg
               - mediatek,mt7622-pericfg
               - mediatek,mt7629-pericfg
               - mediatek,mt8135-pericfg
diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
index 770546195fb5..731bfe0408c2 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -34,6 +34,7 @@ properties:
               - mediatek,mt2712-apmixedsys
               - mediatek,mt6765-apmixedsys
               - mediatek,mt6779-apmixedsys
+              - mediatek,mt6795-apmixedsys
               - mediatek,mt7629-apmixedsys
               - mediatek,mt8167-apmixedsys
               - mediatek,mt8183-apmixedsys
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
index 5b8b37a2e594..81531b5b0db7 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -33,6 +33,7 @@ properties:
               - mediatek,mt2712-topckgen
               - mediatek,mt6765-topckgen
               - mediatek,mt6779-topckgen
+              - mediatek,mt6795-topckgen
               - mediatek,mt7629-topckgen
               - mediatek,mt7986-topckgen
               - mediatek,mt8167-topckgen
-- 
2.35.1

