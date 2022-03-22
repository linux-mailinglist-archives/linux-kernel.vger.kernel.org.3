Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC74E355A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiCVANx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiCVANu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:13:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC52D4D7A;
        Mon, 21 Mar 2022 17:11:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMsKy5bk3z4xL3;
        Tue, 22 Mar 2022 11:09:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647907767;
        bh=4nqnqth803i/Xf8RxS2LPdwAs0gytBUqS/Ki9UbFU/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WkyHmOlGWeOcConUsOwGb5wtziOlfFWgr3Pqf1iBP9uPQ9AhTO3RafUR7aldIjINl
         RtIxaFZkziB5SMLc4FofJ8dBOhnd4pa5WqDssv+yEH37otNPV0G4evYR+Y+3Qc92KP
         qhMAYyWc5qVPPQYpQAfFpK6SW2PQLVZwQDgfEctjWZEqu5ankEEmoxPnppTwyCVilF
         nidqkuMoT8b5S28dTvugDeApUpiLudT0PVamTRxSlKXpTk/i30feDdwuIDsfwMXBd7
         39CFr463iSLpEPnRyWv92UFOYuE/FGODRi5eXJ0+koyZymRYpdDTg6jntu19Z4gWSa
         5e5+TDK3Cq6dA==
Date:   Tue, 22 Mar 2022 11:09:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the parisc-hd tree with the
 asm-generic tree
Message-ID: <20220322110925.7b295e54@canb.auug.org.au>
In-Reply-To: <20220228114523.03b2f921@canb.auug.org.au>
References: <20220228114523.03b2f921@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JECP/m+MkvZbCsBV3x2wGku";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JECP/m+MkvZbCsBV3x2wGku
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 28 Feb 2022 11:45:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the parisc-hd tree got a conflict in:
>=20
>   arch/parisc/lib/memcpy.c
>=20
> between commit:
>=20
>   967747bbc084 ("uaccess: remove CONFIG_SET_FS")
>=20
> from the asm-generic tree and commit:
>=20
>   d4a767ea8b0e ("parisc: Use constants to encode the space registers like=
 SR_KERNEL")
>=20
> from the parisc-hd tree.

This is now a conflict between the asm-generic tree and commit

  360bd6c65807 ("parisc: Use constants to encode the space registers like S=
R_KERNEL")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/JECP/m+MkvZbCsBV3x2wGku
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI5E7UACgkQAVBC80lX
0GxbDggAn6FQaXTvpmAOqqfelYM0EN747gukeBKFXbUP64zbqUjQg9wzpSULUR0I
bIrR4kAJEmic2i5goPHE5c/KgG+pGC80muNBL2KXtEPwSBk5cJHv0v7tUC9SYgSD
ePEI75xwHjd2fc6iWjXTewd8CTEcfw+n+DSHsF9GHBD30+JG76OfdbgU3Bjx+NZq
guwsbqCaoqkBGF4lmj+tWi0dopokNfCRkXzVx7RxHuvQSsGyYbSSzp6a5SjUfxQH
0ferJuYWLMTNO13pyhxdMhlHsnzVabnFh61/uGsZNp3pdKC6y0O6Hs+j409edwR+
FiuFT1zPrK+48+jZTqfOQZPIRsDKoQ==
=FBOi
-----END PGP SIGNATURE-----

--Sig_/JECP/m+MkvZbCsBV3x2wGku--
