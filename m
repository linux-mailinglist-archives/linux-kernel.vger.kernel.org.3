Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D8530A91
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiEWHkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiEWHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:40:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1146F1D304;
        Mon, 23 May 2022 00:40:29 -0700 (PDT)
X-UUID: 6d65f54eef3441d3b5df3770083f8a63-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:d8e92cc5-d9c0-446c-a706-81f7fedae349,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.5,REQID:d8e92cc5-d9c0-446c-a706-81f7fedae349,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:2a19b09,CLOUDID:3ec8427a-5ef6-470b-96c9-bdb8ced32786,C
        OID:40d5bd0b5061,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 6d65f54eef3441d3b5df3770083f8a63-20220523
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 478016615; Mon, 23 May 2022 15:40:23 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 15:40:21 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 23 May 2022 15:40:20 +0800
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Axe Yang <axe.yang@mediatek.com>, Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v11 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and pinctrls properties
Date:   Mon, 23 May 2022 15:40:15 +0800
Message-ID: <20220523074017.12649-2-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523074017.12649-1-axe.yang@mediatek.com>
References: <20220523074017.12649-1-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
This feature allow SDIO devices alarm asynchronous interrupt to host
even when host stop providing clock to SDIO card. An extra wakeup
interrupt and pinctrl states for SDIO DAT1 pin state switching are
required in this scenario.

Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 .../devicetree/bindings/mmc/mtk-sd.yaml       | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 2a2e9fa8c188..e83bf10281d6 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -72,12 +72,27 @@ properties:
       - const: ahb_cg
 
   interrupts:
-    maxItems: 1
+    description:
+      Should at least contain MSDC GIC interrupt. To support SDIO in-band wakeup, an extended
+      interrupt is required and be configured as wakeup source irq.
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: msdc
+      - const: sdio_wakeup
 
   pinctrl-names:
+    description:
+      Should at least contain default and state_uhs. To support SDIO in-band wakeup, dat1 pin
+      will be switched between GPIO mode and SDIO DAT1 mode, state_eint and state_dat1 are
+      mandatory in this scenarios.
+    minItems: 2
     items:
       - const: default
       - const: state_uhs
+      - const: state_eint
 
   pinctrl-0:
     description:
@@ -89,6 +104,11 @@ properties:
       should contain uhs mode pin ctrl.
     maxItems: 1
 
+  pinctrl-2:
+    description:
+      should switch dat1 pin to GPIO mode.
+    maxItems: 1
+
   assigned-clocks:
     description:
       PLL of the source clock.
@@ -208,4 +228,32 @@ examples:
         mediatek,hs400-cmd-resp-sel-rising;
     };
 
+    mmc3: mmc@11260000 {
+        compatible = "mediatek,mt8173-mmc";
+        reg = <0x11260000 0x1000>;
+        clock-names = "source", "hclk";
+        clocks = <&pericfg CLK_PERI_MSDC30_3>,
+                 <&topckgen CLK_TOP_MSDC50_2_H_SEL>;
+        interrupt-names = "msdc", "sdio_wakeup";
+        interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_LOW 0>,
+                     <&pio 23 IRQ_TYPE_LEVEL_LOW>;
+        pinctrl-names = "default", "state_uhs", "state_eint";
+        pinctrl-0 = <&mmc2_pins_default>;
+        pinctrl-1 = <&mmc2_pins_uhs>;
+        pinctrl-2 = <&mmc2_pins_eint>;
+        bus-width = <4>;
+        max-frequency = <200000000>;
+        cap-sd-highspeed;
+        sd-uhs-sdr104;
+        keep-power-in-suspend;
+        wakeup-source;
+        cap-sdio-irq;
+        no-mmc;
+        no-sd;
+        non-removable;
+        vmmc-supply = <&sdio_fixed_3v3>;
+        vqmmc-supply = <&mt6397_vgp3_reg>;
+        mmc-pwrseq = <&wifi_pwrseq>;
+    };
+
 ...
-- 
2.25.1

