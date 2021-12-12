Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF7471E89
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 00:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhLLXDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 18:03:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:44671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhLLXDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639350212;
        bh=Z5WwtTDX5wghj67msRyvSxbS9jBL/4GvXlyeuYQk528=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PYaCbNAuwwmMSZ1EKwRBCRU2CWZ5KEabWhyesX6mpwK5kHsqkAkxmGPvYMtLuUdNg
         iNGHDwTa5qUYFy9O2GThgEKYntPMlE4kM/wWKCP5HlIxQvmn3I0Cv5Hy3p0al0zkze
         CEKVLtlxiQ5QtUrJXT6CrWHMGWIqop0ARDTq5tPA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1n6bQE0uVB-00U1YZ; Mon, 13
 Dec 2021 00:03:31 +0100
Date:   Mon, 13 Dec 2021 00:03:29 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     zweiss@equinix.com,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 5/8] pinctrl: nuvoton: Add driver for WPCM450
Message-ID: <YbZ/wQJwPDIS5fUr@latitude>
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
 <20211207210823.1975632-6-j.neuschaefer@gmx.net>
 <CAHp75Vew=M_ofNM5pmeHtTJHXRUbbO4RrtgYAtLBznTBm3CS6Q@mail.gmail.com>
 <YbC6Bv2teZ5CFhFQ@latitude>
 <20211209082623.GF25091@packtop>
 <CACRpkdb_zGz4+8R0=ORCbbbVeJVkLqBG2CDXAzi2VAA7-PPZ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="30EHFckTS99T6vMB"
Content-Disposition: inline
In-Reply-To: <CACRpkdb_zGz4+8R0=ORCbbbVeJVkLqBG2CDXAzi2VAA7-PPZ6A@mail.gmail.com>
X-Provags-ID: V03:K1:Prd4tc5qLh62yLE6oLOE+ix2UlQ+ezQYkWrRtinGcZEkv8EWY6N
 WKBUScH60G3k16oz7zg6JcWHWrW6vgBtM9857uaF1ApmWYv2EJzhloUCSakNdi/EkGIe4H7
 +IFOD+Rct9FPrTLEuRUKDHYOxYXAWVL7HxJdLfvdA5ID5k/VZQrj5Li1VqSAvzkNDDaChyq
 E02dRLAxbRTQWa9bfRezw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K1/zGZieM+M=:SEuHYXCK7Z3n744Ebh3HR/
 5dX0URXderiqhVpw945NdKElEDjS67jBLOhOGUJUlrspxvJjPNMTxDeNro6Ly/Y8OS5AuFO/y
 5UzL7/CQXD1zZ1INuRoJBXWbVIX23TohFq50h2NjfXNqQkaPvbQmhhHq7l/Hkl7SCqu1NV4TD
 IVqWMIwpdv6MZ/FQn0T5FG25Q915q/9wup/n6Bxrq+3q2fVzpNTIIX+wAp7h4m4dIDge2e7Gb
 YwTfbt8Pa2YZ2wjUcNGH8lxIq24ZEyAGqIfLMywB7rGtIH+B1AAi/UIJ7jSLmKKoCX+ActT56
 1Us3Pjt9+0J1RkW6tM0Sq/WEtv2gNA/KTsz2ovpmBvT00Zlb2J9RXosnsrp8993KWnIbC7uS3
 7evrEs+Q3iHNUYeE/Mh+4NV1lS9M/Cs1D1RdSmkl/Dji0Agy2cQs0002N1FGTw88NieVNJBEz
 fnVBh1Nikc3sSyIjbhudoAAHQeRs0ckTXIkT5WL0a8mCI/eBhBQmorQtvlW7lEPHDRQc+0gPc
 qUC5tn33SmgZnqLLl3gqmk3RmTXuQhTMS0LywHTL/v333bB0spRuG6a3giW++r5d/u0P1optY
 0K95awfoaTyElcP7Jo5khz5NbMRqMsFwi+JRxeZBlC9qkXR0Oj3vrrolCspDxJvBPsCdc4ht5
 mAgI28bNVH/SUz+RZOJ0TFzWYgHHsMpAEPE3UFUwnMm2Wfbn34RI2gtYTrvV9IqRfHYdsOCcP
 idAMWklGp09kqBEeQ1shqDGHFqtzC2uQSeXThBXb7hWfZBeCQGJKe+rKWucmrkAXWw5z5HbPh
 fgYC29y7RnhZkY+cnRcASVXYDQRs2oMD1p+cyzQW6bXjA/2HIlG5FBalA/S85qW9frIjzwTM6
 phsw4+DZlnHO+h0GNbUeDrk0LKEKDluLEBC2NM5JBvhXZk9LmTW/3aJHJDj+kJblZafCAYXCm
 HjDwe0UezlgteRFf7/dJhJ8f1ZxWUtdYMJKicZ7ksCGY9/r4KJYU/HgXzxq5rOHJgnbrga54C
 YIAYTEJlZuzV+L4QZwbUTxD5Hb0l2hi0NToyhlS9cik2uxfLICFdYXSegCzem1nXqXww5em9N
 QyshoJWk6OAY/0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--30EHFckTS99T6vMB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 02:41:45AM +0100, Linus Walleij wrote:
> On Thu, Dec 9, 2021 at 9:26 AM Zev Weiss <zweiss@equinix.com> wrote:
> > On Wed, Dec 08, 2021 at 05:58:30AM PST, Jonathan Neusch=C3=A4fer wrote:
>=20
> > >> BIT()
> > >
> > >I'll use it, but in this case, I think it doesn't simplify much the
> > >whole expression all that much. Is there perhaps a macro that
> > >constructs a continuous bitmask of N bits, perhaps additionally
> > >left-shifted by M bits?
> > >
> > >Maybe somewhere in the bitmap_* API...
> > >
> >
> > There's GENMASK(), though it takes a high bit and low bit rather than a
> > bit position and count, so it'd require a small bit of arithmetic, e.g.
> >
> >   lastbit =3D gpio->first_irq_bit + gpio->num_irqs - 1;
> >   ours =3D GENMASK(lastbit, gpio->first_irq_bit);
> >
> > or a manual shift:
> >
> >   ours =3D GENMASK(gpio->num_irqs - 1, 0) << gpio->first_irq_bit;
>=20
> I think this can be handled with FIELD_PREP() from
> <linux/bitfield.h>? Some examples at the top of the
> header.

Thank you both!

Best regards,
Jonathan

--30EHFckTS99T6vMB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmG2f8EACgkQCDBEmo7z
X9vyUQ//br+ESQtfq4JlJ6O3bLYKACQe7YaNJu423ivv1HwZ8cBzvRLdFgSwPxbM
JwAkXckp05zpRHzp/0WYDsvy16yPlTAoyrLlnqyKuesXIB4Z/EM2aVNtu4dv+Wbl
fMAt3epKy2ZjT7fPooRm0ySjJdq3d2uzu7fVCo+VMWpRZmXrrUVsphPeNKjS/16f
YQHswQMJ9oSDlL3cfugjtz0AOoZ/XyKtKfbcS4uE9lgTq9V5Bj9IiEopv4GDMRhG
eQVItYAukQ0oTxqned+qom4U+RcuJgrel8p5C/ZQojQ3XVYiqvDZWiStk5fkDIt8
IrrPJt1psBE4/O3r6utoo/I9LbctYoy69E5pIvo/IUELfkngzFQu6w+eIL+ndAIx
vKWMJYzAOWY3l94tQqvu3zPloZhbAXmvt5V49r8YQnNXsb7QCGSo7as8/tkT3nIQ
bFXsZarXI6b8tGwUpj4TCgISIG2TojxAZOSxPg/7zUnxXY2O4A2bbuSoumFiDlN3
PhiwUg+6oCZ1EZS4bOhdqrRm/h+7ZVSJxlFnAyeV5bFeW84B3CQzQ7nDtsPK6N4i
oc/McWrIBMt5qKw08eXi2PrE9HrqDcKEhkck45NVR8NsX9+5O9U0Jg5FNHxN64f+
4oqgPpe9vxeinHIrSWs5yTJ1Q1a7c8adb4P7bGeCEWp9aXGvLgI=
=6U2z
-----END PGP SIGNATURE-----

--30EHFckTS99T6vMB--
