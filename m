Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75FA463DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245509AbhK3SjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:39:05 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:46474 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244668AbhK3SjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:39:05 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AE0C51C0B7C; Tue, 30 Nov 2021 19:35:42 +0100 (CET)
Date:   Tue, 30 Nov 2021 19:35:41 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sven Schuchmann <schuchmann@schleissheimer.de>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: lp50xx: remove unused variable
Message-ID: <20211130183541.GB30113@duo.ucw.cz>
References: <20211126152847.11740-1-schuchmann@schleissheimer.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20211126152847.11740-1-schuchmann@schleissheimer.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2021-11-26 16:28:46, Sven Schuchmann wrote:
> During code review this unused variable was found. Remove it.
>=20
> Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>

Thanks, applied.
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYaZu/QAKCRAw5/Bqldv6
8jZjAKCvMx6rCXuZNdzeOLWhj6khbkU3twCfYF42bOExWODPgtapA/Q7Lf0jxXY=
=rWcM
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
