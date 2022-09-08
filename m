Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88025B10C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIHAG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIHAGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:06:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9001A2239;
        Wed,  7 Sep 2022 17:06:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MNKDS31WLz4xGG;
        Thu,  8 Sep 2022 10:06:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662595608;
        bh=3EUyxahfukD0ViHoh9sN+PpgdhRGr2/m7jhYBZd76tc=;
        h=Date:From:To:Cc:Subject:From;
        b=nEjLVyzDRkHldjp0uV0o7tfh+QtUBHoFUlqa3B+b76J4pFdUlbz2UpRri/G1UFtvl
         a8nqxHEGL7vDqFpSWMR57P5wxcL7lWyQpGWxqUL5wrrWfEEls5a+aRHTNPUczac22A
         J8ILQ81rGmIQb+k7ftW8FZwzEq6Y6NcOoexr8vwR1ns6lWs///NaS1HFr8JA1tmr1B
         C6so9GeWRikfYw3GpWMGAFmYKNm34fsEOL5w2KRtE4N1UUwSXh4r/gy5WwWJ2j4qaj
         puza9tV5Eqstr+KxqF421+EP2PmkHtWSDf0pzpXSKLW3tpU4FM1VAPiJBUFdx9iNfY
         Bp84Amrq5A4Gg==
Date:   Thu, 8 Sep 2022 10:06:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220908100646.4cb5f02e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g+HYsHO+bsWipx8H4+U4E3F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g+HYsHO+bsWipx8H4+U4E3F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: vmlinux.a: member arch/powerpc/kernel/prom_init_check in archive is not=
 an object
make[2]: *** [scripts/Makefile.vmlinux_o:61: vmlinux.o] Error 1
make[1]: *** [Makefile:1166: vmlinux.o] Error 2
make: *** [Makefile:222: __sub-make] Error 2
Command exited with non-zero status 2

I don't know what caused this.

I have used the kbuild tree from next-20220907 with the top 4 commits
reverted again.

--=20
Cheers,
Stephen Rothwell

--Sig_/g+HYsHO+bsWipx8H4+U4E3F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMZMhYACgkQAVBC80lX
0GzZnAf9FJq38wWf7bd7VV49TQ4nMc8sDvJxz//Lm3on87kLLYb9mjMAQJB6ot1E
fxJZRAWmZWAdiOilSlFDVcIfktPNPxdJQEQqEui1s/BOorNGuLXbplOgx2b1QrVZ
F8yXA7+DRv/Pz5gLxhPdGmdvtyS6LPSvEP9Lo8ETtVc5BMPOgVFQaXgNiddRbixg
Yu7qZ9Joi5VXP68K760PQxLmOMAhXit8iML4g6f2Sxq/D2SJfrhs5Z2S3KQ1t7Bl
9TQKtmeHMi5DWJrvgEKdJcRT8qDXsbw9eBToh1xE7apYyzjT7/nC/5TIUyw0xlK9
uSk38KpZj2bFg14/3p7rdIUIkJ7VwQ==
=rVsr
-----END PGP SIGNATURE-----

--Sig_/g+HYsHO+bsWipx8H4+U4E3F--
