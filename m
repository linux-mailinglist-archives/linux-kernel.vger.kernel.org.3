Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23864C62C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiB1GJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiB1GJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:09:11 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9FA627A;
        Sun, 27 Feb 2022 22:08:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6VLN5yjfz4xcd;
        Mon, 28 Feb 2022 17:08:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646028508;
        bh=n2y7O4kpz0V/jwE+qIFGvh2yrh1G0JEsfwA7phX8efk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XOMZpnAjvrR8FwrPe8gMSYWTmsskP1bm33mOEZpQAgzxQmwt7YXu+iCGwJfK/QaVA
         cMADijAx9Nycrz2IezP/O99OXn4z1x9fxkHcA18039EcwaJef646u5VQpsE+g+hyHK
         wVl4blCG7FHi8NEYBIGbJKXaO2PkkQE5eGVZIRyj1SRoJXhmUORh4w47sgEDmFe9vq
         KH07t18uI++5NunznF1ErfzOr9QSwtqZ+MlucMjmOZ5CZek7dJwsI/p3Z1kGpq/gpT
         lZuonRevR5yrlCM/7KhZKjsEna1IHriKdz6NuBVVbemjzrlNd4LZ3z3GEeZD3epmpF
         ZrcHrM3etv2MA==
Date:   Mon, 28 Feb 2022 17:08:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mfd tree
Message-ID: <20220228170826.4dedaf6a@canb.auug.org.au>
In-Reply-To: <YhZo7xnNRKz8U1Lf@google.com>
References: <20220223165416.2359767-1-broonie@kernel.org>
        <YhZo7xnNRKz8U1Lf@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D/S4iBvUBUBuV9b78r06kp9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D/S4iBvUBUBuV9b78r06kp9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, 23 Feb 2022 17:03:43 +0000 Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 23 Feb 2022, broonie@kernel.org wrote:
>=20
> > After merging the mfd tree, today's linux-next build (KCONFIG_NAME)
> > failed like this:
> >=20
> > /tmp/next/build/drivers/mfd/sprd-sc27xx-spi.c:255:35: error: redefiniti=
on of 'sprd_pmic_spi_ids'
> >   255 | static const struct spi_device_id sprd_pmic_spi_ids[] =3D {
> >       |                                   ^~~~~~~~~~~~~~~~~
> > /tmp/next/build/drivers/mfd/sprd-sc27xx-spi.c:242:35: note: previous de=
finition of 'sprd_pmic_spi_ids' was here
> >   242 | static const struct spi_device_id sprd_pmic_spi_ids[] =3D {
> >       |                                   ^~~~~~~~~~~~~~~~~
> >=20
> > Caused by commit
> >=20
> >   6fc90b92e9c7ef348 ("mfd: sprd: Add SPI device ID table")
> >=20
> > I used the MFD tree from yesterday instead. =20
>=20
> Thanks.
>=20
> Will fix for tomorrow.

I am still getting this build failure.  It is an x86_64 allmodconfig
build.
--=20
Cheers,
Stephen Rothwell

--Sig_/D/S4iBvUBUBuV9b78r06kp9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIcZtoACgkQAVBC80lX
0GwgxggAh5RT0UWsJBp7THQuCYw2w+197XuDECXayx/jx1nUaMAMFlasEuDKGTNJ
3sFj+RCbiTL0Th4RXs7KQjmjaLo201eVYMCKWlAmYcH2PM71UMIIZDq/ZFzGzlUB
vSs0YIa4kMaUv7OVmVAmMIjVeJeXrMuzc252IfkXu+ZN6EEnRwB95wa6ym2fodgT
wfPWnJTG9PNlkczn/gZwRAWfPvcqN6hP8r79XB/Fi9aq7/sp5LyTr9I/tNRPcRIS
CqNB01PnAb/iYJ85wcCOuHDL1fpJI531B9FB2kQWiOCeDP61O+r5poXdowtNNHO8
hdT4Fmo6rb3K4sxorYPh9J8h51Zycw==
=pTwe
-----END PGP SIGNATURE-----

--Sig_/D/S4iBvUBUBuV9b78r06kp9--
