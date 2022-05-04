Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9991451A4C7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353001AbiEDQBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345462AbiEDQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:01:27 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DE746641
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:57:50 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A091F3FA; Wed,  4 May 2022 17:57:48 +0200 (CEST)
Date:   Wed, 4 May 2022 17:57:47 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.18-rc5
Message-ID: <YnKie9R0RhJsGMz9@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dv9q/IqokSHqWzfx"
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dv9q/IqokSHqWzfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iomm-fixes-v5.18-rc5

for you to fetch changes up to 392bf51946c2463436a1ba237c1ec5865b234825:

  iommu: Make sysfs robust for non-API groups (2022-05-04 15:13:39 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.18-rc5

Including:

	- Fix for a regression in IOMMU core code which could cause NULL-ptr
	  dereferences

	- Arm SMMU fixes for 5.18
	  - Fix off-by-one in SMMUv3 SVA TLB invalidation
	  - Disable large mappings to workaround nvidia erratum

	- Intel VT-d fixes
	  - Handle PCI stop marker messages in IOMMU driver to meet the
	    requirement of I/O page fault handling framework.
	  - Calculate a feasible mask for non-aligned page-selective IOTLB
	    invalidation.

	- Two fixes for Apple DART IOMMU driver
	  - Fix potential NULL-ptr dereference
	  - Set module owner

----------------------------------------------------------------
Ashish Mhetre (1):
      iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu

David Stevens (1):
      iommu/vt-d: Calculate mask for non-aligned flushes

Hector Martin (1):
      iommu/dart: Add missing module owner to ops structure

Joerg Roedel (1):
      Merge tag 'arm-smmu-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into iommu/fixes

Lu Baolu (1):
      iommu/vt-d: Drop stop marker messages

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix size calculation in arm_smmu_mm_invalidate_range()

Robin Murphy (1):
      iommu: Make sysfs robust for non-API groups

Yang Yingliang (1):
      iommu/dart: check return value after calling platform_get_resource()

 drivers/iommu/apple-dart.c                      | 10 ++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  9 +++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c    | 30 +++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c                     | 27 +++++++++++++++++++---
 drivers/iommu/intel/svm.c                       |  4 ++++
 drivers/iommu/iommu.c                           |  9 +++++++-
 6 files changed, 79 insertions(+), 10 deletions(-)

Please pull.

Thanks,

	Joerg

--dv9q/IqokSHqWzfx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmJyonsACgkQK/BELZcB
GuN9mhAA3Ew/O0xkKnZ3nyHVoSXaTifytAc3kotV/KKKKjXrPUVoVQH2ggWZARvj
o2ntI+C8Wf5KkTdVV9KLzWRcPa39ycvgK5Yi1emaFvQuYfxJNVV4nBR3D4bv55AM
f3XdkpJgaRmbw0y/drxraLrennlGDd+aLtiAcJZeejfVkAW5CkOwJPVeOAI/5RqH
wuNgrGtoItdIsbxgW4Vx5vNbXApRS2iKzDwQt7vBTnvnVbxzogjU3WM+1kPjUMSb
ADM1/29Ujg4o2hX4CCeUdvyLhUX8NUXW3v9mhvVNNNf+XnW4rHwyTstMj/lC3DNy
yunf5XMA+o8WlZDcYRh29da9tTH7YRJmOVqwn5V8bOKa2OJSCH38Dm1n5XnDWNLl
yjlM6j2iPnz7fZf9lXzMxCAyxuoZ3YEmSQGILMZUYifvIpdumZ4ymcB5YtwJlYjn
7hffrNz0Bt/VptE/w2pU5boDveEpwFL03t5y5LdDhOf6cIW68ZP8Ut8wBlkbu+0K
YXxpdPn4FcieO2dW/IbXGr6IQ7cecMjAwJVOYX2Hmd1/725sSgCnFP2hwZPn21x6
1EDDiL107HC3y2p+K9R/6vKQuog1mp+ABFs4hXjRkpCJ3mFQI5GsfPgPeEhoirSk
638vDCX6tSvVxbi39DdfMtblbA/67y079JMJi5yH8FetsJ1vyng=
=GbgG
-----END PGP SIGNATURE-----

--dv9q/IqokSHqWzfx--
