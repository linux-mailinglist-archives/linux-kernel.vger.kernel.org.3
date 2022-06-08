Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0933542D37
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiFHKYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiFHKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:23:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A91F5E1A;
        Wed,  8 Jun 2022 03:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D971B826AA;
        Wed,  8 Jun 2022 10:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146DBC34116;
        Wed,  8 Jun 2022 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654683130;
        bh=NgdrgTl3dZ/SGMPXdfbwfHxcsCdqkPUGxnyJC5YWywo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWAr6TkECveSD1zPWhbbzl84/dt6uZH8CWvazsACrsq8kUr/kbc8yCivJqucAVb/j
         jhr+F0WKWU22kbqwesiNuAuDbmXtf2DsLI6tQgMqL3vXgzlG4WaS+1LJDZbLGGY8tk
         QUTJ+oDUGYeC/mwq7Uouwt8LgRf6beP+bNOsyPfGUT9SvJd7QdsdsnSWmq11Wopn4X
         Hav0FK8qsSIVnLRdRS7FxcYGCV7rEKsqBUFnfyb2rUaUUFtSw8sEUwfeP/Z5s9x81+
         i1KPx+x5C/2W/oDJErI9bUf7OG8NFrN+mP5J81R42OvY9r/EeRocM/5LfplYqbWBeI
         GWXSOVDSLZVaw==
Date:   Wed, 8 Jun 2022 11:12:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 3/4] regulator: rt5120: Add PMIC regulator support
Message-ID: <YqB19O/HYvEAxdiM@sirena.org.uk>
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-4-git-send-email-u0084500@gmail.com>
 <Yp+gS6r5Kpi33Ags@sirena.org.uk>
 <CADiBU38+0vp3Dv6i7uYzCwR431PKBr-HNQnY0Qe7fvvRYGEJmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MaGFacYl3eetw6pk"
Content-Disposition: inline
In-Reply-To: <CADiBU38+0vp3Dv6i7uYzCwR431PKBr-HNQnY0Qe7fvvRYGEJmw@mail.gmail.com>
X-Cookie: My NOSE is NUMB!
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MaGFacYl3eetw6pk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2022 at 11:15:56AM +0800, ChiYuan Huang wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:00=E5=AF=AB=E9=81=93=EF=BC=9A
> > On Tue, Jun 07, 2022 at 01:52:40PM +0800, cy_huang wrote:

> > > +     static const char * const name[] =3D { "buck1", "buck2", "buck3=
", "buck4",
> > > +                                          "ldo", "exten" };
> > > +     static const char * const sname[] =3D { "vin1", "vin2", "vin3",=
 "vin4",
> > > +                                           "vinldo", NULL };

> > It would be easier and clearer to just make this a static table like
> > other drivers do, there's no need to generate anything dynamically as
> > far as I can see.

> My excuse. let me explain it.
> buck1 voltage range from 600mV to 1393.75mV.
> buck2~4/ldo/exten is the fixed regulator.
> buck3 and buck4 is fixed by the IC efuse default.
> buck2 and ldo is fixed by the external resistor chosen.
> exten is designed to connected to the external power.

> That's why I cannot directly declared it as the static regulator_desc.

So buck 2-4 need some dynamic handling then but the rest can be static -
that would be a lot clearer.  You could also have a template for the
ones with some dynamic values and just override the few fields that need
it.

> > > +     if (init_data->constraints.min_uV !=3D init_data->constraints.m=
ax_uV) {
> > > +             dev_err(priv->dev, "Variable voltage for fixed regulato=
r\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     desc->fixed_uV =3D init_data->constraints.min_uV;
> > > +     init_data->constraints.apply_uV =3D 0;

> > Drivers should never override constraints passed in by machine drivers,
> > if there's validation needed let the core do it.  The same probably
> > applies to providing a voltage range for a fixed regulator though that's
> > not modifying everything so not such a problem.

> Please check the above explanation about each power rails.

I'm not sure what you're referencing here?

> > > +     for (i =3D 0; i < RT5120_MAX_REGULATOR; i++) {
> > > +             ret =3D rt5120_of_parse_cb(priv, i, rt5120_regu_match +=
 i);
> > > +             if (ret) {
> > > +                     dev_err(priv->dev, "Failed in [%d] of_passe_cb\=
n", i);
> > > +                     return ret;
> > > +             }
> > > +     }
> >
> > This is all open coding stuff that's in the core - just provde an
> > of_parse_cb() operation and let the core take care of calling it.

> Ditto

Or here.

--MaGFacYl3eetw6pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKgdfMACgkQJNaLcl1U
h9C6iwf6AvA+ZFlpGr0gQNW0555AlhBtLyRqR9rwNGL5qQZFAWbQJcvsXnBbtxdV
4G3r/BHQdWP0tkW7FjNrOisB20DqNNw8NE+5RoHZxBLUlFyEmT7eV/JywbDiMmfu
veYdLX0vCPOl53cjAx7oAWSWP/eD6C8A8AiQ/a0MTW08vIjsQhcDNWAfCOKK9deV
RgGqaMpCGe5+UnTbn+Wn9c20K8/lKn5+uD+nn2OOS75d/oj42VzrvAWg90E4ao+x
VZD2EcFV41CW1g/2GDs1zQigwB5+zDhgArNvPPaLnXwY/Pl+U/oHuk2/F0PMFziN
z1rTwX9w3MVaH8DxTIca7wwj6k38PQ==
=Ie6i
-----END PGP SIGNATURE-----

--MaGFacYl3eetw6pk--
