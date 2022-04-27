Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9008A511165
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358215AbiD0Gor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242894AbiD0Gon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:44:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1B1D0CE;
        Tue, 26 Apr 2022 23:41:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kp8Kl22rLz4xXW;
        Wed, 27 Apr 2022 16:41:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651041691;
        bh=FcsV45uvc3DRnc72nl3fsocm7w1tHQcjdaYO52tDaKM=;
        h=Date:From:To:Cc:Subject:From;
        b=dLLNpVh9S/1lcBVhPj/p2Q4imL/67aEJ0uivcypwvvGUCE0Fw3GDWH5X3aR0FkYNk
         r8FQO08Qu8xAsUA4WnrBAWyoO+pO89GzobJQzFfBb71YVHOJWoA5fCxk0JZGi2sa1s
         n57cUq8I1pXZUlVCwUerVEdq7SouCAaD2Ybsizd2EIqHCSaSHFCm9TNPmkMIUZWofj
         ulpIttVe9jHicu54Ov66of7mVWcporGEy1qf9pommTvvB2tCiGX9JBdcbAPy9LpFdn
         ZgCVgbPkf5Js1O1IxzCUVSDRBlPZAZ8RdYczA/uhCk5aDNcDqBLZExNutEybv5attX
         9Zoo6UPu59HVA==
Date:   Wed, 27 Apr 2022 16:41:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20220427164130.113b5837@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PEm6pfZzg8YP/Av4=/CkHmB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PEm6pfZzg8YP/Av4=/CkHmB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (htmldocs)
produced this warning:

lib/maple_tree.c:5578: warning: Function parameter or member 'gfp' not desc=
ribed in 'mas_preallocate'

Introduced by commit

  00d332902d28 ("Maple Tree: add new data structure")

--=20
Cheers,
Stephen Rothwell

--Sig_/PEm6pfZzg8YP/Av4=/CkHmB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJo5ZoACgkQAVBC80lX
0Gxelwf+PefWoVnxOc1fiU9vtEJH/LBJqM0K8qsERJroTuZQNM8aCbnA5Xg2JLQa
7xSMDVAXvskWQGi/wOtwYnC7/lTYFMq8FJccab/+L07cexV8KdZbek22onJnj6hm
Cul3u0yj9585ZnaJVm2IzlPJj6pOz3R0HIEIe8jgaJl6TsUHm5DvdoStL317vs4x
XLi4srNzLUjAKMEKcTGbc83Gv8Qy2XaALh7ak5fIZo0Hjy57r6zTuUjKUuldGq/L
tJShZ2lQ3AuQLv6EUgXhEIqICWYh2Gt3IlrEx8pX29gNcGlPTT1MJcWO+OOUSGpK
oI1ByEi6OiEj1R/zOX8x/o7Naayt6A==
=EIf+
-----END PGP SIGNATURE-----

--Sig_/PEm6pfZzg8YP/Av4=/CkHmB--
