Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C472C56A385
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiGGNYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiGGNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:24:15 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D672E6B0;
        Thu,  7 Jul 2022 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657200254; x=1688736254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=38phggMhdT45AjD8COyUIzPz435OG01zkwgBRQGBzt4=;
  b=mTUg3LDrq6XWDvPmspK+S6MB3qi03AfJThInweduVvuc1ow/rlNwH9+U
   Y4FPQUR6vBi5HQOehzms10qE+Jff2BdqvccCZFTX/Q4D9Vd8OhIIuDzsZ
   rkkMGcrFomO7IueNc5qHCrwh6Y375ptrn58VY+gyzhk2/vuqUNeaj6c+T
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Jul 2022 06:24:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 06:24:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 06:24:13 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 06:24:08 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v14 11/12] arm64: dts: qcom: sc7280: Add sound node for CRD 1.0/2.0 and IDP boards
Date:   Thu, 7 Jul 2022 18:53:03 +0530
Message-ID: <1657200184-29565-12-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657200184-29565-1-git-send-email-quic_srivasam@quicinc.com>
References: <1657200184-29565-1-git-send-email-quic_srivasam@quicinc.com>
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

Add dt nodes for sound card support on revision 3, 4
(aka CRD 1.0 and 2.0) and IDP boards, which is using WCD9385 headset
playback, capture, I2S speaker playback and DMICs via VA macro.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 23 +++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 98 ++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
index 9c21207..dddb505 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
@@ -87,6 +87,29 @@ ap_ts_pen_1v8: &i2c13 {
 	pins = "gpio51";
 };
 
+&sound {
+	audio-routing =
+		"IN1_HPHL", "HPHL_OUT",
+		"IN2_HPHR", "HPHR_OUT",
+		"AMIC1", "MIC BIAS1",
+		"AMIC2", "MIC BIAS2",
+		"VA DMIC0", "MIC BIAS1",
+		"VA DMIC1", "MIC BIAS1",
+		"VA DMIC2", "MIC BIAS3",
+		"VA DMIC3", "MIC BIAS3",
+		"TX SWR_ADC0", "ADC1_OUTPUT",
+		"TX SWR_ADC1", "ADC2_OUTPUT",
+		"TX SWR_ADC2", "ADC3_OUTPUT",
+		"TX SWR_DMIC0", "DMIC1_OUTPUT",
+		"TX SWR_DMIC1", "DMIC2_OUTPUT",
+		"TX SWR_DMIC2", "DMIC3_OUTPUT",
+		"TX SWR_DMIC3", "DMIC4_OUTPUT",
+		"TX SWR_DMIC4", "DMIC5_OUTPUT",
+		"TX SWR_DMIC5", "DMIC6_OUTPUT",
+		"TX SWR_DMIC6", "DMIC7_OUTPUT",
+		"TX SWR_DMIC7", "DMIC8_OUTPUT";
+};
+
 &wcd9385 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&wcd_reset_n>, <&us_euro_hs_sel>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index b8405d5..b3a5a2d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -85,6 +85,104 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&nvme_pwren>;
 	};
+
+	sound: sound {
+		compatible = "google,sc7280-herobrine";
+		model = "sc7280-wcd938x-max98360a-1mic";
+
+		audio-routing =
+			"IN1_HPHL", "HPHL_OUT",
+			"IN2_HPHR", "HPHR_OUT",
+			"AMIC1", "MIC BIAS1",
+			"AMIC2", "MIC BIAS2",
+			"VA DMIC0", "MIC BIAS3",
+			"VA DMIC1", "MIC BIAS3",
+			"VA DMIC2", "MIC BIAS1",
+			"VA DMIC3", "MIC BIAS1",
+			"TX SWR_ADC0", "ADC1_OUTPUT",
+			"TX SWR_ADC1", "ADC2_OUTPUT",
+			"TX SWR_ADC2", "ADC3_OUTPUT",
+			"TX SWR_DMIC0", "DMIC1_OUTPUT",
+			"TX SWR_DMIC1", "DMIC2_OUTPUT",
+			"TX SWR_DMIC2", "DMIC3_OUTPUT",
+			"TX SWR_DMIC3", "DMIC4_OUTPUT",
+			"TX SWR_DMIC4", "DMIC5_OUTPUT",
+			"TX SWR_DMIC5", "DMIC6_OUTPUT",
+			"TX SWR_DMIC6", "DMIC7_OUTPUT",
+			"TX SWR_DMIC7", "DMIC8_OUTPUT";
+
+		qcom,msm-mbhc-hphl-swh = <1>;
+		qcom,msm-mbhc-gnd-swh = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <0>;
+
+		dai-link@0 {
+			link-name = "MAX98360A";
+			reg = <0>;
+
+			cpu {
+				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
+			};
+
+			codec {
+				sound-dai = <&max98360a>;
+			};
+		};
+
+		dai-link@1 {
+			link-name = "DisplayPort";
+			reg = <1>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_DP_RX>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp>;
+			};
+		};
+
+		dai-link@2 {
+			link-name = "WCD9385 Playback";
+			reg = <2>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
+			};
+
+			codec {
+				sound-dai = <&wcd9385 0>, <&swr0 0>, <&lpass_rx_macro 0>;
+			};
+		};
+
+		dai-link@3 {
+			link-name = "WCD9385 Capture";
+			reg = <3>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
+			};
+
+			codec {
+				sound-dai = <&wcd9385 1>, <&swr1 0>, <&lpass_tx_macro 0>;
+			};
+		};
+
+		dai-link@4 {
+			link-name = "DMIC";
+			reg = <4>;
+
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_va_macro 0>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
-- 
2.7.4

