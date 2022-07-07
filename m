Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B740569BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiGGHhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiGGHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:36:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE98326D2;
        Thu,  7 Jul 2022 00:36:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ldp9x3mG9z4xbm;
        Thu,  7 Jul 2022 17:36:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657179366;
        bh=vJnXxPcjofl/dIJrG3s69roSNP0Kb5CB+IRWv7rORRU=;
        h=Date:From:To:Cc:Subject:From;
        b=gHtGI2X0vmZHZixH4ZZI+WRrjaGc64TL9zROPmNVrw30p9Y1UVdbPUlajGvYhwCjv
         m86XwVgMJ4whkOqsU2S8nMlVOUJk2I/6+0IbydzL8efm0z45dTGdkfmrN2HDci05iT
         I4p447ZUA8xXIQkhwVo8U3tHfUfv8cFB9HMO9el6ENsal+PFQkD6SFPpGHQLSTIrYY
         JfytQO4kmg8BtO6UqgAdN/NuZ94GSuiZhOKSLnHMzgYQuO9rIMs3MEruV/a/F+Dn1r
         Lji6kxxSEBuYjmZMFDwb5rY86N+0TtTyjasZOP62RNfdlQjfIjFH/PzmlREdL4sP0W
         7BuqNfOZOFVjA==
Date:   Thu, 7 Jul 2022 17:32:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the random tree with the powerpc tree
Message-ID: <20220707173252.5fff21f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e5AqtJECmuDQE_Wb4bb0LJU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e5AqtJECmuDQE_Wb4bb0LJU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the random tree got a conflict in:

  arch/powerpc/Kconfig

between commit:

  cea9d62b64c9 ("powerpc: Kconfig: Replace tabs with whitespaces")

from the powerpc tree and commit:

  a2ff4b7600cd ("random: remove CONFIG_ARCH_RANDOM")

from the random tree.

I fixed it up (the latter removed some lines updated by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/e5AqtJECmuDQE_Wb4bb0LJU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGjCUACgkQAVBC80lX
0Gzc1wf9Ecu/28vZactDStc5fH3/HRfTbzKkFbYUF1KJILODaEiaY2CQpOsiD9OP
gfgbJbZzimGQJXXsQef2Q8PFaZB54zryJIJz6NQmLOke380U7EFETj5uEPlhDP6i
gahF6cUCQVq9UZvwd5dq38ZmeBW+xBQ3RYv0juOwphXzJuD40a98/yuaXUGgAaRA
A+awkuyzhI+FiAPLHvyQOH5SC5fMgJYBEfJhnxBED3ciZ9xZ4V63352XhxU5cIyO
QgLfcvXiviRQKWgklcBITAcmgmisf3RYytJAkzGoJ2Lh19fUlNl9wkztgCNrqQ94
wpsHrq5MDnbLKNC6hY5OO0143Y5j0A==
=fyUJ
-----END PGP SIGNATURE-----

--Sig_/e5AqtJECmuDQE_Wb4bb0LJU--
