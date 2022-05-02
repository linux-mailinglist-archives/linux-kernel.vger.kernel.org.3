Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3530517159
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385522AbiEBOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385523AbiEBOSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:18:33 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8915830;
        Mon,  2 May 2022 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651500904; x=1683036904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=48+rVERvNTQxNqzw5fqv4Nm35unnocBFemLJibc0Q54=;
  b=YWgn7RQ6jD7QXGM2gYgQbmq3fRy0lv+IPXNbXBVF/OioVLNtFyjr+4zs
   cxBgY1x7MemnpDRsO9KjxGbeA4uYVOkNltNDNL7iMPfo/dSaO2ZRbXbXe
   zceIAQ5UvikRdNKVE9217mN8cCCmCsG5oR8OvimjxbdrI35pQkYlnzIVk
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 May 2022 07:15:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 07:15:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 07:15:04 -0700
Received: from kaushalk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 07:15:00 -0700
From:   Kaushal Kumar <quic_kaushalk@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>,
        "Kaushal Kumar" <quic_kaushalk@quicinc.com>
Subject: [PATCH v2 2/4] ARM: dts: qcom: sdx65: Add QPIC NAND support
Date:   Mon, 2 May 2022 07:14:36 -0700
Message-ID: <1651500878-10244-3-git-send-email-quic_kaushalk@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651500878-10244-1-git-send-email-quic_kaushalk@quicinc.com>
References: <1651500878-10244-1-git-send-email-quic_kaushalk@quicinc.com>
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

Add devicetree node to enable support for QPIC
NAND controller on Qualcomm SDX65 platform.
Since there is no "aon" clock in SDX65, a dummy
clock is provided.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index d6a6087..a75e9f1 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -37,6 +37,12 @@
 			clock-output-names = "sleep_clk";
 			#clock-cells = <0>;
 		};
+
+		nand_clk_dummy: nand-clk-dummy {
+			compatible = "fixed-clock";
+			clock-frequency = <32764>;
+			#clock-cells = <0>;
+		};
 	};
 
 	cpus {
@@ -211,6 +217,22 @@
 			status = "disabled";
 		};
 
+		qpic_nand: nand-controller@1b30000 {
+			compatible = "qcom,sdx55-nand";
+			reg = <0x01b30000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&rpmhcc RPMH_QPIC_CLK>,
+				 <&nand_clk_dummy>;
+			clock-names = "core", "aon";
+
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x01f40000 0x40000>;
-- 
2.7.4

