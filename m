Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B194F9484
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiDHLyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiDHLyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:54:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5B651323
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:52:10 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 331051E9; Fri,  8 Apr 2022 13:52:08 +0200 (CEST)
Date:   Fri, 8 Apr 2022 13:52:06 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.18-rc1
Message-ID: <YlAh5jHAEl/wvb0g@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S78vV3zdgm7+tFOJ"
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S78vV3zdgm7+tFOJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.18-rc1

for you to fetch changes up to 71ff461c3f41f6465434b9e980c01782763e7ad8:

  iommu/omap: Fix regression in probe for NULL pointer dereference (2022-04-08 11:16:29 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v5.18-rc1:

	- Fix boot regression due to a NULL-ptr dereference on OMAP
	  machines

----------------------------------------------------------------
Tony Lindgren (1):
      iommu/omap: Fix regression in probe for NULL pointer dereference

 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--S78vV3zdgm7+tFOJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmJQIeMACgkQK/BELZcB
GuPy1hAAnC8kn6odu36pzkZF/R7Wj51iCXRfHpDqggxFb0Una1PjSlCdIkfUURVU
x0DdLw+qWVbMkwhIvxG+1rNrhGoDqJdoxXLdJoHdm87ATLXj2XOmCd4h4UMGjK5k
jtx2f2n0H9KXa14FtMj4asJ+565ALRiJEswKv4DGji05WtABuUagxX7BG2/cVELW
MQUASwHwCNYXphkBLS0ki2CLNBnA55OkF4vvqRefNGsjwvHyUaYWiFmUfpU4veb2
m02kUxSjJbdevwXwRnQ/YXHZAjXttX1Lc61DJFCgCHhMh2W7NjggqaQ8OySpxmoC
6j3TDp16afUcERdYoQFB0uzeMb6Z5/vBXI71eoFJQse7MTOxsbyvqjDNPj0OMBmU
TRNzS1r4fBC8NcOPqJ+BifdVmcgWz0r+qnGkHYuU2/YaaSmlkFOzM6Y0F3fQcG7c
Drs0hqAABRaLuXVDpFNBVsl+OEaFfsg2hE5nsRFld3gc+fXC3TGtfttljBJuUsxa
ZtID2u53lebjpsODpEZbsY2klTozuIr6oKQNFLWez6KMHJIg4f9UBJGJgD6P/x+4
+Sm/wtRsOQjvJogsal2HEg05Bq+L+44bKdSoCLaMR3Gpu2LeCMjHWhSJAvVh19dm
HayU26ex0tjtkwmppEA58QGvCI1OVycuPvXXn93Y/WRiuRCMFp8=
=5IF9
-----END PGP SIGNATURE-----

--S78vV3zdgm7+tFOJ--
