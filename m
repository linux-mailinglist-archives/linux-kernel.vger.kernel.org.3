Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BFD4C6031
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiB1AqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 19:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiB1AqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:46:07 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB80D3A725;
        Sun, 27 Feb 2022 16:45:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6M9d0d1Bz4xbw;
        Mon, 28 Feb 2022 11:45:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646009125;
        bh=jIeh5ZDTWWqfmzOCG451MDPxA/sl3YsI/XKs8m17ny8=;
        h=Date:From:To:Cc:Subject:From;
        b=OJ5275vKY/9y2tH2T2avpkThoUeOhTD4ewjQ4GuPH+1q3we7u45rM/FkWRNrQ3+aA
         pSMb5olUUOwvEQdAtVvx/s5U4Nkqd7Pufps0WlkPLvepsH2lkvMfUXNNogymKkSkhT
         sAFj1VNs1q3pFcvIOkL3ljMe0STNETRl6QkfO7x49wUUyo0Ntm0rkgvCTe71WPgWrp
         Ezy3znTrcsasPiWDY2o/Gk/c72oTd6NLsRIZn9NpvHWvPHtahInjygIXyjPNQl48lu
         a170v7+rjxKShS4uN0+qWaduULHYS+J6PwTn1cXY2dNh76GbQE08bfhY3ZrgZKzSBU
         9w24yOlolcI3g==
Date:   Mon, 28 Feb 2022 11:45:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the parisc-hd tree with the asm-generic
 tree
Message-ID: <20220228114523.03b2f921@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/env_jC=hHeghxkPdsvWNmCI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/env_jC=hHeghxkPdsvWNmCI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the parisc-hd tree got a conflict in:

  arch/parisc/lib/memcpy.c

between commit:

  967747bbc084 ("uaccess: remove CONFIG_SET_FS")

from the asm-generic tree and commit:

  d4a767ea8b0e ("parisc: Use constants to encode the space registers like S=
R_KERNEL")

from the parisc-hd tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/env_jC=hHeghxkPdsvWNmCI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIcGyMACgkQAVBC80lX
0GzlAgf/Y+T9OD9bA/CjKlAT2MmZvVmr6WUxoHdvl/nMGtPJwGhmzTEcwoQh/5BV
S5H/M4fZSFaFJa7ky2prbwM4kvQYNnZvPku9RTDI7AKKNX1aLS2A2zjo6TPkRfrn
4ECamNmBox2Qvp/BFwMLjutvGTOVReaGVEPTp7pa+LlAOOC8V/cfdAQZKxY77dmh
GijSl/iz8MnCO8tLpTJzGzvaz3bXaHhVcP7S+NIfJnbwn/ZqJeS3tNVymp1lldnF
ZpLcGi091OYwqVRKaiYLB9lc1Ou6gydrD9xxWuFEim6kXX5mCUG/7Gz0g4cnVOA1
xoiyRWs8oXW4YNfqLeMp8BfO6sty1w==
=Epxv
-----END PGP SIGNATURE-----

--Sig_/env_jC=hHeghxkPdsvWNmCI--
