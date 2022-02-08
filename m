Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F3D4ADCD2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380843AbiBHPgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377107AbiBHPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:36:42 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D0C061578;
        Tue,  8 Feb 2022 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644334602; x=1675870602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PY0ZbX6uZ51k5F7k09YtpVBSHY3rCFpFxxgM1Cs4Qvw=;
  b=lwe+8XEhmLyNyFp82JMJ08x++hLOsKs25+OJtq2cY5jyJmeRW6ipXJMz
   GIBwA1vmvfZPjj0RRWaDzTpN1Z7WCvPqXTB/M8PZKpxtrHbD2NzhRRDf4
   lGtO2NV210dNhr0vgLgFfiRlbKL2A1F/UIMHCcdDGmdJ6dA0vftJc3GUp
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Feb 2022 07:34:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:34:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:34:38 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:34:34 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sc7280: add lpass lpi pin controller node
Date:   Tue, 8 Feb 2022 21:04:13 +0530
Message-ID: <1644334454-16719-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
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

Add LPASS LPI pinctrl node required for Audio functionality on sc7280
based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 150 +++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index c7d6c46..4704a93 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -638,3 +638,153 @@
 		bias-pull-up;
 	};
 };
+&soc {
+	lpass_tlmm: pinctrl@33c0000 {
+		compatible = "qcom,sc7280-lpass-lpi-pinctrl";
+		reg = <0 0x33c0000 0x0 0x20000>,
+			<0 0x3550000 0x0 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&lpass_tlmm 0 0 15>;
+
+		#clock-cells = <1>;
+
+		dmic01_active: dmic01-active-pins {
+			clk {
+				pins = "gpio6";
+				function = "dmic1_clk";
+				drive-strength = <8>;
+				output-high;
+			};
+			data {
+				pins = "gpio7";
+				function = "dmic1_data";
+				drive-strength = <8>;
+				input-enable;
+			};
+		};
+
+		dmic01_sleep: dmic01-sleep-pins {
+			clk {
+				pins = "gpio6";
+				function = "dmic1_clk";
+				drive-strength = <2>;
+				bias-disable;
+				output-low;
+			};
+
+			data {
+				pins = "gpio7";
+				function = "dmic1_data";
+				drive-strength = <2>;
+				pull-down;
+				input-enable;
+			};
+		};
+
+		dmic23_active: dmic02-active-pins {
+			clk {
+				pins = "gpio8";
+				function = "dmic2_clk";
+				drive-strength = <8>;
+				output-high;
+			};
+			data {
+				pins = "gpio9";
+				function = "dmic2_data";
+				drive-strength = <8>;
+				input-enable;
+			};
+		};
+
+		dmic23_sleep: dmic02-sleep-pins {
+			clk {
+				pins = "gpio8";
+				function = "dmic2_clk";
+				drive-strength = <2>;
+				bias-disable;
+				output-low;
+			};
+
+			data {
+				pins = "gpio9";
+				function = "dmic2_data";
+				drive-strength = <2>;
+				pull-down;
+				input-enable;
+			};
+		};
+
+		rx_swr_active: rx_swr-active-pins {
+			clk {
+				pins = "gpio3";
+				function = "swr_rx_clk";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-disable;
+			};
+
+			data {
+				pins = "gpio4", "gpio5";
+				function = "swr_rx_data";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-bus-hold;
+			};
+		};
+
+		rx_swr_sleep: rx_swr-sleep-pins {
+			clk {
+				pins = "gpio3";
+				function = "swr_rx_clk";
+				drive-strength = <2>;
+				input-enable;
+				bias-pull-down;
+			};
+
+			data {
+				pins = "gpio4", "gpio5";
+				function = "swr_rx_data";
+				drive-strength = <2>;
+				input-enable;
+				bias-pull-down;
+			};
+		};
+
+		tx_swr_active: tx_swr-active-pins {
+			clk {
+				pins = "gpio0";
+				function = "swr_tx_clk";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-disable;
+			};
+
+			data {
+				pins = "gpio1", "gpio2", "gpio14";
+				function = "swr_tx_data";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-bus-hold;
+			};
+		};
+
+		tx_swr_sleep: tx_swr-sleep-pins {
+			clk {
+				pins = "gpio0";
+				function = "swr_tx_clk";
+				drive-strength = <2>;
+				input-enable;
+				bias-pull-down;
+			};
+
+			data {
+				pins = "gpio1", "gpio2", "gpio14";
+				function = "swr_tx_data";
+				drive-strength = <2>;
+				input-enable;
+				bias-bus-hold;
+			};
+		};
+	};
+};
-- 
2.7.4

