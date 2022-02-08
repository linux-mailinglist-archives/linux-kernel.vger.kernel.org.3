Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE554ADCDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381017AbiBHPhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381047AbiBHPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:37:46 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8A2C0612C2;
        Tue,  8 Feb 2022 07:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644334664; x=1675870664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GyEkYt3zPrC9WZkiqFj1y/fTCDu3JwZi72OcFHHW+0I=;
  b=HJOTMw/53m8XaU4bsqCMp26LKrICQ9FWGCGfJRWsP/ZCiWNfM37cnCqW
   m4IVWO+rh9TxHH4rvUQ3GJJCA06+1lrH2Dorr3m2/t4StHuMK4O8Mmcj9
   7ck9rT2dbIxEaLM9KfH6w4YX7955KOFTDly0FCxsXBceBMiZcTDKcgjoR
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Feb 2022 07:35:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:35:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:35:42 -0800
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:35:39 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq6018: enable the GICv2m support
Date:   Tue, 8 Feb 2022 21:05:25 +0530
Message-ID: <1644334525-11577-3-git-send-email-quic_kathirav@quicinc.com>
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

GIC used in the IPQ6018 SoCs has one instance of the GICv2m extension,
which supports upto 32 MSI interrupts. Lets add support for the same.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 66ec5615651d..b8171548f0e1 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -373,6 +373,8 @@
 
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
+			#address-cells = <2>;
+			#size-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <0x3>;
 			reg =   <0x0 0x0b000000 0x0 0x1000>,  /*GICD*/
@@ -380,6 +382,13 @@
 				<0x0 0x0b001000 0x0 0x1000>,  /*GICH*/
 				<0x0 0x0b004000 0x0 0x1000>;  /*GICV*/
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			ranges = <0 0 0 0xb00a000 0 0xffd>;
+
+			v2m@0 {
+				compatible = "arm,gic-v2m-frame";
+				msi-controller;
+				reg = <0x0 0x0 0x0 0xffd>;
+			};
 		};
 
 		pcie_phy: phy@84000 {
-- 
2.7.4

