Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6E4F48B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384979AbiDEVss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355853AbiDELz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:55:26 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914A7BF4C;
        Tue,  5 Apr 2022 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649157203; x=1680693203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2ycaIj5IxG/RksZqMGqbZm+02qMbVViUT0wyO9DwMe4=;
  b=YMZc2pKgWT58kbxPwEqV3CURgBKT0HvzluLxsNsSX83mKNyefP6UaVfA
   j1Wru3wCiTcNSpv5jB3lW2al55GPWLbildF79CodME88fZSKTpQF6q+AV
   T9x0fX8nVad16FdDBm+e0zcy9SYwQeuK7xSpaP5kklzJqc5yRLMWqVS1I
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Apr 2022 04:13:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 04:13:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 04:13:09 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 04:13:04 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohitkr@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v6 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
Date:   Tue, 5 Apr 2022 16:42:46 +0530
Message-ID: <1649157167-29106-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649157167-29106-1-git-send-email-quic_srivasam@quicinc.com>
References: <1649157167-29106-1-git-send-email-quic_srivasam@quicinc.com>
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

Add AMP enable node and pinmux for primary and secondary I2S
for SC7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 34 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 20 +++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi           | 41 ++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index dc17f20..de646d9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -530,6 +530,26 @@ ap_ec_spi: &spi10 {
 	drive-strength = <2>;
 };
 
+&pri_mi2s_data0 {
+	drive-strength = <6>;
+};
+
+&pri_mi2s_data1 {
+	drive-strength = <6>;
+};
+
+&pri_mi2s_mclk {
+	drive-strength = <6>;
+};
+
+&pri_mi2s_sclk {
+	drive-strength = <6>;
+};
+
+&pri_mi2s_ws {
+	drive-strength = <6>;
+};
+
 &qspi_cs0 {
 	bias-disable;
 	drive-strength = <8>;
@@ -610,6 +630,20 @@ ap_ec_spi: &spi10 {
 	drive-strength = <10>;
 };
 
+&sec_mi2s_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&sec_mi2s_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&sec_mi2s_ws {
+	drive-strength = <6>;
+};
+
 /* PINCTRL - board-specific pinctrl */
 
 &pm7325_gpios {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b8..2afbbe3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -462,7 +462,27 @@
 	drive-strength = <10>;
 };
 
+&sec_mi2s_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&sec_mi2s_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&sec_mi2s_ws {
+	drive-strength = <6>;
+};
+
 &tlmm {
+	amp_en: amp-en {
+		pins = "gpio63";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
 	bt_en: bt-en {
 		pins = "gpio85";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index f0b64be..8d8cec5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3527,6 +3527,31 @@
 				function = "pcie1_clkreqn";
 			};
 
+			pri_mi2s_data0: pri-mi2s-data0 {
+				pins = "gpio98";
+				function = "mi2s0_data0";
+			};
+
+			pri_mi2s_data1: pri-mi2s-data1 {
+				pins = "gpio99";
+				function = "mi2s0_data1";
+			};
+
+			pri_mi2s_mclk: pri-mi2s-mclk {
+				pins = "gpio96";
+				function = "pri_mi2s";
+			};
+
+			pri_mi2s_sclk: pri-mi2s-sclk {
+				pins = "gpio97";
+				function = "mi2s0_sck";
+			};
+
+			pri_mi2s_ws: pri-mi2s-ws {
+				pins = "gpio100";
+				function = "mi2s0_ws";
+			};
+
 			qspi_clk: qspi-clk {
 				pins = "gpio14";
 				function = "qspi_clk";
@@ -4261,6 +4286,22 @@
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
+
+			sec_mi2s_data0: sec-mi2s-data0 {
+				pins = "gpio107";
+				function = "mi2s1_data0";
+			};
+
+			sec_mi2s_sclk: sec-mi2s-sclk {
+				pins = "gpio106";
+				function = "mi2s1_sck";
+			};
+
+			sec_mi2s_ws: sec-mi2s-ws {
+				pins = "gpio108";
+				function = "mi2s1_ws";
+			};
+
 		};
 
 		imem@146a5000 {
-- 
2.7.4

