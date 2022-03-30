Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3524ECF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351453AbiC3WCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiC3WCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:02:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29C28E29;
        Wed, 30 Mar 2022 15:00:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KTL3N3kj0z4x7X;
        Thu, 31 Mar 2022 09:00:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648677649;
        bh=iYw+8p71E5LentbCi72ec4+D2MIP7YhO4dUvkY/SOJM=;
        h=Date:From:To:Cc:Subject:From;
        b=CQ9xfc6wBJdZMuw7HlbUc54Esw/v2xexRAT4w9dftdloZIP7doSy7ZsquOaiLu7us
         KZxxr9w5H+5dtiPKRERAgrgKT5UhSqw6xjh/GDhYmM+cZDsrkeg1zRPk7OsYc6eIoR
         //1fjlT1ZdXRteJ8OXBx6EbRQUnQkYQjeL4UIyU+Meaa9CcriVRRLQmdkKzV31gEju
         AQ1CDUeD5ZjiRp20gqo5RqUOi6jY4s0mxSTlo1XKbhYpTGtr3qQ59hohvJMmDQlSgN
         adYyzX0mos3whviTnBi6lzHVwkXisEZnJs+P1rndBbaovyYMDJktZwdKppM7Kmxo3b
         2dlgzJ95h6UfA==
Date:   Thu, 31 Mar 2022 09:00:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20220331090047.7c6f2e1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TkjzsN7cULUEOTgjMQprT1M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TkjzsN7cULUEOTgjMQprT1M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xfs tree got a conflict in:

  fs/xfs/xfs_bio_io.c

between commit:

  49add4966d79 ("block: pass a block_device and opf to bio_init")

from Linus' tree and commit:

  919edbadebe1 ("xfs: drop async cache flushes from CIL commits.")

from the xfs tree.

I fixed it up (the latter commit removes the code modified by the former,
so I just did that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/TkjzsN7cULUEOTgjMQprT1M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJE0w8ACgkQAVBC80lX
0Gz2JAf+MLKwDWHfyvkRpkpCVU8KdW0edxJzcG0S8GwcKt3v36qLghe/oR5AckRl
W/MIK+0tskRXMxMqfB7XD8MPlVRSBpbZPgPiE9oJtnUMTQose6ktRTkG9lSWom2l
wv9BaazG2kQin6x0qL9YGRmMjJEmWZ7LMB1y7SfaAwRyL8uEX2bjMxvJZKROm1z6
udV54BuCuU7ZJW+5Rpqqurvk0gcq9MAROZ27XJJWbhRCeMWYxogiIeEEMUnysSZn
gcyu3hMpeHMFBXNB2p2VgZEXvK8Xqe5wL/lhn9Kd9gvlLIo4INytCy6B2mhzchIw
XbkfINaUCEwGxba8lyUq8jXuG2wlVg==
=F1V+
-----END PGP SIGNATURE-----

--Sig_/TkjzsN7cULUEOTgjMQprT1M--
