Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9363E4B0CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbiBJL6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:58:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiBJL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:58:10 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A71E2620;
        Thu, 10 Feb 2022 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644494291; x=1676030291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NimGNzxyuv501FWg4UNKvO1dFkUp4SFl9IWlki6DaLI=;
  b=HVuHiAO2ZRvrsC7ebpINyPNycSQsrOYZXPFd8My2L4HJTROeDWJmylqz
   prSH0E8gG1NS2N3uXmsXP2kzjUEAn+Kj0JjU7Ctxjsmq3Fd206N4oU6a7
   60qqr1jqkkL5SehImlxRNrzKGKvfnm5IF9Gm5zAnViqm+NyJgv2PwiIdN
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 03:58:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 03:58:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 03:58:09 -0800
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 03:58:03 -0800
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
        <quic_khsieh@quicinc.com>, <quic_mkrishn@quicinc.com>,
        <quic_vproddut@quicinc.com>
Subject: [PATCH v4 2/5] arm64: dts: qcom: sc7280: Add support for eDP panel on CRD
Date:   Thu, 10 Feb 2022 17:27:32 +0530
Message-ID: <1644494255-6632-3-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644494255-6632-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1644494255-6632-1-git-send-email-quic_sbillaka@quicinc.com>
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

Changes in v4:
  - Create new patch for name changes
  - Remove output-low

Changes in v3:
  - Sort the nodes alphabetically
  - Use - instead of _ as node names
  - Place the backlight and panel nodes under root
  - Change the name of edp_out to mdss_edp_out
  - Change the names of regulator nodes
  - Delete unused properties in the board file


Changes in v2:
  - Sort node references alphabetically
  - Improve readability
  - Move the pwm pinctrl to pwm node
  - Move the regulators to root
  - Define backlight power
  - Remove dummy regulator node
  - Cleanup pinctrl definitions

 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 120 ++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index e2efbdd..6dba5ac 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -21,6 +21,59 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	backlight_3v3_regulator: backlight-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight_3v3_regulator";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_bl_power>;
+	};
+
+	edp_3v3_regulator: edp-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "edp_3v3_regulator";
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
+
+	edp_backlight: edp-backlight {
+		compatible = "pwm-backlight";
+
+		power-supply = <&backlight_3v3_regulator>;
+		pwms = <&pm8350c_pwm 3 65535>;
+	};
+
+	edp_panel: edp-panel {
+		compatible = "sharp,lq140m1jw46";
+
+		power-supply = <&edp_3v3_regulator>;
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
 };
 
 &apps_rsc {
@@ -76,6 +129,44 @@ ap_ts_pen_1v8: &i2c13 {
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
+&mdss_edp {
+	status = "okay";
+
+	vdda-1p2-supply = <&vreg_l6b_1p2>;
+	vdda-0p9-supply = <&vreg_l10c_0p8>;
+	/delete-property/ pinctrl-names;
+	/delete-property/ pinctrl-0;
+};
+
+&mdss_edp_phy {
+	status = "okay";
+
+	vdda-1p2-supply = <&vreg_l6b_1p2>;
+	vdda-0p9-supply = <&vreg_l10c_0p8>;
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 &nvme_3v3_regulator {
 	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
 };
@@ -84,7 +175,36 @@ ap_ts_pen_1v8: &i2c13 {
 	pins = "gpio51";
 };
 
+&pm8350c_gpios {
+	edp_bl_power: edp-bl-power {
+		pins = "gpio7";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		bias-pull-down;
+	};
+
+	edp_bl_pwm: edp-bl-pwm {
+		pins = "gpio8";
+		function = "func1";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		bias-pull-down;
+	};
+};
+
+&pm8350c_pwm {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&edp_bl_pwm>;
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
-- 
2.7.4

