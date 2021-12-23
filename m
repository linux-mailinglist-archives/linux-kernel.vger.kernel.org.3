Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E69947E9A2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 00:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhLWXNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 18:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhLWXNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 18:13:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAEBC061757;
        Thu, 23 Dec 2021 15:13:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JKmFL5hYwz4xdB;
        Fri, 24 Dec 2021 10:12:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640301176;
        bh=mSEwCmZeG0D9DmgQuWbQoRE5M9p+R3WB8Yp/Ec0XfyU=;
        h=Date:From:To:Cc:Subject:From;
        b=u73uzC9jwwXHOjG2aMO6+bLDUAg9QUOKCBIQrlJafhbFcztrr6Mcz5uTlgevnShUx
         x1IDNjn1ePBaBL+0KRIFFQYXTNgmSUWpuXhaulVxJAZv1pJhPXFY6PvsjJ6TZJp04s
         qGEniuH8PcgbG95uEUDoZxA+O33qvlgAkvW9eJgraKYzk6El5NZ2pgFUcYxgV1S2P6
         hz1Bz0PeLcOM1woZgnentRDHAxkT/lkscXAiS95lUCM9ejvXHkQWIfta+KYmA2ZMva
         gBBw+pNk0vh7d4YRlOUSJ+0INt/DkvVOZMwLeekhajsybYo6uK3C8bGHlhw/7tLIer
         d5r1ENFvGwMqA==
Date:   Fri, 24 Dec 2021 10:12:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20211224101250.53eb8270@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8kirmVWH/kta4iwzm9CHywN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8kirmVWH/kta4iwzm9CHywN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, yesterday's linux-next build
(htmldocs) produced this warning:

Documentation/admin-guide/sysctl/kernel.rst:798: WARNING: Malformed table.
Text in column margin in table line 7.

=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
bit 0  print all tasks info
bit 1  print system memory info
bit 2  print timer info
bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
bit 4  print ftrace buffer
bit 5: print all printk messages in buffer
bit 6: print all CPUs backtrace (if available in the arch)
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  658a6ba2a287 ("panic: add option to dump all CPUs backtraces in panic_pri=
nt")

--=20
Cheers,
Stephen Rothwell

--Sig_/8kirmVWH/kta4iwzm9CHywN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHFAnIACgkQAVBC80lX
0GyFqwf9Fhqk6WHpq07lUI68T4iPpyJWYS0QeAK0YgI8JQn0wdGrnSp/rm3512bV
o7rcjn3yWKtUjYFSl0lx/KNFLygBR3WUtExGYw3Bi9XrDy8yjl5UGyJUbfDdDmOs
NEXvUOE97RlF90iQmWWjAAEK9k125+U4sVqMNp4wAnrUSsM1M42fJTC7+4+nbSj5
BvkUHg08/SCT+YCGiSjfE51IdNQaIIx6mSBqeNpq/2RbrqvImNTi23amTsAVnQfU
i3eToeKS81PbckHvr0HLviz5RaXnBGHRrCRg8gTDCvxYG0PWF/gU40EdJ9MoybeW
4r6ATqDwuGLL4UbYgTEk/0ZWBn9lYQ==
=obAK
-----END PGP SIGNATURE-----

--Sig_/8kirmVWH/kta4iwzm9CHywN--
