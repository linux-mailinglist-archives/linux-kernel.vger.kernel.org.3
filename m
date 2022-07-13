Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD40A573FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiGMXNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiGMXNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:13:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC544B4BB;
        Wed, 13 Jul 2022 16:13:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ljthf4MRTz4xZB;
        Thu, 14 Jul 2022 09:13:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657754005;
        bh=8QDhy/yafq+zddNmXsnWB3SOgiThHS2yHFHT/LoOpPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rhhdHVpJFja5h2fSgLdZya6P+U7TbBDSn6rRH4VHqMSUaB3LGcs5Hmh3RdvubQru9
         LdzS+/GJIrXRwyAKvmvxb5af9C6RrpugtIqakDrK+uxEgZOJgvSNhAwEHDYv4YFJ6X
         yGBLHCPRC9TX3wfFJZ9NwVj6n4w8Sx0wcR3lARL2DL0C/0JRgxTNrEefXNR4R45pXK
         /4rEEzwDSzPP9MwJhISz0/XcgksoVoMYg2UDRM9PnD02nzdRt/dyPd/sm0Dw42Ge22
         PyvfWTurVrmfv1oMugdeg5/mfbJrFKh/Esq+3BghM+tL6K1pTGtoWNg+vMIm9f61QL
         lu8p/nFB9bEUQ==
Date:   Thu, 14 Jul 2022 09:13:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Zhang <william.zhang@broadcom.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: manual merge of the broadcom tree with the spdx
 tree
Message-ID: <20220714091321.4ecfe830@canb.auug.org.au>
In-Reply-To: <20220711095520.4fad4c97@canb.auug.org.au>
References: <20220711095520.4fad4c97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ekux/TwU2iZousa/RrxmrUB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ekux/TwU2iZousa/RrxmrUB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 11 Jul 2022 09:55:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the broadcom tree got a conflict in:
>=20
>   arch/arm/mach-bcm/bcm63xx.c
>=20
> between commit:
>=20
>   52e6676ef56f ("treewide: Replace GPLv2 boilerplate/reference with SPDX =
- gpl-2.0_30.RULE (part 1)")
>=20
> from the spdx tree and commit:
>=20
>   889390f83d4e ("arm: bcmbca: Move BCM63138 ARCH_BCM_63XX to ARCH_BCMBCA")
>=20
> from the broadcom tree.
>=20
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the arm-soc tree and the spdx tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ekux/TwU2iZousa/RrxmrUB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLPUZEACgkQAVBC80lX
0Gy92gf8C1qZ21pWn3/VKWtP0JOV2I9uvqpJH4DWoDDbfqOpINgqTBEn2Gvqk9b1
6N7fK+C71ZZl99pkNgAM7o5pHPEFqhiVTX2M5VXCCNjqxfJCN40NY7L5OAS7TA9e
rkHsyUywQexnADKUKuhtjwR5ebH5peteu32xsXOE/D7rmrbCunvWt34HkEWliCNH
3OhVZ4K6lhe9JDPYA4Mb5qf/5BDsdNx+NLuP6sPi8QJ3BM6lk2fTTvzGW0ynhAJI
zyguUGi/j0Oa58N8RB1G+0OGWIcHTvs6ar+r7neGdmG+sH7upnsY3saVZC2F0zuw
gbsxc89VGhNA1vb3Tu4GqXcTGIYpkA==
=RNOJ
-----END PGP SIGNATURE-----

--Sig_/ekux/TwU2iZousa/RrxmrUB--
