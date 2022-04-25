Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7A50EAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiDYVIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDYVIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:08:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AD42612C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650920714;
        bh=2SinOKWBnYwh2Ez74Ny/iUhC1XiNGTZebW2WMKJ0ubI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=H7jlhwwDTay1T74diKlSORH0Pv2/mVRZ0wAKG1wHm1Q3HNIxCkxt1JeQxQmBQkm/7
         J40nKM7mrLXZ7CgD0gJsKLtwcqt2yIMTCGECDoTOnPxnA6B/JxMt5zwUxvzVK7iPfg
         bTngpbBY6ItXnFSxedYBkxwI7IadX6HvY3pXlRFY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeQr-1nMOO92lJj-00VhIn; Mon, 25
 Apr 2022 23:05:14 +0200
Date:   Mon, 25 Apr 2022 23:05:12 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v5 04/11] clocksource/drivers: Add HPE GXP timer
Message-ID: <YmcNCB8trIFww8Mg@latitude>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-5-nick.hawkins@hpe.com>
 <CAK8P3a0nQ1BrtfBJ7sUSaLkA=pbVwx83bEUpZczvLOSOHDR=dw@mail.gmail.com>
 <CACRpkdbJ1N7VOgoBzGS+cOaErFcYiOVDeWRmhPyHA7=9W0CGhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gPm3dkYWD93jriOi"
Content-Disposition: inline
In-Reply-To: <CACRpkdbJ1N7VOgoBzGS+cOaErFcYiOVDeWRmhPyHA7=9W0CGhA@mail.gmail.com>
X-Provags-ID: V03:K1:qHKJGgTrT6rptDoQmCaR5/ooQ1RbWgCkWERKZg4FKnl54DurbY9
 /PnSE0q4TbnF4XcudxKc/bCV3O8Qi0qYwy9qngDLVe7dRMximXWDiF+Ll3EnffCQfA83zxr
 SgaLaLEgSMoG86Vtdvrk9JIeEM96kwXd/NlDB6b5khdILv5EDfhsdP5QtQ/jWkZ3jjOPHZ7
 ObeA5vSZYNcml2YfaPYoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PfseJihy3hs=:wAvhC3gPVIPnGOBfUpDlKi
 HfiyVbUD324SxXk10UwRpeFnIh2RuU1xIlbVGIvY8nvfgmw+bZBZ1q2wpPbhPX8QObdLCFrWO
 vDlbSuq86UsSAQe0dfFr+rHRecoD3jImYjSSp0ZvYyFvraaGj1Hn2l5YX4V8OLjmjZvNv3h1M
 tYuSXff/NN+DLQD2zWuu6aROdBBJ4Gts9hHgpQbzNDWhjRBzwNT0KXNwEK4COfcdQDJnSh/Re
 0xHRyslIa/2mFxUqqtnTZH8KZidSb26Lb5ZJh5KEOp2j+BBxZKtbjyLZlH1l0qSeUVbdoBtht
 ga9/awkOEJmYDqMPr9tCrNvf76ZdaRZu626gUZ2YsQjz4XQtJ+Zeha7LBV9bsiVvSNqv9vVvH
 G6rCqERyAKY0euWSmxP49wGHR4RMvu9kqYqFUmjop22PzGv8jJR6u/3COkrTgVEzv6LBm66sA
 ascFSEZPoFFp7fHUfYzU+Hb6OB+Q9qyvpYCLSJ7PEMNMF/xzxhJseoxJ7oHbcW4tFdKaBxv4M
 kfHyA0JvY6wSs/iE4M23tQzr6pEssbUiAIXLCGagYdIYqbhHOCEU22tBkg+XcDgv6wEyFR1kc
 I8v9iz4lueKaxynjURW/C018YhP0KhbUUEQ0HoPtj9989dm8kQAJ9wsWGz3owkHHvQd00mttz
 BUgdX/a45Yr9EIaA5/G4Z34r7MCjnRtiBoWruPZFwGvHtqkRurBicW3U8Uuf0njN7SZZ6U6D9
 n3JLnm3FqfjxgXn1W1AZ8ShED+49xDdIVR6B5MrveS10pFXOxYH3orUQPN9X8rGANQteI6pAD
 5SQ5f/2kY47skgwtE5K/kvnqpJc4KA5pp/SK/OsV3UcddGI2eB8nZ+sS9lz/caKFWAKgUTPjh
 x4WtXYNgyuJLq5kNaCIwrX4Q1pJJCBaoLn0fCgIFaDSKFs6FEZhvao02Til5xaL8h1gRiaPjK
 9znX/6QN+0po9vOHKJ0ZcJksJv1drU9alJzniTZG5OeOmQZXWGJFNedEYFdeho53SBTndcDUc
 LACcAu7ba4+XojURIgBB1FJfp+Dr4HE4DHVf7QdHZgKO4mNdsEcLY0qzYO2Fl0mbw9JIzBxC7
 meb5KClRPudfzI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gPm3dkYWD93jriOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 10:38:08PM +0200, Linus Walleij wrote:
> On Fri, Apr 22, 2022 at 3:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
[...]
> The ixp4xx driver looks like that because the register range used for
> the timer and the watchdog is combined, i.e. it is a single IP block:
>=20
>                 timer@c8005000 {
>                         compatible =3D "intel,ixp4xx-timer";
>                         reg =3D <0xc8005000 0x100>;
>                         interrupts =3D <5 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>=20
> Device tree probing does not allow two devices to probe from the same
> DT node, so this was solved by letting the (less important) watchdog
> be spawn as a platform device from the timer.
>=20
> I don't know if double-probing for the same register range can be fixed,
> but I was assuming that the one-compatible-to-one-driver assumption
> was pretty hard-coded into the abstractions. Maybe it isn't?
>=20
> Another way is of course to introduce an MFD. That becomes
> problematic in another way: MFD abstractions are supposed to
> be inbetween the resource and the devices it spawns, and with
> timers/clocksources this creates a horrible special-casing since the
> MFD bus (the parent may be providing e.g. an MMIO regmap)
> then need to be early-populated and searched by the timer core
> from TIMER_OF_DECLARE() early in boot.
>=20
> So this solution was the lesser evil that I could think about.

Nuvoton NPCM platforms use yet another approach:

	timer0: timer@8000 {
		compatible =3D "nuvoton,npcm750-timer";
		interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
		reg =3D <0x8000 0x1C>;
		clocks =3D <&clk NPCM7XX_CLK_TIMER>;
	};

	watchdog0: watchdog@801C {
		compatible =3D "nuvoton,npcm750-wdt";
		interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
		reg =3D <0x801C 0x4>;
		status =3D "disabled";
		clocks =3D <&clk NPCM7XX_CLK_TIMER>;
	};


The watchdog control register is in the same register block, but
represented by a separate DT node.

(not necessarily a recommendation, but it is another existing approach.)


Jonathan

--gPm3dkYWD93jriOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJnDNYACgkQCDBEmo7z
X9utyw/+PQptdpmTDI9uz/64ZcyzJ7h8qjbmSrTHrfF2rk+MMvLysUgWCEyLZ3fl
XJUpVAtcF6KJAVrj3yekWbcTqrC9RoHvJ3Wi5X26z/ij3up5ASlVW2NXLPs3dv4i
TZ+5EbASXoMTETwwt6Q6nLxTt29oYpO2W/1xBUYcoj/NvIFAH/p025kLCJrNJvrG
dGvnMbOmVHVfaNNKgK/tDS393lVWbyLOaqvg5vPgMiBogsqwh9YqcvAN6ES/8vQ+
TzQ2FMIdRcS/27PwXOVpOT0XuwNsOsUCNDfCl8ckLV3MlZLDOGb9NE6HiVQBCYZe
VchyHb1gIaAcMAP7Y3nu+IFIy55+KRV1XjiogslO7yi6o6qrDAO8w8abyqbWeGnp
4ayx3qvjENa5/uVB05xpc2YMpF+tQ8nbayKSVh+oWbTmOWJFmRL0dfHghoUEI3WA
8zRhcJJzp98WvinsIAGp3vGm3Xd3k5oLvZg2DtchaZJsH8rJ4/TFgxoyappYn1PA
PouDWjnFQelznYJFrxQJVbJbNMP3Nz9kh1kSyAmCBqMhlAyjuOYdvhYcskKfIoyU
GLCckgHze9BVIjpSZ7/Unmcybc2TTJ+duxUkzrLGZqjM+40YuSvqkSVEbwk4MRNg
DXJe8kmLQ6UFziCFGWta164HWrNVCXZgbuFUWpmLlG9iCVAZyNg=
=SEJz
-----END PGP SIGNATURE-----

--gPm3dkYWD93jriOi--
