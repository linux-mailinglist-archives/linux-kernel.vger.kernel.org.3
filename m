Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D6A4F49C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450437AbiDEW1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442422AbiDEPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:37:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB2111DD8;
        Tue,  5 Apr 2022 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649166713; x=1680702713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5+nWAPFQHv6Q16Bxq/GwQj6VzCNcFVPIYMa5uQiSOBU=;
  b=ZNQLPuExRktDuO3QUPcaEEaJhceRk2h+SvKRHCwuU0S2g+0Yty7WBYBW
   f78U9xlsFPUap+/29LTjspm8aSHEHFVlaRHUYlBh+Xhdt3PCFlgKDdMOO
   9g6QYtkcVaXYQztJWcj8c3jGPRB5U4KCk8u0We7HLxvuiDpCporPcgpUi
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Apr 2022 06:51:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 06:51:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 06:51:36 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 06:51:32 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V9 6/6] arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp
Date:   Tue, 5 Apr 2022 19:20:33 +0530
Message-ID: <1649166633-25872-7-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add pm8008 infra and regulators support for sc7280 idp.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V6:
 - No changes.

Changes in V7:
 - No Changes.

Changes in V8:
 - Add an extra phandle "pm8008_bus" and then include pm8008 dtsi files inside it.
 - Remove output-high from pm8008_active node.

Changes in V9:
 - Added interrupts properties.

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b8..6f39c05 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -263,6 +263,65 @@
 	};
 };
 
+pm8008_bus: &i2c1 {
+	status = "okay";
+};
+
+#include "pm8008.dtsi"
+
+&pm8008 {
+	interrupt-parent = <&tlmm>;
+	interrupts = <24 IRQ_TYPE_EDGE_RISING>;
+
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
@@ -375,6 +434,15 @@
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

