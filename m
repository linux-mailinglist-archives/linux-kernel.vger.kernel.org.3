Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA64A3C26
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347847AbiAaAPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:15:37 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:47567 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiAaAPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:15:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jn7r44jXLz4xRB;
        Mon, 31 Jan 2022 11:15:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643588132;
        bh=gP/30vVGuJ6w37q+stHuO2RXh0e3aoiMfRX54v/tF24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IL5nR17aeWq8Pza7m89YmriBlDmrN3JL3nIubylD/LonlFxyfrbkLrPHp5WOsy2uK
         KF+Md93bDZCs8q67RC97ZTRWt63RacaexSQqzSN1fX2aQvKSI4T/nWpgl04LBcmCre
         rdtisCdAD4v8xqZhoUqOHzOHFJzfthwqPMVDxqSp+sVVASnWvsELd1bthdUb4+R/G5
         pWLzkbGUlT8RfxZzdCcm8J3rLfhtcp8hrswj8w0rxg4il/F+OkKEqIFPQe9g6x29n0
         YBsU5Y3lca9pGgR4EGlkCbLDTfiAlQdR2xDFyEMSSIt6Zk1EPE7KQ6Vz8+6cBFiVqN
         l34Ws+1eT0oIg==
Date:   Mon, 31 Jan 2022 11:15:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Shijith Thotton <sthotton@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220131111111.36510e25@elm.ozlabs.ibm.com>
In-Reply-To: <YfceGSj+h+Iir0nU@gondor.apana.org.au>
References: <20220131093406.4200546c@canb.auug.org.au>
        <YfceGSj+h+Iir0nU@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l6AGqbHKCUx2kHz=3O.h=yZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l6AGqbHKCUx2kHz=3O.h=yZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Mon, 31 Jan 2022 10:24:09 +1100 Herbert Xu <herbert@gondor.apana.org.au>=
 wrote:
>
> On Mon, Jan 31, 2022 at 09:34:06AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the kspp tree, today's linux-next build (x86_64
> > allmodconfig) failed like this: =20
>=20
> This should be fixed if you merge the latest cryptodev tree as
> it includes the following fix:
>=20
> commit f0a26ee8e1f8bda99f1e0050292de928cec17f92
> Author: Kees Cook <keescook@chromium.org>
> Date:   Wed Jan 12 12:38:11 2022 -0800
>=20
>     crypto: octeontx2 - Avoid stack variable overflow

Are you intending to send that to Linus soon (as it fixes a commit that
was merged in v5.17-rc1)?  I would have expected to see it in the
crypto-current tree
(git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git#maste=
r)
in which case it would have been merged before the kspp tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/l6AGqbHKCUx2kHz=3O.h=yZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH3KiMACgkQAVBC80lX
0GwlJAf/Zet3A8puz/7BAX4xIgNRIRyZr5GXXj7UKkLD59GYz+Y/wRyH7p2EgYXk
qhlwmFOOjuTeGSDY0/LROHKuUJyM+uC4f4CFKSCgIXNWkCt0YEAvnDj4z5TyZhQa
97oz4fW6ar4t3xxGtSBpcRxMgmbQ6jf10WIhR4A33YvCupI5Jk3TUHr4DMvKV+nD
zo0akAnvo1Ik4Vr9WNf4p6x0SRC5NmSCwoYf5847q36E63bfnlTdVXmPv9mua32R
rcdDn1SL+5RmG8gVkDtbq0F19/I3j9JtUAwr0UBuIV+vxYcuyWzj8P3BHvIPdbaL
SxZTGUK3GM6d5uVyAqOgPfufKn6+GQ==
=6ZA3
-----END PGP SIGNATURE-----

--Sig_/l6AGqbHKCUx2kHz=3O.h=yZ--
