Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB881597DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbiHRErD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiHRErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:47:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF895C972;
        Wed, 17 Aug 2022 21:46:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M7XRN603Xz4wgn;
        Thu, 18 Aug 2022 14:46:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660798017;
        bh=K2/n1XJ+DurPmRP2EsUxzpVsIh7w9ws2rXXRrMfTguM=;
        h=Date:From:To:Cc:Subject:From;
        b=QYohfq4Qhbqs4haXTCKc8TysRaUPQU2dUYOCzbwzVoBcvaftIFcFNlM+Suea8FCy8
         p8nIJkVQgxnJutaS4wroGaJB+CVpi7t4nDIlVXNJ5SPX6cX8tvC8OIcd1zgRmOIblY
         Q/IbK9+EY/KUaOT5MjHFmSNMEUU98RuRbW4bEunWy/2I1XhZuRUFGIgCtDSOqupasv
         m5AVRH/yTpoqDzRZ+umec5FenvTH+tCJYT7SuGkoK68BrsGqU9NQ/Yo16E0LVpLwes
         dCtd3C7qfwmjThbKDjildh8nm8x8gAvy61hZvM6mOQ5zhzBKi3BtAWc0zbQLlZErrN
         +WNgZ73ZonyZA==
Date:   Thu, 18 Aug 2022 14:46:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild-current
 tree
Message-ID: <20220818144655.1d26133e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LaED2cqKGMeBqDlO+XOOM0Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LaED2cqKGMeBqDlO+XOOM0Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  dd9cc5bcdd66 ("scripts/clang-tools: Remove DeprecatedOrUnsafeBufferHandli=
ng check")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/LaED2cqKGMeBqDlO+XOOM0Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL9xD8ACgkQAVBC80lX
0Gyeowf/dZZPUTHhWtyYrkN5YDph2vAQLVKFl6JLTVjsl0UM908kqWNyPhL/e65+
nchvYQXVHxykhX+57xk1L4leJcXJiGhPFMSzCUoCYRGxk0BqWZdpFP0LfHs6ObhP
iDMnoQwYtaTdZC8u56VtE2zZCGDZwrbpSWUgw9o8Fu82xf2iViFk0ybX60OmMk3M
7onaetU3in+qwQ5lEHs1UX4nZ4sNnuso6HMF3u/oq8UeRpcTO8uq2sv9cyw3CTte
HIWCHO9LITRWofCnQECSXGwtr5CmaEPu87eaHUT3M80NSEKgirNrE4ush4R4VxHn
GFEBDKCfJe6kErcEyu6e8cBKQWSYFw==
=H8KC
-----END PGP SIGNATURE-----

--Sig_/LaED2cqKGMeBqDlO+XOOM0Q--
