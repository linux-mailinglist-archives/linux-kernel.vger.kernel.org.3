Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB39462BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbhK3EbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:31:14 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:35829 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhK3EbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:31:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J38Mt1tFSz4xPv;
        Tue, 30 Nov 2021 15:27:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638246474;
        bh=8evyDFzO2gzR0rGjOVplTe+JpugvCPyGAnb3mo2xeJA=;
        h=Date:From:To:Cc:Subject:From;
        b=kfheRqiflijKcC3RLJfEj62KbdZSRtmMTyU6fTSumtSMlFDD8BHmqX5kv+wb0lkGl
         Lzex/XF6wE25TdbLWdocSG7+bVUxLmP3R1ndjsaN0s8VK/0PRQatkdEspLf1umma7K
         SHbKqaccmY96iawinLj1tERRz0FVNvy/D4+c7qnPrroRyPu4StpUjDgQoJ4SjE/Dmg
         9AmrcdRWMUTdjOWJzH2pQ+NOAelG5DROW5wtYqQYbnGL1MQfgQqP6VV7vvANYN0cQd
         0Fys7ZedrJUJhiQQbvyKV4KaPkzvn3tYSfsIqCTQtUrwmR3Fqs8TzJKAmI8Jrfd7C+
         WGRPIdOjCKEgg==
Date:   Tue, 30 Nov 2021 15:27:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the fscache tree
Message-ID: <20211130152753.6899aa0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i..5Lr7yyir=3elaGNH6Yx0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i..5Lr7yyir=3elaGNH6Yx0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fscache tree, today's linux-next build (arm64 defconfig)
produced this warning:

fs/9p/vfs_addr.c: In function 'v9fs_release_page':
fs/9p/vfs_addr.c:140:16: warning: unused variable 'inode' [-Wunused-variabl=
e]
  140 |  struct inode *inode =3D folio_inode(folio);
      |                ^~~~~

Introduced by commit

  12b841dc2cfd ("9p: Copy local writes to the cache when writing to the ser=
ver")

--=20
Cheers,
Stephen Rothwell

--Sig_/i..5Lr7yyir=3elaGNH6Yx0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGlqEkACgkQAVBC80lX
0GzPrQf/QettmL3mToDh6Ow9Gmbi0bu5UQdrYgcJMOwHt1XrtlnJ6bSdMQhU1TFI
PBC62Ai0F3fs3M2D9wc1Ned/eBu1V/KAt5vioO+HYMKl01EmTREkCvRtnFsD2nKg
6z4SAC1U5DuyzzVleO/JgtkyfBOpxsma9bOl/1QUEtwSE57bCO4US+yPZDF+7sX2
sPQPqoSXZJoZfXgK7LSPjnP5bwwZH8AAZmNK6LHpEPTmo4Y2iTPJ+y4YPc9aGXYj
+Eo0a2bPxY7Hz2dVwWfrQSS1JP7DWFO4jDQzIcmwlc9An4hvbNFWtEQin1mm9ZOF
m5yb86RmBFym1D00V0+6356UMMwGiw==
=xs24
-----END PGP SIGNATURE-----

--Sig_/i..5Lr7yyir=3elaGNH6Yx0--
