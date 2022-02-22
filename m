Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D404BF19F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiBVFht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:37:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiBVFhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:37:22 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22AD13F73;
        Mon, 21 Feb 2022 21:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645508217; x=1677044217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=saNTey0mEjB+dRdqgx0eeHLihhFT1oLws27rFbwKRXw=;
  b=V9ExeaeTQiTMp+yBGH8qCY1ZT59K/Bc4vxVRH2Yzp3uR/yReyAgraKXs
   y8XI0yBtnXOzNDnFXvPtTnXnqiWqJaJmmHzVSdDMK0N4A7J2TOm5LY34d
   wUUFR02A81Nhpras3vZDmu67NbP6sqxk5tKNE8wlwmfzXCgOoD6vJnS95
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2022 20:56:49 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Feb 2022 20:56:47 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 22 Feb 2022 10:26:30 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 67C9744B1; Tue, 22 Feb 2022 10:26:29 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v4 2/5] clk: qcom: Add A7 PLL support for SDX65
Date:   Tue, 22 Feb 2022 10:26:22 +0530
Message-Id: <1645505785-2271-3-git-send-email-quic_rohiagar@quicinc.com>
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

Update A7 PLL Kconfig to reflect support for SDX65.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/clk/qcom/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 42c8741..5159a1d 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -29,11 +29,11 @@ config QCOM_A53PLL
 	  devices.
 
 config QCOM_A7PLL
-	tristate "SDX55 A7 PLL"
+	tristate "A7 PLL driver for SDX55 and SDX65"
 	help
-	  Support for the A7 PLL on SDX55 devices. It provides the CPU with
+	  Support for the A7 PLL on SDX55 and SDX65 devices. It provides the CPU with
 	  frequencies above 1GHz.
-	  Say Y if you want to support higher CPU frequencies on SDX55
+	  Say Y if you want to support higher CPU frequencies on SDX55 and SDX65
 	  devices.
 
 config QCOM_CLK_APCS_MSM8916
-- 
2.7.4

