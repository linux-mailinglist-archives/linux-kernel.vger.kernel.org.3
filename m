Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1925447BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiFIJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiFIJj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:39:28 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907CF3C73C;
        Thu,  9 Jun 2022 02:39:25 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DE5604000E;
        Thu,  9 Jun 2022 09:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654767564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ps+Ms/Yq5xIFxB3kZR+3U7gZ/XQP/0QRaXFop4LSScQ=;
        b=YhLjgSB6qVB3jtaOxsFksvf1eU+iiKHSjvyveupACp21ylA4amfWMN+g/hUdPtmEp2vmKQ
        iEO75v0FbHvDE86Z4z5LwNEqRi4AcRDCPHHHkx/u6eD0OnE8ELkQk55cxt3dh5lfs6HYdP
        E2DVAWxZHxT5Z05M3/KUTfminLOeq7N/mdRczmhrVwNwHzSk9DsFuNgPKGaD7zsIgq1sID
        4+FGCQZbH4T2GnK1dI6ycvT4VXxUb9IRuIlFfI/k3rZBo3yvbvsefZ8QE7gx/MO00chk+/
        yZo3oNTAqwqdbnIAC2fQpZ1E/7KRC/tgQbzzL7O6i7DP3HzbAVnUS2EN0/lpcA==
Date:   Thu, 9 Jun 2022 11:38:23 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] ARM: dts: r9a06g032-rzn1d400-db: enable rtc0
Message-ID: <20220609113823.36b4b264@fixe.home>
In-Reply-To: <CAMuHMdXACzs8aLgry0ughT4zcU6ZQhL5+SaLPGshXGqNKL88-Q@mail.gmail.com>
References: <20220608090850.92735-1-clement.leger@bootlin.com>
        <CAMuHMdXACzs8aLgry0ughT4zcU6ZQhL5+SaLPGshXGqNKL88-Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, 9 Jun 2022 11:36:13 +0200,
Geert Uytterhoeven <geert@linux-m68k.org> a =C3=A9crit :

> Hi Cl=C3=A9ment,
>=20
> On Wed, Jun 8, 2022 at 11:10 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@bo=
otlin.com> wrote:
> > The RZ/N1D-DB board does have a battery to power the RTC. Enable the
> > RTC device on this board.
> >
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> > +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> > @@ -31,3 +31,7 @@ &wdt0 {
> >         timeout-sec =3D <60>;
> >         status =3D "okay";
> >  };
> > +
> > +&rtc0 {
> > +       status =3D "okay";
> > +}; =20
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v5.20, with rtc0 moved up to
> preserve sort order (no need to resend).

Acked, I checked the order but the wdt0 has already been inserted after
the uart0 node so I assumed it was unsorted.

Thanks !=20

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
