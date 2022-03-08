Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965A74D129D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbiCHIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345091AbiCHIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:47:35 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2DC3FDAB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=U2Ezfl4Dj+EY8O/VynpCfVQ0kSYG
        5LvuTVFICTszNJ4=; b=12Qv5+6OrJCG/dtKKpFd4UjqLWGZFABeWALj+Inf3XnO
        Es2LY1S7sG8mWhMzR11DB7QfdqR50mTye55rIzJlrqYZUjI/oB0/ZitG5RBxtCyU
        QLfFqBqXR6eACXO4MhniclUYy8O8H55bctY1aQ6WkliHOpQFp7yO3HEYGjvDAO4=
Received: (qmail 2319030 invoked from network); 8 Mar 2022 09:46:36 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Mar 2022 09:46:36 +0100
X-UD-Smtp-Session: l3s3148p1@wEbHBLHZyqofEkvD
Date:   Tue, 8 Mar 2022 09:46:35 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer
 in Manual mode
Message-ID: <YicX67PsQO0+bMTZ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
 <163282533892.34438.1878675609177525004.b4-ty@canonical.com>
 <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
 <YicSCZfl4wLUzvEJ@shikoro>
 <CAMuHMdUTgooY6SRfp4LB3tSa=-GtS0EH=BD5zo5orLTKp0hjBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mqi2ylIOFRq8KDIZ"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUTgooY6SRfp4LB3tSa=-GtS0EH=BD5zo5orLTKp0hjBg@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mqi2ylIOFRq8KDIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This is not QSPI, but HF.

Ah, okay.

> Building a new firmware for R-Car H3 ES1.0 with HF unlocked will be
> complicated, as it is not supported by upstream TF-A.

You mean QSPI here?

> Note that HF also fails to probe on R-Car M3-W and M3-N ES1.0.

Do you have this patch form Andrew in your tree:

[PATCH] memory: renesas-rpc-if: Avoid unaligned bus access for HyperFlash

Even if so, I don't think that reverting patches is the solution. As you
could see from Andrew's patch, HyperFlash was also broken before and it
just may need more fixes for Gen3 perhaps? IIRC my patches didn't break
Andrew's tests but maybe we should ask him again. Maybe Andrew has also
some more ideas, I only did QSPI.


--mqi2ylIOFRq8KDIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmInF+sACgkQFA3kzBSg
Kbb3iw/9F4+PYhxTI8YLJfM4F2MBGeOh6KaOcky2kckejSdsgOG4oQdUOrdWBvES
kSD1Qd9wydxflG51CfaV6AFZ0KgOpiK0spPwBxwfGHseY5uUYYOjIImf9QhUz5uQ
Q/1VKdMq8NYUGPRk0f5xjrvGhNOg5lO6jnjYTpSNrhdMixqm41ri0ZqlrP0gMLED
EkbSJwr2N2mt7ZWW93UVglFKpcJohCAoC3w4YQrV8YraYp2LzXmkN21s12NVReuw
BVCzRs7nimOwJY71DXqNgdwxvT2LHzJfYMypnbgvNhJ3ARGYgcVWDd8WI2u3STFu
wh/UNojxBn8rYNrnj7H8oMHM/a1X9vFAkEXI6mQMzn31DzFJ4v4qEwLtONGTdZ5u
aTBfA2G2iEOVyTwiKIO5A1C8RobCsL2E0X600UBcDhEEeKc4/p6e/tpkGjzAa4yK
iH7J4qwdipmpnY+e8BPxBtET9DzdJM1GsYuiFy3oahCuzoRRbPk7NPqzLwHY08rA
hH58By3fNGTtfuTYKH0lZjgsHEfXqfkshFSH24uzlcPoBjBZqqrt+9yQqgIFmKr9
oi9VuJqGXgZVVbCA8bWVaJ/D2WevRk2rEqL5WiWKcSxEV7TMzza8bU8f7TSgO+Wf
Kh8zE3v5Nu9dHYyXBLx15LDIs+4RW6ThnkLFK/9ebQ5eY2//cgg=
=FH/T
-----END PGP SIGNATURE-----

--mqi2ylIOFRq8KDIZ--
