Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE376514013
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350934AbiD2BRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiD2BRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:17:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A8436300;
        Thu, 28 Apr 2022 18:13:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KqDyq4p5Tz4ySf;
        Fri, 29 Apr 2022 11:13:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651194836;
        bh=JKudEto56hkdtDEXe6pYOk1Gxjv2rBMewH8G3gmz+Ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ul6O/K/qdKqclNjpEv94zZbvB9l8rwUaR9IyBr7bBeZSMZW3phDEpfGnfKVcb3GGl
         WE6uFX5uiTzo4zV4Tc4mZPtAqH/p6F571uzwIAOmYu5cFa4ZCBE3BDl9KvrrpimuYV
         BV3dI37bFDLBqYRLMHucOAjAflnrZljTaUdOeK2/szEh7I75qtTWEgIKcXRPmgyzh7
         IiBHt2DkqGXA0hANiw1LzPeSSFU2QON4Ya/nnvBbgz58xDiTN9TcUFlw7cpWW1V/r8
         ZcH3qlWAmJE3jr+fLdMOXEwh9LFGJ8PSvf8qL9MgPizIWUI7bGQgPew35gTar4QDQg
         xdN1eAjnQYZ5g==
Date:   Fri, 29 Apr 2022 11:13:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the amdgpu tree with the drm-misc
 tree
Message-ID: <20220429111354.197c6dee@canb.auug.org.au>
In-Reply-To: <20220413101014.6b6c4db2@canb.auug.org.au>
References: <20220406103405.299c06b9@canb.auug.org.au>
        <20220413101014.6b6c4db2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IkXKkyei2vl1p3JTY1CZNbt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IkXKkyei2vl1p3JTY1CZNbt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 13 Apr 2022 10:10:14 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 6 Apr 2022 10:34:05 +1000 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > Today's linux-next merge of the amdgpu tree got a conflict in:
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >=20
> > between commit:
> >=20
> >   fee2ede15542 ("drm/ttm: rework bulk move handling v5")
> >=20
> > from the drm-misc tree and commit:
> >=20
> >   184a69ca4d41 ("drm/amdgpu: separate VM PT handling into amdgpu_vm_pt.=
c")
> >=20
> > from the amdgpu tree.
> >=20
> > I fixed it up (I used this file from the latter and added the following
> > patch) and can carry the fix as necessary. This is now fixed as far as
> > linux-next is concerned, but any non trivial conflicts should be mentio=
ned
> > to your upstream maintainer when your tree is submitted for merging.
> > You may also want to consider cooperating with the maintainer of the
> > conflicting tree to minimise any particularly complex conflicts.
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Wed, 6 Apr 2022 10:28:53 +1000
> > Subject: [PATCH] fix up for "drm/ttm: rework bulk move handling v5"
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_pt.c
> > index 958d7ed97882..a29933fa001f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > @@ -630,7 +630,14 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_=
base *entry)
> > =20
> >  	if (!entry->bo)
> >  		return;
> > +
> >  	shadow =3D amdgpu_bo_shadowed(entry->bo);
> > +	if (shadow) {
> > +		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
> > +		amdgpu_bo_unref(&shadow);
> > +	}
> > +
> > +	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
> >  	entry->bo->vm_bo =3D NULL;
> >  	list_del(&entry->vm_status);
> >  	amdgpu_bo_unref(&shadow);
> > @@ -653,8 +660,6 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_dev=
ice *adev,
> >  	struct amdgpu_vm_pt_cursor cursor;
> >  	struct amdgpu_vm_bo_base *entry;
> > =20
> > -	vm->bulk_moveable =3D false;
> > -
> >  	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> >  		amdgpu_vm_pt_free(entry);
> > =20
> > --=20
> > 2.35.1 =20
>=20
> This is now a conflict between the drm tree and the amdgpu tree.

I noticed that commit 184a69ca4d41 was merged into the drm tree but
only the second hunk of this merge fixup was applied.  So is the first
hunk above unnecessary?

--=20
Cheers,
Stephen Rothwell

--Sig_/IkXKkyei2vl1p3JTY1CZNbt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJrO9IACgkQAVBC80lX
0GxCTQgAlhLO3UAe6juc9E9Jkvm4SgXtBEkla/qeqaYtIVYSYQbat2pNpdmBAHhM
HCN+7O+lPMkX9AkCMwqCxQJ1eAwor4jFlblP6q5IwoHrHLkXAXOR7dVqCTUQYLJV
dUlCy+N3uDZR6EUHIeeyR2j6qaR1WI7VTs3lQYVTOjzq+CLvOjVt8s0u4qjUu+t2
7oqNt6ujs940L4bzuGq8dYEyJ3fkibjrdmlnkUyHDs650ZtgBfRK335fiz/Ojeus
D/yiS5K4wgn+0gY8liMDESeyzciDt9W7iVHaAU6E8GRhgUVKGKliXcdM+t5u6Vzv
eDg1c4OfL4xvu7UTGWiaQR0SHYVi2Q==
=Z4Tp
-----END PGP SIGNATURE-----

--Sig_/IkXKkyei2vl1p3JTY1CZNbt--
