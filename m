Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CBD4A52A8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiAaWxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:53:43 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:34645 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiAaWxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:53:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jnjz657DWz4xPv;
        Tue,  1 Feb 2022 09:53:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643669620;
        bh=9gWhz0yhkc/z4LzkzxWsYqoYCTPaBiVB9ccKR4Ym6HM=;
        h=Date:From:To:Cc:Subject:From;
        b=H/geqBOo539DvaD9OmsiXKM42UIO0ur9xBUllYfsb3xbmckFnPaWE1g7bip2YeeC6
         jm6tB4XnxmHt2mG/TdQ5SaUPwlwunOW0C/WiKtEQLeCSjMXERW/DCssLigUhRacmYj
         tLo2YCkSKUwVlkLfT8NX4abNA5+ctnKDKZ+CHpisSjGhH32/u9CUPj0qDUenrBE6fF
         GDHDiNHWnlSBH0XIoJ6ojeGiLS/+9C9CBLqLU7ObQMnDF0dY928eAnwLWxE5MyEhmv
         NVeXKK9cV1gTdJ1A24wk8PoFGUATEc3WS80Kfz+3fHkEp/qV/W6yXTssodfbudBbsB
         m6eKD315gMLng==
Date:   Tue, 1 Feb 2022 09:53:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: linux-next: manual merge of the samsung-krzk tree with the arm-soc
 tree
Message-ID: <20220201095338.1f3fc49f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5x6DU=9L+b_QEWOThRL0CSd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5x6DU=9L+b_QEWOThRL0CSd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the samsung-krzk tree got conflicts in:

  arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
  arch/arm64/boot/dts/exynos/exynos850.dtsi

between commit:

  e3493220fd3e ("arm64: dts: exynos: Add initial Exynos850 SoC support")

from the arm-soc tree and commit:

  bfb3c7fa3950 ("arm64: dts: exynos: Add initial Exynos850 SoC support")

from the samsung-krzk tree.

I fixed it up (I just used the latter, more recent, version) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/5x6DU=9L+b_QEWOThRL0CSd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH4aHIACgkQAVBC80lX
0GzYKQf/bIr0p407Guk6e5B49Xr+3NRH2IlstHPrfFJcXM2H1wNBiUsMurHJyH/M
M2DGUlMP6wvQlbIyf3x+/GWNyTVBZaZaghf29CxeBUrTA/fMrE+zPDPpvCbJ4gTX
r4pRMkEFnF7yKHCJux9cbi60Fo0pyjHHy3iVxPzQEJn7wO1CJrexsHOs7z4kcgW6
lZhteKASmzifi9tByplF9EoUADPG1PboYyT2trTWgcd4TEmNoh6kxPZPWi1Sjk7o
xrEKU/0GpdHHaZ6OCIZcuSJRP64xyaHRdIW+4BmbytmyfkUFHNR1FTGAX4i5wYJ5
Lol1kqHTCPWz9lYpBlWWmzggfFs3Vw==
=njcY
-----END PGP SIGNATURE-----

--Sig_/5x6DU=9L+b_QEWOThRL0CSd--
