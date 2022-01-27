Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3235149D9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiA0E5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiA0E5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:57:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF9CC06161C;
        Wed, 26 Jan 2022 20:57:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JkpHJ5c6Pz4xcT;
        Thu, 27 Jan 2022 15:57:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643259452;
        bh=9LiJK7T4H6E/r0tI+zhD7z+AZV9GbGkr8ik2vuoYm20=;
        h=Date:From:To:Cc:Subject:From;
        b=Lb0cuKsZV/ya5XqKfROAIoy2asqqANwTHGibUWvMMj8pXI1U+aB/FlfxFkguHDZYJ
         mWD5N283hOnLucBSoctI/JIz9ll4dxJoa8xnlupRp1mhfq49uEqLuLwBxfbw0rfsgu
         g3/xsrHo+pLL/k9T2ydn6gsOUMxvYigTeJ640MyzPocXIlprLq7x7Q2ivZlwPVb2iW
         nSJ3Vpzs3wrqTQQ2U6btYBMB5YBJwt31kgSHyh1AcAclM/SqHBr+W6bVmJO7ltREFs
         j+91mkXWhtQYRUyfrV+N5nvSL87WHymS/cY+lpZsYQqwQhXEo113Zr+cK7XnawYG6n
         Up8A8ZUz+BMew==
Date:   Thu, 27 Jan 2022 15:57:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Li-hao Kuo <lhjeff911@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the spi tree
Message-ID: <20220127155732.44113feb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8WR_SPWPWNKl5jUifwquQr=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8WR_SPWPWNKl5jUifwquQr=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the spi tree, today's linux-next build (s390 allyesconfig)
failed like this:

drivers/spi/spi-sunplus-sp7021.c:568:12: error: 'sp7021_spi_runtime_resume'=
 defined but not used [-Werror=3Dunused-function]
drivers/spi/spi-sunplus-sp7021.c:560:12: error: 'sp7021_spi_runtime_suspend=
' defined but not used [-Werror=3Dunused-function]

Caused by commit

  f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")

--=20
Cheers,
Stephen Rothwell

--Sig_/8WR_SPWPWNKl5jUifwquQr=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHyJjwACgkQAVBC80lX
0GxFuwf/ZD7jCTN8fXHnk8NOxlujrhU4d2aiJNF9TJ/h4B50B9s7crQZeplMbHLJ
EmXhlEbBrTnUwm36MV4Fz46WwlBLdoxzVBw/S6/7gdBZX7fQh9ttzRdvLjRsEI84
laKEsiPg+Uj/AZIUFtQ+gv4sj2O7pEl7YW4Omqu9TDbkBCuPDZcTa2Pl5/SJh50P
DWgJ/aVlMsdR3/Pt/8xwyoNmC/NVjeECNSMYTN+VrSkhw4qSziWTibu5jRULL9dN
Y2P+TcMzDOcCUWm8h8y515fRufJIaAWOpP2zuh5aZ/xQLJp+qlvzFMJAeDZDh6pV
jdzKCdIJ1E4xbXiNgsNtXi65xYYp2A==
=6uOq
-----END PGP SIGNATURE-----

--Sig_/8WR_SPWPWNKl5jUifwquQr=--
