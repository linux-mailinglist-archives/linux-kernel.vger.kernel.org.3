Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E55698CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiGGDZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiGGDZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:25:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C932A30F52;
        Wed,  6 Jul 2022 20:25:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ldhcs6XtWz4xDB;
        Thu,  7 Jul 2022 13:25:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657164334;
        bh=HUxrRP6dmg/hpvNXDPU9B8JU/f+Pnv4osRhpTguyyaY=;
        h=Date:From:To:Cc:Subject:From;
        b=p7Sn5GQ4MOMBiZDsWUxz1l+nZphks4Q6IvQ9D1Uv3oaumM2fk+e1nzmL1U48ev/Xp
         UzPyJKms3flQ+ULpetEU0y9ut7oFlZF2NeKg/f4W/498gT4hLxTtSMVFvQYu/4NyTY
         tCoo7Gnj48o8Ne4/xZvm9z5lPl390aBY5Wzm5CV2nvQxGGrB2RAw5aA83jrvXj2P38
         aikvvKmdUYfebuYFTPNNTUZzhfUGzDhHRaV4mqJt0vkZOXtM0A/9voo9SHdNmKZ0BB
         rVS/Ys+wcsKZW8qdpwidLTkikbiRkzUtNDOVeo/J0UzF6L3ffOmiDU2noXZS9QoV2J
         JoEo4Wj+X/taQ==
Date:   Thu, 7 Jul 2022 13:01:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the regulator tree
Message-ID: <20220707130128.72c0ed60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mxHi5DNEohb7tQALg_yCDI7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mxHi5DNEohb7tQALg_yCDI7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the regulator tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/regulator/max597x-regulator.c:24:10: fatal error: linux/mfd/max597x=
.h: No such file or directory
   24 | #include <linux/mfd/max597x.h>
      |          ^~~~~~~~~~~~~~~~~~~~~

Caused by commit

  38493f008deb ("regulator: max597x: Add support for max597x regulator")

--=20
Cheers,
Stephen Rothwell

--Sig_/mxHi5DNEohb7tQALg_yCDI7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGTIgACgkQAVBC80lX
0GwOxwgAmTxjzc3i8q94N6YAGA/QecX/sLOR9x36zxEh4BdtcW+Kg5Jg5f1PpzDU
jSoCFkoKOnUJxnKZCvu+zkWveG+qCY8GAVIZ9KdNKMWEXTQ2g+KLyiS+EtMxI8lG
+gcnnBgK7czkousMgxzXZURMRlEl/gq2FoaHZO4keCTBi12xmvf1akIMfOtQFg4g
WPi+IQz98hpXv5Cndg3EMl+6o/Qu+43gdwjXmNfSnug7k03WpXc7XmeXOBKwNPwa
pjMgeYzKq1uv4e2Nbhw9u51ZOj3eNJrJNYLkOaRoQ2mp44o9kpwiIB0AVdWiKj/v
Rpit7XlYWXu5dkfsMOvG8hhsnKQnFA==
=UG5b
-----END PGP SIGNATURE-----

--Sig_/mxHi5DNEohb7tQALg_yCDI7--
