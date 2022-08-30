Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0935A5C55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiH3HBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiH3HA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:00:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633AA7C1D0;
        Tue, 30 Aug 2022 00:00:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MGyrQ1grPz4x2c;
        Tue, 30 Aug 2022 17:00:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661842854;
        bh=9mZtjpA0SGCCEg4H6scrULBQ9tRBmMbXbNnu32jsDXE=;
        h=Date:From:To:Cc:Subject:From;
        b=mXawJynN3GXrbCsliLj3cKV5BChnlmaBJ8WVSFz3JLGpZcXEFQoe5hZoL43KZLffA
         39D8bi0LfH1eWLQDFZHXwoaisAE8LFRQtOjIBn20gRlvO8kNW+wZMZiVPkGnRJE3et
         ZJvtgRCLFTjRwJBaWJKTJQb9rv+aUmDq2gOqvheTpOrGNCIApiW29Rm4dMr/RSEpBN
         vEJqByUNzgG0nm9kIMKCFhsPJKj1I6elj6ZTnYJI/KZ9yT9hSCtDz/lZ8obDFAMyfg
         ZDc9nMRJwRR7tAarYZYu4gmd6z+6PtTtZLihSRKCrbfAhml9msKG5XEuJxwf9AXg8L
         8QRNyCMnp1+cg==
Date:   Tue, 30 Aug 2022 17:00:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm tree with the kspp tree
Message-ID: <20220830170051.6c190838@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PpYYce=bsu7zJdF2u/UBfKN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PpYYce=bsu7zJdF2u/UBfKN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  lib/Makefile

between commit:

  5e3ad11bfc5a ("testing/selftests: Add tests for the is_signed_type() macr=
o")

from the kspp tree and commit:

  7a2791666971 ("testing/selftests: add tests for the is_signed_type() macr=
o")

from the mm tree.

I fixed it up (I dropped the latter commit by using the former version
of this file and deleting lib/is_signed_type_test.c) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/PpYYce=bsu7zJdF2u/UBfKN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMNtaMACgkQAVBC80lX
0GxpSgf/XMb+t1osWU0qao713+y+t2SQWDAacrGsvFHcn6F8Or+iroXwwhYyjb+0
q4k2X+o0Dxj6Ta+FqjHFpkmrluEMCSzvKShSYdeiWxNtQZTP6k9HIYIZCdiUs3Z/
E+p7wc9xXEoGXw/DaLR8KR3/rekeNpVJxCayzmVXZPiscf0mrS/simnIznqAcjIx
0U9bGoIyJRAFiTPzCAq98AdlaLn9I3cqTOasXknEpPoR7owj5rr9B/BIDsxnXfJ6
4RA9+gdlHas1ZKmA+vi7cBJWK9gvysaZ8B5aFnMrAYQD2eOclQXP0Wkx3i8azTj3
48Cr5vGTvorzqGPRhnNNVJAutC+21g==
=hKGM
-----END PGP SIGNATURE-----

--Sig_/PpYYce=bsu7zJdF2u/UBfKN--
