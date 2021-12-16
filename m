Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC38477BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhLPSnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:43:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:60973 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhLPSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:43:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFLbV1zSyz4xRC;
        Fri, 17 Dec 2021 05:43:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639680198;
        bh=dQJSvdmNGsE7TZTWfD5000m7y9ZDvqEBJYgKBseryxM=;
        h=Date:From:To:Cc:Subject:From;
        b=Ee8rUx/0ZOdG0bkBn6RBJ88wBJSupF1IJtvgBtTO2lksgnsdqGql6qBj7/TYAhAfn
         0s+qspqwp1TTU+9vtmOyUyqpJrXU7ME3C5Fvutcp5yCt/eS2OEg36Wllfrz1PjdrVU
         1sxJdOVy68DZUXL63invjY7g5RyY6Cz0OnNONaWF6Pt4qBuWaikN+KXJ5a/zVAiJjQ
         tM3gDXrGa33NaHPOud3f4RRGcHmOMNz04+/7Q1KmH9S1eUEHUDVYENcpUWOUgenQoD
         +lMnI5zj5wiOuas3Q6oUmVusRTIpzK5YBXFQ5jd4Ps5T6QnV6dT9s1wMmieCUk1N6z
         GIA+1jO3iiwhw==
Date:   Fri, 17 Dec 2021 05:43:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Dario Binacchi <dariobin@libero.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the input tree
Message-ID: <20211217054317.130ae2b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XRC89kKUq0mz4dh.wvj8L2j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XRC89kKUq0mz4dh.wvj8L2j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  61368d5cd2d2 ("Input: ti_am335x_tsc - fix STEPCONFIG setup for Z2")

Fixes tag

  Fixes: 8c896308fea ("input: ti_am335x_adc: use only FIFO0 and clean up a =
little")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  9d941aace809 ("Input: ti_am335x_tsc - set ADCREFM for X configuration")

Fixes tag

  Fixes: 1b8be32e691 ("Input: add support for TI Touchscreen controller")

has these problem(s):

  - SHA1 should be at least 12 digits long

For the future, these can be fixed by setting core.abbrev to 12 (or more)
or (for git v2.11 or later) just making sure it is not set (or set to
"auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/XRC89kKUq0mz4dh.wvj8L2j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG7iMUACgkQAVBC80lX
0GxojQgAgWiPZZGYwN0419zQvYSew6l8VnnVGELAbJni9c81W7wfOd9W0JOMznZs
z6uROA07jXThPEIrpnMv7cr60/huRuVM+7KQf8E+lm5lflDjhhBL6B96c7RdlqBR
I5B55PrlHno9MOwn/3MV5+23drhL9Gqjs7ZVBhjuDs0TQ7+qcNcMHSoyQ+YySlfp
t/bnpSv26DujyHQGvI9RrZcbj+ObgdXhJdwMRzfETut+iZJzb9DU1t9e4meFueQl
Vela5NERNQMyxMoEryCIKMnBOGzPaQEp7mDsjlWw+WD/jaiRZCpCmijDELPClTce
NjQuqf3tH/ygrrpDIJsvKroliqaeEA==
=Lm2p
-----END PGP SIGNATURE-----

--Sig_/XRC89kKUq0mz4dh.wvj8L2j--
