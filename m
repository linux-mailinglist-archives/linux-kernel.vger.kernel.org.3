Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD544E25F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347128AbiCUMFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347125AbiCUMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:05:03 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F71244757;
        Mon, 21 Mar 2022 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647864217; x=1679400217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+CuPH+HypRoZXbuORf30rMah9KyYyENnN7sT2e3g5CY=;
  b=vcnYC7JKw0w7cnZvrVN8cijSakWV1xL59dDs8KYMNOaIeffXys5cp/33
   s0XcsIl0V867UCipmy4Qpicw/1zU8JAQgCaYys2JDQtk0POpsYOFXYm18
   mGkY0QNKa3eSNFt5Nt2UbwPa4aiAjFv8q4MdP+ioXPG9LN8Rnd181mL2g
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Mar 2022 05:03:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:03:36 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 05:03:36 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 05:03:31 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
Date:   Mon, 21 Mar 2022 17:29:18 +0530
Message-ID: <1647863959-3289-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647863959-3289-1-git-send-email-quic_srivasam@quicinc.com>
References: <1647863959-3289-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
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
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 21 +++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi           | 41 ++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

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
index 688fa95..4a7b18a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -462,7 +462,28 @@
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

