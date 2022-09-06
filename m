Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1875ADF55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiIFGD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiIFGDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:03:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C51E5FF6E;
        Mon,  5 Sep 2022 23:03:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMFFD1PcQz4xG6;
        Tue,  6 Sep 2022 16:03:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662444225;
        bh=7b3+ngxkhtctM0vO5oZZexv2rCQUoxKySEH/G9AyXno=;
        h=Date:From:To:Cc:Subject:From;
        b=cUJcsytbLe6u4Djfoq7YbaJpqa44v4D9iOJcdZ2/vQbVBW0O1qXg8jG9jXqhH/4BS
         y7XsjkWWog8iViM7gh017dwBDBSktrJIGKXayYM+2W7StTuoqN2hS0vpJ8VE5idwHb
         I+ee9RVKS6PqknCnVO4rP9n5VkcqLde9xQ+wyIsiGzkqrTsT8QU6VEM1MFIahhPKz9
         8csu9FyNEcXAf2qu4r0XbL5gm0ZLjpADjDKj4eXWMLh1uKdbQCiKXaVQ5j5DOb+mCj
         Vcn0RWnoUzyC3n3GskS7bXbTDRTtNztGGcQnKmVWTtkyb1UypBJ9VEZxSpUf16wsPs
         mGrmabJmbpExg==
Date:   Tue, 6 Sep 2022 16:03:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Meng Li <li.meng@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: linux-next: manual merge of the kselftest tree with the pm tree
Message-ID: <20220906160342.0dbb0f5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GuM3VoUxrOVUxgH2w.hhhW8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GuM3VoUxrOVUxgH2w.hhhW8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kselftest tree got a conflict in:

  drivers/cpufreq/amd-pstate.c

between commit:

  d8bee41db83e ("cpufreq: amd-pstate: fix white-space")

from the pm tree and commit:

  8c766b24ee62 ("cpufreq: amd-pstate: Expose struct amd_cpudata")

from the kselftest tree.

I fixed it up (some of the code updated by the former has been moved,
and fixed up, by the latter) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/GuM3VoUxrOVUxgH2w.hhhW8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMW4r4ACgkQAVBC80lX
0GwaOAf/WdNEg7C5gkUzn07zstBG3E50TuVQU97LfGw2DfI70shd0tc4+aKGpg41
dBjfO+mIl4gFv48qXmvW0b8LuFTBTkz1W5Xb1UgbofUxi4kyiZ/BlY6clGE5NvG5
FdEcCANGAB2vhmvldITgYkn/gPZ9LUxhrmM7YBZrBFz2NFcapbJzjN0yqjWkjuqn
elu9IJwXbueKaAd9WjN/ahPdArctrBEzp0t8ZYhjoK/i+VFxe5u4UxZ3yG7b1chI
wWp5FcJR/XTO15BAJ2PIvsUJzif3zBt0xMxMwJZbJJEeht4yRqVXtAUokQo8/Wry
8p5sMZ4FR/pPzloumEQMhivfCXq8bw==
=ge5F
-----END PGP SIGNATURE-----

--Sig_/GuM3VoUxrOVUxgH2w.hhhW8--
