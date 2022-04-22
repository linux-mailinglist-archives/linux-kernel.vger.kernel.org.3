Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BB750AD1C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443030AbiDVBRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiDVBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:17:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBB3ED2D;
        Thu, 21 Apr 2022 18:14:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkxJv1RSRz4xPw;
        Fri, 22 Apr 2022 11:14:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650590080;
        bh=PDwdWAr3d36JH4WWt/FccU1tk8rwMVXRWseC7stMlsM=;
        h=Date:From:To:Cc:Subject:From;
        b=Gb0CDA7eukAe0P/i42k0HOKCRwRH1jA0+DZp3nt5xb6JkQ0rWrOxTtzbS5rtS9cAv
         m/ID0RHAA+E/piY2anrEQd5QWOOlJoOnGbpUDDsWmwZarEAHd96x5Xfdyb/0xRtKli
         jaB8pUmxihzbcKKPSdjUj9g6VFjN8HaVt8QJOLW7yQ/umCokGXl3jqn1BmpQdi69RZ
         QS/r6LCAsohc24zzjcrIkr8+qfXhqY4bvWJlSlsj/IKYqkDFIvzUDcoqZIOTtmZt0J
         nvG7qNLx+AksBZXA1fJwifkgEQFuxI8SeaVpgjQvl9ky6J1/sRhwQkhU3g9ddUBYaY
         8Bhl8Thc6Z31Q==
Date:   Fri, 22 Apr 2022 11:14:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <xen-devel@lists.xenproject.org>
Cc:     Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the xen-tip tree
Message-ID: <20220422111438.3946dbae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Acwu5MAWinYu7DVgoSV1rm.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Acwu5MAWinYu7DVgoSV1rm.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b12d41716e32 ("arm/xen: Fix some refcount leaks")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Acwu5MAWinYu7DVgoSV1rm.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJiAX4ACgkQAVBC80lX
0GzLbQf/cAY5DZMoJcCtPP8hz0H5FOYfij/KKWzsQQ2SwET5tZnJunLuHEgGyaMQ
nAZK8EBg4cGBoabLnmdSzYL1gT68MlQJu3YPkBDPXmiJwZ0byd1LYMdex5z3isG/
ttkeb6VzAflpwtMGT3rS/C9ClH/WdISXofDOHK8jrQVKgZyg9fuC1pi0yfwlw80O
WgKGPAjawSdG6rh4urP0M9RoFH0bDoV1T66NYPflGMUqXC3pEQpEFiq27mXkwu38
5yk0zlGMy8YsW9J0pmgDU3foENCua+CqYppn61WgA+FDrfzPCVu6Q2BWdRfuHBh0
QvlCAOMLaHN4AL9g6aiI/X1YtqWZQQ==
=kNGi
-----END PGP SIGNATURE-----

--Sig_/Acwu5MAWinYu7DVgoSV1rm.--
