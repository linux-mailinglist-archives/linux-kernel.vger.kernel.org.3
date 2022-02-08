Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50D4ADBAE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378861AbiBHOzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378846AbiBHOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:55:16 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225C1C03FEF8;
        Tue,  8 Feb 2022 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644332114; x=1675868114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Yk6+mIAqQXnUtLkl5ADbRsIGvIy+eYl6I/IwK+2zswc=;
  b=V1xUOyS2mb9FYEMDvymlQNOsVoEEKbHroiwNoCabeYV7rd1HqkErDrVG
   A+7Rb8EaKdq6Bxk2Nm1YAmikjJM+yWwoMFmRUwh5ABtGs9whnu8ze5pcA
   x62gx5bIN8YYmCbjOLM4ZCy+7/wrZpMXavyvU370BcWWaHt6ZCsfOBaPz
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 06:55:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 06:55:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:55:13 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 06:55:08 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V5 6/6] arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp
Date:   Tue, 8 Feb 2022 20:22:20 +0530
Message-ID: <1644331940-18986-7-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add pm8008_infra and pm8008_regulators support for sc7280 idp.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V2:
 - As per Stephen's comments, replaced '_' with '-' for node names.

Changes in V3:
 - Changed the regulator node names as l1, l2 etc
 - Changed "pm8008-regulators" to "regulators"
 - Changed "qcom,min-dropout-voltage" to "regulator-min-dropout-voltage-microvolt"

Changes in V4:
 - Moved all common stuff to pm8008.dtsi and added board specific configurations here.

Changes in V5:
 - Changed the node names as per pm8008.dtsi
 - Moved supply nodes to chip level (mfd node).
 - Removed the regulator-mindropout property.

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 66 ++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b8..371ad19 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -263,6 +263,62 @@
 	};
 };
 
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	#include "pm8008.dtsi"
+};
+
+&pm8008_infra {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pm8008_active>;
+};
+
+&pm8008_regulators {
+	vdd_l1_l2-supply = <&vreg_s8b_1p2>;
+	vdd_l3_l4-supply = <&vreg_s1b_1p8>;
+	vdd_l5-supply = <&vreg_bob>;
+	vdd_l6-supply = <&vreg_bob>;
+	vdd_l7-supply = <&vreg_bob>;
+};
+
+&pm8008_l1 {
+	regulator-min-microvolt = <950000>;
+	regulator-max-microvolt = <1300000>;
+};
+
+&pm8008_l2 {
+	regulator-min-microvolt = <950000>;
+	regulator-max-microvolt = <1250000>;
+};
+
+&pm8008_l3 {
+	regulator-min-microvolt = <1650000>;
+	regulator-max-microvolt = <3000000>;
+};
+
+&pm8008_l4 {
+	regulator-min-microvolt = <1504000>;
+	regulator-max-microvolt = <1600000>;
+};
+
+&pm8008_l5 {
+	regulator-min-microvolt = <2600000>;
+	regulator-max-microvolt = <3000000>;
+};
+
+&pm8008_l6 {
+	regulator-min-microvolt = <2600000>;
+	regulator-max-microvolt = <3000000>;
+};
+
+&pm8008_l7 {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3544000>;
+};
+
 &qfprom {
 	vcc-supply = <&vreg_l1c_1p8>;
 };
@@ -375,6 +431,16 @@
 	drive-strength = <2>;
 };
 
+&pm8350c_gpios {
+	pm8008_active: pm8008_active {
+		pins = "gpio4";
+		function = "normal";
+		bias-disable;
+		output-high;
+		power-source = <0>;
+	};
+};
+
 &qspi_cs0 {
 	bias-disable;
 };
-- 
2.7.4

