Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0D483893
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiACVhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:37:03 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:57913 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiACVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:37:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JSTbc3G1sz4xd4;
        Tue,  4 Jan 2022 08:36:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641245821;
        bh=Ew0DRF3DQ9T6f/UJrSA6YoVIjjAQzMBiM+sIbOtTg4c=;
        h=Date:From:To:Cc:Subject:From;
        b=oBi5PWAb5AxDsSbnoGG+O7vDfiaI6osQX4tkz0o+k+uVRe9aQ58lZAazXdbcDnuph
         fTbVouHyHwWLSmL/QhJhQYsuLSZBKlbuWUd0zBPMXY1cIazieiW727Lp6qbMdUmbRL
         fk11X8qyKSR/8S/lLY8xV45mnjEclD7bbBgqciGBgLs55JusIZ4IiCXpKT7fLp8JpQ
         o5MD7RiuD3KmijI6zrqJ+Nl5cnhZ1Gl3Sg4V1AVH7fP0CI/h4RoZzYkyuNTE0bYF8d
         R+yJWz78vfLiKolX85o/2FtjvL3kajV1ZZcfFVFGyTcZ4asto8nFp5z57wxHHGUJ32
         r35Immy9nMt4g==
Date:   Tue, 4 Jan 2022 08:36:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Andrej Picej <andrej.picej@norik.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tags need some work in the watchdog tree
Message-ID: <20220104083659.4e5f2754@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EPoGvTglO2z4YW5mSm5hc3P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EPoGvTglO2z4YW5mSm5hc3P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  02d04e694fa3 ("watchdog: s3c2410: Fix getting the optional clock")

Fixes tag

  Fixes: a4f3dc8d5fbc ("watchdog: s3c2410: Support separate source clock")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: e249d01b5e8b ("watchdog: s3c2410: Support separate source clock")

In commit

  ce3401c72f01 ("watchdog: da9063: Add hard dependency on I2C")

Fixes tag

  Fixes: 5ea29919c294 ("watchdog: da9063: use atomic safe i2c transfer in r=
eset handler")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 968011a291f3 ("watchdog: da9063: use atomic safe i2c transfer in res=
et handler")

--=20
Cheers,
Stephen Rothwell

--Sig_/EPoGvTglO2z4YW5mSm5hc3P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHTbHsACgkQAVBC80lX
0GzzKQgAgQgGy08Ay2ps66S/OmAju4bRm7n5CecYyeMUu/ZbAM5T4U1GucNJjz6P
3HP+C7o4M7AVbZwWJyfi4gUOmVi1ANhOUp/tbZJL8xsM6CwrMzZYgIEtH31cNrRA
N2ZeY3624JGJtvitRNq+vjMZ0QrMD27SX+7Ese9R17xbyPg2FxvhKcvj4NNrM3LS
ByXz/X21YeTf/OmEviwnT6E2fX1harrhK6J13OR+7t8LnHfGpBLeNqPllxUDj7qO
rui978U8q0yRhPKHiiRv542oe6HFhDQ0AZW3qOCHOEMXAJjzZbDzaW65vFFqOe8d
bNueTv/1yPiNVpxtWPuKDHyAhMkkdg==
=Vc7Q
-----END PGP SIGNATURE-----

--Sig_/EPoGvTglO2z4YW5mSm5hc3P--
