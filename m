Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ED3581CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 02:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbiG0AMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 20:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbiG0AML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 20:12:11 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69D2E0FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lrQVRdpyTQanHDn5jVr9FDMO6Z/Xr+0Zl1av9ZPUerE=; b=E098vHSF2AsYjqSljAF0EmIZAF
        9v8jTeTj5p3jfc9sPPeJsqjRVYwSlKDOCstexFctzUTWQNACaA/8TwrOXQEcYJjxRyaKO6ErQJ7vN
        CTkvgFcRv6mVFU0QpY+QWoHflrInTlm3rHuTmHEnrgEyGJHPI2ceMyMJ6DzVVggdxxuOjdyGyj38s
        nQEoV6vebL8gBb9g1COm6S4hirbQMp16iJ2gO8WPOrO69WHcHys75Pcpy33qV6zteN3dU9yEPZXmf
        5szqToC8MbBe9gt4vyfiMZKU3UDAhM+2Yb/4klBFPjjd8591Qrxj7yquGlhiOAG6KPmz7tjUjVfKh
        ZgqbpGjQ==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oGUeb-007w0B-G4; Wed, 27 Jul 2022 02:11:57 +0200
Date:   Tue, 26 Jul 2022 23:11:44 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Magali Lemes <magalilemes00@gmail.com>
Cc:     =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        siqueirajordao@riseup.net, mairacanal@riseup.net,
        sunpeng.li@amd.com, tales.aparecida@gmail.com, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        isabbasso@riseup.net, andrealmeid@riseup.net,
        christian.koenig@amd.com
Subject: Re: [PATCH 1/2] drm/amd/display: change variables type
Message-ID: <20220727001124.dsulur5hhlinjg6o@mail.igalia.com>
References: <20220725181559.250030-1-magalilemes00@gmail.com>
 <a7589316-2a55-85f2-b665-5fe4bebf7a69@igalia.com>
 <4f359e30-90f8-c8bf-4e07-6856fcfd3506@gmail.com>
 <20220725233853.5y7wgpbhfau24ric@mail.igalia.com>
 <88ce4703-e295-f41a-5905-d8afe5589f80@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2tzm6eoxhjctyhdr"
Content-Disposition: inline
In-Reply-To: <88ce4703-e295-f41a-5905-d8afe5589f80@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2tzm6eoxhjctyhdr
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l7b6ouf554xuusjc"
Content-Disposition: inline


--l7b6ouf554xuusjc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07/26, Magali Lemes wrote:
> On 7/25/22 20:38, Melissa Wen wrote:
>=20
> > On 07/25, Magali Lemes wrote:
> > > On 7/25/22 16:42, Andr=E9 Almeida wrote:
> > > > Hi Magali,
> > > >=20
> > > > =C0s 15:15 de 25/07/22, Magali Lemes escreveu:
> > > > > As "dcn3_15_soc" and "dcn3_16_soc" are of type "struct
> > > > > _vcs_dpi_soc_bounding_box_st", change their types accordingly.
> > > > >=20
> > > > I can see that indeed this type change sense for those variables, b=
ut
> > > > isn't a bit strange that the type was wrong in the first place? I w=
onder
> > > > if this variable is even used, given that it would very likely thro=
w a
> > > > compiler error when using the wrong type and trying to access struct
> > > > members that aren't defined.
> > >=20
> > > A compilation error would be thrown if either "dc/dcn315/dcn315_resou=
rce.h"
> > > or "dc/dcn316/dcn316_resource.h" were included in the files where
> > > "dcn3_15_soc" and "dcn3_16_soc" are initialized. Since they are not
> > > included, the wrong variable type error is not shown.
> > > To solve the sparse warning in the second patch of this series, those
> > > variables need to be declared first, but they are already declared, w=
e're
> > > only missing the headers. If I only add the headers, then those varia=
bles
> > > will be seen, and I get the expected incompatible variables types err=
or. So,
> > > fixing the types here is a preliminary work for the next patch.
> > >=20
> > Hi Magali,
> >=20
> > Thanks for inspecting it. What you say makes sense, but Andr=E9 pointed
> > out something that makes sense to me too.
> >=20
> > As fas as I checked, dcn3_15_soc and dcn16_soc is not used outside their
> > respective FPU files. Maybe the proper solution is removing those
> > declarations (and make the struct static). Can you take a look at it?
> >=20
> > Best Regards,
> >=20
> > Melissa
>=20
> Hi, Melissa. Thank you for the suggestion!
> My sole reason not to make those structs static was to keep some sort of
> consistency with the rest of the dcn*_resource.h files, since that is whe=
re
> all the other structs are first declared. I'm not sure, though, if that's=
 a
> good enough reason not to turn these variables into static. Let me know w=
hat
> you think.

I don't see any other file using dcn3_15_soc, it's only in dcn30_fpu, so
better make it static. Also, I see that doing this will ring a bell
for some misuse of the struct outside FPU protection, in the future.

With those points addressed, you can add in the next version:

Reviewed-by: Melissa Wen <mwen@igalia.com>

Thanks,

Melissa

>=20
> Magali
>=20
>=20
>=20
> > Magali
> >=20
> >=20
> > > > > Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
> > > > > ---
> > > > >    drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h | 2 +-
> > > > >    drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h | 2 +-
> > > > >    2 files changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resourc=
e.h b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
> > > > > index 39929fa67a51..45276317c057 100644
> > > > > --- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
> > > > > +++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
> > > > > @@ -32,7 +32,7 @@
> > > > >    	container_of(pool, struct dcn315_resource_pool, base)
> > > > >    extern struct _vcs_dpi_ip_params_st dcn3_15_ip;
> > > > > -extern struct _vcs_dpi_ip_params_st dcn3_15_soc;
> > > > > +extern struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc;
> > > > >    struct dcn315_resource_pool {
> > > > >    	struct resource_pool base;
> > > > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resourc=
e.h b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
> > > > > index 0dc5a6c13ae7..d2234aac5449 100644
> > > > > --- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
> > > > > +++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
> > > > > @@ -32,7 +32,7 @@
> > > > >    	container_of(pool, struct dcn316_resource_pool, base)
> > > > >    extern struct _vcs_dpi_ip_params_st dcn3_16_ip;
> > > > > -extern struct _vcs_dpi_ip_params_st dcn3_16_soc;
> > > > > +extern struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc;
> > > > >    struct dcn316_resource_pool {
> > > > >    	struct resource_pool base;

--l7b6ouf554xuusjc--

--2tzm6eoxhjctyhdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmLggsAACgkQwqF3j0dL
ehzLzw//fHDVwNgg4vD2hJIWf8vnNMimAx0eCtHRRiBOi6D000hZ5hkEENmUssIh
ZxT6UXgrF+btpEkW0NTpfylPyo/7EcxpckQrTjlGSJXnQwQ0wPG+iBzgwzolHSO+
Tn8ldJh2a9e10k0kUiuynzxh6XzDQtTLDDgN/0AvQG26nFHXl0sc4yi/gXBNlZXn
8yy6f0JqELCsWdtKQTogmv79xHKDMj+HlCkG4wAahxJReNq/U2lcltWm3ouf6he3
jN6Q4hgVGiFvmPSV2+VBBfOMOufp2gDV5BiedEh5DEyKxwjyLlmxPhr3nMqI2RuU
U8XGcvyf+5q4kQ6DuzdlrIdamf7PXybJDMRyp3me2erc2QhzyoqTRPmYx+DjZrIl
O9YyWYYtY/+TfInOxR8y3Gy05TTHJ7rtlDW58OvOLKHM2NsdNtpEBhV4FkB/IScZ
l7NwoNxX02/L1BTKPO9EVONkbTlLoqYa9Kp08tdE9BQjYwpFPxvf+OmeetGYI2gR
iuGVByuK1D4jBfv0Z5pN7Tq5CuwjZooZ63H1/fu/1LlXvcUxEES87ZxTt3orhbSG
aWQydBauME/S6ZzPxlBAO2dTPDQ7rtKk3j2Y7ieyyg9rsk6Lr33TRDd/CwckLKts
ZGUj7vRqLZWH4VjS6WIdpUmvmFTJ+wEtPFmL//IGg+OPvKL6cvQ=
=Pcd0
-----END PGP SIGNATURE-----

--2tzm6eoxhjctyhdr--
