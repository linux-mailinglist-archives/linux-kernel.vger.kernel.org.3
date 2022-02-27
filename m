Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C55F4C5F70
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 23:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiB0WeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 17:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0WeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:34:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D943434AD;
        Sun, 27 Feb 2022 14:33:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6JFD5SVTz4xNq;
        Mon, 28 Feb 2022 09:33:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646001200;
        bh=he4tqkULprG8lOp+0VNCwlfXYNq9Q5rw/8wBY7GGSSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PvR5T7QhD014wcl3zzqh3gYZdNP6vGzBG6WP7MQqwbYNezQrwouZajKdnlRxKPl/C
         EAuf1j8e7AOc+b8JODLite7RMH1RULnkwzEG3CGo/MtVUuwX+42WBQYpELccNvTeN6
         J0VVjwJTK67HrNfkSe5cSxpgEbXd1JyiqWNI/R7KSAidb1zyLie8JKb0oB238MRJTd
         Zz7FLTxLqQ361qMT8dbVGaTaKhd8RoIndY8bGD21mw8riDN5zfEg7VOTsVjt7IZo4V
         1/YLSsYWnfI0IOI1OdXwWh2ZLGC+n/DzdftDNjttmpZzeYmoU79yNuLHRkstli+9HI
         5rpA9dRb8ZcSQ==
Date:   Mon, 28 Feb 2022 09:33:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 17
Message-ID: <20220228093320.7ac8e394@canb.auug.org.au>
In-Reply-To: <Yg+hpgB4EOp9DNOA@sirena.org.uk>
References: <20220217205133.6c4d9ebb@canb.auug.org.au>
        <Yg+hpgB4EOp9DNOA@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V+pfoY+x8gRXN6_im4u1NRM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V+pfoY+x8gRXN6_im4u1NRM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, 18 Feb 2022 13:39:50 +0000 Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Feb 17, 2022 at 08:51:33PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > News: there will be no linux-next releases from Friday Feb 18 until
> > Friday Feb 25 inclusive. =20
>=20
> I'll try to provide cover from Monday as usual, I'm on holiday myself
> today so not likely to be anything today.

Thanks again for stepping up unasked.

--=20
Cheers,
Stephen Rothwell

--Sig_/V+pfoY+x8gRXN6_im4u1NRM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIb/DAACgkQAVBC80lX
0GxtAwf+KB0f6IEDa0pbZGSTK+wjVX78vCvlhZfHSKIKbR/GzNfukP4V1g+lxKOT
n6P2IyJzDmDNc/XmREhOfTVOsUPdi6qjQjBdmQBbvjp4KAVg2VNbWf6l5/pkhFAF
nLUoFCc0a/VshbD5YVgfMB8Zz3L22neUvRf/GeVit2APebbKEejNt2jtNSG9ZaST
jE+m9nrI1AJRTueB37F2CI64U+rWoVXQ45JEatc4N9/4mtUE19CP2Uw6RVAVJ4l7
k4dY+f35RTy55mHjHB6iFwYJBzk13/Wzr5cpzrKMo5403RVE2I/EUxWcrahlIMqr
guMOo9+sEUk+BgExMTy8byWB6tiW3A==
=Nq1r
-----END PGP SIGNATURE-----

--Sig_/V+pfoY+x8gRXN6_im4u1NRM--
