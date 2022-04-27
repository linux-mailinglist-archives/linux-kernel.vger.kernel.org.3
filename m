Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE705511F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbiD0RNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbiD0RNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:13:41 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FA73AA4B;
        Wed, 27 Apr 2022 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651079429; x=1682615429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gDa4x6ig5LhgIGsVxyAAqW17uIgDW7wMzKHLc+1Lryg=;
  b=aVcwhQ3MWx94usfnwWNEGfnSedd+HEbMXbe/E8PyIzzEuOMsu6yFq1ZX
   msUIQfFkewWxzXzZmU4a53r13pREtFRRAstus3dugkw6zIKvBvgcEw5ZP
   bzxXzI63WMZlILnQvYADEwd6xkuNZGqAoeR8PeFV3MEsjS+e/iZAfToix
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2022 10:10:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:10:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 10:10:27 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 10:10:19 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v12 3/4] arm64: dts: qcom: sc7280: add lpass lpi pin controller node
Date:   Wed, 27 Apr 2022 22:39:42 +0530
Message-ID: <1651079383-7665-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
References: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  84 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107 +++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index fb1f4ca..2f863c0 100644
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
index 0242f1d..fe500f4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2083,6 +2083,113 @@
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
+			lpass_dmic01: dmic01 {
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
+			lpass_dmic01_sleep: dmic01-sleep {
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
+			lpass_dmic23: dmic23 {
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
+			lpass_dmic23_sleep: dmic23-sleep {
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
+			lpass_rx_swr: rx-swr {
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
+			lpass_rx_swr_sleep: rx-swr-sleep {
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
+			lpass_tx_swr: tx-swr {
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
+			lpass_tx_swr_sleep: tx-swr-sleep {
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

