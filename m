Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75576525BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377652AbiEMHFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377642AbiEMHFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:05:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F3029BC69;
        Fri, 13 May 2022 00:05:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L005g0TgLz4xXS;
        Fri, 13 May 2022 17:05:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652425511;
        bh=QPXJXARjzowlwjloa7cLBmL2BxDXx5NSOpyY7VT3aR4=;
        h=Date:From:To:Cc:Subject:From;
        b=r/euw8feskX7WEXQ7HebdE07VTyyMahPgAPCQSkXoKLyxKMk9pA4woyLoGosEe3rD
         UhjWjMHPwLtOBX0AaWxjgvLG3JPF8oi6tRR92ti7bKCHNcfqDdbI6O2cvjGp9S9rPA
         uPbYj5ZT/KjIwBdiFPngTQZk4Ke05rh3B/+RDPW2sQKwGzl+7yeDZB3B+P7ZlVhCWl
         UZvTWG9PV/aCsVK5iuPdBf3gejlHYf5FD8URpYhpPZR84DZy+5xtioqRzLwPSVbMjm
         Yndu86eUhTfS5N9EHsCDTme7XXeWLTMw3gJi33NisBn3dw6jv2CIawj/YrOVrt4q0V
         SvNfKZ0Tq5EKw==
Date:   Fri, 13 May 2022 17:05:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm-stable tree
Message-ID: <20220513170510.1041705a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HIZ86R_nxQYhjvb5kQbuVM1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HIZ86R_nxQYhjvb5kQbuVM1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  de4c279a0ffd ("Revert "mm/madvise: free hwpoison and swapin error entry i=
n madvise_free_pte_range"")

is missing a Signed-off-by from their author and committer.

Reverts are commits too and should have reasonable commit messages.

--=20
Cheers,
Stephen Rothwell

--Sig_/HIZ86R_nxQYhjvb5kQbuVM1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ+AyYACgkQAVBC80lX
0GyXcAf+PRx5kdm6RnDZuL4O3lnuCov2ovsrZFYU04xDPzMfyHn2T4y7nl72HNTB
SZhll4zy7JA/hXsR1NT0ov7DyOKdCXdErZFcRBPzqPJoOwO2dwxadohYfQh8EDJM
+KItYRJ2x1IB3dAVMb21Dr9OinanyiZ5yywytHgQFSdr/gSZBp6Nrtn6RP/LwTVf
ZSm45YCYurfGV2dwGpG3cc7pSGDSWfSwCaNQSsIAnOqImoBLhgJ13Gz5hxF01jGx
Y9P2LoP4heu0X7xne4uDwUJRaOG5IUOOorjYGPsFAsVMyS1uuGwEv2aLlMeIS153
E6HF3160XDLKBwJlayuNi8MbPofCNw==
=x/2w
-----END PGP SIGNATURE-----

--Sig_/HIZ86R_nxQYhjvb5kQbuVM1--
