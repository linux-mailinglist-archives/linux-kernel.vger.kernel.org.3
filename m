Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794E6533234
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbiEXUKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbiEXUKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:10:19 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FA5AEF1;
        Tue, 24 May 2022 13:10:17 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 142361C0B82; Tue, 24 May 2022 22:10:15 +0200 (CEST)
Date:   Tue, 24 May 2022 22:10:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220524201014.GA25684@duo.ucw.cz>
References: <20170323055435.29197-1-bjorn.andersson@linaro.org>
 <20220523163038.GA9124@duo.ucw.cz>
 <CAOCOHw7N9EHcxSSe6n8828oy2fh6xNxRYf9OUXkY4SQh6gtVLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <CAOCOHw7N9EHcxSSe6n8828oy2fh6xNxRYf9OUXkY4SQh6gtVLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The Light Pulse Generator (LPG) is a PWM-block found in a wide range =
of
> > > PMICs from Qualcomm. It can operate on fixed parameters or based on a
> > > lookup-table, altering the duty cycle over time - which provides the
> > > means for e.g. hardware assisted transitions of LED brightness.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > I'd really like to see the patch fixing the pattern interface (or
> > disabling it). I don't want to push the tree to Linus with that bug.
> >
>=20
> Please find a proposed update to lpg_pattern_set() and the documentation =
at:
> https://lore.kernel.org/linux-arm-msm/20220523233719.1496297-1-bjorn.ande=
rsson@linaro.org/T/#u

Thank you, applied.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYo07pgAKCRAw5/Bqldv6
8iXmAJwNblChtHLJRWt3wwM4IRdC6i2VcgCguObb+7WOVcqLdVVg5hWWxnuGh38=
=x0G+
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
