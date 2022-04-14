Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B46501CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346679AbiDNVBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbiDNVBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:01:41 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8E3ECC70
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gXaGmOOsB9TGzqUB1QimCayH4bdRjVTZzE3nk7Y91u4=; b=mWmv74Vv0CmWoCcAqKhK+rJDdn
        TwLeWuS5l0Kf6mCLiWcZD90YM48bvXd8abATpVborWSIN+12/iieJYNfS3ivp5YEaBXbZHJAgfJHt
        ykpQyBmBVAua+XjyWVZmyQwiaIsb9GPlZvDZXdrR/MHbFAYCsrLtIvkDwrj08ByW70+DWtDFOJQJT
        QSrYHzvZw8qwh+4WGtd1OaOVorKjSMSf55Zn4drvXnOY6ECo4glHKQ4RTT6/Mazml/3hzUJf6T9tO
        ahFWWPvArkx4yZ7hvAgb8VRKucNiGVltdNnJIDhHyZJdM5sLEVS8Yh6JG+nikSCXJC2VXHdoR3g/p
        5i7lnVfg==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nf6YU-0000ac-Gw; Thu, 14 Apr 2022 22:59:06 +0200
Date:   Thu, 14 Apr 2022 19:58:51 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Subject: Re: [PATCH 1/1] drm/vkms: check plane_composer->map[0] before using
 it
Message-ID: <20220414205802.f4nkh43por2ohnqo@mail.igalia.com>
References: <20220411233801.36297-1-tales.aparecida@gmail.com>
 <20220411233801.36297-2-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wmzy4nunyg3yxory"
Content-Disposition: inline
In-Reply-To: <20220411233801.36297-2-tales.aparecida@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wmzy4nunyg3yxory
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04/11, Tales Lelo da Aparecida wrote:
> Fix a copypasta error, which resulted in checking repeatedly if the
> primary_composer->map[0] was null, instead of checking each
> plane_composer while composing planes.
>=20
> Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>

Hi Tales,

Nice catch!

I suggest you detail this issue with more information. The caller of
compose_plane() already checks primary_composer->map. In constrast,
plane_composer->map is never verified here before handling.
Also, add the 'Fixes' tag pointing to the commit that introduced this
issue.

Can you send a next version addressing these suggestions and already
adding Andre's reviewed-by tag?

Thanks for your patch.

Melissa

> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index c6a1036bf2ea..b47ac170108c 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -157,7 +157,7 @@ static void compose_plane(struct vkms_composer *prima=
ry_composer,
>  	void *vaddr;
>  	void (*pixel_blend)(const u8 *p_src, u8 *p_dst);
> =20
> -	if (WARN_ON(iosys_map_is_null(&primary_composer->map[0])))
> +	if (WARN_ON(iosys_map_is_null(&plane_composer->map[0])))
>  		return;
> =20
>  	vaddr =3D plane_composer->map[0].vaddr;
> --=20
> 2.35.1
>=20

--wmzy4nunyg3yxory
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmJYiwoACgkQwqF3j0dL
ehxEIxAApmAQvIXxU9r0qhgFR0GUE1pY1DkBT0gjMowhRzC2fMlb4ifORJHu+R4k
ibQZKK/gqC+0ktD+q7vAur5l5zuc2T/4TlLbobxH8utVVpjPiVvGy0dMkEwQFmP8
PqQStNt367sai+DY7wZc5XfYwuv39ilOdr9HUV5Q9iwuqRrL8r2gun6ugBw4lzDb
mTpmO+iWVT5KhMJbcmsa2XHUEQrIkqZN7vm73XBgbw40ebvBhJe1YVLBqIwrGkvh
CGughFZfmncvz17yURvneI0bO8Lzek1AUBm5KKHdyFT4ZCtKKKEpUzMlr2LHqqnc
EPqdtCXDogQt0SL+DMCxviy4tP+flzOJVsKOKGei6/U6YnTGgwVCaQfHL3iVI3U/
o/Fu5eoczG7tKMt8ZL9JJ+aDa03rf0oWQsliQiqde3fCuP4cLyRlPMni20VLUwHd
iJMK6tdM5VjQOUck3+WRe29LcVi2dKEzJyL1WeiBBHgV6EonBq1M9g5Nm6rZWjvG
4HPNtDR/oa9dLRy77SWQzXUTng6oZgVtK6LGkDR+NCh7f38b7uDmpk34qE/6Z9Ao
mN5w0TVcV05IeUh9RIIeuC2C7/HWSIArMwP3L4SLmERte9YWYCkplDeDoEHlONmX
zVe6DB5uEcizY0ax67QB9Azya60lExPHHnK83gPNdQweaam5+0A=
=7LhH
-----END PGP SIGNATURE-----

--wmzy4nunyg3yxory--
