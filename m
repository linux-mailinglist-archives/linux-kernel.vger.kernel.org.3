Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAF856D36A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiGKDjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiGKDi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:38:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00431055F;
        Sun, 10 Jul 2022 20:38:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lh8kP0vzLz4xbn;
        Mon, 11 Jul 2022 13:38:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657510734;
        bh=Z3BrvvwqC1jnPWAkXXv/cP0tDkLg/U7euC2/t+CJSPo=;
        h=Date:From:To:Cc:Subject:From;
        b=GMZlwQv1U1xOiIfUZ82FEZiUaHtbDk3qA3YWUY89Rf9km0/mTfpPIHZbQwVHqw6lk
         S3WwXU1uIq3jDVLLorgZmL+3ythZ2uaTEHQyidw06S4zSKE+OfnSYA6ALPwZllC6vX
         P6moF67TFpJtspOmnS/KqsThkuC7fIMxLdh6l7M8K5TNBfAV9FivmSOOF3L7aoSc0W
         03WYTzecmTzyTJUSJDs0LTrnViRSFhk7Gfwxuv5Axcdmy5AtKaJuhFFvjYKxMqTLQi
         ENn1GhfDbgDVl/XBj7+5WLRPUx4MoiEQw92fPm5h/WLJ9Xr+REIqt2tS5vgiupoHA/
         OQDRrRdv81dpg==
Date:   Mon, 11 Jul 2022 13:38:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20220711133851.0ad00263@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eIJOVq/9U8I65WnT5aGlrMP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eIJOVq/9U8I65WnT5aGlrMP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  drivers/block/mtip32xx/mtip32xx.c

between commit:

  c9d86760342f ("fs: do not set no_llseek in fops")

from the vfs tree and commit:

  ec5263f422a3 ("mtip32xx: remove the device_status debugfs file")

from the block tree.

I fixed it up (the former removed a line that was also removed by the
latter) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/eIJOVq/9U8I65WnT5aGlrMP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLLm0sACgkQAVBC80lX
0GwCBAf/Y0302YBdLlx8HLZBOApztFXwTgQxamcqenYGTjrsXIHVGfgZQHwaqK2F
QH0jf8Ez7F1gkve/y3titQo04D/Yug3uEPiEIGQ4HwoszGOdojA8yCaanrmmtBWG
jRNzKr6AIQmoWwsfT2D1WnGr6jqi02JUf3YRdT7tfsn0UABvXUWEKK1foswyLmJx
hf9WkkN/28e63nJK8QohfNd/TqTkxWYl3teG8+yVAMz6cqfa7DV1q4eAzmkWkLt9
r7y2aZqzT7SbC/40Ii3BOZa0LO3838taXTCsyyIH7FSAR6TZkKw99jkP20yT/Xsa
LZs00UXod9nVLhJF81+eDs/vzPlcyQ==
=g58d
-----END PGP SIGNATURE-----

--Sig_/eIJOVq/9U8I65WnT5aGlrMP--
