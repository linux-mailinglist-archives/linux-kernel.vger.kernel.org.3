Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD261465E49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhLBGf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbhLBGfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:35:54 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043CDC061574;
        Wed,  1 Dec 2021 22:32:31 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z8so52856508ljz.9;
        Wed, 01 Dec 2021 22:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=le05bcxI6qEp4A6rwcm3kbEAXd8KBoY+NNLIKqTMopA=;
        b=nUk9g7IMPF4IHQ9w+5L6E19cJXabzZXUp6krT6XJP0F//YIboMgnfdKXZEaaD2tnQv
         QtPqjujzb/1XE6i0MS2wFinM/zxkUgkz0J4heFdCajm0HA5c0IepTKNYX3KfEQ2h5Dm9
         tiETD3/1MEAtJIjE0qyyz+UFeJnx8KKjDVIPP7MizppRHOe4Y1iPVH99aKX1Y1m6GXdH
         mE3XxQFd+yxS5bZZB/Ma8E2dzrZsL0h8zmva9QV26Qy4/0+/le36sPK1XHJ6EYkcEXXF
         U6X1pIdz4KmbyBKB1oX3tkNRUL4OkCpX8ws45eAmx8AGTLstSOWnKsgPx7owCPrCk+9l
         pGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=le05bcxI6qEp4A6rwcm3kbEAXd8KBoY+NNLIKqTMopA=;
        b=Tq7J9fL58LNJDwEcmrYAx7UqkEysLoJBStIXvdxDrB/Ns6+yixwwQ19IzMfE5c89/9
         u7QYmA70GtokRGbtCDTk522PB0TofyL4AcvcUkuETuOc7kTCAAU80avdump2y3Xh5kB2
         QF0KRgd2tdMKzAFr5XiwocW1xrCihr51WL1O7JS0YjknsfPRUYywTmBJhNvnWtxjfcIq
         tcE1k4LkSgqzcqb5s0jMhBrxb09togDb+yc6aBSwSq3DVtaT/s9l/NKtD82AIe67UB83
         4TP8NJBo09OkeDiWijE7XD/G1FjqFIzARGw+hXUqmZo4GWAxePZpZOSgZ77e2qZYAZni
         XBFQ==
X-Gm-Message-State: AOAM532rchH2ZNm/NXo6if1D0kTx7lX55RTvqV5vPgz6oiMtmpbRlqcd
        7UWSaNXo/MQuObAQZVnsWZLYVR8Cuys=
X-Google-Smtp-Source: ABdhPJznexTDGYzNtedI/YHj9y1zBzsg9CWzw8pIUXtxC3vkfTA3fq+tjbj7cct1gdfobIKKU8RVgQ==
X-Received: by 2002:a2e:a785:: with SMTP id c5mr9877970ljf.384.1638426749923;
        Wed, 01 Dec 2021 22:32:29 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id m15sm226556lfg.165.2021.12.01.22.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 22:32:29 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH REBASE] dt-bindings: pinctrl: use pinctrl.yaml
Date:   Thu,  2 Dec 2021 07:32:16 +0100
Message-Id: <20211202063216.24439-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Also fix some examples to avoid warnings like:
brcm,ns-pinmux.example.dt.yaml: pin-controller@1800c1c0: $nodename:0: 'pin-controller@1800c1c0' does not match '^pinctrl|pinmux@[0-9a-f]+$'

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
---
REBASE after 1dd19cae1552 ("dt-bindings: pinctrl: uniphier: Add child
node definitions to describe pin mux and configuration").
---
 .../devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml | 3 +++
 .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml     | 1 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml        | 3 +++
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml          | 3 +++
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml          | 3 +++
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml          | 3 +++
 .../devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml | 3 +++
 .../bindings/pinctrl/brcm,bcm63268-pinctrl.yaml           | 3 +++
 .../devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml | 3 +++
 .../devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml | 3 +++
 .../devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml | 3 +++
 .../devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml | 3 +++
 .../devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml       | 3 ++-
 .../devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml    | 7 +++++--
 .../devicetree/bindings/pinctrl/cirrus,lochnagar.yaml     | 3 +++
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml        | 3 +++
 .../devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml   | 3 +++
 .../devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml   | 3 +++
 .../devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml   | 3 +++
 .../devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml   | 3 +++
 .../devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml  | 3 +++
 .../devicetree/bindings/pinctrl/ingenic,pinctrl.yaml      | 8 ++++----
 .../devicetree/bindings/pinctrl/intel,lgm-io.yaml         | 3 +++
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml         | 3 +++
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml         | 3 +++
 .../bindings/pinctrl/mediatek,mt6797-pinctrl.yaml         | 3 +++
 .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml         | 3 +++
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml         | 3 +++
 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml         | 3 +++
 .../devicetree/bindings/pinctrl/pinctrl-mt8192.yaml       | 3 +++
 .../devicetree/bindings/pinctrl/pinctrl-mt8195.yaml       | 3 +++
 .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml | 3 +++
 .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml          | 3 +++
 .../devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml | 1 +
 .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml | 3 +++
 .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml | 3 +++
 .../devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml | 3 +++
 .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml  | 3 +++
 .../devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml | 1 +
 .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml   | 3 +++
 .../devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml  | 3 +++
 .../devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml  | 1 +
 .../devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml  | 1 +
 .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml  | 3 +++
 .../devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml  | 1 +
 .../devicetree/bindings/pinctrl/qcom,tlmm-common.yaml     | 3 +++
 .../devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml | 3 +++
 .../devicetree/bindings/pinctrl/renesas,pfc.yaml          | 3 +++
 .../devicetree/bindings/pinctrl/renesas,rza1-ports.yaml   | 3 +++
 .../devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml | 3 +++
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml           | 3 +++
 .../devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml | 3 +++
 .../devicetree/bindings/pinctrl/rockchip,pinctrl.yaml     | 3 +++
 .../bindings/pinctrl/socionext,uniphier-pinctrl.yaml      | 6 +++---
 .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml     | 3 +++
 .../bindings/pinctrl/toshiba,visconti-pinctrl.yaml        | 5 ++++-
 .../devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml    | 3 +++
 .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml  | 3 +++
 58 files changed, 165 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml
index 3f94f6944740..fb0f69ce9c16 100644
--- a/Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml
@@ -184,6 +184,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index cce63c3cc463..bfce850c2035 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -147,6 +147,7 @@ allOf:
   # boards are defining it at the moment so it would generate a lot of
   # warnings.
 
+  - $ref: "pinctrl.yaml#"
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 07b00de79755..61fc05840eb3 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -67,6 +67,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index 100bb6dea3ec..c689bea7ce6e 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -50,6 +50,9 @@ patternProperties:
                   TXD3, TXD4, UART6, USB11D1, USB11H2, USB2D1, USB2H1, USBCKI, VGABIOS_ROM,
                   VGAHS, VGAVS, VPI18, VPI24, VPI30, VPO12, VPO24, WDTRST1, WDTRST2]
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
 
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 904697bc9415..d316cc082107 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -62,6 +62,9 @@ patternProperties:
                   USB11BHID, USB2AD, USB2AH, USB2BD, USB2BH, USBCKI, VGABIOSROM, VGAHS,
                   VGAVS, VPI24, VPO, WDTRST1, WDTRST2]
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - aspeed,external-nodes
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index ad2866c99738..57b68d6c7c70 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -83,6 +83,9 @@ patternProperties:
                   UART7, UART8, UART9, USBA, USBB, VB, VGAHS, VGAVS, WDTRST1, WDTRST2,
                   WDTRST3, WDTRST4]
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
 
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
index 08995a4f854b..ab019a1998e8 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
@@ -37,6 +37,9 @@ patternProperties:
         enum: [ gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpio7,
                 gpio8, gpio9, gpio10, gpio11, gpio12, gpio13, gpio40 ]
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
index 58ffed44b3c4..8c9d4668c8c4 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
@@ -41,6 +41,9 @@ patternProperties:
                 vdsl_phy_override_1_grp, vdsl_phy_override_2_grp,
                 vdsl_phy_override_3_grp, dsl_gpio8, dsl_gpio9 ]
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
index 0fd24f40afb1..a8e22ec02215 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
@@ -36,6 +36,9 @@ patternProperties:
                 gpio20, gpio25, gpio26, gpio27, gpio28, hsspi_cs1,
                 usb_port1 ]
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
index 0c3ce256aa78..35867355a47a 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
@@ -34,6 +34,9 @@ patternProperties:
         enum: [ ebi_cs_grp, uart1_grp, serial_led_grp, legacy_led_grp,
                 led_grp, spi_cs_grp, utopia_grp, pwm_syn_clk, sys_irq_grp ]
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
index 6f68fee373bd..b584d4b27223 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
@@ -41,6 +41,9 @@ patternProperties:
                 gpio15, gpio16, gpio17, gpio18, gpio19, gpio20, gpio21,
                 gpio22, gpio23, gpio24, gpio25, gpio26, gpio27, nand_grp ]
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
index f4168b9f4460..229323d9237d 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
@@ -42,6 +42,9 @@ patternProperties:
                 gpio24, gpio25, gpio26, gpio27, gpio28, gpio29, gpio30,
                 gpio31, uart1_grp ]
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml
index fc39e3e9f71c..8d1e5b1cdd5f 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml
@@ -53,6 +53,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
+  - $ref: "pinctrl.yaml#"
   - if:
       properties:
         compatible:
@@ -77,7 +78,7 @@ additionalProperties: false
 
 examples:
   - |
-    pin-controller@1800c1c0 {
+    pinctrl@1800c1c0 {
         compatible = "brcm,bcm4708-pinmux";
         reg = <0x1800c1c0 0x24>;
         reg-names = "cru_gpio_control";
diff --git a/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml b/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
index 46fbc73ab26b..a44691d9c57d 100644
--- a/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
@@ -137,6 +137,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
@@ -151,9 +154,9 @@ examples:
     #include <dt-bindings/clock/k210-clk.h>
     #include <dt-bindings/reset/k210-rst.h>
 
-    fpioa: pinmux@502B0000 {
+    fpioa: pinmux@502b0000 {
       compatible = "canaan,k210-fpioa";
-      reg = <0x502B0000 0x100>;
+      reg = <0x502b0000 0x100>;
       clocks = <&sysclk K210_CLK_FPIOA>,
                <&sysclk K210_CLK_APB0>;
       clock-names = "ref", "pclk";
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
index a07dd197176a..80020539c3bb 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
@@ -181,6 +181,9 @@ properties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - gpio-controller
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
index 4cb174bf31ff..e50d7ad5c229 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
@@ -117,6 +117,9 @@ properties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - pinctrl-0
   - pinctrl-names
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
index 6d7d162e6171..6717f163390b 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
@@ -58,6 +58,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
index 7131cfd1fc45..b1cdbb56d4e4 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
@@ -58,6 +58,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
index d474bc1f393b..4eed3a4e153a 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
@@ -58,6 +58,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
index 0af2b6c95c17..d4a8ea5551a5 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
@@ -58,6 +58,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
index 86622c4f374b..693398d88223 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
@@ -56,6 +56,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
index a12d0ceb7637..c2c370448b81 100644
--- a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
@@ -28,9 +28,6 @@ maintainers:
   - Paul Cercueil <paul@crapouillou.net>
 
 properties:
-  nodename:
-    pattern: "^pinctrl@[0-9a-f]+$"
-
   compatible:
     oneOf:
       - enum:
@@ -121,6 +118,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
@@ -169,7 +169,7 @@ additionalProperties:
 
 examples:
   - |
-    pin-controller@10010000 {
+    pinctrl@10010000 {
       compatible = "ingenic,jz4770-pinctrl";
       reg = <0x10010000 0x600>;
 
diff --git a/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml b/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
index 2c0acb405e6c..b42548350188 100644
--- a/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
@@ -47,6 +47,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index f8e6e138dc13..6953c958ff7c 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -64,6 +64,9 @@ required:
   - gpio-controller
   - "#gpio-cells"
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 patternProperties:
   '-[0-9]+$':
     type: object
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 152c151c27ad..e7601c0f5a69 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -59,6 +59,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
index 76a6df75ed9c..d42215f59afd 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
@@ -45,6 +45,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
index 0feecd376c69..78a0175cecc7 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
@@ -42,6 +42,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 7602b11e8bce..4eadea55df10 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -56,6 +56,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
index cc1509e9b981..2d13a57b8961 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
@@ -56,6 +56,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
index c4c071211611..3c84676a167d 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -108,6 +108,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index 5e2bb2bf3a55..3cf74df12862 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
@@ -187,6 +187,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index c64c93206817..b83c7f476e19 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -118,6 +118,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
index e47ebf934daf..5c5542f1627c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
@@ -103,6 +103,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
index 3b02dc6626ed..f7bd4be1739e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
@@ -14,6 +14,7 @@ description: |
   MDM9607 platform.
 
 allOf:
+  - $ref: "pinctrl.yaml#"
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index 040d2ada3669..ab4a2b4cfda2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -97,6 +97,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
index abe9f4c9b1e3..64c0a41ca0c3 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
@@ -133,6 +133,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
index 13f338619d77..206f4f238736 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -118,6 +118,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index 7d6a2ab10eec..6c7c3f6a140e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -123,6 +123,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
index a82dab898395..86509172603d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
@@ -14,6 +14,7 @@ description: |
   SC8180X platform.
 
 allOf:
+  - $ref: "pinctrl.yaml#"
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index 112dd59ce7ed..a38090b14aab 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
@@ -118,6 +118,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
index 8fc06f6a3ef4..cfcde405d30a 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
@@ -121,6 +121,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
index 5f7adaa81f83..c8eec845ade9 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
@@ -13,6 +13,7 @@ description: |
   in the SM6125 platform.
 
 allOf:
+  - $ref: "pinctrl.yaml#"
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
index 554992a681f3..898608671c4b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
@@ -14,6 +14,7 @@ description: |
   in the SM6350 platform.
 
 allOf:
+  - $ref: "pinctrl.yaml#"
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index 8508c57522fd..cfa2c50fdb93 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -115,6 +115,9 @@ patternProperties:
 
       additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
index 4f2667ea2805..6b7789db2f75 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
@@ -14,6 +14,7 @@ description: |
   in the SM8350 platform.
 
 allOf:
+  - $ref: "pinctrl.yaml#"
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
index 3b37cf102d41..be8cb0ead62f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
@@ -51,6 +51,9 @@ properties:
       should not be accessed by the OS. Please see the ../gpio/gpio.txt for more
       information.
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - interrupts
   - interrupt-controller
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
index b32f2676cab5..f0c52feb24d7 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
@@ -44,6 +44,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
 
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
index ac4e068aa03f..8548e3639b75 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
@@ -70,6 +70,9 @@ properties:
   power-domains:
     maxItems: 1
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
index 7f80578dc229..8ed4b98a1628 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
@@ -31,6 +31,9 @@ properties:
   reg:
     maxItems: 1
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
index ce1f7343788f..d761fddc2206 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
@@ -72,6 +72,9 @@ patternProperties:
 
       additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index ef68dabcf4dc..302785d7d771 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -90,6 +90,9 @@ additionalProperties:
       additionalProperties:
         $ref: "#/additionalProperties/anyOf/0"
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
index 4a43af0d6e02..70b1788ab594 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
@@ -31,6 +31,9 @@ properties:
     description:
       The bus clock, sometimes described as pclk, for register accesses.
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index 07c0a98ef9c6..b0eae3a67ab1 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -67,6 +67,9 @@ properties:
 
   ranges: true
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - rockchip,grf
diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
index 27c5762b9cf8..14a8c0215cc6 100644
--- a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
 
 properties:
-  $nodename:
-    pattern: "pinctrl"
-
   compatible:
     enum:
       - socionext,uniphier-ld4-pinctrl
@@ -62,6 +59,9 @@ additionalProperties:
 
     unevaluatedProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
 
diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
index ac88e01ec430..83a18d0331b1 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
@@ -183,6 +183,9 @@ patternProperties:
         required:
           - pinmux
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - '#address-cells'
diff --git a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
index 9f1dab0c2430..306524885a2b 100644
--- a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
@@ -20,6 +20,9 @@ properties:
   reg:
     maxItems: 1
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
@@ -80,7 +83,7 @@ examples:
         #address-cells = <2>;
         #size-cells = <2>;
 
-        pmux: pmux@24190000 {
+        pmux: pinmux@24190000 {
             compatible = "toshiba,tmpv7708-pinctrl";
             reg = <0 0x24190000 0 0x10000>;
 
diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
index ac97dbf6998e..cfd0cc549a7b 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
@@ -167,6 +167,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: "pinctrl.yaml#"
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
index 8ef0d07d35fe..2722dc7bb03d 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
@@ -290,6 +290,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: pinctrl.yaml#
+
 required:
   - compatible
 
-- 
2.31.1

