Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD24EA21D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiC1VA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 17:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiC1VAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:00:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EFD6C924;
        Mon, 28 Mar 2022 13:58:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KS4mY27hlz4xXV;
        Tue, 29 Mar 2022 07:58:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648501117;
        bh=K7OHwAPpQKMlSrB9YgvFTdj6aRso5YACSoHnbKYuUrM=;
        h=Date:From:To:Cc:Subject:From;
        b=AInVRvUpwraDcL0IbOamxBV9yehI+5pOdubRXNnnZl2GVNC6JTGC21WR3nbVtiuzp
         xU4hyOB24foz4LYcYCLFx+/unjSsuUNE6+krR3Ff4HMj+0GXFse9/+1niJrjY4APSP
         WiffKOXrDfuf4lEcojawYnfOB39HhNyXgReltK1HbL4haDxshWjrwjOGZo0M1NafEu
         SmEnrXDVILLQRLs+oAqFrGUNaMpMF3oe0PXz+UCXEiutvn/DaMI2GHnmo45/R8Iq4j
         DdWk4N7TL4buH2cW/2wteIUkxjHn3e7z+7sQXIKavIzqf5JsqziBkSF7yxZBtSvRDI
         zfmO0Zm+ZHRUg==
Date:   Tue, 29 Mar 2022 07:58:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the jc_docs tree
Message-ID: <20220329075836.17f78b61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tGkhwHA1AEpcvFnkW1rELlY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tGkhwHA1AEpcvFnkW1rELlY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e0ced88d6439 ("Documentation: kunit: Fix cross-referencing warnings")

Fixes tag

  Fixes: bc145b370c ("Documentation: KUnit: Added KUnit Architecture")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the futreu by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").`

--=20
Cheers,
Stephen Rothwell

--Sig_/tGkhwHA1AEpcvFnkW1rELlY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJCIXwACgkQAVBC80lX
0Gz8agf/b+jwyOyhKPDoBNJlWawcFasn6th6xLhOD2B9Rvg3i6XzwChKAKdxf/sS
trrshdNFmDQmdrDCE+8L3Scf+fUaJuXhrHxch+S7xbBj37fHOcxZHKVfIUIF1vB8
VY2AGzPBLGyCgKu5UVvOCRckjKKl/QM1fBNlrfbQ/f6ERVV2yJ6YkAhDYtdgXcax
68ataHtgUKDy7JCOZc5hIZjG42P1sm0PLRFpRDUkyPGyfSlfNw6IXGXSxyOrxQft
hBYiQX7pp1/Oh6oUCCGLDVuWnfUdNYJn5gLlH4DFsFSgtbjOcj4BDGyS/Jttl1Zo
Jifma8Wwv4pR2KC+ux/5pTPhUKofPQ==
=9j8N
-----END PGP SIGNATURE-----

--Sig_/tGkhwHA1AEpcvFnkW1rELlY--
