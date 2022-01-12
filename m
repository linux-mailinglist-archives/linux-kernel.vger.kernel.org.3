Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22A48C908
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355506AbiALRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:03:49 -0500
Received: from 8bytes.org ([81.169.241.247]:37486 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355540AbiALRC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:02:29 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 67A4525F; Wed, 12 Jan 2022 18:02:24 +0100 (CET)
Date:   Wed, 12 Jan 2022 18:02:23 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.17
Message-ID: <Yd8Jn2aUqblPfRvF@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d8vwtHnKPut+5Js9"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d8vwtHnKPut+5Js9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-update=
s-v5.17

for you to fetch changes up to 66dc1b791c5839d64d261c8b40250a33e6da050b:

  Merge branches 'arm/smmu', 'virtio', 'x86/amd', 'x86/vt-d' and 'core' int=
o next (2022-01-04 10:33:45 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.17

Including:

	- Identity domain support for virtio-iommu

	- Move flush queue code into iommu-dma

	- Some fixes for AMD IOMMU suspend/resume support when x2apic
	  is used

	- Arm SMMU Updates from Will Deacon:
	  - Revert evtq and priq back to their former sizes
	  - Return early on short-descriptor page-table allocation failure
	  - Fix page fault reporting for Adreno GPU on SMMUv2
	  - Make SMMUv3 MMU notifier ops 'const'
	  - Numerous new compatible strings for Qualcomm SMMUv2 implementations

	- Various smaller fixes and cleanups

----------------------------------------------------------------
Christophe JAILLET (1):
      iommu/vt-d: Use bitmap_zalloc() when applicable

Dafna Hirschfeld (1):
      iommu: Log iova range in map/unmap trace events

David Heidelberg (1):
      dt-bindings: arm-smmu: Add compatible for the SDX55 SoC

Hector Martin (1):
      iommu/io-pgtable-arm: Fix table descriptor paddr formatting

Jean-Philippe Brucker (5):
      iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
      iommu/virtio: Support bypass domains
      iommu/virtio: Sort reserved regions
      iommu/virtio: Pass end address to viommu_add_mapping()
      iommu/virtio: Support identity-mapped domains

Joerg Roedel (3):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/will/linux into arm/smmu
      iommu/iova: Temporarily include dma-mapping.h from iova.h
      Merge branches 'arm/smmu', 'virtio', 'x86/amd', 'x86/vt-d' and 'core'=
 into next

John Garry via iommu (1):
      iommu/iova: Move fast alloc size roundup into alloc_iova_fast()

Kees Cook (1):
      iommu/vt-d: Use correctly sized arguments for bit field

Kefeng Wang (1):
      iommu/vt-d: Drop duplicate check in dma_pte_free_pagetable()

Lu Baolu (2):
      iommu: Extend mutex lock scope in iommu_probe_device()
      iommu/vt-d: Remove unused macros

Matthew Wilcox (Oracle) (2):
      iommu/amd: Use put_pages_list
      iommu/vt-d: Use put_pages_list

Maxim Levitsky (5):
      iommu/amd: Restore GA log/tail pointer on host resume
      iommu/amd: X2apic mode: re-enable after resume
      iommu/amd: X2apic mode: setup the INTX registers on mask/unmask
      iommu/amd: X2apic mode: mask/unmask interrupts on suspend/resume
      iommu/amd: Remove useless irq affinity notifier

Ma=C3=ADra Canal (1):
      iommu/vt-d: Remove unused dma_to_mm_pfn function

Paul Menzel (1):
      iommu/amd: Fix typo in *glues =E2=80=A6 together* in comment

Rikard Falkeborn (1):
      iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops

Rob Clark (1):
      iommu/arm-smmu-qcom: Fix TTBR0 read

Robin Murphy (6):
      iommu/iova: Squash entry_dtor abstraction
      iommu/iova: Squash flush_cb abstraction
      iommu/amd: Simplify pagetable freeing
      iommu/iova: Consolidate flush queue code
      iommu/iova: Move flush queue code to iommu-dma
      iommu: Move flush queue data into iommu_dma_cookie

Vinod Koul (2):
      dt-bindings: arm-smmu: Add compatible for SM8450 SoC
      iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation

Xiang wangx (1):
      iommu/virtio: Fix typo in a comment

Xiongfeng Wang (1):
      iommu/iova: Fix race between FQ timeout and teardown

Yunfei Wang (1):
      iommu/io-pgtable-arm-v7s: Add error handle for page table allocation =
failure

Zhou Wang (1):
      Revert "iommu/arm-smmu-v3: Decrease the queue size of evtq and priq"

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 drivers/iommu/amd/amd_iommu_types.h                |   2 -
 drivers/iommu/amd/init.c                           | 109 ++++----
 drivers/iommu/amd/io_pgtable.c                     | 110 +++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   3 +-
 drivers/iommu/dma-iommu.c                          | 274 ++++++++++++++++-=
----
 drivers/iommu/intel/iommu.c                        | 111 +++------
 drivers/iommu/io-pgtable-arm-v7s.c                 |   6 +-
 drivers/iommu/io-pgtable-arm.c                     |   9 +-
 drivers/iommu/iommu.c                              |   3 +-
 drivers/iommu/iova.c                               | 209 +---------------
 drivers/iommu/virtio-iommu.c                       | 115 +++++++--
 drivers/vdpa/vdpa_user/iova_domain.c               |   8 -
 include/linux/intel-svm.h                          |   6 -
 include/linux/iommu.h                              |   3 +-
 include/linux/iova.h                               |  68 +----
 include/trace/events/iommu.h                       |  10 +-
 include/uapi/linux/virtio_iommu.h                  |   8 +-
 20 files changed, 493 insertions(+), 570 deletions(-)

Please pull.

Thanks,

	Joerg

--d8vwtHnKPut+5Js9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmHfCZcACgkQK/BELZcB
GuPYbA/8DJ3UDORB+m9PPRo59QhfMsTtrJVMNxPUYan3Nfoz+l6K8QZc8lMVG6xY
TN7I9ptXi0TdZHbGUA/1YKgZlkXqQj60K9YK/0TBkwB/MwN2utQigbjZSRQPT3Zd
2D6y+mnMSX+j+mCWtwpttJkgriUPtk7eDkK2ur3Ex2QocfBnH1ObuL0ufQrj5XN8
A68YMLfl3bhn6X9RAuxBh15RZXHYyk7AK1NIFOxY4tKFiSk18QRl1y3in8o39kV2
lkDs4ggjh+TgE65+1Rrx1Cl9FV3kbwrkAkBVCKtyQjuPsYRZpw38bg1JWOg4imSY
sp9AXkJdmmFPECdEcE82++CCDp00S89Hh3NgoAhuhLD75h4zV2puYUdv6FgFOBif
bSZq3/Q7psQ9cjsamkjv8fq7gfqQHGS6P3g5Wtm/MGV4Ksv/dE9MnUcdszqpVVdr
9Hq1Fd/OvRDaqnuDIPRRTvzD5EbrnVBAEsXHXQEkZWNvlmPRnyfAnCgC5F4/6pw5
U2w8acAk9sFZHgtEEJK/GqvMGsmZ+Z9P58EXWpZz9/ovwQNpg/LtZp9bLG7cA8vM
xHe+HpJoEBMjZhaqVrngLBUjntZGac9aq35JRCd7/VlBD3qlEvLiQaAV6uWfomJG
FweCzpso0Q18sxH+bqOx0b2tFXYTsCylbvygZJqLSbMiU2Jfrio=
=gWcn
-----END PGP SIGNATURE-----

--d8vwtHnKPut+5Js9--
