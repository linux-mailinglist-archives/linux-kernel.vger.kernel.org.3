Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9AC574BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiGNLX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbiGNLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:23:41 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624765886A;
        Thu, 14 Jul 2022 04:23:29 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CC6311C0001; Thu, 14 Jul 2022 13:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1657797806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6QT5nX5UXBXiE8i6HmCkJes0OQrNQW7DZj7NVeDSXy0=;
        b=IhdRsDS+o3dILqWj9iIbW+mzvQyS+T8yXxkcUAt8uVVojWKyRaVXk+++XRdfkbc7sdH8oj
        gKuScfnSldyZxQmsKpM8jYwCNi7ngORxsNWVesVzDJCu8ZZgeCHUYjndwgPlrjV3paKZHm
        r061Ja9dTCrCJagQ98oocEgxmBkaS6w=
Date:   Thu, 14 Jul 2022 13:23:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lee Jones <lee.jones@linaro.org>, marek.behun@nic.cz
Cc:     linux-leds@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: LED Maintainership
Message-ID: <20220714112326.GA16407@duo.ucw.cz>
References: <Ys/kruf8DE4ISo8M@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <Ys/kruf8DE4ISo8M@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Not sure what's going on behind the scenes, but it looks as though the
> LED subsystem has been left unmaintained for at least 2 months now.

> Does anyone have any objection to me stepping in as temporary
> maintainer until the situation is resolved?

Yes, I'm a bit busy and would not mind help.

There's a lot of easy stuff in the LED -- drivers not introducing new
APIs -- and some quite tricky stuff -- userland API leaves... a lot to
be desired, and we are in the middle of defining multicolor API.

I wanted to ask Marek (in cc now) if he would be interested in
helping. He knows the APIs / issues, and actually has multicolor LEDs
he cares about. Marek, are you interested?

If Marek is not interested, yes, help with the driver stuff would be
welcome.

Best regards,

							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYs/8rgAKCRAw5/Bqldv6
8qPIAKCgDLaOK+oDxPPVYgY5z1KneqhDewCgwh2RI1gZ2R2SuxHFxpWq+CFaTV4=
=Ipbn
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
