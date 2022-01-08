Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D46488334
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 12:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiAHLWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 06:22:49 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:41605 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiAHLWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 06:22:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JWHkZ4V2bz4xsl;
        Sat,  8 Jan 2022 22:22:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641640966;
        bh=VxaJnLBR6LZ4qO7VWtc8nrB4osndOqpKNWabQdCjUio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pAa+1T1YUb+U6WPRWRSMpD6ZPbsrMSyvlr1F5zWDa/XoTCvGxWEza7Er2xOpACWgH
         y49jTaNgWkDMuvedbTiWEENvmH6aEHCbdP2bawcHdblw4FZqaOvGL9OhI8gIR0g8wU
         IEObuifbaisslOaGAqjrxwpA6Omz9MMcwk6WE3b/7mVumwVlu+C40rHLAN23noNvsK
         D6e+iFqYLg94mS/TZLnf6Amd6m8nmPRD3uJaHQQFcu5tqE3iBCh6fXYIqBj/OvR/ZP
         FhaT2+LNamyDlm3s6FtGfiail5Y3YJ8SxS7nEbgqM4BDXgrE75DoH1clV82oyTNuiX
         e1SWSJ28LnVAA==
Date:   Sat, 8 Jan 2022 22:22:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: much more building going on
Message-ID: <20220108222245.21acc816@canb.auug.org.au>
In-Reply-To: <CAK7LNAT9c+_pVyfPA_XfhjSFCifDX3P9JNrbsF6-38Yh=1t69g@mail.gmail.com>
References: <20220107171319.0afa619a@canb.auug.org.au>
        <20220107172206.3fbdd09f@canb.auug.org.au>
        <20220108171424.669e37d6@canb.auug.org.au>
        <CAK7LNAT9c+_pVyfPA_XfhjSFCifDX3P9JNrbsF6-38Yh=1t69g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B/Qlgd0w8Jnk3=gT8vGFwXH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B/Qlgd0w8Jnk3=gT8vGFwXH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Sat, 8 Jan 2022 19:46:12 +0900 Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
>
> I fixed it and updated linux-kbuild/for-next.
>=20
> Hopefully, it should be fine for monday's linux-next.

Thanks, I look forward to it :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/B/Qlgd0w8Jnk3=gT8vGFwXH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHZdAUACgkQAVBC80lX
0GwkGQf/UwgvhlgyGVV01ZdzmI1U1Si3Xgnz0ZRoTqRpiVk2yIjb+vrTVcnPduCi
N7Hfto8exgFiUUjRTOqq0xKAZXrWx2fLZP6KI9FLBMyIQexuXpriPtW0vqWQ2AkJ
4015BGHhZlhvtJgo6aSNqqqn63TnIFSpXJAZFweTdB/ghg+M2yK7HW/X6yQ5J+0e
XT8Tm3buPQ8xZhHFr3to1sCaYyIyQYgb7eGXa6aVcB0hbo92LNyzMh3fxirsbjCv
uOAshsHWVEv0dI8DONe9eM0YSIVAQgCTA/tT8Cf/k+ewcpqWBQaDE74sryeziKAJ
tH2xVHDyghpCG2xg5uOZ6D7TCtQ6xA==
=KbR/
-----END PGP SIGNATURE-----

--Sig_/B/Qlgd0w8Jnk3=gT8vGFwXH--
