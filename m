Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFA5779AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 04:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiGRC7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 22:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:59:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104564FC;
        Sun, 17 Jul 2022 19:59:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmRWp6fy7z4xRC;
        Mon, 18 Jul 2022 12:59:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658113175;
        bh=hDqWNclrxQIfskRhwBQjED7wen2Ep/lOsTe72198r+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R/BzEbtj+86Wi/0t/msPANbdabvHY/JnRruaQP5FWuFbKP63bSFJCfAC1GJvqVFsl
         L9TpS6iDXgEUW4jdPDUsJ2p0LBHZEFGdz+ZQk+tYkRDW9+tpiKJQvHwHt6c4biqOIk
         x9SfXY4HWoQKnhYc492bw8F+6eogOlYKc/o3mB/+dJr0smX2xMRbWWg5UhVpWhyXLK
         NifnGcWRsdasEdOHtvTnt+7GTFZxMj518LiZSnsb3rPJRUDm7QGLEe4DPB20G2DdJp
         kHSPiGGyZ5KVfGLjcmD8ZgPtKei+I/M0s9ZOWzFoZvUtCKsSR+7fVqDa1XV7cS1d8r
         SYsRxq/pAqzgA==
Date:   Mon, 18 Jul 2022 12:59:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20220718125932.1ab89122@canb.auug.org.au>
In-Reply-To: <YtC9AgqezKXuUoy6@ZenIV>
References: <20220714120840.1e1f8c63@canb.auug.org.au>
        <0904ae71-972f-f183-f295-bce3b8518fcf@kernel.dk>
        <YtC6SUmyaCSKe2HX@ZenIV>
        <YtC9AgqezKXuUoy6@ZenIV>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c3OrDG6utUWNfF7eydkpohV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c3OrDG6utUWNfF7eydkpohV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Fri, 15 Jul 2022 02:04:02 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Jul 15, 2022 at 01:52:25AM +0100, Al Viro wrote:
>=20
> > Ones from Keith's branch - #alignment-fixes-rebased in there.  Looks li=
ke
> > one of the commits in it got changed since then - the difference in
> > __bio_iov_iter_get_pages() (unsigned int i initialization).
> >=20
> > Sigh...  I'll rebase on top of that. =20
>=20
> Rebased and pushed out (with copy_pipe_to_iter() fix folded in as well)

BTW, these still cause a conflict.  As long as you are sharing patches
(and then adding changes to the same areas), there will be conflicts.
You need to share commits i.e. a shared branch.

--=20
Cheers,
Stephen Rothwell

--Sig_/c3OrDG6utUWNfF7eydkpohV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLUzJQACgkQAVBC80lX
0GwltAgAlbfgnNkfoM9Zq4GFya0yXAGAQhfJVDrrymIwCL7wiMLa3B2iEosBQD5z
NIi/4zipJUQEkRi5AGDu8xfdFaqy0J/bADsfjg18yU0m32Jj3dEac3HMSziGVJFV
TRuwErpOoVpo9wIyaPNMtWX1w8KXXREQixJY5UDl3Y4wegDhNEW24tbHuISQasJG
pRU2c0XLW8sjw0QW2FsQYfdh3SkyTeX1z8l6wgsJfu87R+0Z3iiLVpJXrh9lU55c
tooTMXKIFijHeIa7WhoeE0+PNL5czM33W1NJiOtng350A3txbBDqnavVF5zL1l9+
eZ8g2WjOQV/K3wz4YOFA0A1wfISDcw==
=znXe
-----END PGP SIGNATURE-----

--Sig_/c3OrDG6utUWNfF7eydkpohV--
