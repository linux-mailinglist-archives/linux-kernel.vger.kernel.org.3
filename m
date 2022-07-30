Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B92585C2E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiG3U5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 16:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiG3U53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 16:57:29 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D6814011;
        Sat, 30 Jul 2022 13:57:27 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 702171C0001; Sat, 30 Jul 2022 22:57:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659214645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jay3CCNF20mooni1ih0V+UiVicjDVm0w35aoKM5nViQ=;
        b=NehfRFrkvwQzJXoHxH8bJRH40rXaa3WTHhgedEJbOZXK+6P5CaMk3P/nc7iSWJ7sEleBlM
        d/ZPqtAbmu0UwtoNjis9xJdZBbcIlxNCddNxo9ot1WGGhCxAxn9hi8wAqk6Bwjc62mcyv3
        Rde20eP3ZU+T0VoqqRXhcz1tOCHZQg4=
Date:   Sat, 30 Jul 2022 22:57:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: turris-omnia: convert to use dev_groups
Message-ID: <20220730205725.GA23307@duo.ucw.cz>
References: <20220729140346.2313175-1-gregkh@linuxfoundation.org>
 <20220729185338.2bba32f5@dellmb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20220729185338.2bba32f5@dellmb>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-07-29 18:53:38, Marek Beh=FAn wrote:
> On Fri, 29 Jul 2022 16:03:46 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>=20
> > The driver core supports the ability to handle the creation and removal
> > of device-specific sysfs files in a race-free manner.  Take advantage of
> > that by converting this driver to use this by moving the sysfs
> > attributes into a group and assigning the dev_groups pointer to it.
> >=20
> > Cc: "Marek Beh=FAn" <kabel@kernel.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: linux-leds@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> Reviewed-by: Marek Beh=FAn <kabel@kernel.org>

Thank you, applied.

							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuWbNQAKCRAw5/Bqldv6
8jchAKCZOYmsJPqvmewWpdTOWZlA0+XbRQCgvnGxRXVpil5XoP+yjC+F99iEHAM=
=MdOg
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
