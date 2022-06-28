Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EBA55C900
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343673AbiF1Gyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbiF1Gyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:54:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1C275C1;
        Mon, 27 Jun 2022 23:54:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LXFgw56zCz4xXF;
        Tue, 28 Jun 2022 16:54:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656399261;
        bh=0NJ4j4WvNJDzrwmj/CN0sV8UZ28t5xB8MJ/OmMV4XTo=;
        h=Date:From:To:Cc:Subject:From;
        b=vGcMyZv797hXDs0chsaLHdoNUZ9XbE0SogHC9xnavHiAmENzX1E6p6qYzQC5aHCm9
         0XgzO2HmI5WOVFpCExVoZJ9xku66NQbQszc7F+/XoUygq+FO6yPFqZGpJLyBkfWKHe
         U+k2wRa674kuLk/OjCbdmF5sWA4XvYC4VUGah4gbkNbDgCOQAksGdFbwEq4Tb8ID2N
         UM0LNkWnVXDaG0yIMLfxSafqhQ2eWelK3lrXjbmePAZdWm27wK6CoN/eBgWMiFszwW
         85h4emtGGqzffLN655x1hTsk6okD3jvWXSmFCgRmGgdRDMbMteLYztH8Al7vi8ga0N
         uexB9NmHrjvfg==
Date:   Tue, 28 Jun 2022 16:54:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: linux-next: manual merge of the mm-stable tree with the jc_docs
 tree
Message-ID: <20220628165419.0bbe7b0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LjNpbVvD=ixMdp9ECtpNiSb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LjNpbVvD=ixMdp9ECtpNiSb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  Documentation/translations/zh_CN/vm/page_migration.rst
  Documentation/translations/zh_CN/vm/vmalloced-kernel-stacks.rst

between commits:

  3f39b3d70fcd ("docs/zh_CN: add vm page_migration translation")
  17c260504f6f ("docs/zh_CN: add vm vmalloced-kernel-stacks translation")

from the jc_docs tree and commit:

  ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")

from the mm-stable tree.

I fixed it up (I moved the files into the "mm" directory) and can carry
the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/LjNpbVvD=ixMdp9ECtpNiSb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK6pZsACgkQAVBC80lX
0GzAKgf/RNkS3lMrZhLcOGbH98yQsKr+Wb/edot0XXyElhs5QoR+fOVDWCCzg1rI
OJRanZhtLDSDRknrZmkXGLaPXXNhqzmU26q1aPLn8Y9UhXaPIxBdzIsCbyJg8Dj6
nMYdAreKwR/i5cFAqbWNWebaF2wNbUGioA3YasxHoPoNMcF1katvJ2wEG6sX2jKW
FjmbXcl3cJ0RsTX3UWQhwYvh3PFjP7kiobPG+FkDmJmyfLIk3szQjZJRyc23bWR6
0hAvf1qqhFEvZ/uaWH/0aTiF5cLBZ2sTZHgmfOxiZbAlDR/Wl7gS+Rk1kkV3MY91
N+3felnUba0xKA3yLoCgmKLIEnFH8w==
=aavn
-----END PGP SIGNATURE-----

--Sig_/LjNpbVvD=ixMdp9ECtpNiSb--
