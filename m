Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5444FBDD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346775AbiDKNzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346739AbiDKNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:55:42 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF2323BEE;
        Mon, 11 Apr 2022 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649685208; x=1681221208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bAACJ7tqQfMx1qJuqthn7gV9D9pAYKRyEqrw72myxlE=;
  b=VTm3WXvcNZqJEr2moPJGhjZPzvdoYZP6yFBIUobT4qUOA2jxOXX8A3Cw
   DbZNU+sN+5jbYtwqjVFgbd9stK/nFE+uUY04ONI9aGLCP1uzVVJvZWK6E
   dC/GxU7QhFyc/7/cR5IuIlUDrTRU9iqQF7Cik4VEq4MfNVHtFM/KOlkiu
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Apr 2022 06:53:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:53:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 06:53:27 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 06:53:23 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v7 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
Date:   Mon, 11 Apr 2022 19:23:03 +0530
Message-ID: <1649685184-8448-2-git-send-email-quic_srivasam@quicinc.com>
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

Add pinmux nodes for primary and secondary I2S for SC7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 14 +++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b8..4ba2274 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -462,6 +462,20 @@
 	drive-strength = <10>;
 };
 
+&mi2s1_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_ws {
+	drive-strength = <6>;
+};
+
 &tlmm {
 	bt_en: bt-en {
 		pins = "gpio85";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index f0b64be..8099c80 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3527,6 +3527,31 @@
 				function = "pcie1_clkreqn";
 			};
 
+			mi2s0_data0: mi2s0-data0 {
+				pins = "gpio98";
+				function = "mi2s0_data0";
+			};
+
+			mi2s0_data1: mi2s0-data1 {
+				pins = "gpio99";
+				function = "mi2s0_data1";
+			};
+
+			mi2s0_mclk: mi2s0-mclk {
+				pins = "gpio96";
+				function = "pri_mi2s";
+			};
+
+			mi2s0_sclk: mi2s0-sclk {
+				pins = "gpio97";
+				function = "mi2s0_sck";
+			};
+
+			mi2s0_ws: mi2s0-ws {
+				pins = "gpio100";
+				function = "mi2s0_ws";
+			};
+
 			qspi_clk: qspi-clk {
 				pins = "gpio14";
 				function = "qspi_clk";
@@ -4261,6 +4286,22 @@
 				drive-strength = <2>;
 				bias-bus-hold;
 			};
+
+			mi2s1_data0: mi2s1-data0 {
+				pins = "gpio107";
+				function = "mi2s1_data0";
+			};
+
+			mi2s1_sclk: mi2s1-sclk {
+				pins = "gpio106";
+				function = "mi2s1_sck";
+			};
+
+			mi2s1_ws: mi2s1-ws {
+				pins = "gpio108";
+				function = "mi2s1_ws";
+			};
+
 		};
 
 		imem@146a5000 {
-- 
2.7.4

