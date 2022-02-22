Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11FE4BF171
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiBVFhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:37:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiBVFhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:37:18 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599AD630B;
        Mon, 21 Feb 2022 21:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645508213; x=1677044213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=c9a7UM3eycakspYO8Qaza117CO9MFjnDGSX8vyBkrj0=;
  b=W5sTXocC9urbKLI7KZAzMV0zS657pBnNIH2ByXEMd9mNTVwO/6HVhf7z
   Skm5O5Tfgdm3Adslrf/PYgPeq1NBIP5D16JQxDHj3X+Sku0APzFtYC//c
   tkfkZ6A1yG+rK5z4BoHAfCPAtLw53GO3xzJfBBEvEWS6k3R7RF2AnFjMb
   M=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2022 20:56:48 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Feb 2022 20:56:45 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 22 Feb 2022 10:26:32 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 0B94144B1; Tue, 22 Feb 2022 10:26:31 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v4 5/5] clk: qcom: Add SDX65 APCS clock controller support
Date:   Tue, 22 Feb 2022 10:26:25 +0530
Message-Id: <1645505785-2271-6-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1645505785-2271-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update APCS Kconfig to reflect support for SDX65
APCS clock controller.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/clk/qcom/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 5159a1d..1a641d4 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -55,13 +55,13 @@ config QCOM_CLK_APCC_MSM8996
 	  drivers for dynamic power management.
 
 config QCOM_CLK_APCS_SDX55
-	tristate "SDX55 APCS Clock Controller"
+	tristate "SDX55 and SDX65 APCS Clock Controller"
 	depends on QCOM_APCS_IPC || COMPILE_TEST
 	help
-	  Support for the APCS Clock Controller on SDX55 platform. The
+	  Support for the APCS Clock Controller on SDX55, SDX65 platforms. The
 	  APCS is managing the mux and divider which feeds the CPUs.
 	  Say Y if you want to support CPU frequency scaling on devices
-	  such as SDX55.
+	  such as SDX55, SDX65.
 
 config QCOM_CLK_RPM
 	tristate "RPM based Clock Controller"
-- 
2.7.4

