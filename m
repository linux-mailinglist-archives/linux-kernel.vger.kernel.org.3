Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A115535AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352482AbiFUPPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352700AbiFUPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:15:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F59D2AC6E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:14:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1E8D165C;
        Tue, 21 Jun 2022 08:14:35 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA8B13F66F;
        Tue, 21 Jun 2022 08:14:34 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iommu: More internal ops cleanup
Date:   Tue, 21 Jun 2022 16:14:24 +0100
Message-Id: <cover.1655822151.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are a few more thematically-related patches from my develompent
stack that don't depend on the rest, so may as well get some exposure
sooner rather than later.

Thanks,
Robin.


Robin Murphy (3):
  iommu: Use dev_iommu_ops() for probe_finalize
  iommu: Make .release_device optional
  iommu: Clean up release_device checks

 drivers/iommu/apple-dart.c                  |  3 ---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  8 +-------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 14 +++-----------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 11 -----------
 drivers/iommu/exynos-iommu.c                |  3 ---
 drivers/iommu/fsl_pamu_domain.c             |  5 -----
 drivers/iommu/iommu.c                       |  9 ++++++---
 drivers/iommu/msm_iommu.c                   |  5 -----
 drivers/iommu/mtk_iommu.c                   |  5 -----
 drivers/iommu/mtk_iommu_v1.c                |  5 -----
 drivers/iommu/sprd-iommu.c                  | 11 -----------
 drivers/iommu/sun50i-iommu.c                |  3 ---
 drivers/iommu/tegra-gart.c                  |  5 -----
 drivers/iommu/tegra-smmu.c                  |  3 ---
 drivers/iommu/virtio-iommu.c                |  8 +-------
 15 files changed, 11 insertions(+), 87 deletions(-)

-- 
2.36.1.dirty

