Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A815F504A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 03:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiDRBeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 21:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiDRBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:34:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237AB17E34
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 18:32:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KhTth5Wnzz4xLS;
        Mon, 18 Apr 2022 11:31:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650245521;
        bh=+egHNHGp0XJO62Sgw3iThmdkjV9F4Yv/Exh6VPswDIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J/eL4aAGni9Mhpb47julrrf2T9mAuoUcCjoIC00sWbo63Q9djVi794Vk0QKT8VkM2
         GQKVgrp4asJKFtJWrkZeMxwtJwXn3D08GJESZK/APCen+OMo/zhKjXvsGLRGnLlRpO
         vGC4R9v06l15FFSUdmhvtsNHhsgV5iZaM/Hucf/Msi1zu4ybGvmf3cCjeeZhyp3M7p
         6lt3OaIo8wed0MramiLVqcTIpJuxINtb4t3x2uuF5fIR2Lrslbie0/0+6x58wJVBKl
         JB/yo4l9Y7ZwGo8i1t5QJJgLEm4gfvqvFB3bzDu+4KpXwAGZ9HLBsdjKCfBQdw8M3P
         hDq9043D70aZA==
Date:   Mon, 18 Apr 2022 11:31:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: Pull request for bitmap branch
Message-ID: <20220418113153.0a302497@canb.auug.org.au>
In-Reply-To: <YlyCz0Hu+aiycuIp@yury-laptop>
References: <YlyCz0Hu+aiycuIp@yury-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zHCos833KvQySCh_sD6vplU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zHCos833KvQySCh_sD6vplU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Sun, 17 Apr 2022 14:12:47 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>
> Hi Stephen,
>=20
> Please pull the bitmap branch for the next tree. This branch is based on =
top
> of 5.18-rc2. Tested by 0-day and TCWG. By myself, built for arm64, x86_64,
> mips, ss90, sparc, arm and sh; boot-tested for arm64 and x86_64.
>=20
> Repo: https://github.com/norov/linux.git
> Branch: bitmap-for-next

Added from tomorrow.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/zHCos833KvQySCh_sD6vplU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJcv4kACgkQAVBC80lX
0GzmaAf9HmYOdHLTAmocql6ZcDak1MoFZmOWwt83nGbcgSl+i9ZPmbRJp7EcOjP5
4iyokHlj95LKInNh5gJQnKRZDGf/HUhbSJ1NOAcAjx6RXdBCi0QDi3N3xXQO+OQv
WxMw43aboI+KDbZQRVQDsdMCPxa8sMF1HkOrExQd4H8ETNNH7Vt2SzSh/zAby4kj
8x9lreG+K2ROpF0crz9K4gHEgaKs1DAkSTtl/dqDnyqBhkLDJuPWJd21YPAz1MiV
5TSJZbtb8WQe6EkKW3sCaVeOQMgxsgZ+ZGfDoLhc7Ylwh5s2bVnmw2jCw4FxHpBF
dIfOkTXMl4OWGZclBynex6Ez0jYtfw==
=hG6E
-----END PGP SIGNATURE-----

--Sig_/zHCos833KvQySCh_sD6vplU--
