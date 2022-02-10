Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0284B10F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbiBJOwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:52:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbiBJOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:52:13 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721B7F06;
        Thu, 10 Feb 2022 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644504733; x=1676040733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IS4iTbJF5rtwuHj4hx7wSDunHMqvYb1+RVU3XQz/wIg=;
  b=KUwp1YwDoK0fVKXjhx/9btLQ4RRancg/l1Okq66aSTCgxlOwg/vcBetS
   9O1hft3zFAZBfp/qw3kpJffXnuyov3BeEpDeFVSAEd/xwxDmBk1rSVxwa
   ojDLs3YT+CXedL8GNZ8mUZaZuRNbt2oOCz2CcoX+jQRcY/iY3Y9kXIltw
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2022 06:52:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:52:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 06:52:12 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 06:52:07 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
Date:   Thu, 10 Feb 2022 20:21:49 +0530
Message-ID: <1644504710-944-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644504710-944-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644504710-944-1-git-send-email-quic_srivasam@quicinc.com>
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

Add AMP enable node and pinmux for primary and secondary I2S
for SC7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 41 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 42 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index d623d71..1a9b465 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -437,6 +437,26 @@
 	};
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
@@ -490,7 +510,28 @@
 	bias-pull-up;
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
 	nvme_pwren: nvme-pwren {
 		function = "gpio";
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 937c2e0..503d461 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3461,6 +3461,32 @@
 				};
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
+
 			qup_uart8_cts: qup-uart8-cts {
 				pins = "gpio32";
 				function = "qup10";
@@ -3620,6 +3646,22 @@
 				pins = "gpio63";
 				function = "qup17";
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

