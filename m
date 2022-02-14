Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A043D4B56E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356617AbiBNQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:37:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356579AbiBNQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:37:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213B46515B;
        Mon, 14 Feb 2022 08:37:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 419021F43601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644856632;
        bh=xtCoDMldrBj2wzxfrRVgsB4LaKOaG5qDFCWlCS3lxaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHkGIZlzuLMY3au0OU09JwwwDc+7TtKA8yHhQ4RZwmqVZ1oVJXqWwVsfDy5n8K0jl
         lhM0z+EW+Vpart5pM9pBdnT6Kl5o/mcS3KTjMxhwORH5YFXKsCNpNWTmPbiyPdrouu
         ZG3Rs0vSNo8q4xtJyaBZjSLg7LrM7Gbbk21oeMSZPxlb4GvqTOqpeEEUzeFlPBr9D5
         5qfh4l1895y2FdoeDFjEX9dtWRYt2mynMKNtfBIhKJFdjkcZgCneiIbvZo5aFobfuD
         uZ2o4dzVwpPEVnzGHIEmQV7GcORMRP/wavoUgBFBkWRWqmvnTOnjyKySVMSjsvpJeL
         2pj6E+trme9FQ==
Received: by mercury (Postfix, from userid 1000)
        id 6684510603FD; Mon, 14 Feb 2022 17:37:10 +0100 (CET)
Date:   Mon, 14 Feb 2022 17:37:10 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: maxim,max14577:
 convert to dtschema
Message-ID: <20220214163710.g5brep7jkvwf44ih@mercury.elektranox.org>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <20220111174337.223320-3-krzysztof.kozlowski@canonical.com>
 <20220112112905.n6zb36kwop2kfm2n@earth.universe>
 <YgpkgSmxAWCNHW9l@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lbjfw46sz4tz7akt"
Content-Disposition: inline
In-Reply-To: <YgpkgSmxAWCNHW9l@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lbjfw46sz4tz7akt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Mon, Feb 14, 2022 at 02:17:37PM +0000, Lee Jones wrote:
> On Wed, 12 Jan 2022, Sebastian Reichel wrote:
> > On Tue, Jan 11, 2022 at 06:43:35PM +0100, Krzysztof Kozlowski wrote:
> > > Convert the Charger bindings of Maxim MAX14577/MAX77836 MUIC to DT
> > > schema format.  The existing bindings were defined in
> > > ../bindings/mfd/max14577.txt.
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> >=20
> > I expect this to be merged through MFD:
> >=20
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Do you need a PR?

No, Not needed.

-- Sebastian

--lbjfw46sz4tz7akt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIKhSIACgkQ2O7X88g7
+pq9MA/+JkCCsNVnqwkgph6JTIH9cztGiu1Jhcm6dR1hCLceMuXV1S3jVlaM9z2I
yvzMmrh7IuIxSqEOlGrtZIxkemcg2v27VdkzNOooQXKEphKsV632WuaoGQr8N+sO
jvg0al6n6PDPsUwb1MkphrRzQeHYhRJ58hZv1JgWeHMSvCwOAy6PT1NwruoSjjg/
iG7QUwk6RaWOlYWqmVcLx0oFpjtHHQOjmZSgyBViK2cDo6DlNv4tjaCWe1Nys3Zj
qmzgRWdh2VjAzFDLANzhZxoLa6h2HfiI4lohgGP+F8p16MxY1OJzMQm4fh3CHM7t
vO2cd3P8910VDCk+6GtQHxzHgUQxRBNqwUqPIA1uwW3r/BOz50DRpG+oBvyWW8u2
usglqyE53tUJD/m58C33fERAUsqoin2TGaM+2TqyR0HYFxuNQ/q+xVU6c/Uh+tDP
mkQkVdfbJFgUf/O3v6+aQhLJd+kNQ/kRNO3M9aMeK4VQABmrEbMe0J800/UqFuas
iSjFRKJcZNLIhmxpRnAfJxV4FqY+dDvOsdBFxYrHRdDDasn7n5R0+5N+p4vrpv8B
1xcyRumGHzrnzV7Aq+H2dUsgd2wRQXgY+khi1Bnw/Zl+Wa5xHzmBI7PLvD8Q3Y7A
Ap5IosC/AcUwb7hSwuGJaObVmOgogotgeoZ46fJputXcOdowthU=
=yjeI
-----END PGP SIGNATURE-----

--lbjfw46sz4tz7akt--
