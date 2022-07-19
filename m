Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3304257A9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiGSW1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiGSW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:26:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A342AEF;
        Tue, 19 Jul 2022 15:26:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LnYN01lWyz4x1c;
        Wed, 20 Jul 2022 08:26:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658269600;
        bh=Dnd8XrokloWaq00/sVIBE41CvanndXephbaBFx7ZZ6E=;
        h=Date:From:To:Cc:Subject:From;
        b=d5dZlRd15Qfhen+ZiGTDoKe+dcf8UX3U1NbBfmGMf6tX2yVxwDa0cpzMRgpVGG7Zw
         3fagZWzYQyy2/8yx94pBX3jH2HNekwFI9d39Oq9/8BggnkdoTR+AZhxn0/HCO9F2gI
         xuvhuLivgep+ck6XJYC4qxvpDlPYqiiyuC6W1ryrTkY6Kq39hAhHvFrM2bRjFH/f/F
         bKrh+rWt2UvrtY5Qgs74XlMZxboR+WZAZkQd1P9WomZgj6zctrIWtCK2klAj06VINR
         e0g8hVXrOjydO/if2v5zuNi20SBJi0ZDCvRG+NUvH3+0Sc7e8iM6FDPAWMoRkyPSbG
         EKQ2P+NTnBA5g==
Date:   Wed, 20 Jul 2022 08:26:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the kvms390 tree
Message-ID: <20220720082639.72a0f57c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kC/Zb8il+rXqi6SZHPMefJ5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kC/Zb8il+rXqi6SZHPMefJ5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  52db9dcc7b3b ("KVM: s390: resetting the Topology-Change-Report")
  a20e4a94c7e8 ("KVM: s390: guest support for topology function")
  117e052974c0 ("KVM: s390: Cleanup ipte lock access and SIIF facility chec=
ks")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/kC/Zb8il+rXqi6SZHPMefJ5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLXL58ACgkQAVBC80lX
0GzeQAf/WiiKfSL8yA5lp5keEUcXzuhHIPuZOiRwCcAPppnZpBE84rSabl+PpqUC
euK71bKxMuBUU8m8o01fyjmYjSboRS1BrTH8fFpB5mRPeEEAtnRTDzOICREPtIIl
6QrnaieCCNo5yWuayX16lI8l6slm5+7Vd8e3PBGm8VKaA6f/5QpER8GyqTgGF+dv
P4Spp+uTbuu+JKVrBbsUNiNLC4WRUThve3SAmb2yGL1sw90gjtb/T25FVM0yo4LF
+H+LFHkXphAQ8zBtdPNw/BH7j62yiuT7zAmefikoLT+7cL9R4yolsGEQ5ANzIMos
4GhsTtInKLSR60Ep47ptfj/bIXI8Yg==
=V4Du
-----END PGP SIGNATURE-----

--Sig_/kC/Zb8il+rXqi6SZHPMefJ5--
