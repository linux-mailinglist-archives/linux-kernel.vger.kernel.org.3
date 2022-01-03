Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B576483898
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiACViU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiACViT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:38:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FA7C061761;
        Mon,  3 Jan 2022 13:38:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JSTd55bSSz4xd4;
        Tue,  4 Jan 2022 08:38:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641245897;
        bh=ZsSJj+L+LP2iqVQvnLJ+2w9vpr5mBWhAgzRK9g5FZNI=;
        h=Date:From:To:Cc:Subject:From;
        b=Y2Ys/jdIlvaOd87ahmOrG58Wr0+TkIIvjxe6BF5H7xCG3ShA9P1dgAupzYiW1YOkm
         0rojGwVow3GmceKEN9mefZwSaG/hs2zUhvOx3qEhakYm262Si8uyz63JVocVL6HLwE
         7j4bKRz6hWCyZZreB4McFBSzGHHX7qH57YEtwZPWmgPjJSpo2AB/HtHP5IOa+aoXNx
         3Quf/xSb2SZMojroMv0g3ICuAYI83teYFcP2Rs61ec9o3O/Urz/QKSUyTGNJR7KGjO
         WBICjlFszvkFneyYT3q+nqRtMLw6spGLsEmZ5onN1Jvw5l7HEQhdOmjEw5e/F2E5Um
         c5qLcIwD0DmvQ==
Date:   Tue, 4 Jan 2022 08:38:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20220104083817.32b03d70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sOg.uusyq._9bRnPoFNsxaV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sOg.uusyq._9bRnPoFNsxaV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  946ab1bbf6f0 ("rcu: Use a single ->barrier_lock for all CPUs")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/sOg.uusyq._9bRnPoFNsxaV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHTbMkACgkQAVBC80lX
0Gz4awf/Q+QY7Llj/gaqL+jorP1kdRPiugi/0ua8m8XA+uOZaYELB8dLLkamfQGM
WJLQY9PvwoyjjJNg+Gbya8Uh6QpjO1U77xhfkIw0wZzNmt4p1+mlxUW5sAF9g7jv
YAaCqvZM1WOTYH1NQ9pGSrGkb/twROfa39Sv+locvZPOa7w7nd5W3ZwmkUzrLsoG
zBcNhT5ehqZw2oDxdeB1rClYD8iwvzEGmq1Vh+U7vmy5N+lptoAAL0z8jJuCMJ5c
Z6TGq6xyNaJHXppp+UP9D0IPh1lTvNnN4wVHXP8wB2zo5k5xfQHh0/sr8LtisSob
GJhjioKh8AleZc2975aYiSSrEg117w==
=50yw
-----END PGP SIGNATURE-----

--Sig_/sOg.uusyq._9bRnPoFNsxaV--
