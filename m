Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56E577DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiGRIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiGRInZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:43:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D08192A7;
        Mon, 18 Jul 2022 01:43:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lmb8R6wRlz4xQt;
        Mon, 18 Jul 2022 18:43:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658133801;
        bh=aXwcZQse9JvHSKXL22foLYLTQbulhGvhqdMm2a2O3Bg=;
        h=Date:From:To:Cc:Subject:From;
        b=MqMyyMPiCO+4WBCLL3ucYNF7VXE+y2mhXmc372hIEC6CY6EzInpXg4ApFYEr3fuB3
         8X6XcCHvecqCuX1vM8geFZ05FX/oWe7rMKtJPXZIRnWPb+UPRp+cQ0m3zvZEz0vXpC
         Xd6fZklFN09iU0lfylyXWdC7PdhMmitGD2wIk0yOJXXY6N+ky99ent9GeL1+YFaHaR
         OStlXZePqpIqCzQj1iO2hrnmafJw7zyumugYLnX1dM4NNDKHpZoL1kRKA3fwzOJ35K
         HogMJdBAsej2HFE3D0NS4VSTZ1PhjgDNKiiR9h67515oPw1Bv9nqvfyDufzprnTCt1
         CLEe1NW2aGmKA==
Date:   Mon, 18 Jul 2022 18:43:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the random tree with the arm64 tree
Message-ID: <20220718184318.25d75848@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Exd8vzD_W6MX5oj.bTwiiWK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Exd8vzD_W6MX5oj.bTwiiWK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the random tree got a conflict in:

  arch/arm64/kernel/kaslr.c

between commit:

  fc5a89f75d2a ("arm64: kaslr: defer initialization to initcall where permi=
tted")

from the arm64 tree and commit:

  29abd7758699 ("random: handle archrandom in plural words")

from the random tree.

I fixed it up (the former has removed tha call to
arch_get_random_seed_words_early() that is updated in the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Exd8vzD_W6MX5oj.bTwiiWK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLVHSYACgkQAVBC80lX
0Gyx+Af/c+NsnChpMNGKzfd2hlBsaJ/+6UIos2H9L4za1TGLwI2dAQkYqBe5GMNP
pW4HibdyneuIAYVD2X7xD9+bvgpZGdslLSXQQHnhepREAa8wenlRaZbgMjCbEdYm
gj0NE3gkJ6gaXVd8c73vrQ5kL8xGRXNfcIGeiuH/W1qa5IVtIWo1tY4RR+oUUd94
+oExrvP64j59MX1CzlUXzi+vqwOgu13/JMVKW/cWOwlyRElxmrIYcrnQ5xHkvF3w
Ye+KzyVMagjTAgTvl/saIcAWvUjQ1hsFvUMbDLwFcWQTpfKMsVYhxlDc50twdr7p
i4hsUpnMikEgL0dTO5N7u0rpXdzagw==
=ngz3
-----END PGP SIGNATURE-----

--Sig_/Exd8vzD_W6MX5oj.bTwiiWK--
