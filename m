Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D03651BA42
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbiEEI3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241850AbiEEI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:28:55 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C9E6D;
        Thu,  5 May 2022 01:25:14 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 140C81C0BCC; Thu,  5 May 2022 10:25:13 +0200 (CEST)
Date:   Thu, 5 May 2022 10:25:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
Cc:     lains@riseup.net, jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <20220505082512.GA14065@duo.ucw.cz>
References: <Yifr4etBFPu1a2Ct@hermes>
 <20220323210423.GA10741@duo.ucw.cz>
 <YjvVptj8exUCD7sx@hermes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <YjvVptj8exUCD7sx@hermes>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The HID++ protocol allows to set multicolor (RGB) to a static color.
> > > Multiple of such LED zones per device are supported.
> > > This patch exports said LEDs so that they can be set from userspace.
> > >=20
> > > Signed-off-by: Manuel Sch=F6nlaub <manuel.schoenlaub@gmail.com>
> >=20
> > Please cc LEDs stuff to the LED lists.
> >=20
>=20
> Will do. Though it seems like first we should discuss whether the kernel
> in fact is the right place, no?

Well, on embedded systems keyboard backlight is handled in kernel.

> > > +	cdev =3D &mc_dev->led_cdev;
> > > +	cdev->name =3D devm_kasprintf(&hdev->dev, GFP_KERNEL,
> > > +				    "%s:rgb:indicator-%d", hdev->uniq, zone);
> >=20
> > So this is keyboard backlight? We should add the documentation at the
> > very least, so that other drivers use same name.
>=20
> I do not own a Logitech keyboard, but some mice. There are RGB leds
> that you can normally control with Windows software.
>=20
> I'd suppose (but could not verify) that supported keyboards by Logitech
> work with the same feature.

And I guess we should do the same for Logitech keyboards. Userspace
does not need to go to /sys/class/gpio... to control keyboard
backlight on Nokia cellphone, it should not need to talk USB directly
to control backlight on Logitech keyboards.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnOJ6AAKCRAw5/Bqldv6
8itPAJ4mgJfNh/+ojD3N55l+TKJll9C7NwCgt+QyCCrDAaKELbCva5XyElaLLwo=
=m8g+
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
