Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E9D4FFA00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiDMPY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiDMPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:24:23 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4FD5C670;
        Wed, 13 Apr 2022 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649863320; x=1681399320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7AhGrgiBzTAvtgoFnt8no14wFX0UcjnvcY//DBl9blk=;
  b=ZXeF3dJjM/JQ+Vv/kIMqrzf6dD6aiW9vi5JZls3d31a0MgbEfiRiVdLu
   60qX7KrngExLgvy0HcJPVt1MBItSVfKVOUVmO9ScFPoipPjSn/94c7evA
   A82dHgmelZtULreuNC5FMV68DjDxchL7VxBCBpO6IwP81mR5jeU7EGus2
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2022 08:22:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:22:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 08:21:59 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 08:21:55 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v7 4/4] arm64: dts: qcom: sc7280: Add dt nodes for sound card
Date:   Wed, 13 Apr 2022 20:51:17 +0530
Message-ID: <1649863277-31615-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649863277-31615-1-git-send-email-quic_srivasam@quicinc.com>
References: <1649863277-31615-1-git-send-email-quic_srivasam@quicinc.com>
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

Add dt nodes for sound card support, which is using WCD938x headset
playback, capture, I2S speaker playback and DMICs via VA macro.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts  | 23 ++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 93 ++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index b944366..1e16854 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -90,6 +90,29 @@ ap_ts_pen_1v8: &i2c13 {
 	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
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
 &tlmm {
 	tp_int_odl: tp-int-odl {
 		pins = "gpio7";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index cf62d06..a7c884a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -84,6 +84,99 @@
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
+		dai-link@1 {
+			link-name = "MAX98360A";
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
+			link-name = "DisplayPort";
+			reg = <LPASS_DP_RX>;
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_DP_RX>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp>;
+			};
+		};
+
+		dai-link@6 {
+			link-name = "WCD9385 Playback";
+			reg = <LPASS_CDC_DMA_RX0>;
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 0>, <&swr0 0>, <&lpass_rx_macro 0>;
+			};
+		};
+
+		dai-link@19 {
+			link-name = "WCD9385 Capture";
+			reg = <LPASS_CDC_DMA_TX3>;
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 1>, <&swr1 0>, <&lpass_tx_macro 0>;
+			};
+		};
+
+		dai-link@25 {
+			link-name = "DMIC";
+			reg = <LPASS_CDC_DMA_VA_TX0>;
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

