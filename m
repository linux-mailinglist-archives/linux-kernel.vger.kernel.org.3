Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0149950B61B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447094AbiDVLZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447083AbiDVLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:25:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DB156206
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45D4EB82C2B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31B1C385AA;
        Fri, 22 Apr 2022 11:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650626558;
        bh=tNf+5h5T3qHAOYjpS84V/nz/K0uUb9xr3AXDzXd1SVI=;
        h=Date:From:To:Cc:Subject:From;
        b=XTO1jMQX7j4vfTBeb9FIw1ko71H9TOx62On1ZoFva/AXm+eOBvgynQS7HoqhxBhMI
         t6snACFLEJ4J68S0O+R4TzdZyFKCowXAosmIxojZV8QOaS7BQrKH6C1kljEqJDJjzu
         VzUDR+IiSRNIzE/I210JtwcxH/yQtJIpKDiSABL1Ab1Nh0T+RLv6xP94kUPZHZ3sOS
         JGC0fjfVP3iDGZdug+hJv2Le69fo0yRqU6BAvyI0Q5YHCzueevqoabyLAnFycpxXr0
         4z64Z2/pKy674216U6ONMwWB+UJJa3PZKgQ537KLqqnRmRsTssfBdq2mfWDhXEGdw0
         KTyrRFRxS0vlQ==
Date:   Fri, 22 Apr 2022 12:22:34 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 5.18
Message-ID: <20220422112233.GB9901@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Unusually, we've got some SMMU driver fixes this time around. Summary in
the tag -- please can you pull these for 5.18?

Cheers,

Will

--->8

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

for you to fetch changes up to 4a25f2ea0e030b2fc852c4059a50181bfc5b2f57:

  iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu (2022-04-22 11:21:30 +0100)

----------------------------------------------------------------
Arm SMMU fixes for 5.18

- Fix off-by-one in SMMUv3 SVA TLB invalidation

- Disable large mappings to workaround nvidia erratum

----------------------------------------------------------------
Ashish Mhetre (1):
      iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix size calculation in arm_smmu_mm_invalidate_range()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  9 +++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c    | 30 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)
