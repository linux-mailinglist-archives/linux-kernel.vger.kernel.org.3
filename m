Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80BB49D997
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbiA0EYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:24:25 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:35821 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiA0EYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:24:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JknY14NSPz4xcR;
        Thu, 27 Jan 2022 15:24:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643257462;
        bh=+E8fMySsBIaP1nIOcvuwmIYSTVj+pA4kualY1D6NyXI=;
        h=Date:From:To:Cc:Subject:From;
        b=A0dX2drZjMulqU0iBTQWXy1ZD9gM93g7upxGthrtg47BNJgwwasBKhZVYvZKC1bB+
         M+0Objg6oYWdWzlC0ytwpPPT491HR+fcnZ8gH7S6YPDQqM6QF/K/5hJrXiP5AWF1q4
         EKd7G+O2J3pCVYTQXfRNz7B2vb6ZpjIjkJLex0t4NSaLzeMxaLwBaJYWglRpMXPKH6
         yBhr7P7FCk4+MfxZ43d1oI2RCQWUwdbc9XAb18tlT99vuRD8+wRRC5W0FlYjansHJ4
         U6OG+iY4UD8ZXETX4qwBt9n5SJ/ZhKFvZUyaxrS5XHR7T0MQwelSILnOejS7odsCRC
         V5znF1CGuUa5g==
Date:   Thu, 27 Jan 2022 15:24:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Harinder Singh <sharinder@google.com>,
        Marco Elver <elver@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings in Linus' tree
Message-ID: <20220127152419.26770ff4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HgDHFoghLx/Y.K5HsN0Ad8b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HgDHFoghLx/Y.K5HsN0Ad8b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Building Linus' tree, today's linux-next build (htmldocs) produced these
warnings (these have been around for a while):

Documentation/dev-tools/kunit/architecture.rst:3: WARNING: Duplicate C decl=
aration, also defined at dev-tools/kunit/api/test:138.
Declaration is '.. c:struct:: kunit_case'.
Documentation/dev-tools/kunit/architecture.rst:1508: WARNING: Duplicate C d=
eclaration, also defined at dev-tools/kunit/api/test:1508.
Declaration is '.. c:macro:: KUNIT_ARRAY_PARAM'.

Introduced by commit

  bc145b370c11 ("Documentation: KUnit: Added KUnit Architecture")

--=20
Cheers,
Stephen Rothwell

--Sig_/HgDHFoghLx/Y.K5HsN0Ad8b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHyHnMACgkQAVBC80lX
0GztNAgAoj9LRizv3U3cZsuQ0zMGR1QMYWxupod8lVMGve/6aUPPzgZuJokE6668
BkLivnxBxmtFmXk+wXhHa7LMjrxMM0wiXpWZCSWrvDgk3JfeI3uKeF3t4WNIwBvY
jjwVGzNYwglOYABnKOtIkiMYSEh8Mr/sOm5/ayMaqIts1j5zTUdfv+rEBaZblkc9
CGEwcQGqu8lQnAJxKEtb/a/FC45+Q8R/gKlPOFZNY+x5Tdx7mDRBTtkmcy0HQYlC
0WktvFFPS0b0xV6RCWQ1GgX6fpfak6Ut6ZxvvQIGmOpt0n/cipuOKqLLFwqZRmDr
4gDxPTxxmhSjJkq+t6tpdMOWbajD3A==
=OFlI
-----END PGP SIGNATURE-----

--Sig_/HgDHFoghLx/Y.K5HsN0Ad8b--
