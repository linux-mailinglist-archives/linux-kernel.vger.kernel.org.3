Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F840488AC9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiAIREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:04:06 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:36278 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiAIREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VQx/8dWKgJHdIyM+DgjejvGRmovrauYKZw3XJ+tiTOg=; b=U3ZxykRseMSCBYqqXn7wEm1yxA
        3XBBhPtPKFErdB7k0/kpk4uZDMcJvEUch2moxO5fUvIOCo9G+zWv9YpdiP0NAzlNzrOup5OVwIQZK
        +EH5AWTiXf8tdDa8BCAb1tNWno8UYhrlLGE9t6pa6PAN5hJodT/wu6W94kaknwFnVl8nwU8tZbsX4
        b02cf7aaLXDWkajWX99xpIGtk3oaDpmJkmJDzOsjiS6x/PZUXzx87WNVJ7Gi87Xoy3FNRlXk2W0kj
        DMaEJ7EQyDMlDnjkJ+USTdQ6qoLWWPa4s21x5+CiyWY5vw/f6wzTvQJQdyus3k9CPIElbPR4RnJFH
        voMTsARg==;
Received: from [165.90.113.117] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1n6bbu-000CTg-O6; Sun, 09 Jan 2022 18:04:02 +0100
Date:   Sun, 9 Jan 2022 16:03:51 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     melissa.srw@gmail.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/3] drm/vkms: drop "Multiple overlay planes"
 TODO
Message-ID: <20220109170333.pne3c3fbker6qoij@mail.igalia.com>
References: <20220107182809.141003-1-jose.exposito89@gmail.com>
 <20220107182809.141003-3-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgz2pd3efn6obs5k"
Content-Disposition: inline
In-Reply-To: <20220107182809.141003-3-jose.exposito89@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgz2pd3efn6obs5k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/07, Jos=E9 Exp=F3sito wrote:
> Remove the task from the TODO list.
>=20
> Signed-off-by: Jos=E9 Exp=F3sito <jose.exposito89@gmail.com>
> ---
>  Documentation/gpu/vkms.rst | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 941f0e7e5eef..9c873c3912cc 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -124,8 +124,6 @@ Add Plane Features
> =20
>  There's lots of plane features we could add support for:
> =20
> -- Multiple overlay planes. [Good to get started]
> -
Hi Jos=E9,

Thanks for your patches.
I'll apply to drm-misc-next.

Reviewed-by: Melissa Wen <mwen@igalia.com>

>  - Clearing primary plane: clear primary plane before plane composition (=
at the
>    start) for correctness of pixel blend ops. It also guarantees alpha ch=
annel
>    is cleared in the target buffer for stable crc. [Good to get started]
> --=20
> 2.25.1
>=20

--dgz2pd3efn6obs5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmHbFXcACgkQwqF3j0dL
ehz21Q/+J6ze3jt3GPGdHF9g8N902t9ONcivJdye/u9Or6r6IGkO9ZBMXY7+tv0q
eadf/DH6mWhq0bYHlWu3g0VwByJa092Izjrr/7lBYFcxrSm936VRmT8wQHL/t0Ds
1v3Dam/f29XhQ1/WIylWiSzqKMQa+r3HW47HN48j/VVW6i7kEstYvH7h/xsYMQZB
zXcNQxpX+MusRLmMLB8BLYPpSYyVdo1vvx9wsM+SPlNTEsxXvlH36E6822xdhdFo
VssQaAmpqoVX+4JmKBY5ZFyKHcayro0rBlTaSyNoWtQIajAIdY7rs/iYYnHojy8e
toHZerLL71jum3CkbZ+oB8uYSrI8rUrcxcxU+wKQpn04+xsflB+eC6gc/9c9Tmvm
AgnZH9rv034ZBOcLEHZ00F+UqJtlzviY6COFMC8lzp698yQ2NPpHjkofqs3BM5Ph
cIvANCZImNfmR0Kvu2sGX8Bexr8bVA/zg3I2ur400ncdsEObh4qhIm/MVT5R1i15
fYRS+p0qxnUnogNbx8rm9FqOVaze6sn1DTgwj/Fm6IcvBI9ob7z+Rd8+7P4DUOwN
whAuEDPMAbiDj7FaE27nHKm/O1X5oQlDi9ghfZlWUQzDRY6F9zPalvJxWZsAQx+M
pnFxJQZYAV4lypF4vtXuKjOImYn7f2yBCR9wxP5edBhNivEo8KQ=
=dx9a
-----END PGP SIGNATURE-----

--dgz2pd3efn6obs5k--
