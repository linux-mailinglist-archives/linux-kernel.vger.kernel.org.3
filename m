Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3689D519E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348977AbiEDLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348951AbiEDLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:48:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11C22B1B0;
        Wed,  4 May 2022 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651664677; x=1683200677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jZZ7kaP+9AkJxnjxtnptjz1nEC2zgCal3osupNC6zFw=;
  b=DWtBY4jSMF1r/nbX3sMLjyzTgxS7VG3+9sSKw407kITMvgwgRklar8G/
   v5alFPh1Cju8M5uz0zve1R/kl2rRiMkZQ1kdlq3B3zHGRJSh9MAwpyVMt
   U1znTHWRox6jt8HN77qVeYKJy0iwBxNwHGcyTukZ4OOsmKyyi0XCoWyYW
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 04 May 2022 04:44:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 04:44:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 04:44:35 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 04:44:31 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v11 01/12] arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital macro codecs
Date:   Wed, 4 May 2022 17:13:58 +0530
Message-ID: <1651664649-25290-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651664649-25290-1-git-send-email-quic_srivasam@quicinc.com>
References: <1651664649-25290-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index c961ca1..fc63051 100644
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

