Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E984C8536
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiCAHaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiCAHat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:30:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B267D005;
        Mon, 28 Feb 2022 23:30:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K78610wrcz4xmt;
        Tue,  1 Mar 2022 18:30:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646119802;
        bh=orFthqPFiROEjHHJB+lrlSid+FqXnyyRmJ5wWJwfFvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I3zt/pewGsm8kxIkOSJ+/2zTkhr1rxXGtUQdzR4qizN7AvHlYj0K1eSqZQj+nUR38
         f9rd3vNfSbjVxm8frBoYUcn9df7HqoQ6NGOBSFQmNfp/tM0Zs6E8qAE0y3iI6mBYmf
         2jnF94XJKPAHg/cQzIy52gVav1KWkHfBwHmPkK2x2OcSNTHzu6Qo1gn9AqvxvayJnA
         Q9iK1/bNtyC+gbLEb9NPD4FYfGvxSmwqaGtSPOXJlw1zb4SUgcaqGOzSeiTr9fYgq4
         th4lbF1ktHY1cpzz2w/HKZN/SfSc9e1nMOJRsBNpCTmQVhuK2acWcql8GGVTj3ezAb
         XjHf4ZMWDZvfw==
Date:   Tue, 1 Mar 2022 18:29:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     broonie@kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the block
 tree
Message-ID: <20220301182958.7897ce30@canb.auug.org.au>
In-Reply-To: <20220221220622.3000432-1-broonie@kernel.org>
References: <20220221220622.3000432-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LZIN_SwZYLgmXKP0cvFGDH6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LZIN_SwZYLgmXKP0cvFGDH6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 21 Feb 2022 22:06:22 +0000 broonie@kernel.org wrote:
>
> Today's linux-next merge of the scsi-mkp tree got a conflict in:
>=20
>   block/blk-lib.c
>=20
> between commit:
>=20
>   0a3140ea0fae3 ("block: pass a block_device and opf to blk_next_bio")
>=20
> from the block tree and commit:
>=20
>   2988062985d59 ("scsi: block: Remove REQ_OP_WRITE_SAME support")
>=20
> from the scsi-mkp tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc block/blk-lib.c
> index fc6ea52e74824,bf5254ccdb5f8..0000000000000
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
>=20
> (took the deletion of _WRITE_SAME from scsi-mkp)

This is now a conflict between the scsi tree and the block tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/LZIN_SwZYLgmXKP0cvFGDH6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIdy3YACgkQAVBC80lX
0GzNyggAmo8RpRW5Hye3jb/vY2h08pfoSCtOHeWQR8t3RWMhDWQ/96HsKeRTk3wl
cYSQzqnEWvWBjo3WUYu5ZVVaXvwpoXZFJt2BPZZsM8751kqSzKFsWjSOIWqPmU9E
8s5SjT74jwlnkPIaQPQAU5N7YTA5PLQq/4Vqt/8LzHYhY+ECNWC1+7huIowdbRgF
F4voSDEUF9r9GXLZ1kt8+RYGzDOahcBbdoxOC8xM2uFaoQIZlWp8H7sVVFc8Er5w
DMB2g2RCujRWlZ9TSHASH2oXHW5S8/AXvPRsnaOA8FrH20PPmj4Gfcg7NTdgiZrZ
KnpoYOJ6q0NfRz/KR/62XhtKsmQkhw==
=ofEz
-----END PGP SIGNATURE-----

--Sig_/LZIN_SwZYLgmXKP0cvFGDH6--
