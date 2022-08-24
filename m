Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456E959FAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiHXNM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiHXNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:12:23 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41AAD2528C;
        Wed, 24 Aug 2022 06:12:19 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id 39C861086FC;
        Wed, 24 Aug 2022 15:11:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zQp53rYCUOcO; Wed, 24 Aug 2022 15:11:09 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 54B0A1086F3;
        Wed, 24 Aug 2022 15:11:09 +0200 (CEST)
Date:   Wed, 24 Aug 2022 15:10:55 +0200
From:   simon.guinot@sequanux.org
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Subject: Re: [PATCH v4 1/5] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Message-ID: <YwYjXzsSHNe+J3aO@76cbfcf04d45>
References: <20220823102344.17624-1-henning.schild@siemens.com>
 <20220823102344.17624-2-henning.schild@siemens.com>
 <YwToilxquEZGqzQD@smile.fi.intel.com>
 <20220823165459.143e1c30@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oXah1uCHx1gQcfsk"
Content-Disposition: inline
In-Reply-To: <20220823165459.143e1c30@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oXah1uCHx1gQcfsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 04:54:59PM +0200, Henning Schild wrote:
> Am Tue, 23 Aug 2022 17:47:38 +0300
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

Hi Andy,

Thanks for this new version. It is looking good to me.

>=20
> > On Tue, Aug 23, 2022 at 12:23:40PM +0200, Henning Schild wrote:
> > > Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> > > very similar to the ones from Fintek. In other subsystems they also
> > > share drivers and are called a family of drivers.
> > >=20
> > > For the GPIO subsystem the only difference is that the direction
> > > bit is reversed and that there is only one data bit per pin. On the
> > > SuperIO level the logical device is another one.
> > >=20
> > > On a chip level we do not have a manufacturer ID to check and also
> > > no revision. =20
> >=20
> > ...
> >=20
> > > - * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882,
> > > F71889 and F81866
> > > + * GPIO driver for Fintek and Nuvoton Super-I/O chips =20
> >=20
> > I'm not sure it's good idea to drop it from here. It means reader has
> > to get this info in a hard way.
> >=20
> > ...
>=20
> Let us see what others say. I wanted to keep this in line with what
> Kconfig says and the oneliner in the Kconfig was getting pretty
> longish. Hence i decided to shorten that. Other drivers also seem to
> not list all the possible chips in many places, it is all maint effort
> when a new chips is added and the list is in like 5 places.

I agree with you that we can drop this line. It was already incomplete
and the information is quite readable a few lines below in both the
define list and the chip enumeration.

>=20
> > > +#define gpio_dir_invert(type)	((type) =3D=3D nct6116d)
> > > +#define gpio_data_single(type)	((type) =3D=3D nct6116d) =20
> >=20
> > What's prevents us to add a proper prefix to these? I don't like the
> > idea of them having "gpio" prefix.
> >=20
> > ...
> >=20
> > > +		pr_info(DRVNAME ": Unsupported device 0x%04x\n",
> > > devid);
> > > +			pr_debug(DRVNAME ": Not a Fintek device at
> > > 0x%08x\n", addr);
> > > +	pr_info(DRVNAME ": Found %s at %#x\n",
> > > +		pr_info(DRVNAME ":   revision %d\n", =20
> >=20
> > Can we, please, utilize pr_fmt()?
> >=20
> > > +			(int)superio_inb(addr,
> > > SIO_FINTEK_DEVREV)); =20
> >=20
> > Explicit casting in printf() means wrong specifier in 99% of cases.
> >=20
>=20
> For all the other comments i will wait for a second opinion. I
> specifically did not change existing code for more than the functional
> changes needed. And a bit of checkpatch.pl fixing.
> Beautification could be done on the way but would only cause
> inconsistency. That driver is what it is, if someone wants to overhaul
> the style ... that should be another patch. One likely not coming from
> me.

About the int cast, I think you can drop it while you are updating
this line. It is unneeded.

I have no opinion on the other comments and I am OK with the rest of the
patch.

Simon

--oXah1uCHx1gQcfsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmMGI1wACgkQzyg/RDPm
szpRXg/7Bc/p3Mo8tT9pE8PJ+uGU+jNsiByhYWbZXSvPuJEo4HD6MO+Fq7pxjvct
mELhzHu4BXGj7tciezcnblJUElyCaTxF4HTxnuPj0TKCi1f3W/uRaIEffpC1EIb7
HZFI6GlNTMASm3KVyKEZKeyb7KxDzW0cyWyASMH1mOcyMZGPU5/So/DEvO3LSgSo
MxqvhF2P8lNZKQj0eFuuKy7CCthNo8peWuNO/rZ4zxkglGQvHy2cj2qIVBydWYtn
SBkjVqE7oXR1IiH1z3yQUu7W9p5xolAmKhtw/EaEFpNnM8Nq3GgAOqT94YyME3Nz
PgUW4kxF9Svj2bJSAqzV9k4eBLsHBCIfUEOePNRbXTCnAKGXuuvzy/zAPggHG3k6
i8X/J0EF1NBngbrQW1WaIFE1OZ0QVooharFQWdHFNjB0X6adE++Bqxr0fImgqB4Y
1JXQJx4W27cJM/6zY0HLvqKypvktcaHNg6uZn3dkY1DJqsnfGkrkktF9Amr25+CC
vZDcfO3lvTEWY1fB9BdWQDaSljhu0YbuCrbQmsWIuYCpRc+3m9ggGPeg6QtxZDv6
VOkHADAryaFgOYXuvKb0GXV3gEoOFGKKAUlJpFe/UHgPyMNzBuh6ufPQMsqCUhEl
fVJyF0MhZ74mGAz6PUFw6SrlevMR8JgpGdb1NKxbasMav5moBxY=
=nfkO
-----END PGP SIGNATURE-----

--oXah1uCHx1gQcfsk--
