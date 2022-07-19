Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8737E5797B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiGSKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiGSKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:32:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A467B3F311;
        Tue, 19 Jul 2022 03:32:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LnFXQ6nLrz4x1h;
        Tue, 19 Jul 2022 20:32:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658226775;
        bh=XDv5DVjoHVv/AJBvQ+Rnx2ZLuzHQ7bwhJwWdKj6Qrk8=;
        h=Date:From:To:Cc:Subject:From;
        b=SnpX6Pwaf/KZa+EEDOmAvOucKVhbCHssrEmjxPg7PFWgOmhT1fw7Cik0UJEThcVU5
         xgltnb5sf44iHtqdbl+qavu03rY8VsrcP0qnvXE/tVqIoaBDSftDCZIi2fDAmYZTbk
         42Wib84VlZDgOuDgUb8PIGIxbDKf7tAu/f4W40FXMen9n6dxMIeHC0vB2RmI1/qGXR
         /vhr5K72X0hmZphJ+FQrL6UZIZCeaQC5smABxRJLD4GL/Tcyq1kvxInKzGT6evj94J
         bR1alpOje4tkGkfqq45UQFMq+oz1z2DTpLPGP7Qe5VJn/bAxuxVjx1uDzC11VcsDG2
         57PlVUohLtETA==
Date:   Tue, 19 Jul 2022 20:32:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the gpio-brgl tree
Message-ID: <20220719203253.40dfdbcb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=8kHWgAUUyps/5.WbPwYfJE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=8kHWgAUUyps/5.WbPwYfJE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  242202329f0d ("gpiolib: cdev: simplify line event identification")
  cc165ba48aaf ("gpio: rockchip: add support for rk3588")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/=8kHWgAUUyps/5.WbPwYfJE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLWiFUACgkQAVBC80lX
0Gx19wf9G9+mNYzRkI/9dtPYLOGfhW54RK7lO8GzQZ3AWd9r6ZrDa5HWlia390/n
AHAFo1M3eQtdXoU9rTgk0GOGNwjGSMUzH/G+QXq08eDR50FWtFNaAxKmiDMqB0m1
/TZf9AHuZi0GVsqT7YYwNykOOR61edElXPZPjktyXsr58wlDxA4bhYP7OtbWeNWc
HT/KcuFRVz6mrXni1EEeoMnkc+BGKOE62RrY/K7Tnj5EaU+/MvpnSZBMh3nNEJHe
z25EZePlEaOJSwqlKYqKhkD9K0qwTp6WKmTKfuvldZ+ZPjxqKqC6N6UnN/0NR0fE
k4Q9MGW752o1a3wWjMV7fcyvnVUmtw==
=CymX
-----END PGP SIGNATURE-----

--Sig_/=8kHWgAUUyps/5.WbPwYfJE--
