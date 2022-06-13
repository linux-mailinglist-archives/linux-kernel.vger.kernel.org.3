Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B51354912B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiFMKhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345609AbiFMKgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:36:11 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BFFD120;
        Mon, 13 Jun 2022 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655115759; x=1686651759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=P0C/r7CssKx3hxTC9MeZV3WMMnfycujIR/DSLZoMRu0=;
  b=KF7yZMupSOYh5fZOi/zqLwH4/BN1Lvq3IPhw76WxgsYziqwVJwuwoShM
   b+nciewxoCWsGKtGXc8a0o9DqrdHEB54cocAeCWump1qnkmrtWJ7pPdvn
   K2ytvBrt1gfCbTiKi25fHmdkFvKvTWOUVTO0fTS62w4u4YFqP5+wKY6b1
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jun 2022 03:22:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 03:22:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 03:22:37 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 03:22:32 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v13 01/12] arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital macro codecs
Date:   Mon, 13 Jun 2022 15:52:02 +0530
Message-ID: <1655115733-16309-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655115733-16309-1-git-send-email-quic_srivasam@quicinc.com>
References: <1655115733-16309-1-git-send-email-quic_srivasam@quicinc.com>
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

SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
external codecs using soundwire masters. Add these nodes for sc7280 based
platforms audio use case.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 128 +++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index b14134a..e5f6b50 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2176,6 +2176,114 @@
 			#clock-cells = <1>;
 		};
 
+		lpass_rx_macro: codec@3200000 {
+			compatible = "qcom,sc7280-lpass-rx-macro";
+			reg = <0 0x03200000 0 0x1000>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&lpass_rx_swr_clk>, <&lpass_rx_swr_data>;
+
+			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
+				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
+				 <&lpass_va_macro>;
+			clock-names = "mclk", "npl", "fsgen";
+
+			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+			power-domain-names = "macro", "dcodec";
+
+			#clock-cells = <0>;
+			#sound-dai-cells = <1>;
+
+			status = "disabled";
+		};
+
+		swr0: soundwire@3210000 {
+			compatible = "qcom,soundwire-v1.6.0";
+			reg = <0 0x03210000 0 0x2000>;
+
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&lpass_rx_macro>;
+			clock-names = "iface";
+
+			qcom,din-ports = <0>;
+			qcom,dout-ports = <5>;
+
+			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
+			reset-names = "swr_audio_cgcr";
+
+			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
+			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
+			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
+			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
+
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		lpass_tx_macro: codec@3220000 {
+			compatible = "qcom,sc7280-lpass-tx-macro";
+			reg = <0 0x03220000 0 0x1000>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&lpass_tx_swr_clk>, <&lpass_tx_swr_data>;
+
+			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
+				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
+				 <&lpass_va_macro>;
+			clock-names = "mclk", "npl", "fsgen";
+
+			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+			power-domain-names = "macro", "dcodec";
+
+			#clock-cells = <0>;
+			#sound-dai-cells = <1>;
+
+			status = "disabled";
+		};
+
+		swr1: soundwire@3230000 {
+			compatible = "qcom,soundwire-v1.6.0";
+			reg = <0 0x03230000 0 0x2000>;
+
+			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&lpass_tx_macro>;
+			clock-names = "iface";
+
+			qcom,din-ports = <3>;
+			qcom,dout-ports = <0>;
+
+			resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
+			reset-names = "swr_audio_cgcr";
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff>;
+			qcom,ports-word-length =	/bits/ 8 <0xff 0x00 0xff>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff>;
+			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
+			qcom,port-offset = <1>;
+
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		lpass_audiocc: clock-controller@3300000 {
 			compatible = "qcom,sc7280-lpassaudiocc";
 			reg = <0 0x03300000 0 0x30000>;
@@ -2187,6 +2295,26 @@
 			#power-domain-cells = <1>;
 		};
 
+		lpass_va_macro: codec@3370000 {
+			compatible = "qcom,sc7280-lpass-va-macro";
+			reg = <0 0x03370000 0 0x1000>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>;
+
+			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
+			clock-names = "mclk";
+
+			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+			power-domain-names = "macro", "dcodec";
+
+			#clock-cells = <0>;
+			#sound-dai-cells = <1>;
+
+			status = "disabled";
+		};
+
 		lpass_aon: clock-controller@3380000 {
 			compatible = "qcom,sc7280-lpassaoncc";
 			reg = <0 0x03380000 0 0x30000>;
-- 
2.7.4

