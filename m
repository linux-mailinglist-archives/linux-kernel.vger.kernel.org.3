Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE26559917
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiFXMD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiFXMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:03:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F092CDC2;
        Fri, 24 Jun 2022 05:03:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j21so4138522lfe.1;
        Fri, 24 Jun 2022 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LRLPrqZ/tJwGdvagoItMmAQzSmts6CJt9PpLGt2HBU0=;
        b=ftyp1r8QDfaCG2ZUcjStjpwLhkm6KG1dI2xfKjr2WmMEkVteu2G5rE8dftLZhyQe2l
         3bX3/fFhpiDREOMiyos/YG9qwD1PxI8Q3ZZRTp/Lux+AVyzkDaBR+5o157pwX7AbXo6i
         Zh0wWQdI6W+I9htRkxQRCU61bPcZrxdXTzUbam2UBO3fjs09URVb/A5n+QPNgzklQC2i
         86+j4hmp1JfgDPR7Bffx6X7cQsdvyZg5zdi9rwr1Dj7tO5GUMB5jRtbSRBoKhFU0kylL
         VVpYhWf6J3REfEs3Fm7ZGjEUlJAhkc4QVXzktYtTvnbShnEPqJ7Qrmev+w1al/8/i8Tu
         /g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LRLPrqZ/tJwGdvagoItMmAQzSmts6CJt9PpLGt2HBU0=;
        b=CNtS8qLsQWocELbwNgRfOk76E/TRuXVQspOBS5PT49vpLclESuIoazaJ0KLp2/Rfh1
         Jx2oOt8xBztynNCja82t2xG4xUeSVNzm5M9aPHAltJi2jYNLD1u4nMjhZxy/76MXxLE5
         UKDteCZLlvaqDaWA7NmvGsuGHvwDszuenTogME61plM+4PPwC9KzevBWH5FctnYNswto
         ohWLKCH3BsVpbAeBf2LZxJes/QN9j81/lUBsoeO403PaKAhtUBWsABMDXaZIjwi7Fdt/
         RHAQfpk2bJ6UT8FKTZk/KFHAziYNvaZsLpaD3qHcgEW+RQ/c3fklKX0zBjYGC15HPxSK
         TKxA==
X-Gm-Message-State: AJIora8eOHrN2AjoegBroamO4YKVJ/m0XHxLTB7JLg8VfOlGpVGUu/kZ
        bBu7bxHUxX9PHmoGSEeOf1k=
X-Google-Smtp-Source: AGRyM1uTUL4Ju7SDEhiFfP/o6kyIS+lpa/Uw3jH+CtX52sw0CDfzA4Sb2rcaHh2nEcKKrb9wIhnIQw==
X-Received: by 2002:a05:6512:ea5:b0:47f:785c:7031 with SMTP id bi37-20020a0565120ea500b0047f785c7031mr8766005lfb.35.1656072199616;
        Fri, 24 Jun 2022 05:03:19 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id u16-20020ac258d0000000b0047f6f675ea1sm338586lfo.161.2022.06.24.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 05:03:18 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:05:08 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] iio: adc: mcp3911: add support to set PGA
Message-ID: <YrWodHgbTJrUJ2lZ@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-10-marcus.folkesson@gmail.com>
 <CAHp75Vf7=Pk7T8ysrFS9u1sKQXUpqczGJkaeX-MLbwpx-iM2rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bKRj2/f7JE0UQ8BO"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf7=Pk7T8ysrFS9u1sKQXUpqczGJkaeX-MLbwpx-iM2rg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bKRj2/f7JE0UQ8BO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2022 at 09:15:51PM +0200, Andy Shevchenko wrote:
> On Thu, Jun 23, 2022 at 7:41 PM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > Add support for setting the Programmable Gain Amplifiers by adjust the
> > scale value.
>=20
> ...
>=20
> > +       int ret =3D mcp3911_read(adc, MCP3911_REG_GAIN, val, 1);
> > +
> > +       if (ret)
> > +               return ret;
>=20
> Please split the assignment.
>=20
>   int ret;
>=20
>   ret =3D ...
>   if (ret)

OK

>=20
>=20
> ...
>=20
> > +       *val >>=3D channel * 3;
> > +       *val &=3D 0x07;
>=20
> GENMASK() ?

I will use GENMASK
>=20
> > +       *val =3D (1 << *val);
>=20
> Unneeded parentheses, perhaps BIT()?

I will switch to BIT()
>=20
> ...
>=20
> > +                               ret =3D mcp3911_update(adc, MCP3911_REG=
_GAIN,
> > +                                               MCP3911_GAIN_MASK(chann=
el->channel),
> > +                                               MCP3911_GAIN_VAL(channe=
l->channel,
> > +                                                       i), 1);
>=20
> This is not good indentation, at least i), should be on the previous line.

Agree

>=20
> ...
>=20
> > +static int mcp3911_calc_scale_table(struct mcp3911 *adc)
> > +{
> > +       u32 ref =3D MCP3911_INT_VREF_MV;
> > +       u32 div;
>=20
> > +       int ret =3D 0;
>=20
> Useless assignment.

Agree
>=20
>=20
> Return directly.

OK
>=20
>=20
> The useless label.

Agree
>=20
> > +       return ret;
>=20


Thanks,
Marcus Folkesson

--bKRj2/f7JE0UQ8BO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmK1qGAACgkQiIBOb1ld
UjKJNRAAge69rOmGEVokFO/oISGAzXS1ZqArxPISfbiEhZnC08gxknW2F8FoFVYd
KF0vimNI8D6ZojSGrJ/3Dn000yFgFf/nhjKWbEu/Wz1hGr5T7c25lw/darA7iyuZ
KhzfVorHKEaZxDd/xVVVS2IU8ebDLsUDDyrBfOyvS5ERj25sz/kw7jZXDjsY3QAd
wtIve7zqV58QRD+TYulZCb4Ms5mTdGHDWktPgeQiOnI7hFQGjVtUuWrcuQAKHffa
QhEqHSVIqXB+Y6pjQuk/SjBZod9zSb5rlSCjId9wzFrBJLkhl1ITqTxcAse9/eyF
6vwqLnfGblOzcFHdovPTSG5IjPgrzeevoftvbera4t+uOAnKSxrrSyftvXSESarE
r92dxeP/nxtJ7sPuwReIHgOHvRNaamlFN5CPgzc0SL6i4xoCryVJswh6/J1SXHmE
b15T1/X6a9L7eFPn0JwgOcr03dh010ZMZF39LYP+TfW1eDkYusd6ePNuyctMjT/1
MhjgZ4uXFEYfCApWJ+0UWyFDnIvU8/SSP+GxE2JQuEzZgnqyGGgZd6gd0oGyQtHJ
y5QsDtfTAhuOh+6wsI447gjnxD0DCzEp0kropz3eaIMGTfrXnF3t9A3HyRdut6/h
LgEyb+kYTGF39sT6FLeR37vvyZKvACpaOalFGKrbz+jmDVltq7k=
=1Q1R
-----END PGP SIGNATURE-----

--bKRj2/f7JE0UQ8BO--
