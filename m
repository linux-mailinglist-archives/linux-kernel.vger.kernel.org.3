Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A867B4A651F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiBATnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:43:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:40339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbiBATnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643744616;
        bh=mlXNAspUBC3g9aZKzGDlPsP/MrhxZykfCLw8MFC0Vs4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CshimOylHKnEg4xSk9EkpUgmMEJWn0629esrD+DtvFU0WDXYa790WUfTZ53onTVXn
         zzDv6owy6He43YQE8UQONeH+f3m0JpTjO4/BbsDdrLyNEAE2YWA8HQlCwjaUB54tIG
         ppVwJajQ/BeXgQRGLsk20XsM/3tFlxqnx/wp3EaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1nCV1N0Xph-002VsI; Tue, 01
 Feb 2022 20:43:36 +0100
Date:   Tue, 1 Feb 2022 20:43:35 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 2/4] clk: loongson1: Terminate clk_div_table with
 sentinel element
Message-ID: <YfmNZ882rcI7c8Kq@latitude>
References: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
 <20220128230922.2047140-3-j.neuschaefer@gmx.net>
 <CAAdtpL5xVjiKSFVcdFiMQHrki2bDSbDppP65QDC5ybBp3u-kMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rS/vUSa6UlTIcpRM"
Content-Disposition: inline
In-Reply-To: <CAAdtpL5xVjiKSFVcdFiMQHrki2bDSbDppP65QDC5ybBp3u-kMw@mail.gmail.com>
X-Provags-ID: V03:K1:qBSeOjxsDd70rGegqzdelP0N1Nmu7D5XTe5+K6fjo6OQF3Kc1Fv
 u4iuoafBaueIm+9Vbkb23VNkhZYmt+5OoQa0Dq6aPEkkKxpso0Y17FpYlZ5z5goxCaIG34I
 3JymUB7hz5I4Se+Lwjzke4oBKj1K1VcnSyC26Ji7gXO5JkmCRwVD/ac4eKmXME8B0Dj3uC0
 MDx6YOw/zLJrxtXMiEHEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gPGBRzmsrEQ=:HOEMtA4Gm6bsKspVwKP4ld
 tootLVhMqkHsavorui0LRQjlXZhy4sISYlQApCxy9zStGdZjTIafDNS9gVpGYjRGke+cLObmG
 wEpDIEjDUh4pBSe1cgozjXPLiZO+xmo0LLwZenq5+fI0sRqUWED3q+Eucd4Fl30aPfXP3IMut
 GLfJ97o0Dq8jvdu9vjR5Fa/XSc0dPcfMRWfiE/Chs/O7Rzw0zsOE6fOpH4KLGLPIM8WxcZKGM
 KilATJEH91ghdgw+DCnHPrPWMp6dCPRRNm8fm3RkhKYv4nitKnK/gTiCg14YKHH0tQMoWxd7n
 Jdv3inozgEv0NKn+C9GZfzxlgHxCPTnoQ7wSYiQGP+wLC9h/WK13cd5HONuIxnhZKfdgIWOjp
 UibjaBJWYmen9STz3s5xf7waQL+/PqTkec95KgW+WgEKOk81hN8e75/aUKssob9aAB4HMyIjp
 STgSYimK6oLU84IleQzMge2v8jff23pIPBfOibjPkg9GpqzTV2tx14vJsA5KL6XlEo8EAiBC7
 y0btvFT1GgxlmbuCqHSMxnp8IRPlnzI0/anwbyBO/l/fus9dfXKTVwcLcbHFxyUwza5I++Ba6
 vkokvJncsqDuX66zZNiTzmCczVo4ah071M2NnBnZWpp7quIhFRtLCkk4DVqxtMrJRRmmnxUyo
 2m6cGfK/Sx2EuenK9UKaLyxATZHz6PL+9Cl3zkzp30ItZv6MwN6+bSHkkk2/29EHY8oPzq5pz
 LlFrK2RJJqxR1i1x94whFcNUuehrducH680L4D290HgGxKqjmvUHlIXL2Gnnuk7/EPuUy3fCq
 /wVoL+ogmlEz8zukSpjtKs7A8w6Hw+02uJ+gvyKY/8TX5udJgtZBTGKHV41pM/vwhiuSshwol
 3i0EhwDqRN+EzsJRJ0v1G/+HSVoeFy7evfzegFOX8i/6MbXShrptkHhaXxXGQuh1wU5eYyEKe
 kNr3UnUA6Aqab75Yk8H8LfNkAl6dp/riU58DoSH0GMOFmtyMqR3iXnOBJrzj8yI2481QJMnXt
 fylBoMC6dW7EwH5YAqSp50n6ss7AIDgOklOha+7Tjj7wBLviReQAbSKD0s1luBAEmePh/6+In
 JiZDZSPgKWamsY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rS/vUSa6UlTIcpRM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2022 at 02:57:03PM +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On Mon, Jan 31, 2022 at 12:48 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> >
> > In order that the end of a clk_div_table can be detected, it must be
> > terminated with a sentinel element (.div =3D 0).
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >  drivers/clk/loongson1/clk-loongson1c.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loong=
son1/clk-loongson1c.c
> > index 703f87622cf5f..6b29ae9ede3e5 100644
> > --- a/drivers/clk/loongson1/clk-loongson1c.c
> > +++ b/drivers/clk/loongson1/clk-loongson1c.c
> > @@ -37,6 +37,7 @@ static const struct clk_div_table ahb_div_table[] =3D=
 {
> >         [1] =3D { .val =3D 1, .div =3D 4 },
> >         [2] =3D { .val =3D 2, .div =3D 3 },
> >         [3] =3D { .val =3D 3, .div =3D 3 },
> > +       [4] =3D { .val =3D 0, .div =3D 0 },
>=20
> Easier to review when self-explicit:
>=20
>         [4] =3D { /* sentinel */ }
>=20
> Preferably updated:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> And eventually:
> Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")

All good suggestions, I'll incorporate them into v2.


Thanks,
Jonathan

--rS/vUSa6UlTIcpRM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH5jUQACgkQCDBEmo7z
X9sbfBAAsWRQW7hSSe6lv8B+ILWJbizwV2Gv8Hr/4ah4C40e+tL2AL3Zb74SFFIB
JiSa3eNiZtGS6k6z0nTny9jaGBTmamzgVaO1+oX4yrPVud/ZRgBWNkIqKtykodlc
+yGaXPGuNzsyg1rq4zUmw1yE7yf2SdRRew92wrVlvMG92qztcCPOKmYQnIPSuHQB
Sh8thsnqQhREK4tfgj7Jvbgyalr3EPOy4PQ8EV/F0sukNx4goC/NvzpQCW05b8zW
mIDrP9gCKT0x8nao869YunTUshRxwJJyh7q9RroyuBPA2nGruDBDxipIf8jYD0j6
yxx6Ovqgun4/RGfTBiJguwdGewAw9Ul0S9src+CWH5LTwnqYjFowLe7FxTy646DY
WHQ71olyqYQWJ6iNnNVYqyyiyxN+epd14ujTErCqHanBrO4QmOnPWKCmNQNtlgBG
1jHpp4lGh80CUAMXDuoqz5rl9nZix4U+HKg5yvgqsAnv31XW3Q5zMl3TQgVESldU
dsF3ustKDo3UXmNCXH8UiIWyolu3uaXu6WTAS01h6oEwe76yVtjWyWQemWY2Zvub
pp5lCHWv3LOR2pRYpcH+GXJd/UPyIGg/o5ysjVWjRrNzQFidHzQv9ijqeX/Q7s0O
sEfURHyrrYzgED1DMeUw52uGJzFagKyvq7gNNrKZzIufWRcc+zk=
=Qh1l
-----END PGP SIGNATURE-----

--rS/vUSa6UlTIcpRM--
