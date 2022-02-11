Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1A4B2889
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351175AbiBKO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:57:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbiBKO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:57:50 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C894;
        Fri, 11 Feb 2022 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644591469; x=1676127469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=z3VE6JETenrtSUhhCtZ7LPvwdVBwN+RBTT4mBZYSqww=;
  b=F0OFvuruLGRgXiUTDqVUYgwMfrIfvx61iYmjB0DjCbuIcKEuiR7O0QyJ
   sI7vgIb4+LWCRqxVK08LAH5Ogft7HCXB6h7c3ng13A9M553n9DBXQ5p4W
   yAxiCbnwCOEjCywPc37wJ3l26D7PYSNTmqsxQofyCUK2cb6znO8we02Z4
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 06:57:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:57:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 06:57:48 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 06:57:43 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v4 3/3] arm64: dts: qcom: sc7280: add sound card support
Date:   Fri, 11 Feb 2022 20:27:18 +0530
Message-ID: <1644591438-6514-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644591438-6514-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644591438-6514-1-git-send-email-quic_srivasam@quicinc.com>
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

This patch adds sound card support for MTP using WCD938x headset playback,
capture, I2S Speaker Playback and DMICs via VA macro.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts  |  8 +++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 93 ++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index dd23b63..fa84fa8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -88,6 +88,14 @@ ap_ts_pen_1v8: &i2c13 {
 	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
 };
 
+&sound {
+	audio-routing =
+		"VA DMIC0", "MIC BIAS1",
+		"VA DMIC1", "MIC BIAS1",
+		"VA DMIC2", "MIC BIAS3",
+		"VA DMIC3", "MIC BIAS3";
+};
+
 &tlmm {
 	tp_int_odl: tp-int-odl {
 		pins = "gpio7";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 4339483..d3db2e2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -58,6 +58,99 @@
 		pinctrl-0 = <&nvme_pwren>;
 	};
 
+	sound: sound-card {
+		compatible = "google,sc7280-herobrine";
+		model = "sc7280-wcd938x-max98360a-1mic";
+		status = "okay";
+		audio-routing =
+				"IN1_HPHL", "HPHL_OUT",
+				"IN2_HPHR", "HPHR_OUT",
+				"AMIC1", "MIC BIAS1",
+				"AMIC2", "MIC BIAS2",
+				"VA DMIC0", "MIC BIAS3",
+				"VA DMIC1", "MIC BIAS3",
+				"VA DMIC2", "MIC BIAS1",
+				"VA DMIC3", "MIC BIAS1",
+				"TX SWR_ADC0", "ADC1_OUTPUT",
+				"TX SWR_ADC1", "ADC2_OUTPUT",
+				"TX SWR_ADC2", "ADC3_OUTPUT",
+				"TX SWR_DMIC0", "DMIC1_OUTPUT",
+				"TX SWR_DMIC1", "DMIC2_OUTPUT",
+				"TX SWR_DMIC2", "DMIC3_OUTPUT",
+				"TX SWR_DMIC3", "DMIC4_OUTPUT",
+				"TX SWR_DMIC4", "DMIC5_OUTPUT",
+				"TX SWR_DMIC5", "DMIC6_OUTPUT",
+				"TX SWR_DMIC6", "DMIC7_OUTPUT",
+				"TX SWR_DMIC7", "DMIC8_OUTPUT";
+
+		qcom,msm-mbhc-hphl-swh = <1>;
+		qcom,msm-mbhc-gnd-swh = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <0>;
+
+		dai-link@1 {
+			link-name = "Secondary MI2S Playback";
+			reg = <MI2S_SECONDARY>;
+			cpu {
+				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
+			};
+
+			codec {
+				sound-dai = <&max98360a>;
+			};
+		};
+
+		dai-link@5 {
+			link-name = "DP Playback";
+			reg = <LPASS_DP_RX>;
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_DP_RX>;
+			};
+
+			codec {
+				sound-dai = <&msm_dp>;
+			};
+		};
+
+		dai-link@6 {
+			link-name = "WCD Playback";
+			reg = <LPASS_CDC_DMA_RX0>;
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 0>, <&swr0 0>, <&rxmacro 0>;
+			};
+		};
+
+		dai-link@19 {
+			link-name = "WCD Capture";
+			reg = <LPASS_CDC_DMA_TX3>;
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 1>, <&swr1 0>, <&txmacro 0>;
+			};
+		};
+
+		dai-link@25 {
+			link-name = "DMIC Capture";
+			reg = <LPASS_CDC_DMA_VA_TX0>;
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
+			};
+
+			codec {
+				sound-dai = <&vamacro 0>;
+			};
+		};
+	};
+
 	wcd938x: codec {
 		compatible = "qcom,wcd9380-codec";
 		#sound-dai-cells = <1>;
-- 
2.7.4

