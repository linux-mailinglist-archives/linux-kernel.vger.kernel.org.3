Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C244FB88D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiDKJyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345006AbiDKJxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:53:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7359B41987;
        Mon, 11 Apr 2022 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649670650; x=1681206650;
  h=from:to:cc:subject:date:message-id;
  bh=FwIfYF2sW0uBB3HT6Ujtl39ujKcPOfiLJ8Kif3t6TUQ=;
  b=DibQT0sMxRRdRNiRMr6MTO7VxEiJ6jJ1YruitlRGncKFX6wkwzN5rFsm
   C4OnZpJme3tXaEJvyL8zrbNcuauLqpsJMiEYTiw518Dfl04zxZ0/GEg6I
   YcGewp6+vvQDyGwIzmi0gQfL+/ufTfntIpVcfHfjkc8LwlRzzEpgMoZg7
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 02:50:49 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Apr 2022 02:50:47 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Apr 2022 15:20:24 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 76E3C3A9B; Mon, 11 Apr 2022 15:20:23 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 0/7] SDX65 devicetree updates
Date:   Mon, 11 Apr 2022 15:20:08 +0530
Message-Id: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds devicetree nodes for SDX65. It adds reserved memory 
nodes, SDHCI, smmu and tcsr mutex support.

Changes from v1:
 - Addressed Mani's Comments and made necessary.
 - Rebased on top of v5.18-rc2.

Thanks,
Rohit.

Rohit Agarwal (7):
  ARM: dts: qcom: sdx65: Add reserved memory nodes
  dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
  ARM: dts: qcom: sdx65: Add support for SDHCI controller
  dt-bindings: arm-smmu: Add binding for SDX65 SMMU
  ARM: dts: qcom: sdx65: Enable ARM SMMU
  ARM: dts: qcom: sdx65: Add support for TCSR Mutex
  ARM: dts: qcom: sdx65: Add Shared memory manager support

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               |  21 ++++
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 110 +++++++++++++++++++++
 4 files changed, 133 insertions(+)

-- 
2.7.4

