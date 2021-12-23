Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C882F47E5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbhLWPod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:44:33 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:42312 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349389AbhLWPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640274220; x=1671810220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9V2xqr0dPL+cIc5owi1RM6CBIMo2TqZ08optrP04nDs=;
  b=d3E+JDNdM4mTeVXZxQQmExW7nrVsbCLmJS5qSwkkG0m+MbE+29iDW6Om
   C4V5wYtmxC9tgO+uifDRCKLcT+QZ6OPM4oRdttn96FoJDqqIuVhAkiOLG
   DfoduOMoRQqxuxyj0q3Bqb6EOeCrSAze/2V+M4nFxzBUCq/vNCrrX3hoQ
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Dec 2021 07:43:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 07:43:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:43:39 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 23 Dec 2021 07:43:35 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH 3/3] arm64: dts: qcom: sc7280: Add wcd9380 pinmux
Date:   Thu, 23 Dec 2021 21:13:09 +0530
Message-ID: <1640274189-14120-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640274189-14120-1-git-send-email-quic_srivasam@quicinc.com>
References: <1640274189-14120-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinmux to reset wcd codec, conneceted on SC7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 86f182c..ddeb508 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -565,6 +565,33 @@
 		 */
 		bias-pull-up;
 	};
+
+	wcd938x_reset_active: wcd938x_reset_active {
+		mux {
+			pins = "gpio83";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio83";
+			drive-strength = <16>;
+			output-high;
+		};
+	};
+
+	wcd938x_reset_sleep: wcd938x_reset_sleep {
+		mux {
+			pins = "gpio83";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio83";
+			drive-strength = <16>;
+			bias-disable;
+			output-low;
+		};
+	};
 };
 
 &sdc1_on {
-- 
2.7.4

