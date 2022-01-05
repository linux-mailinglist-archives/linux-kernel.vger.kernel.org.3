Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8357D4854C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiAEOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:40:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:48219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236305AbiAEOka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641393621;
        bh=mKw/05+8dlDOK1gyFsZxxQMwltPU4uxy0b37Wi8Vt4c=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Z9X06Km9SYng8CmYdVQc7UrvL0Sugy7jC3CjQLcqmvfFGh6GZE2wxflGxEEeLvXGS
         DrzkzsWDu946rk4CtwK5QRvLLBPPqhmtN9TeB5wirHJcLj18V/AdczamFe/FlnGRAp
         u+4YVzwsz0AOXnoen+G04PVae8qGAJjIqRWSw6T8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1mU90w37Eo-00gWIf; Wed, 05
 Jan 2022 15:40:20 +0100
Date:   Wed, 5 Jan 2022 15:40:19 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH v3 4/9] dt-bindings: pinctrl: Add Nuvoton WPCM450
Message-ID: <YdWt0zUh4ds1xlPz@latitude>
References: <20211224200935.93817-1-j.neuschaefer@gmx.net>
 <20211224200935.93817-5-j.neuschaefer@gmx.net>
 <YdTGRY+n9XY522jg@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AegnL8PRarm8VMMK"
Content-Disposition: inline
In-Reply-To: <YdTGRY+n9XY522jg@robh.at.kernel.org>
X-Provags-ID: V03:K1:t38DKzr0APcEybTCihKRzDiRZ98dAfGVOF/UQtV5l9e2SL/Q42A
 oUNz2uzIC+0ZwnDJytxJAoz/eRv5FxTf/lRo1W0kJTrBhGk1Y01wtkRGYTaznrHosKnzaG9
 pqhUnlXSjm/gONM7ADMGdYxFlVZvF4kMcQ/0j0hV8c9g4L/3SnZOiHxPxHaS1i6V68whZES
 hFrWiNi2g3NMIfjE017cQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ahh9kZkiTME=:8F5CgqUwhOliqITJt0h/l+
 FOkiomXBM4jtnbBFrl71IsanQowlDHvXFr1b3P9/5WxpQkURis++1vyDTaD2YZ3t7kyc6fWj+
 Kb2jSNdUWffNMw5EvCEv0bC82OwTsckuoCGfO96xdlX0CjZyQkR1SutCX7ATDxFx+V6jtFQLV
 btPyKyDrpIGOKas6rUcWNRI3v2etsRGSSqqnWaoxiaUx4uCaW8dJMrtKH4YjorF3k5P7EAv6S
 bOcKd/ukzQ1nxKGGIqNof3TnVAtPJ2VdcnHIFKr1wa9obuuECDRgSvqKm5HNtJtnjBXKM8jun
 3jgGC7NLntanjoRyEAi1N37x0y5N6BRGVFQWbeOUC40AO5iffou447gBB5aBR/xLNxM8KoyUi
 z7fVZLowpB8y48KroLwc8DqmAIGBdHjv5yYq4sUn2tIZO03v4ZwF6oZyzDVOrBW52VANomIS2
 NAfbNrFzcATJH3+38tdaIhx4Hn9scTUjRzAs+ljlyxEl+MylcFcg7BeoJpxajbcBvVyEk+pgq
 V13hZD8qfAVBHyF36WKTGqmu9kMvOuc5nfaM7/xV+ENlBXl9Ty0uAmbdMH5XZ8jz1DawLS1DG
 EO6dxlqEZ5IPAAJbNxLtxpY04jdsAgBTeBXxmoHO0CJ2DRyyJtGaI8wLD4HWYTSD5NUKi4cpl
 y0e0c/3DASQ0G6zeIIq+JP1r51JH19t4r9dBxfwmMzV6fyxfeoF5wSj0wDNlnokeUyji0IVgA
 g3paouAHkfeCO0/HJdvx8P1Bd9GB+RJohjLZROMO4fibFS4YXkNaEhmJ+hD/Yczj/ihccr8hK
 WYun0vg3Q1pJNuP1klyLVXLhdJR8wL8f2hJY+Iv/rXWDAxDt30qXFMlq8VAChBTAPsDpMYvw9
 hfCYdJ6wccwiGgynn5L61E5qB9taJ4h2FLAoXUmstf8ijKsCcDgBIatkzS5MyuPVPLhuDvsYU
 C4CaMgdYCYEob/vWfOQl37XeS9wo+z0/dSbj9av3tPi8Y+20IJSR4W5IwaUVJTE002AXA2OLV
 56CmzoOK2yo5+bZwuAhYNbjpwdAQEAxcOV+Ch+6kBaHNx/HzN54A5Sl9IzciL5fjqrhjSrDoD
 GbldNS5m22ronA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AegnL8PRarm8VMMK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 04, 2022 at 04:12:21PM -0600, Rob Herring wrote:
> On Fri, Dec 24, 2021 at 09:09:30PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > This binding is heavily based on the one for NPCM7xx, because the
> > hardware is similar. There are some notable differences, however:
> >=20
> > - The addresses of GPIO banks are not physical addresses but simple
> >   indices (0 to 7), because the GPIO registers are not laid out in
> >   convenient blocks.
> > - Pinmux settings can explicitly specify that the GPIO mode is used.
> >=20
> > Certain pins support blink patterns in hardware. This is currently not
> > modelled in the DT binding.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> >=20
> >=20
> > ---
[...]
> > +patternProperties:
> > +  # There are three kinds of subnodes:
> > +  # 1. a GPIO controller node for each GPIO bank
> > +  # 2. a pinmux node configures pin muxing for a group of pins (e.g. r=
mii2)
> > +  # 3. a pinconf node configures properties of a single pin
> > +
> > +  "^gpio":
>=20
> '^gpio@[0-7]$'

Makes sense, I'll change it.

> > +    type: object
> > +
> > +    description:
> > +      Eight GPIO banks (gpio@0 to gpio@7), that each contain between 1=
4 and 18
> > +      GPIOs. Some GPIOs support interrupts.
> > +
> > +    properties:
> > +      reg:
> > +        description: GPIO bank number (0-7)
>=20
> reg:
>   minimum: 0
>   maximum: 7
>=20
> But there's not an actual register address range you could use instead?

Unfortunately no, not easily.

The GPIO bank specific registers are not arranged in a regular pattern,
so the address/offset of the first register in a bank does not suffice
to know the addresses of all other registers. Instead, different banks
support slightly different functionality (e.g. power source configurations
or automatic blinking), and the registers were crammed into the register
space as tightly as possible.

The full table of register offsets is in the driver, and for the
aforementioned reasons, a full table is necessary.


Thanks,
Jonathan Neusch=C3=A4fer

--AegnL8PRarm8VMMK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmHVra8ACgkQCDBEmo7z
X9suOg/+ODrZdL9EHnUWYJXMx2NcBGgtpeypbvXtcEfuPE2jhg27RuwrCccE5BFY
Hdkmv9t9RpTdHebQ/w8T53GB7CcrBM6scBrbQiYTIY51U5yeycOEUT6ZNpWtm62X
Vkzwx7hPEqb3uieuHHSZ8sxtVOGr/FgH7VUS7c+M/MyJlvzhc6KfatBqfc3KnXth
XPKVFBd6zDScfCHcmsc4FDwBsmktKWZ66c1BwEMrKHwwzNkDJ3GDdKOSdc/KgUL4
ASo1DFAi3dwp+J24iCEMm3JroaujJC0qdmWGBhZAyT90g3Rc9DgZ+wpCQXwgElP9
/1UUWLRUa8XYBd0CWnHC+GVllVugNoAusagCe/GiNngEOoYat3XEvzuw155oqjMA
NRKf9KuB+n4SQlnYkdg3IomnMca378Dm02mU0bvSOajj6kH7ziTXNOe3DuGemoq1
wDhdHtxEHjtcTue9CVBSem5Pt9zzyerJrOIN6xnWaPXqTwD8Bw2x+U4IvfrJ5Up5
XPQn9h1dTDElSDSRaGidKJi4QH14w9ubBUMBlphAuVM1rhEDDMMUX5wmLjB3gqTC
74MICrHDtcNYbtbZUzcXtapY7DN5BQnOIK2HPDJpNI/+0BWcwkdTk8syZqYFiRoc
9fsEGDBJwYRipphIbkXf6lp/o1yGUH79nVPhtyN9UnNuIvdL+8Y=
=PgLj
-----END PGP SIGNATURE-----

--AegnL8PRarm8VMMK--
