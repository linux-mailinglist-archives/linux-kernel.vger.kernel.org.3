Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4959B4D0955
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbiCGV2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiCGV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:28:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4855F98;
        Mon,  7 Mar 2022 13:27:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCBPw5HqCz4xnG;
        Tue,  8 Mar 2022 08:27:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646688468;
        bh=wNPk99aytH+YdqVfBVvS1YzmM3Bo//Qtn+VJABWHybQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dVfgqcP1k23rX/D/dFDFgsiYPJ5YtozLeK8ap+WYLJVFMNYPEqzoGu1oA9cbNi1IK
         T4gLqUQSOWPrlkqvgDcZr8CHzgl80Ms5tVRSOJRu0DrtnmYRfE0X3SYv6R4xFQ9A9L
         BdFUlmAOHT8qxcX/2astIJ69tUab4Wi687e4wZFJh6u0cAE7fgquSe1EUz3uhyb7Po
         N2Rcz54BrYPs7Zsb9ZoYcl4yeDsQJHGlzTJQL9g2QRn+r5Vd+OVDA6Pj94FQH/R0sA
         o7HspKbGjhzQ9JkcmgEMSf4hhKPLLi6Pd3Bd8pcC4kMlcUEBxrzN0py6fXaADp3kBz
         h5Off6Fm2gUxQ==
Date:   Tue, 8 Mar 2022 08:27:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-ID: <20220308082747.4714e155@canb.auug.org.au>
In-Reply-To: <YiY2KYyjsCaANwo0@cmpxchg.org>
References: <20220307215530.7c981424@canb.auug.org.au>
        <YiY2KYyjsCaANwo0@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KmWoziyowq/u_Ib6rCT.93F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KmWoziyowq/u_Ib6rCT.93F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Mon, 7 Mar 2022 11:43:21 -0500 Johannes Weiner <hannes@cmpxchg.org> wrot=
e:
>
> Sorry about that. This should fix it:
>=20
> ---
> From a4d90a5faa418d98f925abe47b1a4fcffc4283f9 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 7 Mar 2022 11:38:42 -0500
> Subject: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED fix
>=20
> On MiPS:
> mm/madvise.c:55:7: error: 'MADV_DONTNEED_LOCKED' undeclared (first use in=
 this function); did you mean 'MADV_DONTNEED'?
>=20
> Define MADV_DONTNEED_LOCKED on archs that don't use the common mman.h
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks.

Added to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/KmWoziyowq/u_Ib6rCT.93F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmImeNMACgkQAVBC80lX
0GzOHAf/QkT4nA8E9Cf+FIOppKuwNTzaijpP/ym1YR3Rnds5p7uQtSap+XH3olSn
M2fq5Rkp9R3RRhDOqVGTQ+Gr5j8TQfHISN1NIcS0RmM+QZsJN/dMMfvNfTKBkKbu
p/VP7RFS00mT1nJi9c+2I+8QQHLo9jNvNaEArjIBYU98t2PMJp6f+0ZO0Ano6wVJ
Yq3SrdFvEdjvtQ+2p65VTXXCd04tYLypBRKFrpgJyY3HwJGsbT+HOzVQUH7zZb40
WtugZO1CrI4T8BxWvvMG3sfB0DsMGWWoiQLxmTYvOoY9RgvBqlG8eM2LcsFZnBPD
UzaO+bo2hnzQPTY+DMYkqFTBTcwc5w==
=8dxC
-----END PGP SIGNATURE-----

--Sig_/KmWoziyowq/u_Ib6rCT.93F--
