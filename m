Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7CB4DB74B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357625AbiCPRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357672AbiCPRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:37:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9D69CC4;
        Wed, 16 Mar 2022 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647452202; x=1678988202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7NjOzSOcPGwwoD5QIu1bu+JxM1iFjfSzFCRR9ylUhJM=;
  b=n6i9hbPO3ZoG+ntBrLuoJqAoEkn6p75B8Hdzn/HTs1sqmaUDEOY8/MFF
   t/8dRlwU7dPlzArCE5oDqel1WEEDAdX2Id3gxQ7ep/kvbT0QzJtQEkgp2
   NJfwZ/z3FNZBLVaU0hfpWhoUP5igJmkJUgS/zzr5axwM+FAbfFCBfSsyQ
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 16 Mar 2022 10:36:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:36:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 10:36:41 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 10:36:33 -0700
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <sean@poorly.run>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <thierry.reding@gmail.com>, <sam@ravnborg.org>,
        <dmitry.baryshkov@linaro.org>, <quic_vproddut@quicinc.com>
Subject: [PATCH v5 2/9] arm64: dts: qcom: sc7280: Add support for eDP panel on CRD
Date:   Wed, 16 Mar 2022 23:05:47 +0530
Message-ID: <1647452154-16361-3-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com>
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

Enable support for eDP interface via aux_bus on CRD platform.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---

Changes in v5:
  - Change the order of patches
  - Remove the backlight nodes
  - Remove the bias setting
  - Fix compilation issue
  - Model VREG_EDP_BP for backlight power

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

 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 93 +++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index e2efbdd..2df654e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "sc7280-idp.dtsi"
 #include "sc7280-idp-ec-h1.dtsi"
 
@@ -21,6 +22,27 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
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
+	vreg_edp_bp: vreg-edp-bp-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_edp_bp";
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &apps_rsc {
@@ -76,6 +98,58 @@ ap_ts_pen_1v8: &i2c13 {
 	};
 };
 
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
+	data-lanes = <0 1 2 3>;
+	vdda-1p2-supply = <&vreg_l6b_1p2>;
+	vdda-0p9-supply = <&vreg_l10c_0p8>;
+
+	aux-bus {
+		edp_panel: edp-panel {
+			compatible = "edp-panel";
+
+			power-supply = <&edp_3v3_regulator>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					edp_panel_in: endpoint {
+						remote-endpoint = <&mdss_edp_out>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&mdss_edp_out {
+	remote-endpoint = <&edp_panel_in>;
+};
+
+&mdss_edp_phy {
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 &nvme_3v3_regulator {
 	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
 };
@@ -84,7 +158,26 @@ ap_ts_pen_1v8: &i2c13 {
 	pins = "gpio51";
 };
 
+&pm8350c_gpios {
+	edp_bl_power: edp-bl-power {
+		pins = "gpio7";
+		function = "normal";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+	};
+
+	edp_bl_pwm: edp-bl-pwm {
+		pins = "gpio8";
+		function = "func1";
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+	};
+};
+
 &tlmm {
+	edp_panel_power: edp-panel-power {
+		pins = "gpio80";
+		function = "gpio";
+	};
+
 	tp_int_odl: tp-int-odl {
 		pins = "gpio7";
 		function = "gpio";
-- 
2.7.4

