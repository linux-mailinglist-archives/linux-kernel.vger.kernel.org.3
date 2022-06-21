Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CC1552F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346829AbiFUKC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343738AbiFUKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:02:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C01E54;
        Tue, 21 Jun 2022 03:02:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LS2Bj6zsmz4xYC;
        Tue, 21 Jun 2022 20:02:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655805775;
        bh=vctygf8n4bMBEsR+8Tbon08BtTT5coxCQgJQe+wLYnw=;
        h=Date:From:To:Cc:Subject:From;
        b=HW2aODsXHbc8KTMopkMU77zhdxzUJWxN/ThLWhscOqWSGRUGIRkzVSFoREO/8MRsT
         nb+ZJl1P/JzaRsDXhEEt32Tv0pVCtq051okP77TT9B566u1pKY1XfJQVE/V4LA47YI
         6AG39K1+mKj+Mbrfmn0hCQDnn0FmnUqw2Ecnnq8KJKqUP5QczzlkVRTy1+vmVn5Ceb
         fSMusu30ukKaPJYUCpiiMcSpOljhY+Ew97bPSzMk07vDdcqBurRpBskuRqrLz6Pr29
         c3VOU+xrDDiVuz6nrR8IHppqDV/uescplByWQhswQDezD7qZDkzRDBfE54rKlgFrc/
         luHuz4Ca+CJoA==
Date:   Tue, 21 Jun 2022 20:02:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-next tree
Message-ID: <20220621200253.60ecf025@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zisjvhq+e3EwuX6MFCMZBsK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zisjvhq+e3EwuX6MFCMZBsK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/cfg80211.h:5741: warning: Function parameter or member 'u' not =
described in 'wireless_dev'
include/net/cfg80211.h:5741: warning: Function parameter or member 'links' =
not described in 'wireless_dev'
include/net/cfg80211.h:5741: warning: Function parameter or member 'valid_l=
inks' not described in 'wireless_dev'

Introduced by commit

  7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")

--=20
Cheers,
Stephen Rothwell

--Sig_/zisjvhq+e3EwuX6MFCMZBsK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKxl00ACgkQAVBC80lX
0Gxibgf/QvCAuVYrPU11+cCIqs42lXGA6HlCOC1YdPUcj1TQk61pnxhPRkcqT4L0
Z3x88lNn65d1CKnMk2fohj0K1VwDuwDZMa7SwoyXt/PrFHUCjMFGkeYub34hl8cI
imxZLbl0IX3gnwA4Vcz64V3PBRDOh0XsU6erMtfPKjdyi3thI6sWZLnuDdNFVsK5
6z+QytOm2ViM3qoM6DZGUuo354xi9bZsuvif3Y3GOasaopAFs5uzV4vRHRphzZ1S
vxC3K3CJ0kL+pnKHsW+Q7LiTYYp8LiGEZfmaOV2RXPVBJA+RZplhqzlaAJMREqDt
7JMB3Ny6jZZmBjU3sxNJqTVufkydOw==
=8B0e
-----END PGP SIGNATURE-----

--Sig_/zisjvhq+e3EwuX6MFCMZBsK--
