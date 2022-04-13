Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26F4FF93E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiDMOrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiDMOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:47:01 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658B05133B;
        Wed, 13 Apr 2022 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649861075; x=1681397075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=62WYanvFy+W9Ch+rMVnHjT/F6jZSf45IXkiBm1NbqbE=;
  b=YaJk0jGlq/JvtyQzqeR2Qmsar5oDNqAMVetzTJPLtLUwSM8It35bL9pk
   M9IbJ47VYKF5JnHMFP68BJ4K3IAitSzVE93GK8EaGzes0D8YijtVva6Or
   RZ5/I/4qqUHUylZiQ3zQodsUoNbV7lP7dn0KWSH8551ursc5gsBIEwNd+
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Apr 2022 07:44:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:44:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 07:44:34 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 07:44:29 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v9 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin controller node
Date:   Wed, 13 Apr 2022 20:14:07 +0530
Message-ID: <1649861047-7811-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649861047-7811-1-git-send-email-quic_srivasam@quicinc.com>
References: <1649861047-7811-1-git-send-email-quic_srivasam@quicinc.com>
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
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  84 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107 +++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 1fc94b5..110d9e9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -359,6 +359,90 @@
 	bias-disable;
 };
 
+&lpass_dmic01 {
+	clk {
+		drive-strength = <8>;
+	};
+};
+
+&lpass_dmic01_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	data {
+		pull-down;
+	};
+};
+
+&lpass_dmic23 {
+	clk {
+		drive-strength = <8>;
+	};
+};
+
+&lpass_dmic23_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	data {
+		pull-down;
+	};
+};
+
+&lpass_rx_swr {
+	clk {
+		drive-strength = <2>;
+		slew-rate = <1>;
+		bias-disable;
+	};
+
+	data {
+		drive-strength = <2>;
+		slew-rate = <1>;
+		bias-bus-hold;
+	};
+};
+
+&lpass_rx_swr_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	data {
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&lpass_tx_swr {
+	clk {
+		drive-strength = <2>;
+		slew-rate = <1>;
+		bias-disable;
+	};
+
+	data {
+		slew-rate = <1>;
+		bias-bus-hold;
+	};
+};
+
+&lpass_tx_swr_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	data {
+		bias-bus-hold;
+	};
+};
+
 &mi2s1_data0 {
 	drive-strength = <6>;
 	bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 6e6cfeda..50fea0e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1987,6 +1987,113 @@
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		lpass_tlmm: pinctrl@33c0000 {
+			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
+			reg = <0 0x033c0000 0x0 0x20000>,
+				<0 0x03550000 0x0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 15>;
+
+			#clock-cells = <1>;
+
+			lpass_dmic01: lpass-dmic01 {
+				clk {
+					pins = "gpio6";
+					function = "dmic1_clk";
+				};
+
+				data {
+					pins = "gpio7";
+					function = "dmic1_data";
+				};
+			};
+
+			lpass_dmic01_sleep: lpass-dmic01-sleep {
+				clk {
+					pins = "gpio6";
+					function = "dmic1_clk";
+				};
+
+				data {
+					pins = "gpio7";
+					function = "dmic1_data";
+				};
+			};
+
+			lpass_dmic23: lpass-dmic23 {
+				clk {
+					pins = "gpio8";
+					function = "dmic2_clk";
+				};
+
+				data {
+					pins = "gpio9";
+					function = "dmic2_data";
+				};
+			};
+
+			lpass_dmic23_sleep: lpass-dmic23-sleep {
+				clk {
+					pins = "gpio8";
+					function = "dmic2_clk";
+				};
+
+				data {
+					pins = "gpio9";
+					function = "dmic2_data";
+				};
+			};
+
+			lpass_rx_swr: lpass-rx-swr {
+				clk {
+					pins = "gpio3";
+					function = "swr_rx_clk";
+				};
+
+				data {
+					pins = "gpio4", "gpio5";
+					function = "swr_rx_data";
+				};
+			};
+
+			lpass_rx_swr_sleep: lpass-rx-swr-sleep {
+				clk {
+					pins = "gpio3";
+					function = "swr_rx_clk";
+				};
+
+				data {
+					pins = "gpio4", "gpio5";
+					function = "swr_rx_data";
+				};
+			};
+
+			lpass_tx_swr: lpass-tx-swr {
+				clk {
+					pins = "gpio0";
+					function = "swr_tx_clk";
+				};
+
+				data {
+					pins = "gpio1", "gpio2", "gpio14";
+					function = "swr_tx_data";
+				};
+			};
+
+			lpass_tx_swr_sleep: lpass-tx-swr-sleep {
+				clk {
+					pins = "gpio0";
+					function = "swr_tx_clk";
+				};
+
+				data {
+					pins = "gpio1", "gpio2", "gpio14";
+					function = "swr_tx_data";
+				};
+			};
+		};
+
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-635.0", "qcom,adreno";
 			reg = <0 0x03d00000 0 0x40000>,
-- 
2.7.4

