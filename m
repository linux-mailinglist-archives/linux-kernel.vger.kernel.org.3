Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16545220AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347083AbiEJQJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348496AbiEJQIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:08:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA81994DA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5100560C2E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC2AC385A6;
        Tue, 10 May 2022 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652198471;
        bh=8R7QdAS1HkPD/ObWmH1HXiPVeYzqdGBRiK33o/ZU5GQ=;
        h=Date:From:To:Cc:Subject:From;
        b=W7y4X9dw1SUbI/nc2u7Y9qeXUtoC/3Nid+dZQ2mRtGYVCq9EGtR9LrpPq/8Kigs+f
         W2qIOf9HwGBKJhpsHxyh57wHT4jWXpHOza9yy78a9p5d+gKATS/5s4NuhJkpmT6HeF
         mdJnStqeNYGrGrhw+GxbHG4ExkvTxZ6bxX+HwNO7r+emR1iCVhO8PYoPtU47RZTSZu
         ELPbwdJ8rW3bzCc9/Ieni0nKZ9hZtDr2raFTrrKYDJBmx6GJQT984s1Jz9kSv5LETH
         MuMw9Wv8CQokRnzPmY4WE5jo316Y1Kg8kGkUr+RYIZ0LM50bjRPHNaGq+f3AirZT5x
         v51+dhoEhe+8A==
Date:   Tue, 10 May 2022 17:01:06 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.19
Message-ID: <20220510160106.GA28351@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.19. The bulk of it is just adding
new device-tree compatible strings for the existing drivers, but there
are some non-critical fixes in here as well. Please see the tag for more
details.

I used the previous fixes pull as a base for this so that you shouldn't
run into any conflicts with upstream.

Cheers,

Will

--->8

The following changes since commit 4a25f2ea0e030b2fc852c4059a50181bfc5b2f57:

  iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu (2022-04-22 11:21:30 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 628bf55b620497a105f4963ee8fb84769f7e6bb4:

  iommu/arm-smmu: Force identity domains for legacy binding (2022-05-10 12:01:31 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.19

- Add new Qualcomm device-tree compatible strings

- Add new Nvidia device-tree compatible string for Tegra234

- Fix UAF in SMMUv3 shared virtual addressing code

- Force identity-mapped domains for users of ye olde SMMU legacy binding

- Minor cleanups

----------------------------------------------------------------
Bjorn Andersson (2):
      dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
      iommu/arm-smmu-qcom: Add SC8280XP support

Jean-Philippe Brucker (1):
      iommu/arm-smmu-v3-sva: Fix mm use-after-free

Robin Murphy (1):
      iommu/arm-smmu: Force identity domains for legacy binding

Rohit Agarwal (1):
      dt-bindings: arm-smmu: Add binding for SDX65 SMMU

Thierry Reding (3):
      dt-bindings: arm-smmu: Document nvidia,memory-controller property
      dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
      iommu/arm-smmu: Support Tegra234 SMMU

Yang Yingliang (2):
      iommu/arm-smmu: fix possible null-ptr-deref in arm_smmu_device_probe()
      iommu/arm-smmu-v3: check return value after calling platform_get_resource()

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 25 ++++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 13 +++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  2 ++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |  3 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  8 ++++---
 6 files changed, 44 insertions(+), 8 deletions(-)
