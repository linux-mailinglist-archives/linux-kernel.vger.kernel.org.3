Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C742C4D9607
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345813AbiCOITr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiCOITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:19:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A021E0B;
        Tue, 15 Mar 2022 01:18:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHmWX0SBPz4xRB;
        Tue, 15 Mar 2022 19:18:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647332312;
        bh=5ICCz9wKBm9SoxKDEUmabQKMoUixurM77xqto89egKs=;
        h=Date:From:To:Cc:Subject:From;
        b=UhtrCKqc5tG6BbLAl4IIMHzseXy7doqa1V7UATtT1ypUZH0yOjthHMVP1YidwjUbh
         Ew+IDwyw71xdL+Ng0+QrvUhGODQjlHy56HPJ/YcbOwcLFOX6qMdsoyJMfB+ZzxZgEs
         2v6nnvdkWm0d3ALAfnRT5UpHLwk+IelXjS8hcQa6EyeGaSuiguepYCOg36Dnsr/5i5
         B9bTRwPIKinha9u2wy7NcFZOIe4LgSBn3JmE0t8mEkR/M/JbscjhgbSiPBAzLxBjep
         ACBv3NL1SMAuW3lSkJTA0BwJZsydnoPsHAT7mpU5+i5SErtPV7in68eLAJ5zKMx1Il
         XgQ/1MrJaTUIA==
Date:   Tue, 15 Mar 2022 19:18:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the nvdimm tree with the block tree
Message-ID: <20220315191831.15816703@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+YpPqtsz2mNdob/CxgQDzEc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+YpPqtsz2mNdob/CxgQDzEc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nvdimm tree got a conflict in:

  drivers/nvdimm/blk.c

between commits:

  322cbb50de71 ("block: remove genhd.h")
  20072ec82864 ("nvdimm-blk: use bvec_kmap_local in nd_blk_rw_integrity")

from the block tree and commit:

  f8669f1d6a86 ("nvdimm/blk: Delete the block-aperture window driver")

from the nvdimm tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/+YpPqtsz2mNdob/CxgQDzEc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwS9cACgkQAVBC80lX
0Gx+SAf+NdvqLE8f0esRN2fwG268MuL+lHSMsolQ4dvkEdmalXqdhyUXiv2BP7Lc
MWgSQ9uc0KaS5BNUSC1jrX4GhUSauJ1UHGo7C9jKRjZwiY77Yu5IbQeHTj+3JUpy
lb8W5/6/GnBOmVdYdKiqpQJhqh5K9Xi66LHwDl/iR7E/XjSv+5KvR1fLyw5uY8vY
NV5SoNU49D3uQI79sDgtehDKVJZrBeZ4L4j6cFZt9NCtTRfIqPv0v1f9xl4+/3U5
hmy7Dy2n2r2/IdnBl84ziQ9Kl/0Ax5k7NvRWvBR5E6copkZtxB282rXNKMlYouB5
Vm5CFJEEa3Fl1nnS2GZvkB8zaCbhSw==
=2hLJ
-----END PGP SIGNATURE-----

--Sig_/+YpPqtsz2mNdob/CxgQDzEc--
