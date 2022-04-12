Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410A74FDE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiDLLvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355015AbiDLLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:49:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A645D266D;
        Tue, 12 Apr 2022 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649759556; x=1681295556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=clIj3R6JMBSbxgmYP1hLjcuHnj7icvDJL9Mcr68ohps=;
  b=Bztc4ARMF1eHXZMWrSZLf9GYLpGV8hmzYh34u8N8mOmfssqmNzp6luv+
   mKyHzXdVh1r1jny9Wcva9IYRZ3LJtdYJC6HlYHnPDySDgAfKK61NlKt0R
   3T6LOCGbW0uPwKRNc2sh+1kno1hMu+TYOKP7RSpJ/SqChpbnkN1jKTEyH
   M=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Apr 2022 03:32:36 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Apr 2022 03:32:34 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Apr 2022 16:02:12 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 1EE915A26; Tue, 12 Apr 2022 16:02:12 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V4 1/2] dt-bindings: mmc: sdhci-msm: Add gcc resets strings
Date:   Tue, 12 Apr 2022 16:02:07 +0530
Message-Id: <1649759528-15125-2-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcc hardware reset supported strings for qcom-sdhci controller.

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 6216ed7..9f02461 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -76,6 +76,7 @@ Optional Properties:
 		"cpu-sdhc".
 		Please refer to Documentation/devicetree/bindings/
 		interconnect/ for more details.
+- resets: Phandle and reset specifier for the device's reset.
 
 Example:
 
@@ -98,6 +99,8 @@ Example:
 				<&qnoc MASTER_CPU_ID &qnoc SLAVE_SDCC_ID>;
 		interconnect-names = "sdhc-ddr","cpu-sdhc";
 
+		resets = <&gcc GCC_SDCC1_BCR>;
+
 		qcom,dll-config = <0x000f642c>;
 		qcom,ddr-config = <0x80040868>;
 	};
@@ -118,6 +121,8 @@ Example:
 		clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
 		clock-names = "core", "iface";
 
+		resets = <&gcc GCC_SDCC2_BCR>;
+
 		qcom,dll-config = <0x0007642c>;
 		qcom,ddr-config = <0x80040868>;
 	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

