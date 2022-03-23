Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9A4E4A41
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 01:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbiCWA7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 20:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiCWA7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:59:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B88613D06;
        Tue, 22 Mar 2022 17:58:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KNVMk74RQz4xRB;
        Wed, 23 Mar 2022 11:58:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647997092;
        bh=pidBt9WRiWeMGPxp90p95PzjZtrosrfkBzbkrdrUFv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r4L3prxtjrbF8YsXUkh4Li1bcHinDn8Ozm/KtITQo15s1q8EPVzBweqPDR6aJFkRc
         DuHDy52CsTDS0kcATJE60gAA0RZjjyPxFJZAKHDPmZrbQNPfUVdZp7C7AWjHHNnpCG
         lXMYMSqT7JeE2rTUCwUKvjmKjJRaCUtIO0qrSg+iYaP03wZ8jv/p+afTvLkvzc+IRL
         DKB5/j5LzBI8TRg+26McTDTo0rZqDd6MhLTCHKe178Lkhm/wW7siB7YzeYCDpJDhag
         i/e1ACzuBWun6XUDXtQjPCQcXpThmXO1FWUt6jFnPMrMLHVi9Bh1ZeUa/d1cyZVqmR
         rNSwIpOdKS4IA==
Date:   Wed, 23 Mar 2022 11:58:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mfd tree with the arm-soc tree
Message-ID: <20220323115810.2b1ce018@canb.auug.org.au>
In-Reply-To: <20220309132952.525b3aa4@canb.auug.org.au>
References: <20220309132952.525b3aa4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I1yL3Wodt.44j4IGhFasOqZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I1yL3Wodt.44j4IGhFasOqZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 9 Mar 2022 13:29:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the mfd tree got a conflict in:
>=20
>   Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
>=20
> between commit:
>=20
>   e465ea5cc05d ("dt-bindings: soc: samsung: usi: refer to dtschema for ch=
ildren")
>=20
> from the arm-soc tree and commit:
>=20
>   0ff4827ed66f ("spi: dt-bindings: samsung: Convert to dtschema")
>=20
> from the mfd tree.
>=20
> I fixed it up (I just used the former version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the arm-soc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/I1yL3Wodt.44j4IGhFasOqZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI6cKIACgkQAVBC80lX
0GzTKAf+MAF1piKQbCyJCKYTdaVpe2p1hjmzU8BaRe4o9AU0UJTIg8gKn812MVbI
abtn/R+b99OhQfhel5egS3ionjthfunucc4ZsPdHiWNbm/MZQrz2zzYYYbz7KwGH
0gVYlUnPW7hBR5bj42DQBELB/FMNvEx62zGz7+RF6RM7eHmzEDcfsq212WM+TY0X
7u2n3k3LCkMsB8fQ/P9nmEWTTf2DlQoRQrQXSN65HIo06Mi+bd9XkzvrreyZIUGC
z7xXlED+ecEBdVGsPIku5pvZeFs9/VBUl/V6V1wnref/RzrjF/RbW8u3/tyk+mhF
QtNj4htnl8KwX6Hsud8n6b6W84Po2A==
=eeq/
-----END PGP SIGNATURE-----

--Sig_/I1yL3Wodt.44j4IGhFasOqZ--
