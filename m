Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE753CAF1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244846AbiFCNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbiFCNx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:53:29 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C98A3669D;
        Fri,  3 Jun 2022 06:53:28 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 938C61C0B9B; Fri,  3 Jun 2022 15:53:26 +0200 (CEST)
Date:   Fri, 3 Jun 2022 15:53:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Add leds-qcom-lpg entry to documentation table of
 contents
Message-ID: <20220603135326.GA14636@duo.ucw.cz>
References: <20220603025735.17953-1-bagasdotme@gmail.com>
 <87bkv9x3qu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <87bkv9x3qu.fsf@meer.lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > After merging linux-leds tree to the mainline [1], htmldocs build produ=
ces
> > a new warning:
> >
> > checking consistency... /home/bagas/repo/linux-stable/Documentation/led=
s/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree
> >
> > The warning above is because leds-qcom-lpg.rst is missing in the table =
of
> > contents.
> >
> > Add the missing entry.
>=20
> The fix is good but ...
>=20
> > [1]: https://lore.kernel.org/all/20220531200619.GA8906@duo.ucw.cz/
> >
> > Fixes: e98a860f65428a ("leds: qcom-lpg: Require pattern to follow docum=
entation")
>=20
> ...I'm confused as to why you used that commit for a Fixes: tag.  It
> touched the file in question but didn't add it in the first place; I
> think 24e2d05d1b68 is the droid you're looking for.

Not sure if that is important, we don't need this in stable, do we?

Anyway

Acked-by: Pavel Machek <pavel@ucw.cz>

=2E.. and I assume it goes through your tree?

Best regards,
								Pavel


--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYpoSVgAKCRAw5/Bqldv6
8nIWAKCWcLLIJQ32FCX2NeS6MLnFdl8klACdF6zcYv7cWK9iP753o88ODVFFAJk=
=Hiy/
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
