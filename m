Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A78559D53
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiFXP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiFXP00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:26:26 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E54F460
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:26:24 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0D88920000F;
        Fri, 24 Jun 2022 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656084383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YqccQuVHkgnWh0eSwnz88UjG/HFD+0dcCnvV17bKt1w=;
        b=d3Rlh0cI+2GQ6bVcd1+bteHr0yYZ75JcUAtKo6t1Swu8K6t/tr4IZNrLa2CAk/9/lPFPj3
        z+T17m+7qVUGkwX3H+q/GCTeEvgiUqQpi8sW0nDy4xMOs3s9cKLR3JY+2g16DPT8uSu+b+
        lhLQw7CMfKzo7V+L8ScgRQBsS/YYBusqLsLpHOlDxL3C/3tqIA2DNna5W8CViewSL9F/L1
        U4b7Xh+6AYo3gax2OlTJABVe0kZGo/s1uYLSyF0PVGSE8MDvoLgWSyjaZ4kwUjkbFSPgl5
        UP92RV/BtKWe+rSL/nITrM6Us3pTGr0dt2/6TiPT4oQNaoCUL3raQt37jv6wAQ==
Date:   Fri, 24 Jun 2022 17:26:21 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] drm: Remove unnecessary print function dev_err()
Message-ID: <YrXXnfFLrYFXInvJ@aptenodytes>
References: <20220613012658.85814-1-yang.lee@linux.alibaba.com>
 <YrXRplhnlUZ2KV3V@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j1BiNMI1wuOdzFcL"
Content-Disposition: inline
In-Reply-To: <YrXRplhnlUZ2KV3V@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j1BiNMI1wuOdzFcL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 24 Jun 22, 17:00, Paul Kocialkowski wrote:
> Hi Yang,
>=20
> On Mon 13 Jun 22, 09:26, Yang Li wrote:
> > The print function dev_err() is redundant because platform_get_irq()
> > already prints an error.
> >=20
> > Eliminate the follow coccicheck warning:
> > ./drivers/gpu/drm/logicvc/logicvc_drm.c:352:2-9: line 352 is redundant
> > because platform_get_irq() already prints an error
> >=20
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>=20
> Thanks for the patch!
>=20
> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Pushed to drm-misc-next, thanks!

Paul

> > ---
> >  drivers/gpu/drm/logicvc/logicvc_drm.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/lo=
gicvc/logicvc_drm.c
> > index df1805cf0f95..437b3011ae1e 100644
> > --- a/drivers/gpu/drm/logicvc/logicvc_drm.c
> > +++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
> > @@ -349,7 +349,6 @@ static int logicvc_drm_probe(struct platform_device=
 *pdev)
> > =20
> >  	irq =3D platform_get_irq(pdev, 0);
> >  	if (irq < 0) {
> > -		dev_err(dev, "Failed to get IRQ\n");
> >  		ret =3D -ENODEV;
> >  		goto error_reserved_mem;
> >  	}
> > --=20
> > 2.20.1.7.g153144c
> >=20
>=20
> --=20
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com



--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--j1BiNMI1wuOdzFcL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmK1150ACgkQ3cLmz3+f
v9FYQQf3XfVBAjvqS/RDgAVJLtAli6neGvkwnOPb6qRfD97qH1SAUsOHmE0arjmr
gRLKR9SPSTTf+1w78Uyp8su3XXvlOqJ/axvc2ZnrHdrPan0Bwa3vRI60mlQPtI+a
7JedVfCH5c2vXyHnO+vKYNI7s1kZYj+pbHMU6jKqlYNE8VHlarWtwVzsEVNBNab5
Ykn2juFT5BDr3PLlp3bYOpYl1SPuBCgHpTjgK+w98crusO080x79niQ71WOdWlt2
iaRf1cTQbmo2m9tNV3w0e2hKSDbZa5gjeUqeC8fJubR3pKj7p36YsU8sYnK6PCkD
BHOGlJl3S3Y+i4qLnNOG6GMDd6kX
=OYMV
-----END PGP SIGNATURE-----

--j1BiNMI1wuOdzFcL--
