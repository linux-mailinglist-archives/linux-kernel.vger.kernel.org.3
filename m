Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60B5511F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbiD0RNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243785AbiD0RN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:13:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2159F33347;
        Wed, 27 Apr 2022 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651079416; x=1682615416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wchRf7uasp3Msv81sa2LxNNZ/QRRHIhp2gjeakQULuA=;
  b=ff1ztKQ7qao+sthnIyS+/Y35ImPU9JQLTIKfWNysLHPM7yqNz9NrlYBH
   TrTtrMDoJ4Kya6pv484zsSbSSAE9HIebnKbhCrW8tOovE1Mal8u2tHZ6k
   YR+66iYN1H82x9M7x2Icnvqe4y5xDwv1sU/Tj96HRpxn+8a4712utCaqS
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2022 10:10:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:10:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 10:10:15 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 10:10:10 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v12 1/4] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
Date:   Wed, 27 Apr 2022 22:39:40 +0530
Message-ID: <1651079383-7665-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
References: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinmux nodes for primary and secondary I2S for SC7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 14 +++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 40 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 015a347..fb1f4ca 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -359,6 +359,20 @@
 	bias-disable;
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
 &pm7325_gpios {
 	key_vol_up_default: key-vol-up-default {
 		pins = "gpio6";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 00bacc4..0242f1d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3713,6 +3713,46 @@
 				function = "edp_hot";
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
 			pcie1_clkreq_n: pcie1-clkreq-n {
 				pins = "gpio79";
 				function = "pcie1_clkreqn";
-- 
2.7.4

