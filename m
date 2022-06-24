Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC6559CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiFXOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiFXOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:52:05 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1757685796;
        Fri, 24 Jun 2022 07:46:39 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE6514000D;
        Fri, 24 Jun 2022 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656081997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QzchmONwTzPfLJQojEaSuoBpphe4iTkr7b8+dO3nG8=;
        b=bnewBukl9Kx8dcWGHh2reToQpME9dbJ2WTDzSIoKJbgl/ez3RmrL5swaTlJ+PAgYjapVCD
        8dl9Xpsnj4YLp7d0VkncTmPBttl2+t02FBBvn8blOlPlhNQC1tU5AkXjAwQb0E5iOvmVmK
        n0Z2QNJg2ptY3OCbUS9JZOiG0wjfuF1c1prK92nWkOXfCFxPzsVXx+i6S/CEW6RJlsWPZF
        7uUxECdfowVHiAzjW853yMcUjVDB4Y3LZ6a8MLEYcEjKqdraTZvww0+nntwBM/Q9CnMO1Y
        lM8QkvD0K52hNRAfHc/hyUZz+TFLT7l7zqNY8X/eW3j8rt5QHB2A2Kz0ne51tw==
Date:   Fri, 24 Jun 2022 16:46:36 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: logicvc: Fix uninitialized variable in probe
Message-ID: <YrXOTAR6koA1b8XJ@aptenodytes>
References: <Yqh6OfSiPFuVrGo4@kili>
 <YrXLrVUIavGWC4sx@aptenodytes>
 <20220624143717.tykkcznvzq5e5qz2@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SOpWuwT3AEi/BzGX"
Content-Disposition: inline
In-Reply-To: <20220624143717.tykkcznvzq5e5qz2@houat>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SOpWuwT3AEi/BzGX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 24 Jun 22, 16:37, Maxime Ripard wrote:
> Hi,
>=20
> On Fri, Jun 24, 2022 at 04:35:25PM +0200, Paul Kocialkowski wrote:
> > On Tue 14 Jun 22, 15:08, Dan Carpenter wrote:
> > > The "regmap" is supposed to be initialized to NULL but it's used
> > > without being initialized.
> > >=20
> > > Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display contro=
ller")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >=20
> > Nice catch, thanks a lot!
> >=20
> > Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> Since you have the commit rights to drm-misc, you should apply it

Absolutely, I'm on my way to doing that.

Do I need to reply to the emails with a message indicating that I merged th=
em
or is using the tool sufficient?

Thanks,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--SOpWuwT3AEi/BzGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmK1zkwACgkQ3cLmz3+f
v9HLuwf/e4518vP5Xi07cO4xiv0Ku8S4/5NWxpTr3QxM7Bh/5T5E0/SUtKN7arFt
zP3E6DCkLyXG+BRJH0NR/OE3XezGM+IBtdulv4vWhA5kVObxF5xyMhs/2Avycsnb
TGhEc+fuAP5qcod+vIF0C2mIoDo/ElgOYjWu0rWcJpsbgJiyBQOqaUhnwAMKmpOE
iDmeH5qEflfqcgfXZq5RNa+prEieNq2O5FBqjIu1PHiZ9XtmOpc6nqjWcaSwHLd1
wAI5OXDmIHtxSKkynAnBzY3TQMvWZDouksiIZLN0iE9vn3IVs3s4LNAPQ7gFdVTR
vYY47D6Q/Nso2IWUsbAcDYhiIZdNag==
=f/rj
-----END PGP SIGNATURE-----

--SOpWuwT3AEi/BzGX--
