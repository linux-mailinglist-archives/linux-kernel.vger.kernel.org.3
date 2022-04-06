Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3363E4F5B92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357637AbiDFKTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377250AbiDFKSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:18:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA4E43A7;
        Tue,  5 Apr 2022 23:45:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KYFQC2Sxzz4xNp;
        Wed,  6 Apr 2022 16:45:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649227539;
        bh=GY7NqJT5gG15KDdh+bqIXSFySSoQEilEDlX+CFfVH5M=;
        h=Date:From:To:Cc:Subject:From;
        b=qjwjHMH5ttiBhM4GfXQvLVTVXKbv3XRQe8zlqkFCjwz36Iyl6kX9EWftSWfXUolcY
         F4Jmb8J3crTULvcshcEZf5nd2o//Ad91gOtU9KNXGeGGolGDmkPLE6x8cZQLRijoEj
         Mzw/Uj/BA0yeBRL3jxeDtfsHnF7RBk39xw5APF1qdoSzzC0vpNdUfIigX801omHD/Z
         YMOPZPvzuc4UCH6NUyO/GlzHp+h/zR8D9O8bPIQrbwUg0G4B/RAu7QjYgPaYl1Z4Nc
         LVCZoy2b0xai+yqoc/eNzDCXMe9lF2K/aNtq+5A1Af6Vl1bZ3b3SXECZvowxERtHFE
         bK7cff63RcuxQ==
Date:   Wed, 6 Apr 2022 16:45:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild tree
Message-ID: <20220406164538.0438bd0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uAcPf6hRDwqokOX0NsMO1d2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uAcPf6hRDwqokOX0NsMO1d2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  33057b0081b7 ("docs: kbuild: add references on Kconfig semantics")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/uAcPf6hRDwqokOX0NsMO1d2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJNNxIACgkQAVBC80lX
0GztYgf+Po2sx3ZyCb8JCY1PE9r0gxnHMR38JnauKMHT0BgL/R6o2ydwZmwPsQXI
b2DHDScE0Fk8p2gaYTVUrSsIJ8/wwzLXXQY+4X7GHb23z6xuP91fF0+bo5CQHRU9
X7NoZJdJHnF/E0s7mINPPnpNR433LvtKBR6bhf4KYjt6xqmNLFS3gsomWatL6Oq5
c0F+vgnjlOZKpKb1T662ZpqKEC1+wNEy4VqF1pXywqOSh1VoobTn/cQWGinyIQRR
U3XOcXaIBc6/pSIRDYfCfImkST07v2Bl+fCIbXrNCk9LfMdMv8hJuSExsObfuO0r
nyVJ58+0BXUbRzxeHWRNzN4rtnHyNA==
=jj5G
-----END PGP SIGNATURE-----

--Sig_/uAcPf6hRDwqokOX0NsMO1d2--
