Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5DD5714E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiGLIms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGLImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:42:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E17DA44FD;
        Tue, 12 Jul 2022 01:42:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LhvQS07Gsz4xL4;
        Tue, 12 Jul 2022 18:42:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657615360;
        bh=eZDrBrH/oDGHeRw9fIk9gVHXIN4bp5aZjGGhktdWJlQ=;
        h=Date:From:To:Cc:Subject:From;
        b=WKPFoEWu99+PSS9j97lMbwhQiqBbp3kyBAgVhJRupm8FepZ6KlEj2rSlUP05p5k4P
         r48GBRpmlx26piEDG5G3l1RBb5cb2FlaNn2etXPD3PFXcwya6DK8J7xGJq1twiCXRz
         TpQV15BF4qVHR5ORn5R8Iy/zYpjoNGEeeWdQjCAnSDjUeof+eCBfFvow/E/YgFKEom
         Rn2wN0hvEQIe3M2i7aL4ZNf/DxB/qiyJCVfA8AAe62P0zoTOEiy9cOsvt70SWHDO4T
         wtPq8OtjbkNKY5OVp5n6MRSYsQl1kbzCInxdENEltZTP15//bxAq9sna14qOAcQxEO
         yTARm0FK9qplA==
Date:   Tue, 12 Jul 2022 18:42:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: linux-next: manual merge of the mm tree with the m68k tree
Message-ID: <20220712184238.3670f277@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M.T6m48gRiu66qgjieKl5EU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M.T6m48gRiu66qgjieKl5EU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  arch/m68k/include/asm/sun3_pgtable.h

between commit:

  c2a6236024b7 ("m68k: sun3: Fix spelling mistake")

from the m68k tree and commit:

  e7911fea382d ("m68k/mm: enable ARCH_HAS_VM_GET_PAGE_PROT")

from the mm tree.

I fixed it up (the latter removed the comment that the former updated)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/M.T6m48gRiu66qgjieKl5EU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLNM/4ACgkQAVBC80lX
0Gyp7Qf/VkPqYDRZ9+KE5/VGNXMm3W0tM73slrbL1yOsnhY76zv+DMr9PAcHEYuv
p/2uv8vd8evXgt+0LAJ4EX04lqDNaSnDzoBPVi7jDEy42NRmjqZ6IWrqOyzX+Nav
5FRM7v+Upmyjoh1lLJ5/FLDP1+Zh6uI6CXX8n8OxckcE4h3ZW8SQxOzwtyLucibu
AAL87vzH/4+iteCAcmKyCoJKOVURuPx07xCTo3EKjmwwi3EumtqEfQfw/yQZ+zBn
1U9/l1fRbcQcbA+0q7kWav0xW0ov2fA58Lvb7N/IcMFSha6NWrtuJmxFXdiz46+k
yTQ5aqQYaBRDS+RXY0/VrhtRHOTNIA==
=eErR
-----END PGP SIGNATURE-----

--Sig_/M.T6m48gRiu66qgjieKl5EU--
