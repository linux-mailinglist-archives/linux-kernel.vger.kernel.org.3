Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56ABE478113
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhLQAHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:07:25 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:56889 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLQAHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:07:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFTnP3GSkz4xdH;
        Fri, 17 Dec 2021 11:07:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639699642;
        bh=SXpDAUuTPz/50alIAYRDF3NrWV0acgZ4F6yu/uAsW4s=;
        h=Date:From:To:Cc:Subject:From;
        b=JOwyf2+EIfLp2NWEmZmAbdZEZ5zwMk7EHkCgydtQFOo0cARmaXHMbIor5ISYoN0bl
         FVyeXP0junobNVRHUkBhVOk3uxJVCghkJS9PVJe1SzrJRf6M/FgMOuVyNMKOoRhKpi
         oP/OtEmdVs8QnCLGnqOOESzo1Jknm0hpuMn2i/+BA2vO2VUp9egifzzfd6BLtIy34+
         7HoFKKn0PRGC5L9CYgRXqZUfpuh3wEe8eJjK14Ln3ACU2RLFPpknE02euMEYWSuXEW
         wVqgzSMMlpKcqSiZ9jertfJbj1NRffqUKVWvLdUJApCRYztsACAzdpmRAl9yytElAr
         8fznpSe+z10RA==
Date:   Fri, 17 Dec 2021 11:07:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the fscache tree with the asm-generic
 tree
Message-ID: <20211217110720.21e8020b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cqtiIWZmudd0HzqPAb6Me5T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cqtiIWZmudd0HzqPAb6Me5T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fscache tree got a conflict in:

  Documentation/filesystems/caching/fscache.rst

between commits:

  d881c06e0890 ("Documentation, arch: Remove leftovers from fscache/cachefi=
les histograms")
  5c61c384095a ("Documentation, arch, fs: Remove leftovers from fscache obj=
ect list")

from the asm-generic tree and commit:

  ac1c0f96f4c0 ("fscache: Rewrite documentation")

from the fscache tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/cqtiIWZmudd0HzqPAb6Me5T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG71LgACgkQAVBC80lX
0GyBNgf7BWBZI4SWWBdxvr7kPL/ST0YPWBNlmHj8w5+HjrI+J/GX0EfNFL6hutDl
N/t3qYPZ7kYcgRbYeWoOeDohHzSYlTT4NDT2JtVoqoi2TRLEmZ78cToUbYZXxTzB
PwNSn3+n7DVQq516qZBkfDeGAUyHxcY5/zzIKNRGqXpuEU4HVW9pUlYojpRXOJRM
7U4i5MVJAjt1TpgrHhCmLc7gCwdPL+q65qDpv8Dj/7XvoBcl9xorHiqUpFxqpKMP
NLagJO3fd96f8gOfNrx/fGf/bnB5g53wmS5Su8kH+hTN65Y6jpVl4cJnSwfhUHG9
FVDCmX63co+IDIibygZVVUXz4Hy38g==
=j/CT
-----END PGP SIGNATURE-----

--Sig_/cqtiIWZmudd0HzqPAb6Me5T--
