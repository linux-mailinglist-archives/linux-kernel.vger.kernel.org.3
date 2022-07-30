Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923BA585C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiG3VL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 17:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiG3VL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 17:11:56 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA731FD8;
        Sat, 30 Jul 2022 14:11:55 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6E34B1C0001; Sat, 30 Jul 2022 23:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659215514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlorDYEwXMxpMsZ8bICGev4x98eQSXUdeeCtUIUXnK8=;
        b=PxO/uL7dTnQEcdljh4N4SOnisLwH7L8UAyrjIRxka4LVsHEZBE2uSH/Xu09Ph6h3Y4C+Ca
        IKnr2bzz0QPXUtRqf/dRAi1x8ol9k7mf3QtzZoEEXQGH0g78d7sZoFjACVfgUxi9n5ISo5
        zOixTCQS6C+MX8Wbu0sZ96i9q0whDkA=
Date:   Sat, 30 Jul 2022 23:11:53 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: LED Maintainership
Message-ID: <20220730211153.GE23307@duo.ucw.cz>
References: <Ys/kruf8DE4ISo8M@google.com>
 <20220714112326.GA16407@duo.ucw.cz>
 <YtAIm+X2XchcSkFX@google.com>
 <20220714222541.232eadfb@thinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
In-Reply-To: <20220714222541.232eadfb@thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > > > Does anyone have any objection to me stepping in as temporary
> > > > maintainer until the situation is resolved? =20
> > >=20
> > > Yes, I'm a bit busy and would not mind help.
> > >=20
> > > There's a lot of easy stuff in the LED -- drivers not introducing new
> > > APIs -- and some quite tricky stuff -- userland API leaves... a lot to
> > > be desired, and we are in the middle of defining multicolor API.
> > >=20
> > > I wanted to ask Marek (in cc now) if he would be interested in
> > > helping. He knows the APIs / issues, and actually has multicolor LEDs
> > > he cares about. Marek, are you interested?
> > >=20
> > > If Marek is not interested, yes, help with the driver stuff would be
> > > welcome. =20
> >=20
> > No problem.  The offer still stands.
> >=20
> > I guess Marek and I aren't mutually exclusive either.
> >=20
> > Any harm in us both helping out (if Marek is also interested that is)?
>=20
> Hello Lee, Pavel,
>=20
> I am interested, but unfortunately I won't have much time for reviewing
> patches until september.
>=20
> From september, I would be open to co-maintaining.

Thanks a lot, lets do that in September.

Best regards,
							Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuWemQAKCRAw5/Bqldv6
8kRAAJsGodRSKFUP2L5+QNLh6H3gQFBHxgCgq553LS0XoqY2B95fPA6v8mAYJq0=
=tzX1
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
