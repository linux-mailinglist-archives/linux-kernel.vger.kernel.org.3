Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07244CD7F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbiCDPgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiCDPga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:36:30 -0500
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481F31C60F4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:35:41 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E18F91CA; Fri,  4 Mar 2022 16:35:39 +0100 (CET)
Date:   Fri, 4 Mar 2022 16:35:38 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.17-rc6
Message-ID: <YiIxynRjN0sRPIju@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sAXEzC0S1am36OTS"
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sAXEzC0S1am36OTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc6

for you to fetch changes up to 9826e393e4a8c3df474e7f9eacd3087266f74005:

  iommu/tegra-smmu: Fix missing put_device() call in tegra_smmu_find (2022-02-28 14:01:57 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.17-rc6

Including:

	- Fix a double list_add() in Intel VT-d code

	- Add missing put_device() in Tegra SMMU driver

	- Two AMD IOMMU fixes:
	  - Memory leak in IO page-table freeing code
	  - Add missing recovery from event-log overflow

----------------------------------------------------------------
Adrian Huang (1):
      iommu/vt-d: Fix double list_add when enabling VMD in scalable mode

Lennert Buytenhek (1):
      iommu/amd: Recover from event log overflow

Miaoqian Lin (1):
      iommu/tegra-smmu: Fix missing put_device() call in tegra_smmu_find

Suravee Suthikulpanit (1):
      iommu/amd: Fix I/O page table memory leak

 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 10 ++++++++++
 drivers/iommu/amd/io_pgtable.c      | 12 ++++++------
 drivers/iommu/amd/iommu.c           | 10 ++++++++--
 drivers/iommu/intel/iommu.c         |  2 +-
 drivers/iommu/tegra-smmu.c          |  4 +++-
 7 files changed, 30 insertions(+), 10 deletions(-)

Please pull.

Thanks,

	Joerg

--sAXEzC0S1am36OTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmIiMcoACgkQK/BELZcB
GuOVgw//cRwpzihkCZzEyg3UdyLz3/T2+rJukHB+ACyZot/DmB4ygu/SNI5CY2tE
b5gbxBEX8ZiKoobFewhMe+qWi0z9y5FIuuKOOGgnS81XYb89DhedMsIeiTtLNa5m
87BrByk+t9x7Nlo5AHfm8RfpBaRs6ZFewP37twZMdq+MF0lKyl7Af5kFxwol4D7Q
+3oxGHl6zEINYeFB6i+/8hUm0zk4uTOZPdai52HNXbH658Mz07+xi03h7EK0SfWC
y8eJvjUvO/9+JSYdYn7FJiyo8WsV/p+UaxoVQ6sHo6/pmTT7tB/ENsWnzCde+KVB
a2Pali17xmQunUvP74QMHgghf6ebvEcqgIqn8tTrEdNfkcJRp9XrZgVRdYeZlSOX
gjTfqTcoLfkIrnJlfC36zYa4QmXtp6jE9n3D3i8zkGSKVqKu4fRgjyXF2gBBUm03
CTMRZW1Z63HyiDBbZfwwVzMGVhmNKBDAX4xPIiTQwb6yh52a3LhRTQP22mSmnpjp
W4UaJSucKkkpeGvQKwr6Qx9Td2fYCL5tiKdP1u8fH9rAPT9TX1LKZKpncFJE+d/7
kMN62iDnYdOm0AZiWkSQ0Xr5FIbTLfMAqiIAQ3zbt6ujNVl7be20h9ZOvgUeckUX
e6mZHuyhhUT1V/XslRwWldo1TsZC2HYCKsNddQVd6in9B0gr4zY=
=bjSp
-----END PGP SIGNATURE-----

--sAXEzC0S1am36OTS--
