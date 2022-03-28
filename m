Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EA4EA2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiC1WN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiC1WNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:13:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258C7147516;
        Mon, 28 Mar 2022 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648505000;
        bh=ikNTAPZNKF24qy3SSeVLpOY649ZPWA/t8khPYr08wEQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=awmlpNlzCwoLr6l0zmrsuN88doab8x7a+/BUsGAUmPf1be3v7tQoSV6IjOusgoNWb
         jFgQbFO1QW9eF1K6Ea7aYWKQxQ/F+8LprR0p+9SyRjp5ZCzWjI88YWKu112o51BiOI
         yZ105yLC/xU+VyTkjlHkDa2KsM//rqRDgjhIkXHg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1nm8ML34HQ-00DHd7; Mon, 28
 Mar 2022 23:38:17 +0200
Date:   Mon, 28 Mar 2022 23:38:17 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [GIT PULL] pin control bulk changes for v5.18
Message-ID: <YkIqyb6lhn5uU2jb@latitude>
References: <CACRpkdZ_Jr3OzfoOpSSsAJMy1Oe_=zD861jouDzCVD-BQ6yZMg@mail.gmail.com>
 <CAHk-=whzqAB6kfHUcX2uhfPnNiWJRq=UmeA1TbgGi3XA+57j3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yvrgZB0uozz8tcri"
Content-Disposition: inline
In-Reply-To: <CAHk-=whzqAB6kfHUcX2uhfPnNiWJRq=UmeA1TbgGi3XA+57j3w@mail.gmail.com>
X-Provags-ID: V03:K1:s4cTLq9e1kTz4rvikF7Mq9oKq7PlgRHhoQuBCNZQG2qEFBxDq3H
 RPEvTaIiJE1LzBT6NQkWXxZ2bupQWHQ6IgOiVIJNfulsVQFw89Jdi/ua5CWLmGZNhjnJS6D
 SLnx6k5/nZsGTJnBiBhgExiEo70kG09pPIC+F9dQAIXNBPSoEzc6Ks8JLAW9i7SyoUFBMX/
 vWNIaRARIUaceOm+cHh+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZxojnKK9JrI=:Z3jdjLqop7T4GlcejOYxrl
 kQHr9D3kLBByyuOh8m7SAupZqtOpj83u1EcBTlr+Z3RjPyfQksAOab0u1iN1RUkccUJ2Avl9o
 9zLFBxV9hA3Q/69S+EKDoEyPpH+H6a4JhcDkvIi+CbHbWc2iRoEs1JjTRgn7aQKrOBcffkI7h
 Djb5JoBGk13Z6UOov8BqTn+u6A59g5reEORPQ2kHE5qW6ZNA2MBRLIPVWohT/9ai8Kv2G+jq/
 kivEHzhkb+1JdDMFc200asvUejRtycc0oHNh8XPzlE9U1/TnHcpK/D5ntnBGfkLOIaP4JGsCH
 bSBr2mwNRqfztfMqiwl7lOLLwKNuy/9Yryf3GuX43080v5berTY1puwCbtQWcuZV6rAJhxnoD
 PMa6Jyefzcyzkk3wMf1gBJkx8KWUthMO596VQBA7G+aGWhTqLyRKAXHktqnQAa8K4sR0QBd9Z
 lvMbNu2aTX+stXuoYfvuPAnTXxJOLH+M/Tb2ABO/8AMRFs3iirc3DCLpstf+/ELZjsacUVrqr
 Pts2ZiJsxuTKnWtI6XunlztqCa1yxOXeo6sFwDVljzjavvpshHrF9Pr+n5BaW47/ieKWwhYdS
 RyVNDVSG3UhAW0fNsDqYbG71FREm+qqB1uyP7nbErpOnwZheNExIEUdsHygTlvvtfp+/0BTYW
 7OngohlV8Cb86n43GbZqyjgtlOm0s+yv6KoiDoOSbpTsA9lR1pLrF0Ze/k5mF9fyqpHdVDqba
 HeCa30Nq8vPSREt+DdTDDs5o5ZVzV0z64Hd5u2mGz2oKYo7pz/kWPWcTCELNsKGkWLNJwm3Fw
 MzVCtJ/q5fN6ruUP1J+LXWggwX5o2/DkKIYDL41uyGPKWQCnqVyFu1LS9aZ4Se8Wq2uIS/hGF
 IIQyiGWlAumCTqTsGH1NTDJygYCwhy/6n4yT0Xy2w2FkAtzezePSMh91Rrq7sjdlSp6EiPbGv
 v9G22VJ5LIJcXjCOUjI78nPwV0NnIQKv9L+QuwqDAioeyB5HJQDNVegYcZpLbHIhE4nWKCQU7
 ik/OXZYJFH4RsomRjIcWbofsxtZwe+C8yf1C249BM0Aslbk3+FVEiABdKR9v38VFDQDRPP6aZ
 34/Ta0dc5hE8uE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yvrgZB0uozz8tcri
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 28, 2022 at 12:11:49PM -0700, Linus Torvalds wrote:
> On Mon, Mar 28, 2022 at 6:08 AM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> > tags/pinctrl-v5.18-1
>=20
> Hmm.
>=20
> This clashes badly with the fact that we in the meantime have enabled
> -Warray-bounds, and I got
>=20
>   drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c: In function =E2=80=98npcmgpi=
o_irq_handler=E2=80=99:
>   ./include/linux/find.h:40:23: error: array subscript =E2=80=98long unsi=
gned
> int[0]=E2=80=99 is partly outside array bounds of =E2=80=98u32[1]=E2=80=
=99 {aka =E2=80=98unsigned
> int[1]=E2=80=99} [-Werror=3Darray-bounds]
>      40 |                 val =3D *addr & GENMASK(size - 1, offset);
>         |                       ^~~~~
>   drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:219:13: note: while
> referencing =E2=80=98sts=E2=80=99
>     219 |         u32 sts, en, bit;
>         |             ^~~
>=20
> as a result.
>=20
> Was this not in linux-next?

It was =E2=80=94 but when it was noticed, the fix went through the IRQ tree=
, on
top of a refactoring that happened there (the switch to generic_handle_doma=
in_irq):

https://lore.kernel.org/lkml/164751044707.389.16417510835118111853.tip-bot2=
@tip-bot2/

So=E2=80=A6 the issue should resolve itself when the IRQ tree is pulled.

> Or was the array bounds checking not there?
>=20
> Anyway, that cast to "const void *"
>=20
>      for_each_set_bit(bit, (const void *)&sts,
>=20
> in that driver is completely wrong.
>
> The bit operations are defined in arrays of 'unsigned long', and you
> can't just cast the issue away, because the end result is not the same
> on a big-endian machine.
>=20
> I fixed it up in the merge, but what really confuses me (apart from
> the apparent lack of testing in linux-next) is that I don't actually
> see what made this happen now, and not before. Maybe that's why it
> didn't show up in linux-next: it's some odd gcc heisenbug.
>=20
> Because there seems to be no actual changes to that driver that would
> explain why I get the warning now, but not before the pull.

When I added the pinctrl-wpcm450 driver, I changed the pinctrl/nuvoton/
directory to obj-y and exposed the pinctrl-npcm7xx to CI bot testing.
The bug existed, untouched, since the driver was added a few years ago.


Jonathan

--yvrgZB0uozz8tcri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJCKqgACgkQCDBEmo7z
X9tAfRAA0Lwv6e2tpRvOKaLo/Ou9kPLpQCasdBSh/IgzKFoVlMsZmfGNbBZqU/bv
dy6/AoTuVnwXRAJt7QM9MPd1N8ekXnMT0VMZOh+4hhBLhN8lAsB2fNaFCcjTNeA/
IxgTx1zqzdpjgQq7vWzX3om1graLj9OV4E59sD4Dl9/jeXP5ESz71yaq4WEYFW25
nxPnj6OxXhlS5CEkOVIUUO7mGzlv6a8+rtcU7tjXeNmZ1QlLZ/jhaOEo0tbPn2Gv
AmDDscAS8olaFCHdcMWAP+YFbFD6sjWBzkBuCETk2CX3YnJuITMQsjjyUvEva/Hm
aAgOQf+bZBRgcVnS1hI+RH1zpq5ahrNtXbAbMrGqSbMMaI/6VyPdsJyf3LXA6/id
bp6zNuwSGber0yU2YFGtvNFKx7e5tBGuckNebu/E/VFQAwwB0jwSpK/pifWt3p3i
LVbcOcauLddSQqUlejjs/buMOrSt+lWzhIY0m1ZuC6xqyCm1/LJz2LwoLMAfw0gi
IEj93h+SzT5X+zeNuNojxCVaxuEa+DJdTTrA58ztzI5f8Hwy7D2Hq4JmrAQiJM+z
v44tGk+W9ye8ONaQ2lL02oFDHgfic1QN0uJzflU7bpFY9EEqsGWps9GweMeYr7LD
HIJrALebsg5geI0gKyAAf6gwWgF/GREiqF45IxuK5fdrc4enmRI=
=gFUj
-----END PGP SIGNATURE-----

--yvrgZB0uozz8tcri--
