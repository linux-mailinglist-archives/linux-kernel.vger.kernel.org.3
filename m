Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A11523096
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbiEKKVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiEKKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:20:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973C6E06;
        Wed, 11 May 2022 03:20:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyrXG5Thpz4xR7;
        Wed, 11 May 2022 20:20:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652264447;
        bh=vJkr2n6TGMynWLbnQFj9uEMUaYkEKtzD8EPYXhTyTiE=;
        h=Date:From:To:Cc:Subject:From;
        b=Mi0HtKgJaeiKcI0PDf/AuOEyNMHsd49W7zlaTRWCPjsDmm9F7vPdUVBrw306S9UqH
         Y7MKTxU4zrhPJs/e6Qu/f3rbbGsL12BMv/b4ZXWrCLVUUvzM2YB5Bj3lYlIar0Ozoe
         MTyalDnXk4JrY/rUQZTCLrOisKBIS44Td64tcJ4maPlDm9Jyme+NPNnnFcnZISZB9K
         yfP8PlhgXjgswtCMTIzJPMGP5urcjWofZHFu+efLnWZ48gPHOxFVybP03Cu6X4zxpg
         l0deSvoYYzWJR62XGq+PYO0jD2punApXXTzYX0Mb/x3oKVDKJc8e8PLVUcVEECkagW
         /jDl8T5d8s5fQ==
Date:   Wed, 11 May 2022 20:20:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the mm tree
Message-ID: <20220511202045.45d84077@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iigqVFONXk2vdfPo9VgpG8L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iigqVFONXk2vdfPo9VgpG8L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/filesystems/proc.rst:1155: WARNING: Definition list ends with=
out a blank line; unexpected unindent.
Documentation/filesystems/proc.rst:1161: WARNING: Unexpected indentation.
Documentation/filesystems/proc.rst:1162: WARNING: Block quote ends without =
a blank line; unexpected unindent.
Documentation/filesystems/proc.rst:1165: WARNING: Unexpected indentation.

Introduced by commit

  9e43c820f7b2 ("Documentation: filesystems: proc: update meminfo section")

--=20
Cheers,
Stephen Rothwell

--Sig_/iigqVFONXk2vdfPo9VgpG8L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ7jf0ACgkQAVBC80lX
0GxjvQgAkVIAjfwgsLOBCdel/T8kFVHPkLwPXOaFa2hBtUPkboCHJ8dWtMnOcYZ5
yIW0OC7EFs/zeFosKNiG6lOnfqvkGsPpvBsIKxgqJSNZGlM6GTTOy6Xrk7ha5/iF
hwTOj9fjLE119uYKrMGiRNnpgp1n+cPOAAoO0ywdcYZ+TreY+Sdpi81B8o4c2Wru
noggE69OjFnPbpLpJV5zkWtWmQEm2jGv6oJyeWR9NdkLgk1Bs8oXWMI7Zc1ELH2C
GN03uvrMicNfki7dDIAq4Vy6Wgqq6By87HympMXtaAMGI3x0kuDgxeIN8RiG4k7L
U7ZMRDCL+ViRDFsYFyy8/Qj+0ZNAdA==
=tCjS
-----END PGP SIGNATURE-----

--Sig_/iigqVFONXk2vdfPo9VgpG8L--
