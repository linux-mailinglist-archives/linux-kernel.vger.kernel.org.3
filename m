Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB284CA3C6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiCBLcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiCBLcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:32:39 -0500
X-Greylist: delayed 23385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 03:31:57 PST
Received: from gimli.rothwell.id.au (gimli.rothwell.id.au [103.230.158.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0272231214;
        Wed,  2 Mar 2022 03:31:56 -0800 (PST)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4K7sQd6VVgzyR1;
        Wed,  2 Mar 2022 22:31:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1646220715;
        bh=cGQ/Prp2ZF3cq5EOsFgJhjoGVAgt9x539UwmRwN7hsc=;
        h=Date:From:To:Cc:Subject:From;
        b=WrcgciZWzgbabQzge+Jrz17c5SCcE35RZGOiSehNfJY4/UvmSoyUgPs8WvJCzVj9w
         5hOvMgOnqXqallVLk34gK/4/H9+I6NlD+QchHLm4VB6Dg9bca/sM32ybNqdhpAoltl
         jJztgqCyDT5cNRopaNaYxBGUERAYWzP9Za22vMfihqYA7w6P4Q1MGON3SwaIPzAP04
         DcS8QUuGTruXMZ4X8nAyUxKt59I0ZIVaAUxi+GiCpQB1iQW4Mx9OhmQkLgOFlIgiWa
         PxlkU3yMC8Tar/6t42li8mWzbTnQbcfzoIGQpbh3zt05z4fzx2gMtnlHyElKGVxkrl
         hm/PLRIvRXoEg==
Date:   Wed, 2 Mar 2022 22:31:52 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Alan Kao <alankao@andestech.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: removal of the nds32 tree
Message-ID: <20220302223152.13a7d2af@elm.ozlabs.ibm.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LjflsjsnaP7l9tmaX2Dx8wy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LjflsjsnaP7l9tmaX2Dx8wy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I noticed commit

  9f15ac318b83 ("nds32: Remove the architecture")

newly in the asm-generic tree, so I have rmeoved the nds32 tree from
lixnu-next starting tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/LjflsjsnaP7l9tmaX2Dx8wy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIfVagACgkQAVBC80lX
0GwKxwf+JouGByaXcUjdIq3SYb5WrpmiqjpMZf5aoUBYK8LS2HGeOxR5WnUo/9nA
CYyd0KV3VBlBiO+zIBnJ5zhqRqkfBUgkxZukzM0SZ725lx9kowh/HWKKKCfEmq9A
xyjjZTSKBFVkmKK2KJAKA5Ur7GHXwznnjDzAc2UyLhzzR/TBLJaFv04LnnfUBMWq
8AKtrJ/FxVUaMJXRLzekf82Q5ThvszwM/ywTt0w4UmfsFGjUc/81ypdNX4614C9+
mVjPmHiBVQtpAWeCfsUY3Ds3ms7c797jt1VYwFffh9Sdu3Vmf10aVJQpd/nXFRfa
0HDDmgohtPlGhsVRNR1/lgezjDtaiQ==
=7qyT
-----END PGP SIGNATURE-----

--Sig_/LjflsjsnaP7l9tmaX2Dx8wy--
