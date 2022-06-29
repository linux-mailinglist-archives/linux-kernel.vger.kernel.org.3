Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7555F560537
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiF2QBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiF2QA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AE420BF2;
        Wed, 29 Jun 2022 09:00:25 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 057AA6601A28;
        Wed, 29 Jun 2022 17:00:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518424;
        bh=gqdq1+xz9/LOr4x7zjy0Q3+2j4Bwrp8jWZIH9ix1isE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJB2DZI25Uezk14CTkd4yAkAz0+oE4+EXH2g0f59vZgs5JIdEd1epUZS0U8pJc0AI
         65y+l2bKNEx8qd40agBs44u5rvqSjq2Z5h84khUSJUkp/SrPpIYj51E7xyiJXu6Bmn
         LPqkuuRFNlIYs7T3ArzN/CEN692EKy4FxevXo5v6W5fgDlBIf2f6bIQMYRamuA3wFK
         qDgJ0YqwGpmz34uNGYM1Y9wXrDKAthDGYvstTNdmxhQ2WMVcqiU6x6cyfwdvfK20KP
         9NEckruvJi+YNtZNexa4Ka5DpjhK9fd92cEu9ieT/9eKMdxe1xssJBYERbBlpes0xU
         At69IliUbtFgg==
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
Subject: [PATCH v4 14/19] arm64: dts: mediatek: asurada: Enable PCIe and add WiFi
Date:   Wed, 29 Jun 2022 11:59:51 -0400
Message-Id: <20220629155956.1138955-15-nfraprado@collabora.com>
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

Enable MT8192's PCIe controller and add support for the MT7921e WiFi
card that is present on that bus for the Asurada platform.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

(no changes since v3)

Changes in v3:
- Renamed regulator node to be generic

Changes in v2:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 69bb43f7b346..e59c178d3d26 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -66,6 +66,19 @@ pp3300_u: regulator-3v3-u {
 		vin-supply = <&pp3300_g>;
 	};
 
+	pp3300_wlan: regulator-3v3-wlan {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_wlan";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pp3300_wlan_pins>;
+		enable-active-high;
+		gpio = <&pio 143 GPIO_ACTIVE_HIGH>;
+	};
+
 	/* system wide switching 5.0V power rail */
 	pp5000_a: regulator-5v0-a {
 		compatible = "regulator-fixed";
@@ -84,6 +97,17 @@ ppvar_sys: regulator-var-sys {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		wifi_restricted_dma_region: wifi@c0000000 {
+			compatible = "restricted-dma-pool";
+			reg = <0 0xc0000000 0 0x4000000>;
+		};
+	};
 };
 
 &i2c0 {
@@ -144,6 +168,28 @@ &i2c7 {
 	pinctrl-0 = <&i2c7_pins>;
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+
+	pcie0: pcie@0,0 {
+		device_type = "pci";
+		reg = <0x0000 0 0 0 0>;
+		num-lanes = <1>;
+		bus-range = <0x1 0x1>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		wifi: wifi@0,0 {
+			reg = <0x10000 0 0 0 0x100000>,
+			      <0x10000 0 0x100000 0 0x100000>;
+			memory-region = <&wifi_restricted_dma_region>;
+		};
+	};
+};
+
 &pio {
 	/* 220 lines */
 	gpio-line-names = "I2S_DP_LRCK",
@@ -430,6 +476,34 @@ pins-bus {
 		};
 	};
 
+	pcie_pins: pcie-default-pins {
+		pins-pcie-wake {
+			pinmux = <PINMUX_GPIO63__FUNC_PCIE_WAKE_N>;
+			bias-pull-up;
+		};
+
+		pins-pcie-pereset {
+			pinmux = <PINMUX_GPIO64__FUNC_PCIE_PERESET_N>;
+		};
+
+		pins-pcie-clkreq {
+			pinmux = <PINMUX_GPIO65__FUNC_PCIE_CLKREQ_N>;
+			bias-pull-up;
+		};
+
+		pins-wifi-kill {
+			pinmux = <PINMUX_GPIO145__FUNC_GPIO145>; /* WIFI_KILL_L */
+			output-high;
+		};
+	};
+
+	pp3300_wlan_pins: pp3300-wlan-pins {
+		pins-pcie-en-pp3300-wlan {
+			pinmux = <PINMUX_GPIO143__FUNC_GPIO143>;
+			output-high;
+		};
+	};
+
 	spi1_pins: spi1-default-pins {
 		pins-cs-mosi-clk {
 			pinmux = <PINMUX_GPIO157__FUNC_SPI1_A_CSB>,
-- 
2.36.1

