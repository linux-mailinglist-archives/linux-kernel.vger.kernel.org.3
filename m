Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53B49D914
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiA0DPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiA0DPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:15:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266DEC06161C;
        Wed, 26 Jan 2022 19:15:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jkm1M6Rvhz4xhm;
        Thu, 27 Jan 2022 14:15:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643253320;
        bh=VoGoQgVDK2sZTcHuebPz+Pr+33dx2Hmpkr3lUbO3a+E=;
        h=Date:From:To:Cc:Subject:From;
        b=oxgSNelPS3ReDVLmUmokWFVfPgI+VWDqJLnXaDg/McpBX5rA9qW9tzTf4PfrSeKTD
         U527BCJOCPwXekUeK9B1gEuXBTcUIssMfAW8L5I6esqgtOjTxbRTNu9/kEnWLuvNIn
         gXkUwsdjGOXPMZBEnITJJrmosEvC7Vh/dJMq98CXBsfc5JMCan9++5x27Tx9wH7aFm
         Qikfssw1sIMBfx4mlSloveA8gBqNwBNVR7pyJeJAVYWeZuI1bx4nZbHnZ9KIXnQw4I
         PkmItodOg6ziJM4PUItyZPXif4H4K4vd/cSV/0knQU+ENVc210bW8JTGq0+l9XehYn
         V+EyUNvQNkAbw==
Date:   Thu, 27 Jan 2022 14:15:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the jc_docs tree
Message-ID: <20220127141518.54dbb9a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TdtfE7KuZW=/xe=tmBQQ=Rm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TdtfE7KuZW=/xe=tmBQQ=Rm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the jc_docs tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/tools/index.rst:2: WARNING: Explicit markup ends without a bl=
ank line; unexpected unindent.
Documentation/tools/index.rst: WARNING: document isn't included in any toct=
ree

Introduced by commit

  1ce5371ee32f ("docs: Hook the RTLA documents into the kernel docs build")

--=20
Cheers,
Stephen Rothwell

--Sig_/TdtfE7KuZW=/xe=tmBQQ=Rm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHyDkYACgkQAVBC80lX
0Gx0GAf+Khbg53fV+P5qV7uQWdFVfWyDMsFDvAV28ZnFYEjY2HEXMKR1lU6/C62+
sPtoiG5PGgQGDOPMggtYnzb2JMtICyjZkve3w/1hQ4Ks7WrZdkaeH0K82FXu3P2Y
t/N5kHPDNndPofXT3qBdZwVYA56YYnzv9XzoYs8TBkhujamzI4BpEEBAeuthp1tT
ILagfmsNAkUcALm8BmGh/NhB6wToFI1ND+36534ISKgNIrij1RStlMcKpCosDz81
cGUIkmNreGBP52p9JG1Lr2kKqPi2pT8JCaql435GqxN9V9jLUAhWSKRnUaof646g
5O9fov7KmqxIXJSw2aSgAU+GIPLQ6A==
=3c8q
-----END PGP SIGNATURE-----

--Sig_/TdtfE7KuZW=/xe=tmBQQ=Rm--
