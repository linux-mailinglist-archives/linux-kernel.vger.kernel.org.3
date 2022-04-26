Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E8510474
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353507AbiDZQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353378AbiDZQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:51:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B9E488B3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:46:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so22861352wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDUErSF+n1k4cG7IQv0rQoHbdfQHDvgwLI/ub82oI98=;
        b=kN1kjMj3AUcIxo+isiGbvhu7TC4PV+So7N1BvAQzcaE48QfCfbPjXiHPKOG6zQliuA
         ER+yoD75Uc33LlmE99guO8c7Ubxx8haampaZds46hwE/b6ZhPM5C3oAdiylNdirL+STx
         pSbXgv5rwilHw+43iW3IOCZJ0Hmt1GDZULXi0LPGK6KEPf6JUVJ3OuyEUn/EgoZin51p
         1JNHrR9MhvYCpXQ060nrxpEA7dqfa+hPyl/+5eFJlGKlyns+DEyoSsL6NAU5g/Drtpp2
         IQIvnM7ReE15C7n+NtMbu4ig2qJLOtcMrAOu8/xnFtvC0Gxa1duo6KQVTWkylLVfcnvm
         EQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDUErSF+n1k4cG7IQv0rQoHbdfQHDvgwLI/ub82oI98=;
        b=A/2Y9kvJWkx7cNmb0t19Blr5GBD6RyNvVzI+RTFONdQYietf2+y9ljjnxqA1ZE3eaG
         edYDZQCOS6XEAEWDav/ZWEYZUWA4QDKD2J4ozqrCYvudSq5VJzS/J4dcKeKwTVn5lo1m
         lud+4+1M+f8TIoJJQaM0bgECTy7tjMvQ4D9FPP1LsEoyfO+TvwEzOCmkA2FCr6DCMaXZ
         F3nYYGU1x+CniVP61acLMye2M5rChwV5Swcwjpfr7okJ7GlyqlSow0B1tT2GraVoC6wF
         y9zsmOA1qH9x+ItGhCcaAIxkvDzFPbLkiq2Nyg75YTZtcblKhCW9VnM3X0HvOj3iwIsU
         Tshg==
X-Gm-Message-State: AOAM531vJV2xVYaio1rQ0ftQBf24ISJegDbQYtImvNJBLHuRuKMjR6+t
        gueTSERIJXndSQEb8+peQOsIXA==
X-Google-Smtp-Source: ABdhPJwDpUz3osm/6WMOLqtZWzpqkpSglRhHXyNOzKVIBhSeAfIer9VL6SBEZjBTZd3EB5JnlNnqcw==
X-Received: by 2002:adf:fe47:0:b0:20a:c899:829f with SMTP id m7-20020adffe47000000b0020ac899829fmr18600290wrs.165.1650991575214;
        Tue, 26 Apr 2022 09:46:15 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm14499539wml.5.2022.04.26.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 09:46:14 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8183-pumpkin: add HDMI support
Date:   Tue, 26 Apr 2022 18:45:47 +0200
Message-Id: <20220426164547.434324-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426164547.434324-1-fparent@baylibre.com>
References: <20220426164547.434324-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8183 Pumpkin board has a micro-HDMI connector. HDMI support is
provided by an IT66121 DPI <-> HDMI bridge.

This commit enables DPI and add the node for the IT66121 bridge.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: rename pinctrl node names to not include any underscore

 .../boot/dts/mediatek/mt8183-pumpkin.dts      | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index ee912825cfc6..10b2c0500219 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -62,6 +62,18 @@ ntc {
 		pulldown-ohm = <0>;
 		io-channels = <&auxadc 0>;
 	};
+
+	connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "d";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_connector_out>;
+			};
+		};
+	};
 };
 
 &auxadc {
@@ -120,6 +132,41 @@ &i2c6 {
 	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
 	clock-frequency = <100000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	it66121hdmitx: hdmitx@4c {
+		compatible = "ite,it66121";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ite_pins>;
+		vcn33-supply = <&mt6358_vcn33_wifi_reg>;
+		vcn18-supply = <&mt6358_vcn18_reg>;
+		vrf12-supply = <&mt6358_vrf12_reg>;
+		reset-gpios = <&pio 160 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&pio>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x4c>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				it66121_in: endpoint {
+					bus-width = <12>;
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				hdmi_connector_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &mmc0 {
@@ -332,6 +379,67 @@ pins_clk {
 			input-enable;
 		};
 	};
+
+	ite_pins: ite-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_GPIO160>;
+			output-high;
+		};
+	};
+
+	dpi_func_pins: dpi-func-pins {
+		pins-dpi {
+			pinmux = <PINMUX_GPIO12__FUNC_I2S5_BCK>,
+				 <PINMUX_GPIO46__FUNC_I2S5_LRCK>,
+				 <PINMUX_GPIO47__FUNC_I2S5_DO>,
+				 <PINMUX_GPIO13__FUNC_DBPI_D0>,
+				 <PINMUX_GPIO14__FUNC_DBPI_D1>,
+				 <PINMUX_GPIO15__FUNC_DBPI_D2>,
+				 <PINMUX_GPIO16__FUNC_DBPI_D3>,
+				 <PINMUX_GPIO17__FUNC_DBPI_D4>,
+				 <PINMUX_GPIO18__FUNC_DBPI_D5>,
+				 <PINMUX_GPIO19__FUNC_DBPI_D6>,
+				 <PINMUX_GPIO20__FUNC_DBPI_D7>,
+				 <PINMUX_GPIO21__FUNC_DBPI_D8>,
+				 <PINMUX_GPIO22__FUNC_DBPI_D9>,
+				 <PINMUX_GPIO23__FUNC_DBPI_D10>,
+				 <PINMUX_GPIO24__FUNC_DBPI_D11>,
+				 <PINMUX_GPIO25__FUNC_DBPI_HSYNC>,
+				 <PINMUX_GPIO26__FUNC_DBPI_VSYNC>,
+				 <PINMUX_GPIO27__FUNC_DBPI_DE>,
+				 <PINMUX_GPIO28__FUNC_DBPI_CK>;
+		};
+	};
+
+	dpi_idle_pins: dpi-idle-pins {
+		pins-idle {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO46__FUNC_GPIO46>,
+				 <PINMUX_GPIO47__FUNC_GPIO47>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_GPIO14>,
+				 <PINMUX_GPIO15__FUNC_GPIO15>,
+				 <PINMUX_GPIO16__FUNC_GPIO16>,
+				 <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO18__FUNC_GPIO18>,
+				 <PINMUX_GPIO19__FUNC_GPIO19>,
+				 <PINMUX_GPIO20__FUNC_GPIO20>,
+				 <PINMUX_GPIO21__FUNC_GPIO21>,
+				 <PINMUX_GPIO22__FUNC_GPIO22>,
+				 <PINMUX_GPIO23__FUNC_GPIO23>,
+				 <PINMUX_GPIO24__FUNC_GPIO24>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>,
+				 <PINMUX_GPIO27__FUNC_GPIO27>,
+				 <PINMUX_GPIO28__FUNC_GPIO28>;
+		};
+	};
 };
 
 &mfg {
@@ -381,3 +489,16 @@ &scp {
 &dsi0 {
 	status = "disabled";
 };
+
+&dpi0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dpi_func_pins>;
+	pinctrl-1 = <&dpi_idle_pins>;
+	status = "okay";
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&it66121_in>;
+		};
+	};
+};
-- 
2.36.0

