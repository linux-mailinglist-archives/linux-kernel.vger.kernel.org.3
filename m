Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFF59FF04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiHXQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiHXQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:03:29 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20BF27D1CC;
        Wed, 24 Aug 2022 09:03:27 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id 5B9B21086F5;
        Wed, 24 Aug 2022 18:03:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qh_e4nFra39O; Wed, 24 Aug 2022 18:02:36 +0200 (CEST)
Received: from localhost (softwrestling.org [95.216.36.37])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 7D7391086F3;
        Wed, 24 Aug 2022 18:02:36 +0200 (CEST)
Date:   Wed, 24 Aug 2022 18:02:25 +0200
From:   simon.guinot@sequanux.org
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Subject: Re: [PATCH v4 1/5] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Message-ID: <YwZLkeu2RmJsDPC+@76cbfcf04d45>
References: <20220823102344.17624-1-henning.schild@siemens.com>
 <20220823102344.17624-2-henning.schild@siemens.com>
 <YwToilxquEZGqzQD@smile.fi.intel.com>
 <20220823165459.143e1c30@md1za8fc.ad001.siemens.net>
 <YwYjXzsSHNe+J3aO@76cbfcf04d45>
 <20220824155038.5aa19495@md1za8fc.ad001.siemens.net>
 <a001efb5-95a3-d89d-32bd-557b6f11bb80@redhat.com>
 <20220824161757.4ca3bb97@md1za8fc.ad001.siemens.net>
 <3ec46cab-c775-824c-6bad-6fdddeea6e6a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M3dzRQFvnwZDbVpO"
Content-Disposition: inline
In-Reply-To: <3ec46cab-c775-824c-6bad-6fdddeea6e6a@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M3dzRQFvnwZDbVpO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 04:24:46PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 8/24/22 16:17, Henning Schild wrote:
> > Am Wed, 24 Aug 2022 15:54:28 +0200
> > schrieb Hans de Goede <hdegoede@redhat.com>:
> >=20
> >> Hi Henning,
> >>
> >> On 8/24/22 15:50, Henning Schild wrote:
> >>> Am Wed, 24 Aug 2022 15:10:55 +0200
> >>> schrieb simon.guinot@sequanux.org:
> >>>  =20
> >>>> On Tue, Aug 23, 2022 at 04:54:59PM +0200, Henning Schild wrote: =20
> >>>>> Am Tue, 23 Aug 2022 17:47:38 +0300
> >>>>> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:   =20
> >>>>
> >>>> Hi Andy,
> >>>>
> >>>> Thanks for this new version. It is looking good to me.
> >>>> =20
> >>>>>    =20
> >>>>>> On Tue, Aug 23, 2022 at 12:23:40PM +0200, Henning Schild wrote:
> >>>>>>  =20
> >>>>>>> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO
> >>>>>>> chips are very similar to the ones from Fintek. In other
> >>>>>>> subsystems they also share drivers and are called a family of
> >>>>>>> drivers.
> >>>>>>>
> >>>>>>> For the GPIO subsystem the only difference is that the direction
> >>>>>>> bit is reversed and that there is only one data bit per pin. On
> >>>>>>> the SuperIO level the logical device is another one.
> >>>>>>>
> >>>>>>> On a chip level we do not have a manufacturer ID to check and
> >>>>>>> also no revision.     =20
> >>>>>>
> >>>>>> ...
> >>>>>>    =20
> >>>>>>> - * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882,
> >>>>>>> F71889 and F81866
> >>>>>>> + * GPIO driver for Fintek and Nuvoton Super-I/O chips     =20
> >>>>>>
> >>>>>> I'm not sure it's good idea to drop it from here. It means reader
> >>>>>> has to get this info in a hard way.
> >>>>>>
> >>>>>> ...   =20
> >>>>>
> >>>>> Let us see what others say. I wanted to keep this in line with
> >>>>> what Kconfig says and the oneliner in the Kconfig was getting
> >>>>> pretty longish. Hence i decided to shorten that. Other drivers
> >>>>> also seem to not list all the possible chips in many places, it
> >>>>> is all maint effort when a new chips is added and the list is in
> >>>>> like 5 places.   =20
> >>>>
> >>>> I agree with you that we can drop this line. It was already
> >>>> incomplete and the information is quite readable a few lines below
> >>>> in both the define list and the chip enumeration.
> >>>> =20
> >>>>>    =20
> >>>>>>> +#define gpio_dir_invert(type)	((type) =3D=3D nct6116d)
> >>>>>>> +#define gpio_data_single(type)	((type) =3D=3D nct6116d)
> >>>>>>> =20
> >>>>>>
> >>>>>> What's prevents us to add a proper prefix to these? I don't like
> >>>>>> the idea of them having "gpio" prefix.
> >>>>>>
> >>>>>> ...
> >>>>>>    =20
> >>>>>>> +		pr_info(DRVNAME ": Unsupported device
> >>>>>>> 0x%04x\n", devid);
> >>>>>>> +			pr_debug(DRVNAME ": Not a Fintek
> >>>>>>> device at 0x%08x\n", addr);
> >>>>>>> +	pr_info(DRVNAME ": Found %s at %#x\n",
> >>>>>>> +		pr_info(DRVNAME ":   revision %d\n",     =20
> >>>>>>
> >>>>>> Can we, please, utilize pr_fmt()?
> >>>>>>    =20
> >>>>>>> +			(int)superio_inb(addr,
> >>>>>>> SIO_FINTEK_DEVREV));     =20
> >>>>>>
> >>>>>> Explicit casting in printf() means wrong specifier in 99% of
> >>>>>> cases.  =20
> >>>>>
> >>>>> For all the other comments i will wait for a second opinion. I
> >>>>> specifically did not change existing code for more than the
> >>>>> functional changes needed. And a bit of checkpatch.pl fixing.
> >>>>> Beautification could be done on the way but would only cause
> >>>>> inconsistency. That driver is what it is, if someone wants to
> >>>>> overhaul the style ... that should be another patch. One likely
> >>>>> not coming from me.   =20
> >>>>
> >>>> About the int cast, I think you can drop it while you are updating
> >>>> this line. It is unneeded. =20
> >>>
> >>> Ok two voices for doing that one fix along the way. I will send a v5
> >>> and hope nobody insists on me fixing the other findings in code i
> >>> never wrote. =20
> >>
> >> You did not write it, but you are using it to do hw-enablement for
> >> your company's products. So being asked to also some touch-ups
> >> left and right while you are at it really is not unexpected IMHO.
> >=20
> > Sure thing. Dropping a few characters from a line i touch anyhow is
> > easy enough. But i.e a refactoring to pr_fmt would feel like asking too
> > much in my book. That feels like work of the author or maintainer.
>=20
> Right, but that assumes that the original author / maintainer is still
> around and actively contributing which unfortunately is not always
> the case.

Actually the original author is not active but he is still keeping an
eye on the driver :)

I still review and test the patches I catch on the MLs. And I am ready
to do some maintenance work if needed.

Henning, I think you could have done the pr_fmt conversion. It is not
a big deal and it would have been nice. But indeed, you don't have to...

Simon

--M3dzRQFvnwZDbVpO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmMGS4wACgkQzyg/RDPm
szpTlhAAxXX31W3p2E5qH5oNGNmHIqUSt+Ckv8Roe77lrNCktr+h+VqzNmfuamHW
5XepeoEb8Fl17K5yNF2O72I5q1Z37SRwlsWblI1k53SsPFzzad3bd/3TLJiRY6KB
Q5hjGc1ygqUAPIlEamnWBk194F0seLDnMKvj3ovO3DGst9xCgvH43p+SetJnN3P0
q6nqlG9GxBXUw+3tijt2Szdqn6VWs8TcCynvvElaU1gGRqj9S/XbIcRBj9ASWL0d
eLkJpT5WSvBf4M0pNgzF5P0ytWlCijb5V05/Bc9Hg+O3cA3NPXCFMwLpoXy8/UoB
YSFrYgUtTf5vnMHZnTBVLWuXmrA/Tqq1xiBLY/jGPxa6Eqc1+r+ewkBmjq9xUBac
5DvzHk82D9quTtIf0ETHQf/t646vvXhEHEew9IVwWYjfwvYpgMCJa1bZYr/xfGh7
THvV7dygt2e/twQnjFLcNaJ1qWV3YKU81ASb6Sy1ccULgtL/WN8out1l/zQByQAU
8l84emk+qaMCNX1+PHlKuOxglBiHzY4M8bBmInhyqUAKDbwPRisYD+KuqnYvXBDm
Wj7eotUx/Czc387v+HhZvsQKBQiYRUgACf0L0qBE6NplJac4vjTaUNvcYsX4fR+b
Ny1y9KDRoojcO1v4OeJHagdG2NXsyG+b6IG3S+W4/CSgGEr0t6o=
=1yeY
-----END PGP SIGNATURE-----

--M3dzRQFvnwZDbVpO--
