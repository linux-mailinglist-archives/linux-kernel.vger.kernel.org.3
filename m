Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E8E542616
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443047AbiFHCBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1840559AbiFHAFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:05:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3102C2FFD8;
        Tue,  7 Jun 2022 16:53:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LHnHt1kmlz4xD0;
        Wed,  8 Jun 2022 09:53:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654646027;
        bh=CMoIYQyB2XCl8XOq/AHSIFF64iEb3UrjYX3oNA8db2g=;
        h=Date:From:To:Cc:Subject:From;
        b=q3L3251TRZfjSMWWSxhL3d3KStRWQsN0+2GHtWdbGiuLe8vd6AY9tRyqIHtPDWjsM
         wdsDgu5TUQpanKc5oFqt+zOnmk+nV8FZs1Df/iJtyHFddzaMfy6VD6FvvjRrD8pjQS
         WK0Vy1Hd6XGhfiCT0m5XYb0zjJkgE75cUOXeBPKj4VPjjQNGN+L5YOYqWMqngagYwL
         HSU+frgduNoDCdaY8Dtf5hKTL+1r/FfkJmprfLAdjfUNNGIi/EbJkwkxNsUxRn+9MG
         mqMJ1+/fQZThvVFHkm4MSIUyYPm5w3GJaHHB5AD0VmoXQkwb8WwzbdeGBNz4APSiW+
         7Ll313gochhkA==
Date:   Wed, 8 Jun 2022 09:53:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with Linus' tree
Message-ID: <20220608095343.7196dedf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G6Mo72/2g.zbh2P=VlJh1mA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G6Mo72/2g.zbh2P=VlJh1mA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_dmc_regs.h

between commit:

  2518f226c60d ("Merge tag 'drm-next-2022-05-25' of git://anongit.freedeskt=
op.org/drm/drm")

from Linus' tree and commit:

  21c47196aec3 ("drm/i915/dmc: Add MMIO range restrictions")

from the drm-intel tree.

I fixed it up (these were only white space differences, so I just used
the version from Linus' tree) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/G6Mo72/2g.zbh2P=VlJh1mA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKf5QcACgkQAVBC80lX
0Gye+ggAjx6eChYTEh0PeTJ+FoHjOkUp57S6hFI5UMhIStDBHq7bzjz9FYM7KUb9
btdnRs2IQAdr53YBtKSHxV7PWQmAEAKn5fH/UQSD5ahP836KsEm/gZvxhu/Ntz72
YEw8eA34NvycenM3EaUSUf2k2onmqzZNh1YgmPC9j+vRyH6fvOEwyZIq1oAn95ES
pgt+5CcFWswo5qkYpPHeHx7rRK+A/TZvMjGxYiyccQOkj9XebeH4vjomelrrB5sU
CCOPyEIsy45pdC7EO2Az1wXiWrWKuVRbU+QqTBAvOGcfhju1JrCMJt0qFvFt/jeB
7EV200qI6Kkzrl4o852GyvXMHnQNtA==
=l25w
-----END PGP SIGNATURE-----

--Sig_/G6Mo72/2g.zbh2P=VlJh1mA--
