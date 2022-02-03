Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB8C4A8520
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiBCNZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:25:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:56873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233666AbiBCNZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643894707;
        bh=LjG7jU7LeCId0a06uLjWHVAGBesuo4KI9BTRCxVfE6U=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KMfLbh+ulvcsbxsRLK+EEB3J9rwT+ZLGLCqdcoVhn2pwaTaTJ3cZdAbYnCNax5R6n
         dk4zfZwe5R1ozZncRLNs95zJFwqVJfTF7Sa1h1MauStK1apuXhmlzrVgLpYK1/BW4J
         wK8IP/kesm29x4aBF+Q6W/lXGXnPjv+TBqJDIVPE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1mfBMd0lWG-00cfXP; Thu, 03
 Feb 2022 14:25:07 +0100
Date:   Thu, 3 Feb 2022 14:25:05 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 0/2] Fixing the compile-test warnings in pinctrl-npcm7xx
Message-ID: <YfvXsZYYA7+0U9P0@latitude>
References: <20220202125438.19345-1-j.neuschaefer@gmx.net>
 <CAHp75VdtTzkXVY21WZje1EkqixOOxxA3M09NfqQanV0XSRiNjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vVxDn9wXo9OMNmFd"
Content-Disposition: inline
In-Reply-To: <CAHp75VdtTzkXVY21WZje1EkqixOOxxA3M09NfqQanV0XSRiNjQ@mail.gmail.com>
X-Provags-ID: V03:K1:zy6YfY08eWiqEpgvhZoQm2Ze8GMAUThz2WINg4DhcjOc5nJkVSc
 XPYh7T9MwkBMaHQ+baW/A3cjsS1/jT2jQziMW7XLhlVNbSk+Wsprxz1I4DOdKVU/XU0yvjK
 TpAWRtoiTk6bP3YRWIrW3f5xmaL6QYzPbCc57/5MMbPm9oblPk+KxCrGIj5jwpQb8969j3t
 fyWCh1f9A7slSOaJEBBuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DjLqU1a2xqI=:+9M9LhJ2dQPKXgPYvPnnYU
 i8zS3MJPD+ym7uk0O0L+7tAcYTTKVMU1v2jHeF8x7kx0EnX226y0BYgy2Sz54O6TBCAaZS9xN
 HWxH9zUGtjqnUYZW+WuefI97/iKJSK4RK7L72a7OeZ5z/MTflSae6/apZ1JqoaKd7iuDmM+xk
 gf1f4XKcf5zs8JljSrOHyyWMFCylGDMtmNxG1F9KdDs5YQBfUkD7q0PRkzVrGtpuMsLibDJfF
 IQ1F+K6Ri623DqIYvlWwrjpCnuB8wrB5pXEAJlP+djCPU/aBi1L+XO1peWT5InhPJyB5EP8mY
 VMqBKB8rYGDJY8YcKxRuNzSVu/2Zof1RGK3URntpO/q5mCo5XBqIjpftkig95cGc4ceGn0Cc2
 QvpN3VyfPWMgsoOwg1N2OufI+2okuEs/OaXiMWv/du+Epf8kCAVFHlDMUv5ItXjVFBghdyjUM
 H0r8FwetT474E0bMSiSLb4nfZyrywVyRjk8cdbrKz6E8JwyGaqTtaCAHmsZyRH6u1Hxe+yuas
 TWcMPhnUvV/sKrGp2CdX+IhKP7MDgdq9PQHY4s8TFGXjE0id3uHvyN8i8XP3/QcZ49lmjNCqj
 /AUuzqRKDl6sLNbv8Zwi+kQKbVJD/9HZhjLgbAFf3v4PBCzP+BrRhDOuwgfotmwTRwcYKG9LU
 QN4UxYtZpDsdZHNUpjPA+3/36yMX2KZj4+spyw81Qkx2hY5K+GARCeHaW3UdFSSZ1h5nEnDmH
 nPMFUovZSIHX99jXB+xJPlpvzRpSLpyANHHOmRdlQ2Fxwglm1NJECsOjuxiILm/WmlHXT4ww/
 822ysV5AUp++pDut0gxBOL7q6uBfsk6XTFBoDJKvK/vnnfa1u8FoaWo0WjzVSMieHeApl9uU4
 Sdoq4hybjrjtIFuZgZ1ViRpn/mLmASYzEzFzqTm/kKqXHVHUGKNE9NyIlozmFTH0TH3TCnGRm
 PPnHKWxtYeqjeFbM139HF8WNiz80krCT0Jqiwrs0398yKYyuvUSKie23qETpigEfcyRRDtxWh
 pDMUsp1y1MMsxPhsdGqFKttVtGmBXkY9/hrWFYWhPpJXo4MsXQaD8a1z2DFPVgn2dY/I6HRCO
 5pboFfBiPZ6iOg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vVxDn9wXo9OMNmFd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 04:20:11PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 2, 2022 at 2:54 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> >
> > My "Nuvoton WPCM450 pinctrl and GPIO driver" patchset brought two
> > warnings[1] in the pinctrl-npcm7xx to light. Here's an attempt at fixing
> > them.
>=20
> With added the respective Fixes tag to each of them

Good idea.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

Jonathan

--vVxDn9wXo9OMNmFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH7138ACgkQCDBEmo7z
X9vH/Q//f2fVT/6Iiwn6RLsc45O7VUiNAl5MSYq/YqDxhijUR6iiBPMS9gzAp5MO
ffZmfZ4lHje9815TXVc+k+IUN96DwJFM6oVg0xFbXpIMcspFNKor/Lz85Af+LtC+
093x3zBZMj+k1vqCwJL7scwsO4hBmLHf3u8yKyJ/Xk58OhZ21DLEq6JCv+iB1WdF
VJqYG7UChkucF1l5T7muw+mh7eEPQLhuvYvHxkXJgvb+otvItLNl6DMXkg+Cs/j0
s6gu2LKSlUqGTD5VdOpMvXQQm/czpY35D3lX/Rj4/3b8j1zexmkawlfme0BKMMgQ
+yLhTwbyZE88zBtbLIEhyTuBiWWy9+Z+ugJw2bTYpw21FsJB0KS5sfiZwApNKw8R
WDbEF39OKQG7eLUQ1cEOekv8cTVX9JEO7LBNIChCPqbZfyFwMVbBmKq845a844RG
OMIrP3oT9xe3h9zF4YdRsuFgGpZh80DgbYxeEyCrcWyyDlmXVAb+OrzgJ5L8E/Xg
UHeTD+GSXh5KA3jn4PPtm052YfKtp/LyXyKU0+AqpDJW8MGwhgTDjzgsp9swWtkK
x5niOb0kN97LRYzHfvWOjnCopbtl4Ya3U/XK5uCZMsBBsSPDUAVo9u/UAXqvwdSX
Ga37TZoB0XHjs9sMWSyFCC3kzNUgndlEC1+zhJDtGhr/QfsNZr8=
=fheY
-----END PGP SIGNATURE-----

--vVxDn9wXo9OMNmFd--
