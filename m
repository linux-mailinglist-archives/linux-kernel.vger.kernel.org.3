Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753AE4FB420
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbiDKG6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiDKG6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:58:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC102A709;
        Sun, 10 Apr 2022 23:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649660173; x=1681196173;
  h=from:to:cc:subject:date:message-id;
  bh=aRKhlH11BYG4D30HiNuvL9KWitrjNW8cRlhyWm2s6Sg=;
  b=r5Vkc6Hn25zxcY1woyXjZM/DjGcESDU0ZnX7iyxGW94PAjVskshWO0sq
   zHiTt917zSovvQhuzXqaZkQiyYeAfITAnMfurpgoPtXM9Y7Dewz6FKnV6
   PkL5tlwITtycskVj9t1tim7C/RP2ksqeqrwse9q1OgPqOXEtXaQJqIl3l
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 10 Apr 2022 23:56:13 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Apr 2022 23:56:11 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 11 Apr 2022 12:25:51 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id A84B437D9; Mon, 11 Apr 2022 12:25:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/7] SDX65 devicetree updates
Date:   Mon, 11 Apr 2022 12:25:36 +0530
Message-Id: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
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

This series adds devicetree nodes for SDX65. It adds
reserved memory nodes, SDHCI, smmu and tcsr mutex support.

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

