Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93B516C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383814AbiEBIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEBIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:41:39 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E85018396;
        Mon,  2 May 2022 01:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651480691; x=1683016691;
  h=from:to:cc:subject:date:message-id;
  bh=+H8Cn+KGxCLUnovgOg/dhAnwXPNW3VIwUWFvZftP4lM=;
  b=IGtN9hOaXJBZA41Q6ketBB85/EUlDpMzZPVkxXdXaUs0rSRxyHaCNPf5
   zILwDLL/k5Aa78rrolWLKg26Uh/3n+oKaDNKSMSKjSAGSug9K51agUz+m
   vCqrApgNICBPIJXPnYMoCuV7A1QrUVD1YsFJ/wjd4tEboP+UCFPQpjvxI
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 01:38:11 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 01:38:09 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 14:07:49 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 598A33BE0; Mon,  2 May 2022 14:07:48 +0530 (+0530)
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
Subject: [PATCH 0/4] SDHCI and SMEM updates for sdx65.
Date:   Mon,  2 May 2022 14:07:41 +0530
Message-Id: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds some patches addressing comments from Bjorn and Ulf.
The patches are from the  original series "SDX65 devicetree updates" that
were needed some changes.

Thanks,
Rohit.

Rohit Agarwal (4):
  dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
  mmc: host/sdhci-msm: Add compatible string check for sdx65
  dt-bindings: arm-smmu: Add binding for SDX65 SMMU
  ARM: dts: qcom: sdx65: Add Shared memory manager support

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml  | 1 +
 arch/arm/boot/dts/qcom-sdx65.dtsi                     | 4 +++-
 drivers/mmc/host/sdhci-msm.c                          | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.7.4

