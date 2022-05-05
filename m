Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BA551BA87
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349408AbiEEIgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349333AbiEEIfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:35:46 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C325C45785;
        Thu,  5 May 2022 01:32:06 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 829D31C0BA6; Thu,  5 May 2022 10:32:05 +0200 (CEST)
Date:   Thu, 5 May 2022 10:32:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <20220505083205.GC14065@duo.ucw.cz>
References: <Yifr4etBFPu1a2Ct@hermes>
 <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
 <Yjvm1F3ZrJnyAOE6@hermes>
 <CAO-hwJLW=UT6APsKKZaRHBvKn5GOe5xg+bLQH7TGy-PH8N4yUQ@mail.gmail.com>
 <Yj0a+OwfSqDVMyTK@hermes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <Yj0a+OwfSqDVMyTK@hermes>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > While I realize that there is e.g. ratbagd which supports a great dea=
l of the
> > > HIDPP features and should allow you to control LEDs, unfortunately fo=
r my G305
> > > it does not support the LED (and as far as I remember my G403 does not
> > > work at all with it).
> > >
> > > Then I figured that actually having the LEDs in kernel would allow le=
d triggers
> > > to work with them, so you could do fancy stuff like showing disk or C=
PU activity
> > > or free physical memory... and here we are now.
> >=20
> > The one thing that concerns me with those gaming LEDs, is that there
> > is much more than just color/intensity.
> > Those LEDs have effects that you can enable (breathing, pulse, color
> > changing, etc...) and I am not sure how much you are going to be able
> > to sync with the simple LED class.
> >=20
> Sure.=20
> I actually had thought a bit about that and would say that the concept
> of breathing, pulse etc.. can be modeled quite well with hardware pattern=
s.=20

Yes please.

Note that many devices have different patterns with different
limitations; we need to somehow solve that, anyway.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnOLhQAKCRAw5/Bqldv6
8s9OAJ9hrl4bE+uCfpaKAhOOviM0yd6o7QCfSuCvj5V/MlhrNr42n7gGfM8XYCI=
=EUms
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
