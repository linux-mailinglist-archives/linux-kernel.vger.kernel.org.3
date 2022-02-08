Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20564ADC59
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379756AbiBHPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379750AbiBHPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:19:22 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE12C061578;
        Tue,  8 Feb 2022 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644333561; x=1675869561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Hr+erJv13IsDCdHfbYTGqKmwd31gTxSGKV+RdCXu8+8=;
  b=uguSAumhNz9M7nz0w4ogHeX2OLzf1KitGX+biyndm+2YHrPpZbFPg5yM
   XE+5z2Zhxo7JDE9Hl1/MuJ0mQ2CVcbJ28y/RVVt0IRDLZVeHK7I8+H/p3
   By30O12b6eLkUku37Qtx+7nl/gRCUGT+eJ66MUuq1A+DswkIuhmF1UZ/1
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 07:19:21 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:19:20 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:19:19 -0800
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:19:13 -0800
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <dianders@chromium.org>,
        <krzysztof.kozlowski@canonical.com>, <thierry.reding@gmail.com>,
        <sam@ravnborg.org>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <quic_kalyant@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_mkrishn@quicinc.com>
Subject: [PATCH v2 2/4] arm64: dts: qcom: sc7280: Add support for eDP panel on CRD
Date:   Tue, 8 Feb 2022 20:48:43 +0530
Message-ID: <1644333525-30920-3-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644333525-30920-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1644333525-30920-1-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the eDP display panel support without HPD on sc7280 platform.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---

Changes in v2:
  - sort node references alphabetically
  - improve readability
  - move the pwm pinctrl to pwm node
  - move the regulators to root
  - define backlight power
  - remove dummy regulator node
  - cleanup pinctrl definitions

 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 122 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi    |   2 -
 2 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index e2efbdd..bff2707 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -21,6 +21,34 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	backlight_power: backlight-power {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight_power";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_bl_power>;
+	};
+
+	edp_power: edp-power {
+		compatible = "regulator-fixed";
+		regulator-name = "edp_power";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 80 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_panel_power>;
+	};
 };
 
 &apps_rsc {
@@ -76,6 +104,42 @@ ap_ts_pen_1v8: &i2c13 {
 	};
 };
 
+&edp_out {
+	remote-endpoint = <&edp_panel_in>;
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_edp {
+	status = "okay";
+
+	vdda-1p2-supply = <&vreg_l6b_1p2>;
+	vdda-0p9-supply = <&vreg_l10c_0p8>;
+};
+
+&mdss_edp_phy {
+	status = "okay";
+
+	vdda-1p2-supply = <&vreg_l6b_1p2>;
+	vdda-0p9-supply = <&vreg_l10c_0p8>;
+};
+
+&mdss_dp {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp_hot_plug_det>;
+	data-lanes = <0 1>;
+	vdda-1p2-supply = <&vreg_l6b_1p2>;
+	vdda-0p9-supply = <&vreg_l1b_0p8>;
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 &nvme_3v3_regulator {
 	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
 };
@@ -84,7 +148,65 @@ ap_ts_pen_1v8: &i2c13 {
 	pins = "gpio51";
 };
 
+&pm8350c_pwm {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&edp_bl_pwm>;
+};
+
+&pm8350c_gpios {
+	edp_bl_power: edp-bl-power {
+		pins = "gpio7";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		bias-disable;
+		output-low;
+	};
+
+	edp_bl_pwm: edp-bl-pwm {
+		pins = "gpio8";
+		function = "func1";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&soc {
+	edp_backlight: edp-backlight {
+		compatible = "pwm-backlight";
+
+		power-supply = <&backlight_power>;
+		pwms = <&pm8350c_pwm 3 65535>;
+	};
+
+	edp_panel: edp_panel {
+		compatible = "sharp,lq140m1jw46";
+
+		power-supply = <&edp_power>;
+		backlight = <&edp_backlight>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				reg = <0>;
+				edp_panel_in: endpoint {
+					remote-endpoint = <&edp_out>;
+				};
+			};
+		};
+	};
+};
+
 &tlmm {
+	edp_panel_power: edp-panel-power {
+		pins = "gpio80";
+		function = "gpio";
+		bias-pull-down;
+	};
+
 	tp_int_odl: tp-int-odl {
 		pins = "gpio7";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 3572399..f8fa716 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3012,8 +3012,6 @@
 
 			mdss_edp: edp@aea0000 {
 				compatible = "qcom,sc7280-edp";
-				pinctrl-names = "default";
-				pinctrl-0 = <&edp_hot_plug_det>;
 
 				reg = <0 0xaea0000 0 0x200>,
 				      <0 0xaea0200 0 0x200>,
-- 
2.7.4

