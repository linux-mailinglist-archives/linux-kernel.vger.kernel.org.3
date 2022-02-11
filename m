Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3B4B288B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351169AbiBKO5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:57:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbiBKO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:57:45 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897494;
        Fri, 11 Feb 2022 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644591464; x=1676127464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kOjDFR5hrbB6EsAYjDejT/kUTL8MBGwtDLSa9LFiMSg=;
  b=gbRu/sKPp92V+8yUQJ5SI8NraPvbIU8B/oVzm655GZKNtNdH9oZuANzH
   2dHF5a1tGzejxwUIW/0bO9pKablK4J0bfcifHmEBXCnWqUAn9bhVwp+y1
   xc/O6LaPqjqlYWZyc0IOWD56yd/y3QYGtha6iPO3uOiaT5Wlm6VSkSBaG
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Feb 2022 06:57:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:57:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 06:57:43 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 06:57:39 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v4 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
Date:   Fri, 11 Feb 2022 20:27:17 +0530
Message-ID: <1644591438-6514-3-git-send-email-quic_srivasam@quicinc.com>
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

Add lpass cpu node for audio on sc7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 28 +++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 59 ++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 07f8b1e..4339483 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -271,6 +271,34 @@
 	modem-init;
 };
 
+&lpass_cpu {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sec_mi2s_data0>, <&sec_mi2s_sclk>, <&sec_mi2s_ws>;
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
+
 &pcie1 {
 	status = "okay";
 	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index daae5bc..2c90ed1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -1750,6 +1751,64 @@
 			#clock-cells = <1>;
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
 		lpass_ag_noc: interconnect@3c40000 {
 			reg = <0 0x03c40000 0 0xf080>;
 			compatible = "qcom,sc7280-lpass-ag-noc";
-- 
2.7.4

