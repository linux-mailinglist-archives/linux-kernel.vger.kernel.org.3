Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A354E4F4DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582866AbiDEXuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355868AbiDELz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:55:26 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12EDF25;
        Tue,  5 Apr 2022 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649157203; x=1680693203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vHMukNzZ0vGwzv5HpHfAgBPnVXGeYIp4RttOVHI381w=;
  b=UevOKzN95Th49d55Bkmo/7VRY1JdrfCZq3GSVOGIaFJqiiPBKbFwGWbi
   R3SFq47uW44HDRhsdan96m3JZSm7+UPbLicZl+cFvABUOzPktnpPMSLf+
   DU3rojwyjgMxeMMssFwzVW7cc6LwQ9O9BRGcVAx6OV63v9lkmWLiGX3N1
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Apr 2022 04:13:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 04:13:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 04:13:13 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 04:13:09 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohitkr@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v6 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin controller node
Date:   Tue, 5 Apr 2022 16:42:47 +0530
Message-ID: <1649157167-29106-3-git-send-email-quic_srivasam@quicinc.com>
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

Add LPASS LPI pinctrl node required for Audio functionality on sc7280
based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  98 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107 +++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 2afbbe3..f912a89 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -238,6 +238,104 @@
 	modem-init;
 };
 
+&lpass_tlmm {
+	dmic01_active: dmic01-active {
+		clk {
+			drive-strength = <8>;
+		};
+
+		data {
+			drive-strength = <8>;
+		};
+	};
+
+	dmic01_sleep: dmic01-sleep {
+		clk {
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		data {
+			drive-strength = <2>;
+			pull-down;
+		};
+	};
+
+	dmic23_active: dmic02-active {
+		clk {
+			drive-strength = <8>;
+		};
+
+		data {
+			drive-strength = <8>;
+		};
+	};
+
+	dmic23_sleep: dmic02-sleep {
+		clk {
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		data {
+			drive-strength = <2>;
+			pull-down;
+		};
+	};
+
+	rx_swr_active: rx-swr-active {
+		clk {
+			drive-strength = <2>;
+			slew-rate = <1>;
+			bias-disable;
+		};
+
+		data {
+			drive-strength = <2>;
+			slew-rate = <1>;
+			bias-bus-hold;
+		};
+	};
+
+	rx_swr_sleep: rx-swr-sleep {
+		clk {
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		data {
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	tx_swr_active: tx-swr-active {
+		clk {
+			drive-strength = <2>;
+			slew-rate = <1>;
+			bias-disable;
+		};
+
+		data {
+			drive-strength = <2>;
+			slew-rate = <1>;
+			bias-bus-hold;
+		};
+	};
+
+	tx_swr_sleep: tx-swr-sleep {
+		clk {
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		data {
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+	};
+};
+
 &pcie1 {
 	status = "okay";
 	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8d8cec5..db74fc3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1987,6 +1987,113 @@
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		lpass_tlmm: pinctrl@33c0000 {
+			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
+			reg = <0 0x33c0000 0x0 0x20000>,
+				<0 0x3550000 0x0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 15>;
+
+			#clock-cells = <1>;
+
+			dmic01_active: dmic01-active {
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
+			dmic01_sleep: dmic01-sleep {
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
+			dmic23_active: dmic02-active {
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
+			dmic23_sleep: dmic02-sleep {
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
+			rx_swr_active: rx-swr-active {
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
+			rx_swr_sleep: rx-swr-sleep {
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
+			tx_swr_active: tx-swr-active {
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
+			tx_swr_sleep: tx-swr-sleep {
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

