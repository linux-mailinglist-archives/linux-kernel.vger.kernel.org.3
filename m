Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6893D4B22FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348847AbiBKKVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:21:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348839AbiBKKVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:21:20 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D0ABC0;
        Fri, 11 Feb 2022 02:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644574880; x=1676110880;
  h=from:to:cc:subject:date:message-id;
  bh=59ic2RslKip5FyT6CNFHlhCwmGSxYTwwGp8ZkQ2whD8=;
  b=oBKkYUzyI647mVQIeBXY1UbUIfRp3tsR1PDnzVhqj/qXGpJ4A/CuMiBH
   ggl2nfsdX23VqOvdICOFOqaLkstyNdbYZZM6AAjs5fhy5+8ZgGKN2gjvO
   LWjQp1P18q3Z30YxDL/gSZn5DCyLCZS4UBa7OpW7Jikp9mqkoROIdsiji
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 02:21:19 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Feb 2022 02:21:17 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Feb 2022 15:51:09 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id E373142BB; Fri, 11 Feb 2022 15:51:08 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH] ARM: dts: qcom: Add chosen node information for SDX65.
Date:   Fri, 11 Feb 2022 15:50:45 +0530
Message-Id: <1644574845-23248-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add chosen node in the base dtsi file of SDX65.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 4 ----
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 59457da..3a75c21 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -14,10 +14,6 @@
 	aliases {
 		serial0 = &blsp1_uart3;
 	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
 };
 
 &blsp1_uart3 {
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 796641d..653df15 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -17,6 +17,10 @@
 	qcom,msm-id = <458 0x10000>, <483 0x10000>, <509 0x10000>;
 	interrupt-parent = <&intc>;
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0 0>;
-- 
2.7.4

