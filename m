Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4014B66B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiBOIzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:55:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiBOIzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:55:06 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A71160D3;
        Tue, 15 Feb 2022 00:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644915283; x=1676451283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=oEYEtCXQVxiXB3NBA5NM7Lh+uCEXxQ1+nZW7awHGa8o=;
  b=dkmwdl7PzsOG6MjEat4YIsVU/bxRE7bNyNmet5lGC510H2nYUHBKFwwZ
   sNXpeynNz5j+iv14b73l4CTzH/lOcpthkdf/Lr930bf34DMBVziwnUrT9
   PEjNVD8AaFXgwlAvVgE3Jk1u0uBn0RecwC8wlCiopzWEMO7xWhTiD1Yvh
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 00:54:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:54:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 00:54:42 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 00:54:38 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V6 6/6] arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp
Date:   Tue, 15 Feb 2022 14:23:51 +0530
Message-ID: <1644915231-7308-7-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Changes in V6:
 - No changes.

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

