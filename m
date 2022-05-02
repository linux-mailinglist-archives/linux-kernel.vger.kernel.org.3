Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DED516C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383848AbiEBImC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383826AbiEBIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:41:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C9517E1;
        Mon,  2 May 2022 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651480697; x=1683016697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=O9Bm4+VM0hSsOodPChUSKIHx37h49GrPwg9RzKLBxOY=;
  b=w490mIBY2XWXnCJlRahQqt8aSRykgj4kIkit+mH4XXnGIcQB/8GinRkX
   JY+eDYwf2fg5KMpnY3Ec9+KWmgoLk9BiLs8IgtowSECccyJ930aTbiu/k
   6NnxwQT/7N3k4l1Emtc53glAp+E31/FfPGoywd3Hu8m5pcXxhH5T2BAfi
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 01:38:17 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 01:38:15 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 14:07:50 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 3100F3BE8; Mon,  2 May 2022 14:07:49 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        bhupesh.sharma@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/4] mmc: host/sdhci-msm: Add compatible string check for sdx65
Date:   Mon,  2 May 2022 14:07:43 +0530
Message-Id: <1651480665-14978-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdx65 SoC specific compatible string check inside qcom
'sdhci-msm' controller driver.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index fd8b4a9..65661ad 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2453,6 +2453,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
 	 */
 	{.compatible = "qcom,qcs404-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sdx55-sdhci",  .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sdx65-sdhci",  .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sdm630-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sm6125-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sm6350-sdhci", .data = &sdhci_msm_v5_var},
-- 
2.7.4

