Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B64FBDDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346786AbiDKNzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346773AbiDKNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:55:46 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B610924F30;
        Mon, 11 Apr 2022 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649685212; x=1681221212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tgpPo55v0hZMP1D9KLS+8Bk9D5L0sftc2mUdtFpjW8k=;
  b=FotL7c2SP6A+WwNuPd/WFDDuGZ+uWFJ+pf3UF8GFzXHAu90WqaaYeYx3
   PSWLIcmVH57CQIjmrriLbjHYLvVS7zfwn/gg+0AYiMzfB31H8rBiFPZOv
   icRWyvNfGqy9FpggVMh+r0+Sb2wHF7sn5h+O2KzzwlplMmzKMjKUMvJQi
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Apr 2022 06:53:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:53:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 06:53:31 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 06:53:27 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v7 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin controller node
Date:   Mon, 11 Apr 2022 19:23:04 +0530
Message-ID: <1649685184-8448-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649685184-8448-1-git-send-email-quic_srivasam@quicinc.com>
References: <1649685184-8448-1-git-send-email-quic_srivasam@quicinc.com>
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

Add LPASS LPI pinctrl node required for Audio functionality on sc7280
based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  84 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107 +++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 4ba2274..ea751dc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -238,6 +238,90 @@
 	modem-init;
 };
 
+&dmic01 {
+	clk {
+		drive-strength = <8>;
+	};
+};
+
+&dmic01_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	data {
+		pull-down;
+	};
+};
+
+&dmic23 {
+	clk {
+		drive-strength = <8>;
+	};
+};
+
+&dmic23_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	data {
+		pull-down;
+	};
+};
+
+&rx_swr {
+	clk {
+		drive-strength = <2>;
+		slew-rate = <1>;
+		bias-disable;
+	};
+
+	data {
+		drive-strength = <2>;
+		slew-rate = <1>;
+		bias-bus-hold;
+	};
+};
+
+&rx_swr_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	data {
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&tx_swr {
+	clk {
+		drive-strength = <2>;
+		slew-rate = <1>;
+		bias-disable;
+	};
+
+	data {
+		slew-rate = <1>;
+		bias-bus-hold;
+	};
+};
+
+&tx_swr_sleep {
+	clk {
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	data {
+		bias-bus-hold;
+	};
+};
+
 &pcie1 {
 	status = "okay";
 	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8099c80..c692420 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1987,6 +1987,113 @@
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		lpass_tlmm: pinctrl@33c0000 {
+			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
+			reg = <0 0x033c0000 0x0 0x20000>,
+				<0 0x03550000 0x0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 15>;
+
+			#clock-cells = <1>;
+
+			dmic01: dmic01 {
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
+			dmic23: dmic23 {
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
+			dmic23_sleep: dmic23_sleep {
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
+			rx_swr: rx-swr {
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
+			tx_swr: tx-swr {
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

