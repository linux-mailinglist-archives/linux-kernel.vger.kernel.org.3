Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D237E5778DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 01:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiGQXpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 19:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQXpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 19:45:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD4FD1D;
        Sun, 17 Jul 2022 16:45:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmMCB63PXz4xhn;
        Mon, 18 Jul 2022 09:44:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658101499;
        bh=kQL7s0bv0QVHOf6xNkEQ6iRj458x4B3GPPXuqjZxsDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G9/V5bsYQdzT8lFlBqsJgYbE3dK4DCoDdyXL2f6eaU6ntUfOygHABeUCbQbW4QNUD
         wvSgw9eBM2hJaduED9ml1DITLUHnMrlPZ6rDi53PPtGA6rb5bT9V/p1R4n+gdlzOPj
         fwWM0GexHRPyUYE0QCQO/p3vlnYhbQNMoBWYYpVGuZWrhAdBVLOHcIs/+LRKMzle0y
         lIW8O9r0Xt2vDy7aWDXS25JPjOfvBwqwi6b995CNhmqN8wfYhAnIPx7UlpfeZzExX2
         jbs+QbU8PsOIU5jgfKnEslfl3UDxvcLcIujcIOQDLpdqy7ZS7+BaiyBGdz8XXvSbkI
         pKKzU/b4E1Jpg==
Date:   Mon, 18 Jul 2022 09:44:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with the
 drm-misc-fixes tree
Message-ID: <20220718094453.2f1a1f09@canb.auug.org.au>
In-Reply-To: <6e60d396-2a52-d1fa-f125-3c585605b531@amd.com>
References: <20220711124742.3b151992@canb.auug.org.au>
        <6e60d396-2a52-d1fa-f125-3c585605b531@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8YejglQrq3zPUgCrXSL0TSk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8YejglQrq3zPUgCrXSL0TSk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 11 Jul 2022 10:05:45 +0200 Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
>
> Am 11.07.22 um 04:47 schrieb Stephen Rothwell:
> >
> > Today's linux-next merge of the drm tree got a conflict in:
> >
> >    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> >
> > between commit:
> >
> >    925b6e59138c ("Revert "drm/amdgpu: add drm buddy support to amdgpu"")
> >
> > from the drm-misc-fixes tree and commit:
> >
> >    5e3f1e7729ec ("drm/amdgpu: fix start calculation in amdgpu_vram_mgr_=
new")
> >
> > from the drm tree.
> >
> > This is a mess :-(  I have just reverted the above revert before mergin
> > the drm tree for today, please fix it up. =20
>=20
> Sorry for the noise, the patch "5e3f1e7729ec ("drm/amdgpu: fix start
> calculation in amdgpu_vram_mgr_new")" and another one is going to be
> reverted from the drm tree as well.
>=20
> It's just that -fixes patches where faster than -next patches.

Here we are a week later, -rc7 has been released and as far as I can
tell (though I may have missed it), this is still a problem :-(

I am still reverting 925b6e59138c (which is now in Linus' tree).
--=20
Cheers,
Stephen Rothwell

--Sig_/8YejglQrq3zPUgCrXSL0TSk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLUnvUACgkQAVBC80lX
0Gw6agf9GW4WNGxB7WRUxFOdrFlVRBxgU93UbVTP5tRDPx9AiZiDEOVvGTI6/QlL
z8HL2oxR4QCqQBI3JeY+jGbOY/0DCn2OwtaKe1bTCYtdNbprgZxeTi4/x7dru2V9
Db8ypw5hqiNrXsLSE+RR+t2joQj3jkmnvNK4PXM78LyuXkt31TbrkBCU/vVtVjp6
xcnIlDP2jtiuPAbh1EZf/fPG3/fYKid+g35eSDLV2Y4gc0/CNUuP+D9dh4DaLAzW
bBOEa40Wq3QLSysAhGf4lxGbxFwQQBkLURC/XP71PWMMfvqmhmPqlgtXqVRiux5C
nJQ3xEsLCLYUe/CCd7XEEC8RzBZtuA==
=qitT
-----END PGP SIGNATURE-----

--Sig_/8YejglQrq3zPUgCrXSL0TSk--
