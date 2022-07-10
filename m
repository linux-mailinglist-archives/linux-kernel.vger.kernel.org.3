Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54B156D20E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiGJXz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGJXz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:55:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7776A6386;
        Sun, 10 Jul 2022 16:55:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lh3mT3Dvdz4xbn;
        Mon, 11 Jul 2022 09:55:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657497322;
        bh=cKdhqPjL663aReE7J0Akh1OlDsvIBphzF9qwxMYLS4g=;
        h=Date:From:To:Cc:Subject:From;
        b=F9LAfyXOnokWcsxgIt+Cjh2qY+jTiZELrrOma+kLfwWC28AAdtlQicSoMyp43Uvou
         9Bi44zItPqauGkluLLItxsPJTI2aZ/6JSDKfDPMorT8rXuWYUoGsGk0SNNPJPn6sMZ
         cD8wS5zfnW9bnPhpcy2mi6NoxdKWR8MhTbqMvW2Zy34Q3SXIj/VWxQj2EGaNBOkdTw
         oETuJovRsWZ7YJ9SRcj9Jxf4O6tQ1lb+XN1od9RvcAsymmHKCwSBFIkKOf8Ku6WeKD
         gVYFAMH9nipkAntZIRHayR9+dlACk8CVCLPLeR8UFVqQ6DFAEm4DGH7ZOVOFJ2sWOZ
         Sbb/jFyL+mHfA==
Date:   Mon, 11 Jul 2022 09:55:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>, Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Zhang <william.zhang@broadcom.com>
Subject: linux-next: manual merge of the broadcom tree with the spdx tree
Message-ID: <20220711095520.4fad4c97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QZfOo4.E+tZm9BtI5+68FML";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QZfOo4.E+tZm9BtI5+68FML
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the broadcom tree got a conflict in:

  arch/arm/mach-bcm/bcm63xx.c

between commit:

  52e6676ef56f ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
gpl-2.0_30.RULE (part 1)")

from the spdx tree and commit:

  889390f83d4e ("arm: bcmbca: Move BCM63138 ARCH_BCM_63XX to ARCH_BCMBCA")

from the broadcom tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/QZfOo4.E+tZm9BtI5+68FML
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLLZugACgkQAVBC80lX
0Gx/VwgAnlmSEjd0JRZwT6D4uf3sQYuy+nWRDm6cf3STHRSMqdcbRDfKrTQcbJa8
C67VTf3GH8oddBu8X1I4/aFvjHiFof7mUGt0DwWFnp8Jhs8g7RiKpzi5x0X/heqK
BdsuIYmW4zq2jtJCnx8UEkMj+MlJCLvyOjibEUv2xF4b5QKpFVMBTLnagEQVy3MP
pkr758q1O5y4Bm3HjFqwWRrBDNs8fN/QdBbkVS5Q2/d5wnhm+Ak7pzhpiPM6DcmI
L0Fvnvo4UpaveFk3EUMCM8CfbRR/h8NnnzlObKv2uPUoYIFBg/f6VSAS1/cJ0Bm4
fd24y4m+xXtQnS6O+zH2E8SeCEDt2Q==
=yEwP
-----END PGP SIGNATURE-----

--Sig_/QZfOo4.E+tZm9BtI5+68FML--
