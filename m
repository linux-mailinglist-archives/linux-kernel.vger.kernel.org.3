Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8EB5651E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiGDKOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiGDKNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:13:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9FD11F;
        Mon,  4 Jul 2022 03:13:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8ACA2660198D;
        Mon,  4 Jul 2022 11:13:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656929619;
        bh=F4XTdpmeLLBzARBbsr/g15mmfE1S0Zdj681HWBdHZeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFRDuScIM3T486D9EEH82Z/qHJcrJPM/Lfi6d7nloU0tYn2zk67XnE6IGPu5Wc++1
         dKHIgzZILXIhcrfwlpb/o8irqlQyCIzm4k0sx6XC+zZ/JHu1crgXt3lil6n8074sBB
         /lDQU5u9uYrR9VzTZoUEuqS0yb3tm6Je5M6BDT9NoL7fd87XJTtFt/+Im/y/JMBbkT
         FCTDpb8aCdpT/r0Gqqm2OVDokULmlZyOimXDL/i+eu+IrwJrjnrvSyOs3SSFiC8D6f
         c4s2HFka0bjPcVZ9p9+pwkMaTP8/FJolTVH2io/ERk/0qVHf2Cjtlk3J9y3Ar8WwDf
         IZstoYHSCp81w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        gtk3@inbox.ru, luca@z3ntu.xyz, sam.shih@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 11/11] arm64: dts: mediatek: cherry: Add I2C-HID touchscreen on I2C4
Date:   Mon,  4 Jul 2022 12:13:21 +0200
Message-Id: <20220704101321.44835-12-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
References: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
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

This platform carries a HID compatible I2C touchscreen on the i2c4 bus,
but it may be at a different address, depending on the board model.
Add the node for a touchscreen at 0x10, but enable it only in the
final board dts.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  4 +++
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  4 +++
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  4 +++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 28 +++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 7ca344ccc225..3348ba69ff6c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -9,3 +9,7 @@ / {
 	model = "Acer Tomato (rev1) board";
 	compatible = "google,tomato-rev1", "google,tomato", "mediatek,mt8195";
 };
+
+&ts_10 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index eb80f23273aa..4669e9d917f8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -29,3 +29,7 @@ pins-low-power-pcie0-disable {
 		bias-pull-down;
 	};
 };
+
+&ts_10 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index f9cdda07da88..5021edd02f7c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -30,3 +30,7 @@ pins-low-power-pcie0-disable {
 		bias-pull-down;
 	};
 };
+
+&ts_10 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 2c8b760d0da1..fcc600674339 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -145,6 +145,18 @@ &i2c4 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c4_pins>;
+
+	ts_10: touchscreen@10 {
+		compatible = "hid-over-i2c";
+		reg = <0x10>;
+		hid-descr-addr = <0x0001>;
+		interrupts-extended = <&pio 92 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		post-power-on-delay-ms = <10>;
+		vdd-supply = <&pp3300_s3>;
+		status = "disabled";
+	};
 };
 
 &i2c5 {
@@ -609,6 +621,22 @@ subpmic_pin_irq: pins-subpmic-int-n {
 			bias-pull-up;
 		};
 	};
+
+	touchscreen_pins: touchscreen-default-pins {
+		pins-int-n {
+			pinmux = <PINMUX_GPIO92__FUNC_GPIO92>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+		pins-rst {
+			pinmux = <PINMUX_GPIO56__FUNC_GPIO56>;
+			output-high;
+		};
+		pins-report-sw {
+			pinmux = <PINMUX_GPIO57__FUNC_GPIO57>;
+			output-low;
+		};
+	};
 };
 
 &pmic {
-- 
2.35.1

