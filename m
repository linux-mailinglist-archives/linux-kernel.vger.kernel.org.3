Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172054A9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352799AbiFNG5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiFNG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:57:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1A2ED4C;
        Mon, 13 Jun 2022 23:57:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMfQC0jYvz4xZ0;
        Tue, 14 Jun 2022 16:57:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655189859;
        bh=2zwfr6L2/DazjFrIS0k6vEjrnwebcsif0EZPmsedaY4=;
        h=Date:From:To:Cc:Subject:From;
        b=lNau3KfMwraf1JKCFyNueNKFQVJJadM87oCIZ4yAXtKiOUSG0iyvhFTdwzXA4TdW9
         rPk2JPFj1fRp/hUbqLvXrTTaLOF6YLI1/yww0jF+98FhjXmscRpYgvVpQy7AYv+6nl
         vRM14/xEQiKwxNSwmnac4XJTlmsdDX8Yo2jgTCZJgmE2v7qOVAwgK4RzdAlM4M87Jw
         Gj5mnv45T28w3+hmfhYwFryUraslZu7DXXo8IhTFGRKaywqAbz9312kriwp1Zqb92a
         CX2lLdU24qZCwnI98pJBH+caLJK4+UgoF4HD5v3izt0eiYtgb3nDKdvryvTUuoORvh
         xaKy9QTeMeCSA==
Date:   Tue, 14 Jun 2022 16:57:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings in Linus' tree
Message-ID: <20220614165738.715686f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BaMS1miKY7y=KzDC7lqKZKo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BaMS1miKY7y=KzDC7lqKZKo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Building Linus' tree, today's linux-next build (htmldocs) produced
these warnings:

include/linux/netfs.h:314: warning: Function parameter or member 'ctx' not =
described in 'netfs_inode_init'
include/linux/netfs.h:314: warning: Excess function parameter 'inode' descr=
iption in 'netfs_inode_init'

Introduced by commit

  e81fb4198e27 ("netfs: Further cleanups after struct netfs_inode wrapper i=
ntroduced")

--=20
Cheers,
Stephen Rothwell

--Sig_/BaMS1miKY7y=KzDC7lqKZKo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKoMWIACgkQAVBC80lX
0GyOpwf+KaBOpCT47awst7A2fQd7E14dtzAP4um5+sKfiUFRfUct9uvBWtICUt2I
1Jo1UwYinrl06jfKeuxIPdLUtWr2jpCUW1ubqmQaVQaZ+QiW7C1cmXSf80CtRb7O
oOIjtrAMqVHwGM7VlJJfRL+AqrCt1l3Ks9pF/qAFLoTvnFR2XY79t5YFGHXODknn
Y0ZIXPJLGLaHDOVQvvciGGQJmlOzHLkPXnQzcvhv0E71efn5q8rNemfC+xkPURHo
1dwG7JBLQJw6Hc1OW2mZcpidpMRhmBXwwOZG2SqbDZ5Y3+Ifuuzw+DlCCGN/SR+3
YlrAJCWnuqw6IJIAmWVHKrb+xkjK1w==
=eHpj
-----END PGP SIGNATURE-----

--Sig_/BaMS1miKY7y=KzDC7lqKZKo--
