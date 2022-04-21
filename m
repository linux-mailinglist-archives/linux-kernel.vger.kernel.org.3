Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF650ABD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392623AbiDUXKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiDUXKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:10:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11D043395;
        Thu, 21 Apr 2022 16:07:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KktTq3Jhjz4x7V;
        Fri, 22 Apr 2022 09:07:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650582432;
        bh=sbbm9H/2IAzK4sv5W+QwATkGNJ5Dqq8EBhM9Vr6iJgg=;
        h=Date:From:To:Cc:Subject:From;
        b=FjZipVJT5UTmUADuSiXWM7uWZcTB0I63xM0weEUtAT/S3OR/NzsGoFJqoNP9lQMF8
         tdWGt6s52IGorUxbo/ma7+75l++AC7TBBpsQeKCDilbB/BdVZXG/MmhzZUMO7fhNVY
         O7Q1DshjT4g0cLf3twMImheALDKzu0K2maDP5psrH9F8RlsM1PFRB1tUYKX5OgCaMQ
         xUQkkZz5t1E5jbv80/vfsK7Q642Sa/DTFwZyCjOC4sU/dQyUjwzoswj1oc2yjsFnBm
         Ihf57h/+849NUmP6OZPAclNI1VJ9FqekkzIWlvIhYBOw5j76Sv9SAw76vbk2j9T4Xk
         ckf25bMBSiIeA==
Date:   Fri, 22 Apr 2022 09:07:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the arm-soc tree with the
 samsung-krzk-fixes tree
Message-ID: <20220422090710.5d947170@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IMZHDZPL=gg0QrCYKLG0RSS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IMZHDZPL=gg0QrCYKLG0RSS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/Kconfig

between commit:

  436ce66003d5 ("ARM: s3c: mark as deprecated and schedule removal")

from the samsung-krzk-fixes tree and commit:

  b59e8a5fd321 ("[TO BE REBASED] ARM: omap1: enable multiplatform")

from the arm-soc tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/IMZHDZPL=gg0QrCYKLG0RSS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJh454ACgkQAVBC80lX
0GwHBQf+IFoOJtvnOSRVehHSK0xbh0LOC1X4SQp+gDC/CkGG6mgWK95osyUHhpLj
2Nraa/NsOUXu1Je/uqxV0UwhwTvgpr7colCJyo43yXKIpYvjbByTSmZS3EMoQv09
H+cCiTDd/xvmrWUwhkHRAdDn1ImwCRttdcqz/3H2ACt1cRSQysYFKxv0+SdKh6J1
YqTA1ta/qGzksr1Uvgc9avL+/ewdKGabEL3DJOm6L+ChEly/S+YUh0uW22hhkmXS
BGFnepv1G2YzAx+Shjv0W2us8lOkp3DSNue8vS+Tm7VtL8MPmj2czUsCEMnmjIIB
Ntw/TO6LjkSE3b183YARaEfe4Zpb2Q==
=PfCC
-----END PGP SIGNATURE-----

--Sig_/IMZHDZPL=gg0QrCYKLG0RSS--
