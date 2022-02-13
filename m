Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C724B3B01
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 12:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiBMLAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 06:00:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiBMLAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 06:00:47 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF05EDDD;
        Sun, 13 Feb 2022 03:00:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JxPXS1fChz4xcY;
        Sun, 13 Feb 2022 22:00:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644750040;
        bh=LgXs76Dju0jSFRHKKrckEL2WS2aNQ58HZxTb3GTqDQw=;
        h=Date:From:To:Cc:Subject:From;
        b=G8GPbRnAtrDCyXoxP1Bz5crWXsy/IK546fd6ATCQuH9SWYquFKBCFCfDEfd9MDlHA
         1THJXlmKFgoDwPKslq75Cg/Syljbr5HQp3Yw8XkWLsdjJfT9+2Pw7i1bNg75qtcOAN
         U+aIa7NU0opuOqPLj3j95tM/B8s2lnKqp0Alq6wInWZfiGLiI+UHnw4w1fddrv6oJY
         7MyZeHwBshe3ggzcwK6xbL2gS/D68KjLK+SUPr7bMkRf8yRDcK3bzyW+Oe5SuEFi/5
         qUtppC1vLDZb9Bgam1uMBb/amqbi3YrOln/oPKAe+fOQlCIFhTiMLvqLWeTIQAZr0G
         L6FXhZOweBdJA==
Date:   Sun, 13 Feb 2022 22:00:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the battery tree
Message-ID: <20220213220039.4a583a0a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lPJ7W0GN+Y+8nnDwLuAIYOE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lPJ7W0GN+Y+8nnDwLuAIYOE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e748590daf72 ("power: supply: PCHG: Use MKBP for device event handling")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/lPJ7W0GN+Y+8nnDwLuAIYOE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmII5NcACgkQAVBC80lX
0GxOvQgAiUjdkD/HyZPne62rQMvVg6jz689Ej5DySBZ0wHBtql/IgkYRxvpnG56C
3D70NuwKkJmgyQ0sAkze3dfvpRqjJNEzNouHSoSplit6ijHejeoNldep90t9zMos
+ZhFLqmKMpexXM9BSvrcGwWA0J45/bwgS6ZO2Wcnp26DWcSMHCe00Ovwh8EUEP8k
B1QglLBgyXqFsD8dYmrP40Haz8yjJhicy7L9/JF7w4V7m7iDA44Joy7T4Zea9qsY
Zg6Nnb5EDlA+Kw3m0+8v9z0T5ZGw6i8KEKe37SvnOCQGtePxliJq1wETDFAte8FF
EoNrEroT+sC3q9UZQ/xVvS2HofRtiA==
=UQE9
-----END PGP SIGNATURE-----

--Sig_/lPJ7W0GN+Y+8nnDwLuAIYOE--
