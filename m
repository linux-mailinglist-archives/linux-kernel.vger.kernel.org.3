Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8624A8335
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiBCLde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:33:34 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:58617 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350273AbiBCLda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643888010; x=1675424010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=uWDrLlZaIqPWHGnc/osMu0ayYA5+sdohWnyXZzOBG3s=;
  b=GAg+FTLZRpC6guoT2+KeNZ0I4H2cmcbxBydVyxHEG214cXurpTponAeL
   9MV72MrSk615f4psQPxYOqg63SGli92NWbN9jE82kKW5rCH0mPeILWu56
   yZqo+k+QvaeRDeCreHyprS2wi7vwlberlZ37ujpmZwPDV0aBt9K8RMp/a
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Feb 2022 03:33:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 03:33:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 03:33:30 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 03:33:26 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v3 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
Date:   Thu, 3 Feb 2022 17:03:00 +0530
Message-ID: <1643887981-31011-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643887981-31011-1-git-send-email-quic_srivasam@quicinc.com>
References: <1643887981-31011-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lpass cpu node for audio on sc7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 28 +++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 59 ++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 2806888..a76b2d1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -691,3 +691,31 @@
 &vamacro {
 	vdd-micb-supply = <&vreg_bob>;
 };
+
+&lpass_cpu {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sec_mi2s_active>;
+
+	mi2s-secondary@1 {
+		reg = <MI2S_SECONDARY>;
+		qcom,playback-sd-lines = <0>;
+	};
+
+	hdmi-primary@5 {
+		reg = <LPASS_DP_RX>;
+	};
+
+	wcd-rx@6 {
+		reg = <LPASS_CDC_DMA_RX0>;
+	};
+
+	wcd-tx@19 {
+		reg = <LPASS_CDC_DMA_TX3>;
+	};
+
+	va-tx@25 {
+		reg = <LPASS_CDC_DMA_VA_TX0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 946eb01..c2da5ce 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -17,6 +17,7 @@
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -1847,6 +1848,64 @@
 			#size-cells = <0>;
 		};
 
+		lpass_cpu: audio-subsystem@3260000 {
+			compatible = "qcom,sc7280-lpass-cpu";
+			reg = <0 0x3260000 0 0xC000>,
+			      <0 0x3280000 0 0x29000>,
+			      <0 0x3340000 0 0x29000>,
+			      <0 0x336C000 0 0x3000>,
+			      <0 0x3987000 0 0x68000>,
+			      <0 0x3B00000 0 0x29000>;
+			reg-names = "lpass-rxtx-cdc-dma-lpm",
+				    "lpass-rxtx-lpaif",
+				    "lpass-va-lpaif",
+				    "lpass-va-cdc-dma-lpm",
+				    "lpass-hdmiif",
+				    "lpass-lpaif";
+
+			iommus = <&apps_smmu 0x1820 0>,
+				 <&apps_smmu 0x1821 0>,
+				 <&apps_smmu 0x1832 0>;
+			status = "disabled";
+
+			power-domains =	<&rpmhpd SC7280_LCX>;
+			power-domain-names = "lcx";
+			required-opps = <&rpmhpd_opp_nom>;
+
+			clocks = <&lpass_aon LPASS_AON_CC_AUDIO_HM_H_CLK>,
+				 <&lpasscore LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK>,
+				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM_CLK>,
+				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM0_CLK>,
+				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM1_CLK>,
+				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM2_CLK>,
+				 <&lpasscore LPASS_CORE_CC_EXT_IF0_IBIT_CLK>,
+				 <&lpasscore LPASS_CORE_CC_EXT_IF1_IBIT_CLK>,
+				 <&lpass_aon LPASS_AON_CC_VA_MEM0_CLK>;
+			clock-names = "aon_cc_audio_hm_h",
+				      "core_cc_sysnoc_mport_core",
+				      "audio_cc_codec_mem",
+				      "audio_cc_codec_mem0",
+				      "audio_cc_codec_mem1",
+				      "audio_cc_codec_mem2",
+				      "core_cc_ext_if0_ibit",
+				      "core_cc_ext_if1_ibit",
+				      "aon_cc_va_mem0";
+
+			#sound-dai-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "lpass-irq-lpaif",
+					  "lpass-irq-vaif",
+					  "lpass-irq-rxtxif",
+					  "lpass-irq-hdmi";
+		};
+
 		vamacro: codec@3370000 {
 			compatible = "qcom,sc7280-lpass-va-macro";
 			pinctrl-0 = <&dmic01_active>;
-- 
2.7.4

