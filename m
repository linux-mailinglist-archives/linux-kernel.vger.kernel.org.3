Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6B1530FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiEWNAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiEWNAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4353B49;
        Mon, 23 May 2022 06:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE84561345;
        Mon, 23 May 2022 13:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9BDC385A9;
        Mon, 23 May 2022 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653310839;
        bh=0gJAhDWK23rUCBEAT34CY4awugOC65Cdzpv/yAHbc7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kvm3v85Z6Fv+WogPmdKKfh3PQ36Ep86EwiFoAJsMmlPnVDmEKSnbaoVXbD+mjuCbR
         7pVZ+OD+zZ6r2qmQ/jY+r4AOsPjfvQ/YJUWrKfxKSX52Wd/FG0clmH1Ew0vASF0kYj
         zR90qdJyWkxltZQqCpOmgNgpWn9qxiEfIOb04TjwXYVQJJv80Ah0KkmSGSD26cjw7L
         iKrBXWjokUFPC4ZvISgEpvBp0NZKXeftsNMe7eXtqzoD++yvvrtyLwDyfNTSDq7L93
         SrZRxRQIbU6BELoDxcDp9N+IPb3T3iQU94Cmyv/++EDAFtRubC8Wolmh+A4ZFKSkxd
         pkICzjHhbkFpA==
Date:   Mon, 23 May 2022 14:00:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] regulator: Add driver for MT6331 PMIC regulators
Message-ID: <YouFcSapkVC7ZfuP@sirena.org.uk>
References: <20220520133305.265310-1-angelogioacchino.delregno@collabora.com>
 <20220520133305.265310-3-angelogioacchino.delregno@collabora.com>
 <YoepiTUfdhkYByo7@sirena.org.uk>
 <6cc68be9-e509-eae4-801d-997fdc01dcf2@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zrq/BafcBysX3uNy"
Content-Disposition: inline
In-Reply-To: <6cc68be9-e509-eae4-801d-997fdc01dcf2@collabora.com>
X-Cookie: Sales tax applies.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zrq/BafcBysX3uNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2022 at 02:49:19PM +0200, AngeloGioacchino Del Regno wrote:
> Il 20/05/22 16:45, Mark Brown ha scritto:
> > On Fri, May 20, 2022 at 03:33:03PM +0200, AngeloGioacchino Del Regno wr=
ote:

> > > +static const unsigned int ldo_volt_table10[] =3D {
> > > +	1200000, 1300000, 1500000, 1800000,
> > > +	1200000, 1300000, 1500000, 1800000,
> > > +	1200000, 1300000, 1500000, 1800000,
> > > +	1200000, 1300000, 1500000, 1800000,
> > > +};

> > So the top bits of the voltate selection field just get ignored?  Might
> > be easier to just write the code to not include the top bits.
> >=20

> No, they're all valid values for real... but I guess that I can simplify
> this voltage table by simply modifying the bitmask that we use for the
> regulators that are using this table....

Right, my point here is that it looks awfully like the documentation
(this came from documentation I guess?) is including some extra bits
that get ignored in the voltage selection field here.  That seems like a
weird choice somewhere along the line.

> > > +	if (info->qi > 0) {
> > > +		reg =3D info->desc.enable_reg;
> > > +		en_mask =3D info->qi;

> > If the regulator doesn't have status readback it shouldn't provide a
> > get_status() operation.

> What I've understood is that when there's no "QI" flag, the enable regist=
er
> will provide the regulator status (EN/DIS) acting like QI, that's why I've
> added that if branch...

> Anyway, I'll recheck this part before sending the next version!

That would be fairly unusual, often a regulator won't even detect when
it's gone out of regulation.

--zrq/BafcBysX3uNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKLhXEACgkQJNaLcl1U
h9A4gAf/S2iKtIJE+f3lzVnAs3dpnbYYgTd2ZdrDVFtyW/cH6sKeRTKVzvHefnRc
t3SVVtMNVJ2TZNiO+p1WAm9qU/X1Z1QCsnD+8fqRl5GdVHLLcZCbajSb661dRKYg
mg9WRUMZ66mk6o8F3mU1v1Ov5oitF2ng4hT9GLseXXyaLKd/72OwO/yhzLItjUWN
IQmSkytWOrEJIUjDQcvzBkCIREMjOKASkpwfkVN0h08n5GoedQ/DrQL/hQ/vojrh
Jc3FdWtaYWIxa9bUCOPWMAkJPvxS8BE1xkOxrS+I/BnD66WTigrlJRdnsIEy1XzJ
51w8eBJpVpXGsRyh2h3SzY0hPouSHg==
=YULk
-----END PGP SIGNATURE-----

--zrq/BafcBysX3uNy--
