Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF444E2656
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347337AbiCUMaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347311AbiCUMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:30:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168026418;
        Mon, 21 Mar 2022 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647865729; x=1679401729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ml56jHMzZiBNHW/uYlWlw1vcW9YxZvJzFAROWSPNOv8=;
  b=kfoZ5xbxpCQUu/9L0teU1isyjdLfoddrUeCOMUA3nwTU4EvqrKHPwVs1
   Wm/pmc9wIK8T3RpFoU2/WvHndOlUGkLoNtSAR2WaeNjAe68p0wJOIGRwZ
   nux9KXRq2HljASdd5ib13fI3VeTik+pOJ6z2MhXjM2Bamb54rELENamrH
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Mar 2022 05:28:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:28:48 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 05:28:48 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 05:28:43 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v5 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and rx macros and external codecs
Date:   Mon, 21 Mar 2022 17:58:14 +0530
Message-ID: <1647865696-19192-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647865696-19192-1-git-send-email-quic_srivasam@quicinc.com>
References: <1647865696-19192-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
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
codecs like WCD938x, max98360a using soundwire masters and i2s bus.
Add these nodes for sc7280 based platforms audio use case.
Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts        |   6 +
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |   8 ++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 172 +++++++++++++++++++++++++
 3 files changed, 186 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index e2efbdd..224a82d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -84,6 +84,12 @@ ap_ts_pen_1v8: &i2c13 {
 	pins = "gpio51";
 };
 
+&wcd938x {
+	pinctrl-names = "default";
+	pinctrl-0 = <&us_euro_select>;
+	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+};
+
 &tlmm {
 	tp_int_odl: tp-int-odl {
 		pins = "gpio7";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index de646d9..c6a04c3 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -20,6 +20,14 @@
 #include "sc7280-chrome-common.dtsi"
 
 / {
+	max98360a: audio-codec-0 {
+		compatible = "maxim,max98360a";
+		pinctrl-names = "default";
+		pinctrl-0 = <&amp_en>;
+		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 4a7b18a..5f75c9a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -20,6 +20,41 @@
 		serial1 = &uart7;
 	};
 
+	max98360a: audio-codec-0 {
+		compatible = "maxim,max98360a";
+		pinctrl-names = "default";
+		pinctrl-0 = <&amp_en>;
+		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+
+	wcd938x: audio-codec-1 {
+		compatible = "qcom,wcd9380-codec";
+		#sound-dai-cells = <1>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd938x_reset_active>, <&wcd938x_reset_sleep>;
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		vdd-rxtx-supply = <&vreg_l18b_1p8>;
+		vdd-io-supply = <&vreg_l18b_1p8>;
+		vdd-buck-supply = <&vreg_l17b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
+							  500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -476,6 +511,143 @@
 	drive-strength = <6>;
 };
 
+&soc {
+	rxmacro: codec@3200000 {
+		compatible = "qcom,sc7280-lpass-rx-macro";
+		reg = <0 0x03200000 0 0x1000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&rx_swr_active>;
+
+		clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
+			 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
+			 <&vamacro>;
+		clock-names = "mclk", "npl", "fsgen";
+
+		power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+				<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+		power-domain-names ="macro", "dcodec";
+
+		#clock-cells = <0>;
+		#sound-dai-cells = <1>;
+	};
+
+	txmacro: codec@3220000 {
+		compatible = "qcom,sc7280-lpass-tx-macro";
+		reg = <0 0x03220000 0 0x1000>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tx_swr_active>;
+
+		clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
+			 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
+			 <&vamacro>;
+		clock-names = "mclk", "npl", "fsgen";
+
+		power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+				<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+		power-domain-names ="macro", "dcodec";
+
+		#clock-cells = <0>;
+		#sound-dai-cells = <1>;
+	};
+
+	vamacro: codec@3370000 {
+		compatible = "qcom,sc7280-lpass-va-macro";
+		reg = <0 0x03370000 0 0x1000>;
+
+		pinctrl-0 = <&dmic01_active>;
+		pinctrl-names = "default";
+
+		clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
+		clock-names = "mclk";
+
+		power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
+				<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+		power-domain-names ="macro", "dcodec";
+
+		vdd-micb-supply = <&vreg_bob>;
+
+		#clock-cells = <0>;
+		#sound-dai-cells = <1>;
+	};
+
+	swr0: soundwire@3210000 {
+		compatible = "qcom,soundwire-v1.6.0";
+		reg = <0 0x03210000 0 0x2000>;
+
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&rxmacro>;
+		clock-names = "iface";
+
+		qcom,din-ports = <0>;
+		qcom,dout-ports = <5>;
+
+		resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
+		reset-names = "swr_audio_cgcr";
+
+		qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
+		qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
+		qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
+		qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
+		qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
+		qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
+		qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
+		qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
+		qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
+
+		#sound-dai-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		wcd_rx: codec@0,4 {
+			compatible = "sdw20217010d00";
+			reg = <0 4>;
+			#sound-dai-cells = <1>;
+			qcom,rx-port-mapping = <1 2 3 4 5>;
+		};
+	};
+
+	swr1: soundwire@3230000 {
+		compatible = "qcom,soundwire-v1.6.0";
+		reg = <0 0x03230000 0 0x2000>;
+
+		interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
+				      <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "swr_master_irq", "swr_wake_irq";
+		clocks = <&txmacro>;
+		clock-names = "iface";
+
+		qcom,din-ports = <3>;
+		qcom,dout-ports = <0>;
+
+		resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
+		reset-names = "swr_audio_cgcr";
+
+		qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03>;
+		qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02>;
+		qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00>;
+		qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff>;
+		qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff>;
+		qcom,ports-word-length =	/bits/ 8 <0xff 0x0 0xff>;
+		qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff>;
+		qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff>;
+		qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
+		qcom,port-offset = <1>;
+
+		#sound-dai-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		wcd_tx: codec@0,3 {
+			compatible = "sdw20217010d00";
+			reg = <0 3>;
+			#sound-dai-cells = <1>;
+			qcom,tx-port-mapping = <1 2 3 4>;
+		};
+	};
+};
+
 &tlmm {
 	amp_en: amp-en {
 		pins = "gpio63";
-- 
2.7.4

