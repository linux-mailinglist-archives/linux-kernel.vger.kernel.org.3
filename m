Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF64F05CC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbiDBTaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbiDBTaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:30:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF2113D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 12:28:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bh17so12308387ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LyaA5oNQO5OuXiPbk5OIIbMXaiCWEbCXALdzmJEtNOw=;
        b=io2yNzQFocbxf/GN7IHJDdYKJdnlxFFdR59pq7HPwV0SFPqjAGO4uy6kB00KBUZDsO
         vUatcCT44pwS71J0TC/HuL9FVIiGKYxepmd1vPLe2lQEYd6mG2/8bIk1LenXPsFUDKUP
         V1Y0IjiY930OLV2odz+gVUF/ebhl+dcnnaWI7e1jvKgmU7sI5em0dfIZBhKKiCOgo3Wf
         zQ43anzd9bjxl4foU+Ks5JRPwua+kz5rkxnW15r6b5Vw+SB78ozzCIKGHmRGOX8K9NnN
         NRvCCsZaiJZEoagV2ABNCR8YMsIRFGIpAnQ3pmqFKaTdiDxUdOpA+mARqztyBL/UMYXJ
         rJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LyaA5oNQO5OuXiPbk5OIIbMXaiCWEbCXALdzmJEtNOw=;
        b=4hpeZCHLXsGJcTGaXym+Pzh7RQ4TZKJeKvOn+k/8gdQ5Ehhb64AXTQ7BV1FDHdSyon
         lWCmUbWf7AulM1F0kCc2I8xP0OK0jQhdSys3Y8HVURWRHNrumjtjA0rja4vvZ68dgGYQ
         6isq7d8wSQ7Qe3Kc5HhoBkfNLrNKoye09vOiWP4E5zly+yBaqCjKofvvCYUyaIXBR7Td
         hgMAtzlztrISB6luUZf05AoFmGxqh27ykaohI3N7YXo51tWIXE0aweDm9YVqvc8P+5Hc
         mV6fYzgIbUvqTvAklTDBa1k5fUSeajHWummMhk816NoI4vylwnXZ3GDMlVc0Fihctey/
         A0yQ==
X-Gm-Message-State: AOAM532MyyTSvzGURZXgguNCXBFyJQZBZ3Q1IjqtJWArdCy0kxFETaoI
        6ujBEYUdSIImlwdTLNE0E5AD/vkYqddwFLtb
X-Google-Smtp-Source: ABdhPJx3rgPTw/IeWjHD03K97q2qNv1msgi16+Yi+TijH4p2II07NldKpDvS/hO16DV/NYqcyBQpOw==
X-Received: by 2002:a17:907:7255:b0:6df:6b81:3872 with SMTP id ds21-20020a170907725500b006df6b813872mr5017865ejc.461.1648927703117;
        Sat, 02 Apr 2022 12:28:23 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm2408985ejk.119.2022.04.02.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:28:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: white-space cleanups
Date:   Sat,  2 Apr 2022 21:28:19 +0200
Message-Id: <20220402192819.154691-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove trailing white-spaces and trailing blank lines (yamllint when run
manually does not like them).

Suggested-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/samsung,exynos4412-isp-clock.yaml          | 1 -
 .../devicetree/bindings/crypto/allwinner,sun8i-ce.yaml        | 1 -
 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml    | 1 -
 .../bindings/display/bridge/google,cros-ec-anx7688.yaml       | 1 -
 Documentation/devicetree/bindings/display/bridge/ps8640.yaml  | 1 -
 .../devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml      | 1 -
 .../devicetree/bindings/display/mediatek/mediatek,merge.yaml  | 1 -
 .../devicetree/bindings/display/panel/ilitek,ili9341.yaml     | 1 -
 .../devicetree/bindings/display/panel/orisetech,otm8009a.yaml | 1 -
 .../bindings/display/sprd/sprd,display-subsystem.yaml         | 1 -
 Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml  | 1 -
 Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml    | 1 -
 Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml      | 1 -
 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml    | 1 -
 Documentation/devicetree/bindings/hwmon/adt7475.yaml          | 1 -
 Documentation/devicetree/bindings/i2c/i2c-gate.yaml           | 1 -
 Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.yaml      | 1 -
 Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml     | 1 -
 Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml   | 2 +-
 Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml   | 1 -
 .../devicetree/bindings/leds/backlight/qcom-wled.yaml         | 2 +-
 .../devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml   | 1 -
 Documentation/devicetree/bindings/media/microchip,xisc.yaml   | 1 -
 Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml   | 1 -
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml         | 2 +-
 .../devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml     | 1 -
 .../devicetree/bindings/power/supply/cw2015_battery.yaml      | 1 -
 .../devicetree/bindings/power/supply/power-supply.yaml        | 1 -
 Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml | 1 -
 .../devicetree/bindings/power/supply/tps65217-charger.yaml    | 2 +-
 .../bindings/regulator/socionext,uniphier-regulator.yaml      | 1 -
 .../devicetree/bindings/regulator/st,stm32-vrefbuf.yaml       | 1 -
 .../devicetree/bindings/reserved-memory/ramoops.yaml          | 1 -
 Documentation/devicetree/bindings/reset/microchip,rst.yaml    | 1 -
 Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml   | 1 -
 Documentation/devicetree/bindings/serial/sprd-uart.yaml       | 2 +-
 .../devicetree/bindings/soc/amlogic/amlogic,canvas.yaml       | 1 -
 Documentation/devicetree/bindings/sound/adi,adau1372.yaml     | 1 -
 .../devicetree/bindings/sound/amlogic,gx-sound-card.yaml      | 1 -
 Documentation/devicetree/bindings/sound/maxim,max98520.yaml   | 1 -
 Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml     | 2 +-
 Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml     | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml  | 1 -
 .../devicetree/bindings/sound/samsung,aries-wm8994.yaml       | 1 -
 Documentation/devicetree/bindings/sound/samsung,odroid.yaml   | 1 -
 Documentation/devicetree/bindings/sound/tas2562.yaml          | 1 -
 Documentation/devicetree/bindings/sound/tas2770.yaml          | 1 -
 .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml       | 1 -
 .../devicetree/bindings/spi/amlogic,meson6-spifc.yaml         | 1 -
 Documentation/devicetree/bindings/spi/renesas,hspi.yaml       | 1 -
 Documentation/devicetree/bindings/usb/dwc2.yaml               | 4 ++--
 Documentation/devicetree/bindings/usb/smsc,usb3503.yaml       | 2 +-
 52 files changed, 10 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml
index 1ed64add4355..7ad8a0c23b2a 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos4412-isp-clock.yaml
@@ -61,4 +61,3 @@ examples:
         clocks = <&clock CLK_ACLK200>, <&clock CLK_ACLK400_MCUISP>;
         clock-names = "aclk200", "aclk400_mcuisp";
     };
-
diff --git a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
index 00648f9d9278..026a9f9e1aeb 100644
--- a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
+++ b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
@@ -82,4 +82,3 @@ examples:
       clock-names = "bus", "mod";
       resets = <&ccu RST_BUS_CE>;
     };
-
diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
index 343598c9f473..2e208d2fc98f 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
@@ -150,4 +150,3 @@ examples:
              };
         };
     };
-
diff --git a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
index a88a5d8c7ba5..a44d025d33bd 100644
--- a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
@@ -78,4 +78,3 @@ examples:
             };
         };
     };
-
diff --git a/Documentation/devicetree/bindings/display/bridge/ps8640.yaml b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
index 186e17be51fb..8ab156e0a8cf 100644
--- a/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
@@ -119,4 +119,3 @@ examples:
             };
         };
     };
-
diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
index 0091df9dd73b..989ab312c1f4 100644
--- a/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
+++ b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
@@ -105,4 +105,3 @@ examples:
             };
         };
     };
-
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
index d635c5dcb68b..69ba75777dac 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
@@ -102,4 +102,3 @@ examples:
             clock-names = "merge";
         };
     };
-
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
index 20ce88ab4b3a..6058948a9764 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -75,4 +75,3 @@ examples:
              };
         };
 ...
-
diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
index 17cbd0ad32bf..ad7d3575190e 100644
--- a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
@@ -50,4 +50,3 @@ examples:
       };
     };
 ...
-
diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
index d0a5592bd89d..b3d5e1b96fae 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
@@ -63,4 +63,3 @@ examples:
         compatible = "sprd,display-subsystem";
         ports = <&dpu_out>;
     };
-
diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
index 01e2da23790b..d6ea4d62a2cf 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
@@ -75,4 +75,3 @@ examples:
     };
 
 ...
-
diff --git a/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml b/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
index 7b1833d6caa2..1e1d8549b7ef 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
+++ b/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
@@ -51,4 +51,3 @@ examples:
     };
 
 ...
-
diff --git a/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml b/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
index 87b4afd2cf62..00cfa3913652 100644
--- a/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
+++ b/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
@@ -104,4 +104,3 @@ examples:
     };
 
 ...
-
diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
index 62486f55177d..d60626ffb28e 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
@@ -53,4 +53,3 @@ examples:
         clocks = <&clock 278>;
         clock-names = "rotator";
     };
-
diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
index 7d9c083632b9..38879419c364 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -81,4 +81,3 @@ examples:
         adi,pwm-active-state = <1 0 1>;
       };
     };
-
diff --git a/Documentation/devicetree/bindings/i2c/i2c-gate.yaml b/Documentation/devicetree/bindings/i2c/i2c-gate.yaml
index bd67b0766599..0cdc3e890df7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-gate.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-gate.yaml
@@ -36,4 +36,3 @@ examples:
         };
     };
 ...
-
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.yaml
index 9b0603a72f40..b6af924dee2e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.yaml
@@ -28,7 +28,6 @@ description: |+
       '------------'                  '-----'  '-----'  '-----'
 
 
-
 allOf:
   - $ref: /schemas/i2c/i2c-mux.yaml#
 
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
index 930f9e3904d7..0b2f5dc80600 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
@@ -44,4 +44,3 @@ examples:
       };
     };
 ...
-
diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
index e51a585bd5a3..133b0f867992 100644
--- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
@@ -41,7 +41,7 @@ examples:
     spi {
       #address-cells = <1>;
       #size-cells = <0>;
-  
+
       dac@0 {
         compatible = "lltc,ltc1660";
         reg = <0>;
diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
index af51b91c893e..783c6b37c9f0 100644
--- a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
@@ -107,4 +107,3 @@ examples:
       power-domains = <&pd_gsc>;
       #iommu-cells = <0>;
     };
-
diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
index 1c24b333c6e2..5d66c3e4def5 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
@@ -81,7 +81,7 @@ properties:
     description: |
       kHz; switching frequency.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371, 1600, 1920, 
+    enum: [ 600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371, 1600, 1920,
             2400, 3200, 4800, 9600 ]
 
   qcom,ovp:
diff --git a/Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml b/Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml
index aa2b3bf56b57..ea06976fbbc7 100644
--- a/Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml
@@ -51,4 +51,3 @@ examples:
           interrupts = <208>, <209>, <210>;
           #mbox-cells = <1>;
     };
-
diff --git a/Documentation/devicetree/bindings/media/microchip,xisc.yaml b/Documentation/devicetree/bindings/media/microchip,xisc.yaml
index 086e1430af4f..40947f18873a 100644
--- a/Documentation/devicetree/bindings/media/microchip,xisc.yaml
+++ b/Documentation/devicetree/bindings/media/microchip,xisc.yaml
@@ -126,4 +126,3 @@ examples:
                 };
         };
     };
-
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
index a30419ef550a..b783ad0d1f53 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
@@ -142,4 +142,3 @@ examples:
                assigned-clock-parents = <&k3_clks 118 11>;
          };
     };
-
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index cdf7b873b419..82d0a6b2a0a0 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -302,7 +302,7 @@ examples:
         pcie0 {
             #size-cells = <2>;
             #address-cells = <3>;
- 
+
             wifi_0: wifi@0 {
                 reg = <0 0 0 0 0>;
                 memory-region = <&qcn9074_0>;
diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
index 7657721a4e96..86e5f6513bb3 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -40,4 +40,3 @@ examples:
             #power-domain-cells = <1>;
         };
     };
-
diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
index 2dda91587dc3..dc697b6147b2 100644
--- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
@@ -78,4 +78,3 @@ examples:
            power-supplies = <&mains_charger>, <&usb_charger>;
        };
     };
-
diff --git a/Documentation/devicetree/bindings/power/supply/power-supply.yaml b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
index 531b67225c74..9a490fbd32e1 100644
--- a/Documentation/devicetree/bindings/power/supply/power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
@@ -19,4 +19,3 @@ properties:
       supply it power, referenced by their phandles.
 
 additionalProperties: true
-
diff --git a/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
index a23f6653f332..93654e732cda 100644
--- a/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
@@ -87,4 +87,3 @@ examples:
         };
       };
     };
-
diff --git a/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
index a33408c3a407..2c2fe883bb48 100644
--- a/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
@@ -24,7 +24,7 @@ properties:
     items:
       - const: USB
       - const: AC
-      
+
 required:
   - compatible
   - interrupts
diff --git a/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml b/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
index 1218f21ba320..b48790cc05c8 100644
--- a/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
@@ -83,4 +83,3 @@ examples:
             resets = <&sys_rst 14>;
         };
     };
-
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml b/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
index 836d4156d54c..a5a27ee0a9e6 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
@@ -51,4 +51,3 @@ examples:
     };
 
 ...
-
diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
index f4c351a69542..0391871cf44d 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
@@ -142,4 +142,3 @@ examples:
             };
         };
     };
-
diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index 578bfa529b16..81cd8c837623 100644
--- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -57,4 +57,3 @@ examples:
         #reset-cells = <1>;
         cpu-syscon = <&cpu_ctrl>;
     };
-
diff --git a/Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml b/Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
index 61963fa9347e..067e71e8ebe8 100644
--- a/Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
@@ -33,4 +33,3 @@ examples:
       compatible = "intel,ixp46x-rng";
       reg = <0x70002100 4>;
     };
-
diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
index a444bebd2c1a..da0e2745b5fc 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
@@ -35,7 +35,7 @@ properties:
 
   clock-names:
     description: |
-      "enable" for UART module enable clock, "uart" for UART clock, "source" 
+      "enable" for UART module enable clock, "uart" for UART clock, "source"
       for UART source (parent) clock.
     items:
       - const: enable
diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
index 02b2d5ba01d6..17db87cb9dab 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
@@ -48,4 +48,3 @@ examples:
         compatible = "amlogic,canvas";
         reg = <0x48 0x14>;
     };
-
diff --git a/Documentation/devicetree/bindings/sound/adi,adau1372.yaml b/Documentation/devicetree/bindings/sound/adi,adau1372.yaml
index 701449311fec..59f7c60a14ba 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1372.yaml
+++ b/Documentation/devicetree/bindings/sound/adi,adau1372.yaml
@@ -64,4 +64,3 @@ examples:
         clock-frequency = <12288000>;
     };
 ...
-
diff --git a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
index 8b5be4b92f35..b4b35edcb493 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
@@ -112,4 +112,3 @@ examples:
                 };
         };
     };
-
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98520.yaml b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
index b6509cb2c8e0..3f88c7d61e34 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
@@ -33,4 +33,3 @@ examples:
         reg = <0x38>;
       };
     };
-
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml b/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
index 4a2129005c0f..970311143253 100644
--- a/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
+++ b/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 
 description:
-  The Microchip Sony/Philips Digital Interface Receiver is a serial port 
+  The Microchip Sony/Philips Digital Interface Receiver is a serial port
   compliant with the IEC-60958 standard.
 
 properties:
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
index bdfb63387c53..d5c022e49526 100644
--- a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
+++ b/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 
 description:
-  The Microchip Sony/Philips Digital Interface Transmitter is a serial port 
+  The Microchip Sony/Philips Digital Interface Transmitter is a serial port
   compliant with the IEC-60958 standard.
 
 properties:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml
index e768fb0e9a59..b1deaf271afa 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml
@@ -82,4 +82,3 @@ examples:
         clocks = <&clk 216>, <&clk 217>, <&clk 120>;
         clock-names = "pll_a", "pll_a_out0", "mclk";
     };
-
diff --git a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
index 97f83eeaf091..a01c4ad929b8 100644
--- a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
@@ -149,4 +149,3 @@ examples:
             sound-dai = <&wm8994>;
         };
     };
-
diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
index db2513f3e168..7b4e08ddef6a 100644
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
@@ -92,4 +92,3 @@ examples:
             sound-dai = <&hdmi>, <&max98090>;
         };
     };
-
diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index acd4bbe69731..5f7dd5d6cbca 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -76,4 +76,3 @@ examples:
        ti,imon-slot-no = <0>;
      };
    };
-
diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index 027bebf4e8cf..bc90e72bf7cf 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -80,4 +80,3 @@ examples:
        ti,vmon-slot-no = <2>;
      };
    };
-
diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 4d46c49ec32b..50de0da42c13 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -95,4 +95,3 @@ examples:
               reg = <0>;
           };
     };
-
diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
index 54b6f15eca18..8a9d526d06eb 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
@@ -52,4 +52,3 @@ examples:
               spi-max-frequency = <40000000>;
           };
     };
-
diff --git a/Documentation/devicetree/bindings/spi/renesas,hspi.yaml b/Documentation/devicetree/bindings/spi/renesas,hspi.yaml
index c0eccf703039..bab5d4b7fc3d 100644
--- a/Documentation/devicetree/bindings/spi/renesas,hspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,hspi.yaml
@@ -56,4 +56,3 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
     };
-
diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 4cebce682d16..17fc471a12bd 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -139,12 +139,12 @@ properties:
 
   snps,need-phy-for-wake:
     $ref: /schemas/types.yaml#/definitions/flag
-    description: If present indicates that the phy needs to be left on for 
+    description: If present indicates that the phy needs to be left on for
       remote wakeup during suspend.
 
   snps,reset-phy-on-wake:
     $ref: /schemas/types.yaml#/definitions/flag
-    description: If present indicates that we need to reset the PHY when we 
+    description: If present indicates that we need to reset the PHY when we
       detect a wakeup. This is due to a hardware errata.
 
   port:
diff --git a/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml b/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
index 39228a506b93..b9e219829801 100644
--- a/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
+++ b/Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
@@ -77,7 +77,7 @@ examples:
       i2c {
           #address-cells = <1>;
           #size-cells = <0>;
-        
+
           usb-hub@8 {
               compatible = "smsc,usb3503";
               reg = <0x08>;
-- 
2.32.0

