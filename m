Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87024B286F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351098AbiBKOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:54:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351092AbiBKOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:54:48 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5E131;
        Fri, 11 Feb 2022 06:54:45 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E459C1C000C;
        Fri, 11 Feb 2022 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644591284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/snWoyO1kCOhCBySz55Uo3NXloeQ7id88PKB2/aReeA=;
        b=dfg7TkK0I/3exJfTOxYHVvr+fl22x+mJh10e7NYDZQrLuonafe07F0MGv4zTJwjUywdwFo
        jszufveg/kUZOQseo7aSWH+ZDBcvBvoeUGIXooGkG9zRt7vZ4ZXkQXuyUEiJKBa3hL5v5z
        VLjimiAl3xTxrobw3fTaaSlsB2FmK0aWuxFNKiErLGib6APgR2wqIuxyqMlNBE/CVJSVao
        m5j1qNLRBIw+OhjrBFwakpt30YI4+kdgQ3oA9WZihYjswXyBWQznS97QrkPcL1aCexMaiY
        RWHtH3TXANId8vXSxjIngtuLKGcITBqu8JEMrJhbgvQdBGniWJi2Q16d1PRMZg==
Date:   Fri, 11 Feb 2022 15:54:42 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v10 2/6] dt-bindings: gpio: logicvc: Add a compatible
 with major version only
Message-ID: <YgZ4sj1o4WzMPd0P@aptenodytes>
References: <20220120150024.646714-1-paul.kocialkowski@bootlin.com>
 <20220120150024.646714-3-paul.kocialkowski@bootlin.com>
 <CACRpkdbnEKeDNmFCuUCLaySs6AtD9MPtxV+9JDxKuXvTs9iMVQ@mail.gmail.com>
 <6f0e58dc-4b81-d819-13e3-9e0f79ba279c@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fi4rh3UJ303yTdHr"
Content-Disposition: inline
In-Reply-To: <6f0e58dc-4b81-d819-13e3-9e0f79ba279c@arm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fi4rh3UJ303yTdHr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 02 Feb 22, 14:26, Robin Murphy wrote:
> On 2022-01-30 00:46, Linus Walleij wrote:
> > On Thu, Jan 20, 2022 at 4:00 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> >=20
> > > There are lots of different versions of the logicvc block and it
> > > makes little sense to list them all in compatibles since all versions
> > > with the same major are found to be register-compatible.
> >=20
> > The reason we try to be precise is because sometime, long after the dri=
ver
> > has been merged and maintained for a few years, a bug is discovered
> > in a specific version of the silicon.
> >=20
> > What happens is that a fix is applied on all silicon whether it is need=
ed
> > or not.
> >=20
> > If you have the precise silicon compatible, you can avoid this and targ=
et
> > only a specific version.
>=20
> Indeed, the better approach would be something like:
>=20
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - foo,bar-v1.0
>               - foo,bar,v1.1
>           - const: foo,bar-v1
>       - items:
>           - enum:
>               - foo,bar-v2.0
>           - const: foo,bar-v2
>=20
> That way the DTs are future-proof, while drivers can still match on only =
the
> less-specific strings until a need arises. Plus it avoids the problem that
> if an existing OS that only understands "foo,bar-v1.0" is given a new DT
> with only "foo,bar-v1" for v1.0 hardware it won't be able to use the devi=
ce,
> even though it's *functionally* capable of doing so.

Yes I understand that we need to keep compatibility with the already-defined
compatible.

> However, from skimming patch #5, it looks possible that none of these
> changes are needed at all. If LOGICVC_IP_VERSION_REG tells you the exact
> revision, and is always present (as the unconditional reading of it
> implies), then the only reason for adding new compatibles would be if, sa=
y,
> v5 has more clocks from v4 and you want the binding to enforce that;
> otherwise, newer versions are literally compatible with the
> currently-defined binding and therefore should continue to bind against t=
he
> existing string(s) to maximise forward- and backward-compatibility. Sure,
> it's not the prettiest thing for a "generic" compatible to be based on an
> oddly-specific version number that doesn't necessarily match the actual
> software-discoverable version, but what's done is done and that's the cost
> of ABI.

Indeed it's true that hardware quirks can be applied based on the precise
version read from the register, so I don't think there is a need for overly
precise compatibles.

Since the device-tree binding is currently the same for all versions,
I understand that it makes sense to keep a single compatible (the already
defined one), so I guess I will make another iteration without introducing
new compatibles. But I will probably update the binding document to reflect
which versions are currently known to work with its current state.

> (also, nitpick for that part of patch #5 since I'm here: please include
> linux/bitfield.h rather than reinventing FIELD_GET() locally)

Ah good to know thanks, first time hearing about those.

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--fi4rh3UJ303yTdHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIGeLIACgkQ3cLmz3+f
v9Fovwf9FazGyUpB/nAwH7VeTeXwajEB0NHvM9mlYAMba4/aI1h1YN7YzzP6bCm6
xHVZg35DyCEzdwgDdrqhskFL94mRN43XIsu4a6tZhdJ38uqXAu91O/bjQDaNu4zM
h37R+IAlna1D/+O9iiwQ/46t0mdI1kRmsgNcrMwG1ERdMQs7o2tZAupPuhHHioZk
dPwBHCMAJkljVgzf80BgtFuNXglYHp8sunbv05NtodkFLZ/mAANkyRqq9IztJR3D
Myu/D9/AZjU/57KFg3vuveYoMs3PJrPV0No5pgZX2HP0SJwVL9zmLj43L5K2POdK
2LJbjDIKaSkNQ0iJE55P1Qzmqmb7Tg==
=9Gbl
-----END PGP SIGNATURE-----

--fi4rh3UJ303yTdHr--
