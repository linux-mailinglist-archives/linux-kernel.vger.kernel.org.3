Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F8C4B34DF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbiBLMJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:09:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBLMJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:09:02 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2266924BC1;
        Sat, 12 Feb 2022 04:08:59 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CA2081C0B7A; Sat, 12 Feb 2022 13:08:57 +0100 (CET)
Date:   Sat, 12 Feb 2022 13:08:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Florian Eckert <fe@dev.tdt.de>, Rob Herring <robh+dt@kernel.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] leds: ktd20xx: Extension of the KTD20xx family of
 LED drivers from Kinetic
Message-ID: <20220212120857.GJ20866@duo.ucw.cz>
References: <20220121140150.1729-1-fe@dev.tdt.de>
 <20220121140150.1729-2-fe@dev.tdt.de>
 <CAHp75Vd4pwFXoF=xS5cskM2GDNb6c6RXTYo3j3FLP+nuQVoRyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd4pwFXoF=xS5cskM2GDNb6c6RXTYo3j3FLP+nuQVoRyg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > +       struct device *dev =3D &chip->client->dev;
> > +       int ret;
> > +       unsigned int value;
>=20
> Here and everywhere can you use reverse xmas tree ordering?
>=20
>        struct device *dev =3D &chip->client->dev;
>        unsigned int value;
>        int ret;

Lets not ask people to do that.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYgejWQAKCRAw5/Bqldv6
8tnZAJ41Q0fqqLPQF2mfmRxh96z9hZHCFQCdExBMKGrnAQWoVhIWNICuT6y9NXQ=
=rwST
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
