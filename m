Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D613E47E5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244313AbhLWPpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:45:14 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:50729 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbhLWPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640274313; x=1671810313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ofhD/uIRCiSzkugGXI2agPN8d03c46nO5Juuuzs9H6A=;
  b=qk7fSjBKz59fEbzWSnt49Pyl9eisYnEdRoT1Djg3pZzf3Nf/qWXEWrS1
   /kdoBTw7E8QO7CIH57ANt4M22c2QjeulSanEGT+h1Voc85B1pJTioolr3
   voDbVelvYNXxe5FX1wwC+bK5SA/dEBsLdw4wXrSUrHvE3V2h734OBPZpV
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 Dec 2021 07:45:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 07:45:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:45:12 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:45:08 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH 2/3] arm64: dts: qcom: sc7180: Add lpass cpu node
Date:   Thu, 23 Dec 2021 21:14:47 +0530
Message-ID: <1640274288-14399-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640274288-14399-1-git-send-email-quic_srivasam@quicinc.com>
References: <1640274288-14399-1-git-send-email-quic_srivasam@quicinc.com>
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
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 27 +++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 57 ++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index edfc8d7..3449d56 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -689,3 +689,30 @@
 	};
 };
 
+&lpass_cpu {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sec_mi2s_active>;
+
+	wcd-rx@6 {
+		reg = <LPASS_CDC_DMA_RX0>;
+	};
+
+	wcd-tx@19 {
+		reg = <LPASS_CDC_DMA_TX3>;
+	};
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
+	va-tx@25 {
+		reg = <LPASS_CDC_DMA_VA_TX0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index b271de9..3f31caf 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -17,6 +17,7 @@
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -1841,6 +1842,62 @@
 			#size-cells = <0>;
 		};
 
+		lpass_cpu: qcom,lpass@3260000 {
+			compatible = "qcom,sc7280-lpass-cpu";
+			reg = <0 0x3260000 0 0xC000>,
+				<0 0x3280000 0 0x29000>,
+				<0 0x3340000 0 0x29000>,
+				<0 0x336C000 0 0x3000>,
+				<0 0x3987000 0 0x68000>,
+				<0 0x3B00000 0 0x29000>;
+			reg-names = "lpass-rxtx-cdc-dma-lpm",
+					"lpass-rxtx-lpaif",
+					"lpass-va-lpaif",
+					"lpass-va-cdc-dma-lpm",
+					"lpass-hdmiif",
+					"lpass-lpaif";
+
+			iommus = <&apps_smmu 0x1820 0>,
+				<&apps_smmu 0x1821 0>,
+				<&apps_smmu 0x1832 0>;
+			status = "disabled";
+
+			power-domains =	<&rpmhpd SC7280_LCX>;
+			power-domain-names = "lcx";
+			required-opps = <&rpmhpd_opp_nom>;
+
+			clocks = <&lpass_audiocc LPASS_AON_CC_AUDIO_HM_H_CLK>,
+					<&lpasscc LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK>,
+					<&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM0_CLK>,
+					<&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM1_CLK>,
+					<&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM2_CLK>,
+					<&lpasscc LPASS_CORE_CC_EXT_IF0_IBIT_CLK>,
+					<&lpasscc LPASS_CORE_CC_EXT_IF1_IBIT_CLK>,
+					<&lpass_aon LPASS_AON_CC_VA_MEM0_CLK>;
+			clock-names = "aon_cc_audio_hm_h",
+					"core_cc_sysnoc_mport_core",
+					"audio_cc_codec_mem0",
+					"audio_cc_codec_mem1",
+					"audio_cc_codec_mem2",
+					"core_cc_ext_if0_ibit",
+					"core_cc_ext_if1_ibit",
+					"aon_cc_va_mem0";
+
+			#sound-dai-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-names = "lpass-irq-lpaif",
+					"lpass-irq-vaif",
+					"lpass-irq-rxtxif",
+					"lpass-irq-hdmi";
+		};
+
 		vamacro: codec@3370000 {
 			compatible = "qcom,sc7280-lpass-va-macro";
 			pinctrl-0 = <&dmic01_active>;
-- 
2.7.4

