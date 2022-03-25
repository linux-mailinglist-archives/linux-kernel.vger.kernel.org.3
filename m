Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A784E729A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358253AbiCYMBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358158AbiCYMAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:00:55 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8751FCE2;
        Fri, 25 Mar 2022 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648209556; x=1679745556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Zb562oKu4RF+IsQLMY3xmQ9qdSlgjD71uneHcYeDDPk=;
  b=A+GhG1Kw+m/reKCeYAt1uIadnhkvLM6GYdQ+Lscu0oNx+hXdCtSNbubY
   FXU5z48leTcX6pJvQdmfNBXZgXw3RXqUQ5xVfvz7WmDbCCx4iSWw2Vbyv
   2RC/Z1n8nJlWxRWtxo7tA+RD97I+/5j9XYHG70W09JrcVTXt3zMzH+hgR
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Mar 2022 04:59:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:59:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:59:15 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:59:10 -0700
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
Subject: [PATCH V8 7/7] arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp
Date:   Fri, 25 Mar 2022 17:28:11 +0530
Message-ID: <1648209491-30165-8-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
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
Changes in V6:
 - No changes.

Changes in V7:
 - No Changes.

Changes in V8:
 - Add an extra phandle "pm8008_bus" and then include pm8008 dtsi files inside it.
 - Remove output-high from pm8008_active node.

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b8..0843e92 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -263,6 +263,67 @@
 	};
 };
 
+pm8008_bus: &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
+&pm8008_bus {
+	#include "pm8008-infra.dtsi"
+	#include "pm8008-regulators.dtsi"
+};
+
+&pm8008_infra {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pm8008_active>;
+
+	reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_HIGH>;
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
@@ -375,6 +436,15 @@
 	drive-strength = <2>;
 };
 
+&pm8350c_gpios {
+	pm8008_active: pm8008-active {
+		pins = "gpio4";
+		function = "normal";
+		bias-disable;
+		power-source = <0>;
+	};
+};
+
 &qspi_cs0 {
 	bias-disable;
 };
-- 
2.7.4

