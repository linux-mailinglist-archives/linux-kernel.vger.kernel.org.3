Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1565928D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbiHOEfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbiHOEfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:35:00 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6B15718;
        Sun, 14 Aug 2022 21:34:55 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c28so5135531lfh.3;
        Sun, 14 Aug 2022 21:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=koRe361yf+ju3e2grtdRsIwtJPcKdw6GpoFa2OUU6YY=;
        b=afsAZELNeFWlzNYGj83UNLIQVgpGVhl4CjDXTewbDb2RaoNSX64KcWZjD75JqFaAzr
         iJwogjuQ2fI4Zoo/BsXvM5AwWDnL96L1I1UprCDREI+RDlLm1gFYXvL/MW5ZMW1Febh6
         6xz5sTGWI1dP5dejLmSPXLzPSxO4RhByjMiCMLG4hXca6axDTq8VwDLwTscXKqTEOEf7
         ayi9lG4XzHSiFSxOyYU2eMQbLbKHea7G0Wk6IKC/PlEhW1qlWPY8oFCNc4Z3Gr57/8eY
         v3KXnhaaijNzdYdA1x5ADZVvjLKvdKk6+SRq8Ua9pXP25WFXmpydpMChNJVtaufG/z8B
         iaWQ==
X-Gm-Message-State: ACgBeo3uQchoZPdxShtbv4LDHZMiUeOMg2Xe8WSpLfWu4zCqRAmURmtw
        m4i74AYnb3SJqhH0zK76sCs=
X-Google-Smtp-Source: AA6agR71B6BYC08TKQGaEQgjRLHE/P0rIJDvZLclVliQAyFVRPtTPVbYzi2sb6AgzdFgaR1Wnw1LvA==
X-Received: by 2002:a05:6512:3f97:b0:48a:8549:2329 with SMTP id x23-20020a0565123f9700b0048a85492329mr4556426lfa.62.1660538093551;
        Sun, 14 Aug 2022 21:34:53 -0700 (PDT)
Received: from dc73szyyyyyyyyyyyyyft-3.rev.dnainternet.fi (dc73szyyyyyyyyyyyyyft-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::9])
        by smtp.gmail.com with ESMTPSA id j5-20020ac24545000000b0048b28acab8csm979169lfm.64.2022.08.14.21.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 21:34:52 -0700 (PDT)
Date:   Mon, 15 Aug 2022 07:34:36 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] iio: Simplify drivers using
 devm_regulator_*get_enable()
Message-ID: <YvnM3LvwRiUaLLAg@dc73szyyyyyyyyyyyyyft-3.rev.dnainternet.fi>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <13bb483e1f3ee003ca3a6949e27eee7f505e047d.1660292316.git.mazziesaccount@gmail.com>
 <CAHp75Vcz_ufnLCE8TYBjM0b8BiS4W1AgXq8euNrUFo3WZy3=fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="41Y4qJgjVrNBiXfo"
Content-Disposition: inline
In-Reply-To: <CAHp75Vcz_ufnLCE8TYBjM0b8BiS4W1AgXq8euNrUFo3WZy3=fA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--41Y4qJgjVrNBiXfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Morning Andy,

On Fri, Aug 12, 2022 at 09:05:52PM +0200, Andy Shevchenko wrote:
> On Friday, August 12, 2022, Matti Vaittinen <mazziesaccount@gmail.com>
> wrote:
>=20
> > adc/ad7192:
> > Use devm_regulator_get_enable() instead of open coded get, enable,
> > add-action-to-disable-at-detach - pattern. Also drop the seemingly unus=
ed
> > struct member 'dvdd'.
>=20
> In IIO we expect to have one patch per driver. Please split.

Fine with me. I didn't go through too many drivers anyways. I'll split
for the v3. I'll just wait for a while for other feedback.

Best Regards
  Matti

--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--41Y4qJgjVrNBiXfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmL5zNgACgkQeFA3/03a
ocV5EggAoPQpVk1csTJRDsQpNBj7nDvr8lCkwwJPlXJMMuTgB5+jz8TOInP16VXh
KrKRjzLJqycV/Xz1u0OPIWryRQdQvHoKAHQjEbmiDVSNWNNvOMeSfHqRHT2XIPc2
Owxsbaxj5e7+0NFK4wtGQ3juWkt561CvMPi1DfAjNXStPE/rxbkCDXZlA571RrWB
eCn/DHJk9aNWeLNKNT8IZYVqjePmX3MDxbsP7oxMcs1hbddSrtowRnw6Ux+KZpRt
1XsTIZ6S8kJuujMvhbjHZlYunIaTXvkyc4LqvXc7x8vR0NZpkh3z9v3Wy62VlHGL
eRSwU4Vo5B451BagBtSxlp7+SYtL6g==
=zIfe
-----END PGP SIGNATURE-----

--41Y4qJgjVrNBiXfo--
