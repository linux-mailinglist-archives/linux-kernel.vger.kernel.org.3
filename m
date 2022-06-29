Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A455D56052B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiF2QBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiF2QAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5441C91E;
        Wed, 29 Jun 2022 09:00:20 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7CD8E6601977;
        Wed, 29 Jun 2022 17:00:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518419;
        bh=4spTm+nSjWESSW3qtK2fAkjQznUiCUQIQixr1OG7tGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIyvFqwi7EKzy9XT184H158DbWBDB7JOhQ08VdfYt4F5mrlkQR81QZjh/owIfw382
         6+KedYF88uUo+tKUxPm0XYJh6FWv2SZzvo/1L414dxp2AjBBLArzEbthknC29ZOa0e
         8n1HzV21JpgAewjKYpUWSGCRldi8s1Yq5Q/HczZLcTa6Vq8X+/9u/Q5bieQrae0mQq
         V9SDFI/2uXYJXDTByXUhdS/Gemjmc5KMpqd4U1ynyZdyVIWYL8KvphnHKIgpQ4kE67
         OcYtqyf0Lc0hdGjPVob2BC0GxGjIJcnGVdGAMnPl+lTAm08M0KEDpGG1E6OoEvn91V
         mN3JeqN2ZjX3A==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 11/19] arm64: dts: mediatek: asurada: Add I2C touchscreen
Date:   Wed, 29 Jun 2022 11:59:48 -0400
Message-Id: <20220629155956.1138955-12-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629155956.1138955-1-nfraprado@collabora.com>
References: <20220629155956.1138955-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All machines of the Asurada platform have a touchscreen at address 0x10
in the I2C0 bus, but the devices vary: Spherion has the Elan eKTH3500
touchscreen, while Hayato has a generic HID-over-i2c touchscreen.

Add common support for the touchscreens on the platform and the
specifics in each board file.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---

(no changes since v1)

 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  7 ++++++
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  4 +++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 25 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
index ca18fcf2ad4f..1e91491945f6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -38,3 +38,10 @@ MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
 		CROS_STD_MAIN_KEYMAP
 	>;
 };
+
+&touchscreen {
+	compatible = "hid-over-i2c";
+	post-power-on-delay-ms = <10>;
+	hid-descr-addr = <0x0001>;
+	vdd-supply = <&pp3300_u>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index 30b03895de41..42db81e95fae 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -40,3 +40,7 @@ MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
 		CROS_STD_MAIN_KEYMAP
 	>;
 };
+
+&touchscreen {
+	compatible = "elan,ekth3500";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 4de4235cb768..6eace280c14a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -92,6 +92,13 @@ &i2c0 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
+
+	touchscreen: touchscreen@10 {
+		reg = <0x10>;
+		interrupts-extended = <&pio 21 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+	};
 };
 
 &i2c1 {
@@ -454,6 +461,24 @@ pins-int-n {
 			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
 		};
 	};
+
+	touchscreen_pins: touchscreen-default-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO21__FUNC_GPIO21>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO137__FUNC_GPIO137>;
+			output-high;
+		};
+
+		pins-report-sw {
+			pinmux = <PINMUX_GPIO138__FUNC_GPIO138>;
+			output-low;
+		};
+	};
 };
 
 &spi1 {
-- 
2.36.1

