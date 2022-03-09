Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28274D2748
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiCICay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiCICax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:30:53 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49BE643E;
        Tue,  8 Mar 2022 18:29:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCx415sG6z4xgv;
        Wed,  9 Mar 2022 13:29:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646792994;
        bh=ypfxRf7dJRjx8lo3S2FVKwL6a2rcsCwMKaeXPyNybic=;
        h=Date:From:To:Cc:Subject:From;
        b=fI2Zx2wzfah+nMMJ9mVEL+5cTke7QXqbqFuaz3C1GW72Mu9ewg7F3gd0eCkmLWNZo
         n7Xa5dO0RgKeBZUJEnj5I6RB9up/QJx0ygBeu5o1P6NI49YHln3GCqhHm7a3bdHEHV
         3iloo477UUrb8IsoySzehAIkfzz2BaNfyI4PxHN3sejP5GOoan4xpKCGDylrCxRg+u
         gpzNP/vIfd8izHg2pwWXOl8GUfRxOf9rANk+wzQCVMv9SPJ4BspHIyronZCLTiCJYk
         gt3s/Nf8qxxqUyLrBUPmsGo5ew8QdYhacgwh+DNxiSuPcYOogjrl8IT+FJmce/ETNw
         +nGUpc+9WiIhg==
Date:   Wed, 9 Mar 2022 13:29:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mfd tree with the arm-soc tree
Message-ID: <20220309132952.525b3aa4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nS+BbVYJ.+TjXE_Z.JuxTLp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nS+BbVYJ.+TjXE_Z.JuxTLp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml

between commit:

  e465ea5cc05d ("dt-bindings: soc: samsung: usi: refer to dtschema for chil=
dren")

from the arm-soc tree and commit:

  0ff4827ed66f ("spi: dt-bindings: samsung: Convert to dtschema")

from the mfd tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/nS+BbVYJ.+TjXE_Z.JuxTLp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIoESEACgkQAVBC80lX
0GzAUQf+ODsnBkQtuQiVylNTNUtG0njOVLH2/3IAFhQ56rD/6ZJwTYwiGFwi6htR
jZrpOycKoPE2HbKMngdUyRKfpGoPj0sHuz/fb3QcxXWN2WQGUkEQxcIa8kGU9LDq
WQtG9blCjgaZwAbYhf3V/a7ZDDi4cBd/PPxMRmO1jF9PWWyGPCSIkD6F0yA2yKhG
YrPSPgazJPaYNA6ThojqTNOPA4UHJs1zvXM6Z7VgpPOncUEuj16TX1vp5mmX98de
rFYt44eKvvviGXPz4GThbXtRBb7+EI1P60IBMJ833hNYesivm9up3/hPMTZ2kxCE
e3TGWOPNM678tFldblIzLpMCJOjjcQ==
=iRsA
-----END PGP SIGNATURE-----

--Sig_/nS+BbVYJ.+TjXE_Z.JuxTLp--
