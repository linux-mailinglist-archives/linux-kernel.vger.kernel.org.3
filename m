Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF850FE27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350488AbiDZNC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350476AbiDZNCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:02:06 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFAB180712;
        Tue, 26 Apr 2022 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KMQsvzJ5VuMOPuBnH+dQf/vlRQxi5wCpYK/os3PuYGs=; b=X5amV1/S6PMGm9SMCIZJLYLDnm
        yMnFdUCZ/ukuBffqkdybr3YCGePmMWZv2vSIGIzHIpebAyX2utmufI9clXjGlphf8G0iFaaDJ7Flx
        Lo2pgSk93kvzWusWONBgx02kXzkRCzeB3QBzkOjV17RpW4XmgTi49hoAuiYVcFlwip9Y7DoFjAYtv
        dWjCjFBuodSPgNvBCQ7iQUoPRxEZO5LDn8vgtUDJuf5g58MFvewO4mIubwBg5aThxEBZAUOM1E2Vp
        6twuj2brt6kmx0aS+Hne/dSfYTmC2tSqHvqO6oyNXkHyj/YVaqE5ANSbLt9FmnG7uSusMFe1z3ix4
        S9hrqQOg==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1njKmC-0004lu-8R; Tue, 26 Apr 2022 14:58:44 +0200
Date:   Tue, 26 Apr 2022 11:58:30 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Juan =?utf-8?Q?A=2E_Su=C3=A1rez?= <jasuarez@igalia.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Fix null pointer dereference of pointer perfmon
Message-ID: <20220426125749.5i5nbtlcvwvmhzfh@mail.igalia.com>
References: <20220424183512.1365683-1-colin.i.king@gmail.com>
 <890f6416ab37e40c929d95a8b4dcc8feb3dfb4d1.camel@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="du4ctwa34t2th2i2"
Content-Disposition: inline
In-Reply-To: <890f6416ab37e40c929d95a8b4dcc8feb3dfb4d1.camel@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--du4ctwa34t2th2i2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04/25, Juan A. Su=E1rez wrote:
> On Sun, 2022-04-24 at 19:35 +0100, Colin Ian King wrote:
> > In the unlikely event that pointer perfmon is null the WARN_ON return
> > path
> > occurs after the pointer has already been deferenced. Fix this by
> > only
> > dereferencing perfmon after it has been null checked.
> >=20
>=20
> Good catch!
>=20
> Reviewed-by: Juan A. Suarez <jasuarez@igalia.com>

Applied to drm-misc-next.

Thanks,

Melissa
>=20
>=20
> 	J.A.
>=20

--du4ctwa34t2th2i2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmJn7HYACgkQwqF3j0dL
ehy8tQ/+Ky3MiJludVLn1UxomYXaF+PMsaoMN6FFFM0mRo9oXAhI3iftu3gDNxwv
ukhuJncOwu6Vdrz4PYK5ZkawyU9LoQH8fgMHOw+Pm7viMAV/6aGrB9jnrwRvoYZQ
q6FPBa7rKQyvuZujQkm4+vkNr4jSJCDiwdLR2VVSPsLpCm4ttNKPPTaAx8mR9QVB
k+4XFMluWtiqkX8eU61Igi43WavCuc/OS1XaiVrS/43DLSMIx2BpsMALFygWmplo
mZ1N8aiJfO1IoQpmv0TgB/8XOC6s6VkQ7l0yekEwPto1TJrDlc3xY3He+sLAjq08
m/FF+zYJ72BCFK5pEaf5LCeQfnptVQVScfkiGkSYC2w+gPC9wmV/ZCbCZHPZ8JVp
c1cMqaNzJq0edkBoa4wnWVeftZykddN51JyjGnE3uS4wxeO70OXbgFBX97tAL3F8
XNruI80NdPpoSjT+9BcOBqpZHqRe/ODrnXTeKlITeFEstNQagknuqtVHBT2idHX7
ntJxJWQitefSx0meBsk1dvxJgCpEvoY+HEvSZT+127WjTbVnCxP8J1bvthCU/O5l
dnN5QoTzQJr67WVK2O+xCvA9e20srRnPEcnUjRK2F0+GGqbi2Dv8FM1Exh/iR56/
WOfHk5CD8+ofK4H90XLF/VjWZTE+2HzfBa7yZOGb40Xq7lEiiI4=
=WLJW
-----END PGP SIGNATURE-----

--du4ctwa34t2th2i2--
