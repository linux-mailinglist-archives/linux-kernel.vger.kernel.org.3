Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69C49D9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiA0EbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbiA0Ea7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:30:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46819C06161C;
        Wed, 26 Jan 2022 20:30:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jknhc3wDRz4xcN;
        Thu, 27 Jan 2022 15:30:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643257857;
        bh=argfXXrnQQpLmM2er9CWk6DYYJ2z8ndK/aTRi6qWuSE=;
        h=Date:From:To:Cc:Subject:From;
        b=dtJFmEpTApecJ9c5uaLCLsFF1naFrwiNpDIHN1sY2A8bf2QcWxOR13G4SUT8IwCVH
         bKuUNZcT5n4PAZYVENwVFHLPGYUdNjhLVLunEJMMBZ8iRwqpmfe+C7WS9xrDxUxPeo
         r0MQA9jiCUZO/1aS25DpgOLcmeX2p4/P/5TOmpuZjZUihlj8xvOGbGCrJRuE0Uo2Z3
         ri+F8cdPASTzdu7vpqtgc63kVNU5h8GkqsQCZtlyV0IrA7dKVOTl25Kg2644sedsWe
         HLSYcTm4Eyz8Dnx9iFqZCjmTMlExF/6gDGBBTfU3GPCqepyf//UQMPTHXpxiBB/PWr
         iUzKIK3IBKT2g==
Date:   Thu, 27 Jan 2022 15:30:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings in Linus' tree
Message-ID: <20220127153055.6dd9f73d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yr3vaHR45tr9zDzj7FiFR1b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yr3vaHR45tr9zDzj7FiFR1b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Building Linus' tree, today's linux-next build (htmldocs) produced
these warnings:

include/linux/blkdev.h:1533: warning: Function parameter or member 'start_t=
ime' not described in 'bio_end_io_acct'
include/linux/blkdev.h:1533: warning: Excess function parameter 'start' des=
cription in 'bio_end_io_acct'

Introduced by commit

  956d510ee78c ("block: add disk/bio-based accounting helpers")

--=20
Cheers,
Stephen Rothwell

--Sig_/yr3vaHR45tr9zDzj7FiFR1b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHyH/8ACgkQAVBC80lX
0GwRmgf/ctZsuUB4THlHGDH3jTlJeIx2uOJCCPsvpFE4mHJdpnG5ROJ8vDnmw3gC
T+f+Cmcg71uz6jcNnAnRn+/dEJKDomSe/t6Ieix01hsbYTW3XXqBg7Ie7OdQ4WWK
dzP2j1mgXyTF4cYc9CTSFUJ6V9xvdP82Rqh62jhNmR/BdeTftgUGqteojE941wPy
7GlecKvWHIBZT8YTwW6sAaLJFsXGdtASQkKAsY/JmAP30+hWheDdz2up39Z6iTcY
1ZTbF9oxwdulLVJXR/IT/VEmbQlMegIw1F4BX7w8GHMVa3vbUZTSexnGWnOcVOiR
l1bO40rmyNRthuvbhtucAsP8/lZU3g==
=/pKU
-----END PGP SIGNATURE-----

--Sig_/yr3vaHR45tr9zDzj7FiFR1b--
