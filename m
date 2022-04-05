Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393D34F5275
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457125AbiDFCvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586948AbiDFAGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:06:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F45BF53B;
        Tue,  5 Apr 2022 15:32:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KY2Sd6x1Gz4xY2;
        Wed,  6 Apr 2022 08:32:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649197922;
        bh=m8mQ+AAlaFbjrsVWsEIbNf1ef+uhsQG+0q725wBu1b0=;
        h=Date:From:To:Cc:Subject:From;
        b=e97n9l0n+mWY7rInRU4D4W1tu+awUnIHu4J2xHpCxBKz5hXMXlvcyFMhZ2simTPW7
         7tMjbW7EIK7FIr0ajuwSvk8eFltl/+z2I0D2bgbYuLeeJcZAx/4tAnam5qn4qHYlwA
         l9pIXTbiN2Oa0O1d4tR5YxwhsKwuX3a8iyzr8lHHXG0gky+knlPolswKmkgdroalEZ
         TyMdy6AY8gz7Qe/Pl/HyVrrXKUoU5RNBfJ6usVrauZMvqIhE8BuBoQ7ngV6XzDV0QQ
         b8ow7wodZdOwcEwq73W7IzhPaQA1yGTcaHQpIXDEV5rYQn578plHa/pNYaSnFp2tjh
         ON4r8rITZp+DQ==
Date:   Wed, 6 Apr 2022 08:32:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb tree
Message-ID: <20220406083201.15e8e589@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hZkRtp5noDF.3RVrYk5gFG4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hZkRtp5noDF.3RVrYk5gFG4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  535f49a9e1f9 ("media: platform: imx-mipi-csis: Add dependency on VIDEO_DE=
V")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/hZkRtp5noDF.3RVrYk5gFG4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJMw2EACgkQAVBC80lX
0GxMwgf8DzWjdfW7ehDUCjvyT17Y5RWVtuzrXQ3xYGlQqZCXUwM/h18MXkr53Mqm
7wtCj/UyVPfDVOlQpZdJqZCZTCqBlPSYWEU1i/AfkWl270rstJfs3Uh8RRzWxGmL
+keKVHltYnAiHlQpzBYrRer4jFr2/EVg0xJEBeE66d++UdZKQ3VGmwbzqdIqzpvR
liSoFhmccji47BfzAMCMGaKyQPi0jp8tgxku4Lvqaoq0R0hEdCdUPUYQREgASbPf
JiISIGJqU+Wy3E1XsrRE8D8nNF/MdjwrTlD2j6+FCROA5r+LBihBcUgjx7klghLb
O2b6YwMuUj/GvZ4XCg6dpZspsCsXDg==
=nDqG
-----END PGP SIGNATURE-----

--Sig_/hZkRtp5noDF.3RVrYk5gFG4--
