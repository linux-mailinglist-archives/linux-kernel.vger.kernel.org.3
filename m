Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29A517230
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385669AbiEBPI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiEBPIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:08:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AF7E09C;
        Mon,  2 May 2022 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651503889;
        bh=aJ3JHLVrs8e6RirYuV2oCs4M43xpWB7y1g+S6XmEMCo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XjhgOjrzgackXjMpkVN8D2iIcRvZycxB5NwIM0NIU0QiR4jfJM65PfTGvf9SDQ3Kq
         5C58iF+NEuPlj/ajI1KiHDod/Rs8vZ2Fb3tDj5N+6lN0P0PEylzC9s5MvOwvxyJo+t
         Zm9+CRR5dRL5K+a2+16+ISK36939/Wmv2RQZ00NA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO6M-1oDxXd392m-00oqAD; Mon, 02
 May 2022 17:04:49 +0200
Date:   Mon, 2 May 2022 17:04:47 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: Add Nuvoton WPCM450
 clock/reset controller
Message-ID: <Ym/zDx2PQfybo9mm@latitude>
References: <20220429172030.398011-1-j.neuschaefer@gmx.net>
 <20220429172030.398011-5-j.neuschaefer@gmx.net>
 <3c2f2e75-153b-05bf-9878-70fc1c1a81b1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iJIm8ItN0stP3fsU"
Content-Disposition: inline
In-Reply-To: <3c2f2e75-153b-05bf-9878-70fc1c1a81b1@linaro.org>
X-Provags-ID: V03:K1:TZdL9LJQvffWCywN7yHsPoZieyCLTqiPONLOMGAo7ZUvz5KCzrs
 aVVfLiCR8XYIq5pRQdqsgtuSzfW5jxFtVgFoJnT+tdw0gHA3PWNL5a/WpBopwDpv31SOXlk
 NO4ZumurZWJA2bVke/3KoB/EpXuqC6NUgr/EeqwVqHjVaPNRPiwfcQGPEvRyY9cvrqadFUU
 OKbY3s4F3KDVkqNZTCwAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E7rPTkpJM3M=:THgyq7C721gGP/p0tFEbsg
 t6HkfFPiIqULbvlKleEjFP5yWBm5QbEDrgmSEekDh1y71bWAXqdABZvnDw1D6qhu+JTJ5xnmm
 ssz3Wfhf3Rk2RENrfcqjELA1hVGqD4NwIXXnuWQbBM4rQmPxKgWHswIYDTJq3ChLPA3aL/gX3
 y527ROTiebMuArl6jtyyifasZVjQhl70ibcSw7AfTZX8ByMEQRmgEwwDdwMqYZm1YqxAqi3YQ
 POcu6UPTSIi0hoSI3QWIP5Iemf9NQtpDTc9M4nF2mmN0daOyUEov2ZWtnLRAIrUkLQL3Ydfpj
 UyaFmqPjsWUCWmGKBGNVq9KSVro4hCDG4+MhjB3RCExIGoPXr+QTFWaJ1OrkU3kZXv0yiw+RS
 KzIq62OxYJZEMAAgQOrQmEotd/xX7iNHYapereiOLcswikq0v3kZT9OhptsPuP7xeNa2b24eU
 jcCjnwTKx4DLVTjpzY+wKLi7fcppp1e2WYxdtSX4iwuxwLeOoxBtz/081k00d+jjAE4Qz9KaB
 rGO+Nx3qP913N6Ic5FDI2BQ5gvEjFKWlCqhudgElhyYzeGvrcM2pTSx4Vm+24CnJ47RH2/kgp
 TrYlZ00If+4GTdbTyo4A5bvIkDVZxAurdzZXWR9qt/gFvJw8d0pOzyRACClcNxxncsWbrVjVq
 VhpnO4+CMyYpRm9mZ9kQnfGnHZUbBE2P1VRtRG4pOBEhBqbI6NuAGW4AOyVluuYYBOOnHCSag
 ADYxYotr9Mn9uXn1E5V5cSod8RPmXRXWb9MN69I8Q3bw7zEROdKzWoYQNhpG4W/rm/JLJFtRc
 B7CQu+6zvBlkSVl28kTmVhNWbGKzYrBLAEuh7NwT2kogkgKzXhJHTCmNofENaHq7thhnrXMSW
 z0zA/5LhHIfG5rE1FElMXCzchjxyq740ZyomeanrqmSKkrM1CzNX58f0/JG+LVi/SF95oPECB
 GE37J4dLcKOH2Qw099sLmOsWLbTGc+CSlA3ooNKMXwGi1puZ4SsJJfVMhvG9Jw2SOZECRUXu+
 ZWnnZWI4XnHSLLjgr0VeMn/7N6bM4AS78wwmliS7KfwQTFG3SL8dym+yXZ6mixYbAT5/57YI2
 aZlfrONZ6xSpR0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iJIm8ItN0stP3fsU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 01, 2022 at 10:55:37AM +0200, Krzysztof Kozlowski wrote:
> On 29/04/2022 19:20, Jonathan Neusch=C3=A4fer wrote:
> > The Nuvoton WPCM450 SoC has a combined clock and reset controller.
> > Add a devicetree binding for it, as well as definitions for the bit
> > numbers used by it.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
[...]
> > +  clock-names:
> > +    items:
> > +      - const: refclk
>=20
> Sorry for not bringing it up earlier - this should be just "ref". Names
> in values should not have suffixes (so no "tx-dma", "wake-gpio",
> "ref-clk" etc).

Ok, I'll fix it throughout the patchset.


Jonathan

--iJIm8ItN0stP3fsU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJv8ugACgkQCDBEmo7z
X9uxvg//SxUnanNqiaNcEGDN/q839nwe+ZlnAB+RHsg3zz5Myd3rFgwg+Or75NZS
6NXE6b32M0p8QIb8AOLUlQjf2Noqu7u7nuF4gmXTwjlyM+p9GgyX+G2X9IpHAJLd
vtXj++SbRts2AWM5pcvnW8WR2/gKDFg7cqryVZE60uyuc14pb57xCGqKBmdtUxxn
K6/wugMsEfhB+UPb7gfQL9Equ0ku03lJRKKtdTQTC5uvozRGy5PXX+yYaTpYiPRw
MiQ0b/8sFmGmRpWvmyG2eGRyGIpQwPMXfngyAaZ2KyTEZ/qqzV1cw5LunC0IWmLI
OIL4qcz+StrKlk9foTAniJYMksDeeTtYJVkL0dMx3N17q4sHZlb39MpCxFrqhL05
wnZnIBCQzAhKJISqasd4wzJPc7SifE3lUTEeIqNUXWG+sG+rTtTrjtFbB5RbdHeW
7YCmEjKGAZ3+EoWphVrDUkrQa/FJxAaITEsa7D0hnEhfcwjJVMD+WYt1wA7RZhDw
c5rcEfybgjSzVYLDken1hWRXDqG6SglXUvr75AxAnKiYoIiL3E14jLdGiVuT1/9S
TQDEGIszP+x/mgzBtq+Y/5ri6CvMZmpzgMd80bYOmXmsQv5JHMUVYGhTTLYZ3QBI
Yi0zPWd1kLdSL49PU7uQYDGl8JDdoo4KRPblZwnP7fQZ3ljjUf4=
=BKcw
-----END PGP SIGNATURE-----

--iJIm8ItN0stP3fsU--
