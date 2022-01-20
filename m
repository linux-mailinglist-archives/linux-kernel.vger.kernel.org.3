Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC30494612
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358317AbiATDW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiATDW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:22:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF006C061574;
        Wed, 19 Jan 2022 19:22:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfSVh745lz4y3V;
        Thu, 20 Jan 2022 14:22:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642648945;
        bh=OG0rkIcDCcesSdBh9lbVJxVgPqCl19hYHy5bCxOnPMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qe4Q3tmHkAQTqIUyYxfDh/yyMgVpWVncHb9KgNViMSC9GI86UXxq+FNana2LAxbOv
         zRQFxlwHJjWpF5MHfJIQWtxIV44W+gusHE1ItHjwBzTpC0nnmtXpKLqeAea9zdqPQ5
         yn5oLvzeLI98zp/yByEyOuSaR3gwJt26qNVMv4459lNJxMbqb22zMC0Bxjn8gK9S9A
         Pu+MIat/qXTHSNkc4teNacMBfE0FdJdo9v0KnwBsOmMB8hsdGl5tprXwF7qVC3R5M3
         SDeAiUSmN2l1auDGCJc9kcDhhVTwq0sg/+bu/07XRgjdAFHe2FVkJSoPoTtqnYmCB1
         9dJQWgQptiN/A==
Date:   Thu, 20 Jan 2022 14:22:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Oskar Senft <osk@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-soc tree
Message-ID: <20220120142220.1717e755@canb.auug.org.au>
In-Reply-To: <CACPK8XfS+Gy1dhL-_uWKhW1D4++6LdWM-SdXtnsEV15OUhiK1w@mail.gmail.com>
References: <20211026103939.136dc73b@canb.auug.org.au>
        <CACPK8XfS+Gy1dhL-_uWKhW1D4++6LdWM-SdXtnsEV15OUhiK1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LRD4QWe=n7Ka/Sy4NwaWNAa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LRD4QWe=n7Ka/Sy4NwaWNAa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 26 Oct 2021 06:15:29 +0000 Joel Stanley <joel@jms.id.au> wrote:
>
> On Mon, 25 Oct 2021 at 23:39, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> >
> > After merging the arm-soc tree, today's linux-next build (htmldocs)
> > produced this warning:
> >
> > Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing:2: WARNING: =
Inline emphasis start-string without end-string.
> >
> > Introduced by commit
> >
> >   c6807970c3bc ("soc: aspeed: Add UART routing support")
> >
> > The problem is (probably) the '*'s on the previous line. =20
>=20
> Chai-Wei, are you able to send a fix for this issue?

I am still getting this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/LRD4QWe=n7Ka/Sy4NwaWNAa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHo1WwACgkQAVBC80lX
0Gyo+Qf9GsCMMFNaGAWVW2bsYgR8ZJn6rkR+g55eeV2YT0L5WnAgIsvrxM+32IGW
Sl/EdKjRRCaSLUL9SBRXZH/vkC+G/WkL1tMKe92YNop2gXHp6IhO9EAVU4a0ph/5
WLD4J55BVScBQ8lFrH/36VlhtpfPMUUd3/f/QtAxgWDMIoNRwsvQA87pjaoBusxy
2JMj5BfczOOFdDvAHTY6BpDnk9beIAiYv1cJ8hDyJKzsjBhDjF5lvUY58HPnMUVi
+PqJvtgdexOrW/UnP//ywR8R7EaW5qdZ2QBucjZqWh3g3Evib06deosVYOUK6JHY
yn1q7BNjGfgL6d0DQ+Ximxu+SVZY2g==
=ehth
-----END PGP SIGNATURE-----

--Sig_/LRD4QWe=n7Ka/Sy4NwaWNAa--
