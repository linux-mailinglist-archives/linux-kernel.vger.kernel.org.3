Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A095B49888C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbiAXSov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:44:51 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:15306 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245043AbiAXSou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:44:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643049890; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ppxgPtI7FNs4AGoK17I/zfz6dJ1Z7KppGzQnrtUptqs=; b=G+odYynxae6BrKEjgezZ2j2SlafpJJTLKc99eGtAgYAmQBa0cQ4cnjlI4uXI2L+zfBB5bNgZ
 g6Pu6yC6YqNfbC+j3IXh+vuvdKMFOYjoDP/QTkAr2q5Hi6I7e/yNpuyRHNhR0YcZ12qhXRzp
 h0K5T7n3wuHs1cWWejlTnWgqHRA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61eef3a1d64b5e7b6e17993c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Jan 2022 18:44:49
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A18CC4360D; Mon, 24 Jan 2022 18:44:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD97CC4360D;
        Mon, 24 Jan 2022 18:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AD97CC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] arm64: dts: qcom: sc7280: Add camcc clock node
Date:   Tue, 25 Jan 2022 00:14:37 +0530
Message-Id: <20220124184437.9278-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the camera clock controller node for SC7280 SoC.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 937c2e0e93eb..2b4596f2b4cb 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
  */
-
+#include <dt-bindings/clock/qcom,camcc-sc7280.h>
 #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
 #include <dt-bindings/clock/qcom,gcc-sc7280.h>
 #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
@@ -2761,6 +2761,18 @@
 			#power-domain-cells = <1>;
 		};

+		camcc: clock-controller@ad00000 {
+			compatible = "qcom,sc7280-camcc";
+			reg = <0 0x0ad00000 0 0x10000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				<&rpmhcc RPMH_CXO_CLK_A>,
+				<&sleep_clk>;
+			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sc7280-dispcc";
 			reg = <0 0xaf00000 0 0x20000>;
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

