Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2806F505EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 22:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbiDRUnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 16:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbiDRUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 16:43:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567FB1D8;
        Mon, 18 Apr 2022 13:40:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KhzMr3F3wz4xNl;
        Tue, 19 Apr 2022 06:40:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650314425;
        bh=9agyEmuiypG94eVvorJ8y98r2UF29vOEKNsFpbFyjlw=;
        h=Date:From:To:Cc:Subject:From;
        b=Ac2dkAz0llnwnNB5YUtu6riurHAHp972Vg8P1VDBIWZQ5nJBL5Tv4cO9e7OmsIuX2
         NI3syIuGu75oSp4/ePK8uC2BTLBcNopqqZp/SyLYUG6jn9D8TIo9CicqIUZhRyKT3U
         13fdljVBlvaAQUWvgKcmXENOMdP8ZD32mv0VMQV9onBhvvxeBqRQmCVCM02nm0/JhE
         ccmdjIqu/iGseYeylkL8aTqUHTIFFc/6r0vbpJdjo46925XsPpwSUE2hhELpuSpmVo
         yNTwRPJqFvUj3FXNwDOJmVUm8s3ox2jWkdIEqJlkk0+6rk74SSvJOKNG+3bOtJplpC
         7J8ExDiJM///w==
Date:   Tue, 19 Apr 2022 06:40:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Rolf Eike Beer <eb@emlix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the arc-current tree
Message-ID: <20220419064023.4cedc139@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8/RFPmKQV81F.6qG3noSAiT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8/RFPmKQV81F.6qG3noSAiT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a20aadab6ad6 ("arc: drop definitions of pgd_index() and pgd_offset{, _k}(=
) entirely")

Fixes tag

  Fixes: 974b9b2c68f ("mm: consolidate pte_index() and pte_offset_*() defin=
itions")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/8/RFPmKQV81F.6qG3noSAiT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJdzLcACgkQAVBC80lX
0Gxzrgf/cBzXqxXAffJqAd5iI5tgZDAaXJm191s7Orxj0lhicR9vqjOaM94arZZk
SnVmvWHdW9p0FZE5nFeurTJv/282t3/LsuFaQao6yIde8DgVLIuqirGhnU0E6CrV
83Aim1LkRbwa85wcWLHndHx/Ei0iTNWEdYQy/IFgNkN5QUsA+rcd84pD83IP3pZz
XNwFy9wsJUkKEYFSbWTscIzUikFOwuhfGoKaGnJ5/GV0bCNxbh8k5SqDfekRWN39
3w79rEs3lPdmn9wikLFNf1ZwhwxIpwl7ql8k7anUCw7r/3AvKxqaDemYfuXvhHDL
2toyBMrLbDzUXtjp135HQlIKxNXY9Q==
=v5cv
-----END PGP SIGNATURE-----

--Sig_/8/RFPmKQV81F.6qG3noSAiT--
