Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C749CCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbiAZOzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:55:24 -0500
Received: from mx1.riseup.net ([198.252.153.129]:47108 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242415AbiAZOzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:55:19 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4JkRbW3PjkzF4TX;
        Wed, 26 Jan 2022 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1643208919; bh=FF68SLiqc8b5fH7Zc/D77KvbJQeyA0oyuLSsKGxo1l0=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
        b=ORnQiz/JkGZs0/0i3ikX/PDVzc/cmiPjbDpMdAAhhIbSaIhUX8QUqab2T1A1uNvl8
         XFiclKMiCDX2HMBVKswwlTkPsMCZze3NKzuiTHed8J8zZJgwTJbYlwT3VoWHytNVIy
         6b8kALNXvO10Q/un+PaAK8E0592XfcAdtBQxjbrk=
X-Riseup-User-ID: 4C4FACAA98837759C447321967370CADB64E81B0CFA66B90AE86480C2FF5498C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4JkRbT5vxqz5vkm;
        Wed, 26 Jan 2022 06:55:17 -0800 (PST)
Message-ID: <15ef80cc2ecdcc993043aa0c1d5ea88f41f9b67b.camel@riseup.net>
Subject: Re: [PATCH] HID: logitech-dj: add new lightspeed receiver id
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Lucas Zampieri <lzampier@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
In-Reply-To: <CAO-hwJ+KyV+Ks38DDF8EuT9kEc9jd9SvNn=nGyTwjkD3GOQ+RA@mail.gmail.com>
References: <20220126144400.130797-1-lzampier@redhat.com>
         <CAO-hwJ+KyV+Ks38DDF8EuT9kEc9jd9SvNn=nGyTwjkD3GOQ+RA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZtH0jJT5Y0ZBG7kBkzTc"
Date:   Wed, 26 Jan 2022 14:54:33 +0000
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZtH0jJT5Y0ZBG7kBkzTc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2022-01-26 at 15:47 +0100, Benjamin Tissoires wrote:
> On Wed, Jan 26, 2022 at 3:44 PM Lucas Zampieri <lzampier@redhat.com> wrot=
e:
> >=20
> > As of logitech lightspeed receiver fw version 04.02.B0009,
> > HIDPP_PARAM_DEVICE_INFO is being reported as 0x11.
> >=20
> > With patch "HID: logitech-dj: add support for the new lightspeed receiv=
er
> > iteration", the mouse starts to error out with:
> > =C2=A0 logitech-djreceiver: unusable device of type UNKNOWN (0x011) con=
nected on
> > =C2=A0 slot 1
> > and becomes unusable.
> >=20
> > This has been noticed on a Logitech G Pro X Superlight fw MPM 25.01.B00=
18.
>=20
> The patch looks good to me.
>=20
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>=20
> Ideally, Nestor, can you confirm this is expected and that we won't
> have any bad surprises there?
>=20
> I think we probably want this to be Cc-ed to stable once it gets
> merged (we can add the tag as we merge it).
>=20
> Cheers,
> Benjamin

This is likely a different connection type, so it should probably get its o=
wn
case statement, but let's let Nestor confirm :)

Cheers,
Filipe La=C3=ADns

--=-ZtH0jJT5Y0ZBG7kBkzTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAmHxYKkACgkQ+JPGdIFq
qV38xhAAnjELLgF7c3FigXFEzvruKFTxNgNyxMnmFmuAp0baGSbK6BaPn0b6U00x
0crpSY9q1/uxoIludufS5D1+f6r8GZnYwgghA72Y80HFOFIA1YqoZCmpKpPXMK0n
YUu8HU+yqq1NGfSITFSR5rYq3lwnR2sVU6t5e0LYhW4q96sUrBP1udoE0BoEOxWv
I6APDgGdvfy9BuC0+eJ+xUfDILc0wUuUgtYexUraKpIMxRldylYiwb9VQgTrshvU
kwVfvv2+HOY4HBlIab0K9/aYIGkJUFQPlKnnxgUpE25nE9NKnrgI+ECDupzpAYRC
87kf2JdrpqfVpXarHzSCGciQ861hSg7eQe+oDf9qwygTJu66UDqDAEE65DrA71g1
3u9PBZtowsWwr6AJgt0MmEi3doBfqcdn8qZHGliRDLiWCUszw19h9x1835FRbXsJ
iijr11o7BCs6dttmb3d2YkKIJZ1E/2p9V+WWmDBV+2OOOFMZ8S90GQXUgZAzaP0P
87qzXgBkXoy855DSxOsAaeDcp4Q9riAeFcXs75fiJzkXpq/q+XVYxechOZ9mUM2M
cHv+XmuTaSiPhZCt49RfIeFHOELnj1EOAS8TZavudoubo/HkgY9tRXvLBXNXhVFL
u2tN19cNDtJpy866157RH5Sx0tD1MhA/1NxJQYUcwgBQxt4xYI8=
=XWgf
-----END PGP SIGNATURE-----

--=-ZtH0jJT5Y0ZBG7kBkzTc--
