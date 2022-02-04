Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F0E4A9C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359851AbiBDPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBDPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:49:57 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC59FC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:49:56 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C014836A; Fri,  4 Feb 2022 16:49:54 +0100 (CET)
Date:   Fri, 4 Feb 2022 16:49:53 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.17-rc2
Message-ID: <Yf1LITyFpv5yAUNJ@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZbT9qK9E8AKZwGNr"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZbT9qK9E8AKZwGNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc2

for you to fetch changes up to 9b45a7738eec52bf0f5d8d3d54e822962781c5f2:

  iommu/amd: Fix loop timeout issue in iommu_ga_log_enable() (2022-02-04 12:57:26 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.17-rc2

Including:

	- Warning fixes and a fix for a potential use-after-free in
	  IOMMU core code

	- Another potential memory leak fix for the Intel VT-d driver

	- Fix for an IO polling loop timeout issue in the AMD IOMMU
	  driver

----------------------------------------------------------------
Guoqing Jiang (1):
      iommu/vt-d: Fix potential memory leak in intel_setup_irq_remapping()

Joerg Roedel (1):
      iommu/amd: Fix loop timeout issue in iommu_ga_log_enable()

John Garry (1):
      iommu: Fix some W=1 warnings

Vijayanand Jitta (1):
      iommu: Fix potential use-after-free during probe

 drivers/iommu/amd/init.c            |  2 ++
 drivers/iommu/intel/irq_remapping.c | 13 ++++++++++---
 drivers/iommu/ioasid.c              |  1 +
 drivers/iommu/iommu.c               | 33 +++++++++++++++++++--------------
 drivers/iommu/omap-iommu.c          |  2 +-
 5 files changed, 33 insertions(+), 18 deletions(-)

Please pull.

Thanks,

	Joerg

--ZbT9qK9E8AKZwGNr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmH9SyEACgkQK/BELZcB
GuOzRQ/+NruR8YEI/iqLztKrrEUvgn+TLtxe24qZC9GR9sCVqRpSy9u7xj/W4MpK
OQqyuJNhPqLd4i8NdToAmjOLhibjwV1Muv09/65Kvfw52I/JukPDat8mAqy5kwAf
XsKiiLmgxYIvlXsy5NTJEOUjaLC+2curn5pnDLvLVN6unOxsyUqMm1DzjyVR6jr+
+IivXrRVJT295WQNhI3lDPGEPPMxeABD/uFLNbBxS5LrEmMae5YFfAREvuV2HBxq
b2E/8nx+wFSE13nqMBg/8StkXgitsQ2mD9gzkX55sP/o1Jm65PN4/oG7BSxSAoJI
PrqtlYVAnxi16KeMZZF43XfGfdYJPAHQLPdWzF2t2SxEO52lv1N+iYpK+rgVTDcG
FiBsy901zE+3eBL8iDOAnsWB9ZLP78OqP7FEUu36zR2YPACBGw+6MZEbz6c/FZso
9HG0XGwVaXWWpvnx9tmg0B5mfPW2W4tektVF29ZRf8LlQGU5qcDCP8SK89dtUd8q
H4xhntVEFQhNVHowUvAtCJW8vXqsFXX9iCnclYIv5Jbir2nlo45JtJ4mUqjy7K1B
R3uPG4BtrBrANCrTkrdftggNqHUtrmGyhW8GPMGc2bh92VoB3LxXDxMMbCNw72EG
CpgA7BRRFLCD638ZgNV32tXEd67ZTWZytvPQlh9W2JKuklK1cjs=
=Baa5
-----END PGP SIGNATURE-----

--ZbT9qK9E8AKZwGNr--
