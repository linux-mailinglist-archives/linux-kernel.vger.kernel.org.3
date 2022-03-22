Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD464E48D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiCVWFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiCVWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:05:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FCAE0D7;
        Tue, 22 Mar 2022 15:03:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KNQVL0C9Qz4xNq;
        Wed, 23 Mar 2022 09:03:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647986619;
        bh=uPT3/zjA7Oy0eQTo6UvfmoeIQAREqPSHv4paadqKdHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/eBO9u08DlGAleiYTPJB/xRvEuZ2SYq9SvsgnUuuqYxqVKt5xyTg9WUAg98f7M3d
         iz3J82jkNoCW9lupPhJnhCVjr2hHe4Dj4Bcd6e2GyTwa7m5KJATp4mpgPETHWTJMXh
         Yu7UQcIn0rJaYXMEmRqA1rqr3GEqAXSN4/tQCymynIlIBxaQGRF8mDst0I0wDHN3Hv
         cihZ79c3OXznay6/3/gRl3SyeZ4sC8lsJXwkPEwCDvBQFg4HAa8Sd+OC3LULZNjtt0
         rLK18WnjCwbU2Mrob+9A4rcQSq+hiZ2af6zxntXZDCNQzGMuE61+wynDheOAMw0biH
         H6Aur9hAC2S9Q==
Date:   Wed, 23 Mar 2022 09:03:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the spi tree with the arm-soc tree
Message-ID: <20220323090337.58419e7f@canb.auug.org.au>
In-Reply-To: <20220301143136.7489cab5@canb.auug.org.au>
References: <20220301143136.7489cab5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/du7sLH_ou+6ZACh_AHw=f5.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/du7sLH_ou+6ZACh_AHw=f5.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 1 Mar 2022 14:31:36 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the spi tree got a conflict in:
>=20
>   arch/arm/mach-pxa/stargate2.c
>=20
> between commit:
>=20
>   28f74201e37c ("ARM: pxa: remove Intel Imote2 and Stargate 2 boards")
>=20
> from the arm-soc tree and commit:
>=20
>   31455bbda208 ("spi: pxa2xx_spi: Convert to use GPIO descriptors")
>=20
> from the spi tree.
>=20
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the arm-soc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/du7sLH_ou+6ZACh_AHw=f5.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI6R7kACgkQAVBC80lX
0GyhTAf8CX0lcs9+T4GKxnaVH8Inl5k6sMNjLP3BN7RC77XomXARi4HHHWgnzcrJ
pprUxkKvDTdcBnbDyhRxZMFtsMcR8r9/QH3OOH9kFfMl7ZouNbmdtQVB4dx38IJA
AZGeV5fACH2blrmDyPrvJMpOxbZIt6gkbiR7vQY2x5Mzw5YcimmO+7MoNXww3lyj
kU95uy2S5IuMFrp1J2PkqLMJC1khlTWxyP8XnowPiCRp+bpdMgGCGtChEuSIBIjy
GF3orasDljAEdtCl67SE9QwYU3IOnLYxkzeVgbtbqXNlW3luI6S6m0K39aXbg/+M
WN2LxiPPiytOzjunocR6rYmiFuP8og==
=p6gf
-----END PGP SIGNATURE-----

--Sig_/du7sLH_ou+6ZACh_AHw=f5.--
