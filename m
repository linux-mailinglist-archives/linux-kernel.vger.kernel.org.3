Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDD4B2879
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351128AbiBKOz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:55:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351111AbiBKOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:55:56 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF4133;
        Fri, 11 Feb 2022 06:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644591355; x=1676127355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=00rfHxZdjDwXHOWKxOImKn9XINXKvERPkITuMdoGgZU=;
  b=zFRYInRJaWExZXivmvEX2T+P/6qPusdL9hjIEMlAl65H7lKsh4aqlHKt
   laxY53x1gqaCeeb9ntL66S9dsQLzeEujmuh9qdAo0rpd8QhACYUTtpWbQ
   zpd6iDD2uj9KAsG+EDaMr4W0Oxhd8hQ5794CGAszT18U3THHkwlWIWu09
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Feb 2022 06:55:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:55:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 06:55:54 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 06:55:50 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [RESEND v3 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
Date:   Fri, 11 Feb 2022 20:25:04 +0530
Message-ID: <1644591305-6235-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644591305-6235-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644591305-6235-1-git-send-email-quic_srivasam@quicinc.com>
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
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 41 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b8..1089fa0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -375,6 +375,26 @@
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
 };
@@ -462,7 +482,28 @@
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
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
 	bt_en: bt-en {
 		pins = "gpio85";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 3572399..99d4ce2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3297,6 +3297,31 @@
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
@@ -4031,6 +4056,22 @@
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

