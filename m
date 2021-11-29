Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11954613F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243736AbhK2Lhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:37:50 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:63787 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhK2Lfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638185540; x=1669721540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aWyg/hqII2EESn63QJcDyH0xwS7gd8e0tsP16smAns4=;
  b=v8rUu/kzmUuH79fExrOaoM45ztSmVzuB8qete86qy+lKmyF3zeozg5Xc
   dKMD+omWmFucptbX/C9KrJ9LY8KlQXmtLPZ+0IDI7StPdBz+REYLgLbLK
   aGhcvUphd44WzcgjY2IzEZMWuHJKB8mes0LGCKOiDwytuM/fAMbrm1cEo
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 29 Nov 2021 03:32:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:32:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:32:19 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:32:16 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, <kgodara@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 3/4] arm64: dts: qcom: sc7280: Define EC and H1 nodes for IDP/CRD
Date:   Mon, 29 Nov 2021 17:01:36 +0530
Message-ID: <1638185497-26477-4-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
References: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kshitiz Godara <kgodara@codeaurora.org>

The IDP2 and CRD boards share the EC and H1 parts, so define
all related device nodes into a common file and include them
in the idp2 and crd dts files to avoid duplication.

Signed-off-by: Kshitiz Godara <kgodara@codeaurora.org>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts        |   1 +
 arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi | 105 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts       |   1 +
 3 files changed, 107 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index 2da6603..1e3e2f3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-idp.dtsi"
+#include "sc7280-idp-ec-h1.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
new file mode 100644
index 0000000..0896a61
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * sc7280 EC/H1 over SPI (common between IDP2 and CRD)
+ *
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+ap_ec_spi: &spi10 {
+	status = "okay";
+
+	pinctrl-0 = <&qup_spi10_data_clk>, <&qup_spi10_cs_gpio_init_high>, <&qup_spi10_cs_gpio>;
+	cs-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
+
+	cros_ec: ec@0 {
+		compatible = "google,cros-ec-spi";
+		reg = <0>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ap_ec_int_l>;
+		spi-max-frequency = <3000000>;
+
+		cros_ec_pwm: ec-pwm {
+			compatible = "google,cros-ec-pwm";
+			#pwm-cells = <1>;
+		};
+
+		i2c_tunnel: i2c-tunnel {
+			compatible = "google,cros-ec-i2c-tunnel";
+			google,remote-bus = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		typec {
+			compatible = "google,cros-ec-typec";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb_c0: connector@0 {
+				compatible = "usb-c-connector";
+				reg = <0>;
+				label = "left";
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "source";
+			};
+
+			usb_c1: connector@1 {
+				compatible = "usb-c-connector";
+				reg = <1>;
+				label = "right";
+				power-role = "dual";
+				data-role = "host";
+				try-power-role = "source";
+			};
+		};
+	};
+};
+
+#include <arm/cros-ec-keyboard.dtsi>
+#include <arm/cros-ec-sbs.dtsi>
+
+ap_h1_spi: &spi14 {
+	status = "okay";
+
+	pinctrl-0 = <&qup_spi14_data_clk>, <&qup_spi14_cs_gpio_init_high>, <&qup_spi14_cs_gpio>;
+	cs-gpios = <&tlmm 59 GPIO_ACTIVE_LOW>;
+
+	cr50: tpm@0 {
+		compatible = "google,cr50";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&h1_ap_int_odl>;
+		spi-max-frequency = <800000>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <104 IRQ_TYPE_EDGE_RISING>;
+	};
+};
+
+&tlmm {
+	ap_ec_int_l: ap-ec-int-l {
+		pins = "gpio18";
+		function = "gpio";
+		input-enable;
+		bias-pull-up;
+	};
+
+	h1_ap_int_odl: h1-ap-int-odl {
+		pins = "gpio104";
+		function = "gpio";
+		input-enable;
+		bias-pull-up;
+	};
+
+	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high {
+		pins = "gpio43";
+		output-high;
+	};
+
+	qup_spi14_cs_gpio_init_high: qup-spi14-cs-gpio-init-high {
+		pins = "gpio59";
+		output-high;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
index 3ae9969..0382c77 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-idp.dtsi"
+#include "sc7280-idp-ec-h1.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU2 platform";
-- 
2.7.4

