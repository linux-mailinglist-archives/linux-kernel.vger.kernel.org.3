Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393EB4ADCCD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380540AbiBHPfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380673AbiBHPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:35:40 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD0C061576;
        Tue,  8 Feb 2022 07:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644334540; x=1675870540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7ZQlDQCf+14boNm4JKmpv2b7alWc5ogeZKII3lt9FVc=;
  b=ATJC8mKoYZXRWX5UewVay5NGs1EZLo73ao02c2SnegWqSNAinFaScGYK
   GUd7y7bgn8gBitBwWbLFi0Tj+T1MiQdwRLHCjTmSDdcp2xrnC31jSnrDf
   sY1O+A8/YNPAEsxkmkiNHg2kkwgScLt9Es/9L7K4V94WVRwv7AZJtmx7D
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 07:35:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:35:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:35:39 -0800
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:35:36 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 1/2] arm64: dts: qcom: ipq8074: enable the GICv2m support
Date:   Tue, 8 Feb 2022 21:05:24 +0530
Message-ID: <1644334525-11577-2-git-send-email-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644334525-11577-1-git-send-email-quic_kathirav@quicinc.com>
References: <1644334525-11577-1-git-send-email-quic_kathirav@quicinc.com>
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

GIC used in the IPQ8074 SoCs has one instance of the GICv2m extension,
which supports upto 32 MSI interrupts. Lets add support for the same.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 26ba7ce9222c..7b0258407d10 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -620,9 +620,18 @@
 
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
+			#address-cells = <1>;
+			#size-cells = <1>;
 			interrupt-controller;
 			#interrupt-cells = <0x3>;
 			reg = <0x0b000000 0x1000>, <0x0b002000 0x1000>;
+			ranges = <0 0xb00a000 0xffd>;
+
+			v2m@0 {
+				compatible = "arm,gic-v2m-frame";
+				msi-controller;
+				reg = <0x0 0xffd>;
+			};
 		};
 
 		timer {
-- 
2.7.4

