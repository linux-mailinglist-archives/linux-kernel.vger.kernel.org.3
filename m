Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F56C49D3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiAZUuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiAZUuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:50:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A619C06161C;
        Wed, 26 Jan 2022 12:50:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JkbSj322Yz4xmj;
        Thu, 27 Jan 2022 07:49:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643230197;
        bh=fSP4pk+gLT9lXhwLtplW9408kxdERgKMUbPCTn7gWdw=;
        h=Date:From:To:Cc:Subject:From;
        b=ggmf7Dmsd48Y8VoxnCusCkLdRZc7DHCPjPoqooKIUlPxhpStIe0Tj/lWPcfKXsMx/
         NvknFIZNeW4q8T/b8T7AAKTPKu7cGhB1/waGCCOdl/yjFl5FaTzwQKv6DAcz9cAlEC
         fC3FwK7EY0mwkLx1to3BlTePCO5hNxDUcoEp9Pqn4GMunGSmgRCM+W996+0xwMiD8D
         qKmiOTDhRIaZY4A3AruiLwLAM6BcJoFpbw+/TG8IJYdgFbY0ckqc3D2NTxEi++5cSt
         DCSBLXWQ1NcxBO15BPA2qz12pwKGkA9kUDCrrN/C3kBhdYfsJMtC+xSdDUzl1OVRX4
         2xfoKoGRoxn/w==
Date:   Thu, 27 Jan 2022 07:49:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20220127074955.11974c91@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eGW8Oxu21XfY5MvfncKOw21";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eGW8Oxu21XfY5MvfncKOw21
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  339cc9b208bd ("arm64: dts: imx8qm: Drop CPU 'arm,armv8' compatible")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/eGW8Oxu21XfY5MvfncKOw21
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHxs/MACgkQAVBC80lX
0GzbmAf+MAXDPpHjeMY4uCZdbK57rAzApS8smtzHszCi1l2EnbyCoOnSzNmx2QOp
wnPb3/A0SLubQ3SAFPY1eqOctJtBDOxwwobnXw6nDIYC5zIr6pSco4/Dc9I30hsn
Bdy/jkeGmSimrILD1+c9/rgUWbX1pqTe2nfDVZdh5BHKFjx5bkLbs+q3u883IkWq
Gk4xNS5HYkk9gK6XOxkprqs2VEeeqGRx3bMoCG7BqN9uEQsx9MUNgreOlgao25Zx
HeND5HwulfWhryOugp9eCyY/XTpEeWTRXaE82nyixQBTilfxrUxyUygzsh/oFv1K
EDPjBqf+zVD/ffP4bv4fIW7TzhRmPg==
=6WKw
-----END PGP SIGNATURE-----

--Sig_/eGW8Oxu21XfY5MvfncKOw21--
