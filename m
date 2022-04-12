Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7841E4FDA28
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353624AbiDLHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351884AbiDLHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:13:03 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 4A2B51039
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:53:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1649746436; h=Content-Type: MIME-Version: Message-ID:
 Subject: Subject: Cc: To: To: From: From: Date: Sender: Sender;
 bh=CrnCIOfBYIadE7ysir0roGXoerEsn51pLccKc9in+ho=; b=B84pj8byG97/6sREz8dXyQmXfxoTyVEb4TUhkye9oN7xDHe4y6Io8XSMi7ck4WkLnm06pz1C
 +zgA7A5bGiPNUCx4i7Zp3cJAAuUKxRDF/jo/bdOgMvzpBZRPuvcDhvymKUmDFyJgIzAOhIWh
 gMojPk3ySj9G+fOiUznM+cdtMkduke3smoAwwtfD5w2FiQegpxmIKfOhZz3ZjljtyA2f31wI
 5IQ+FbeHKsOsZ3Tj6YWgD9+3PBRZNWVU52hd7IfhuOrfLEaz3TAOwULfMumVcTzh6ihEEB2o
 VEsC2b01n/uAJqfFrLQFuJLFNreAcJoA4JD39biq+vLYX8EpUjf18Q==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 62552202225c469082002d64 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 12 Apr 2022 06:53:54 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 12 Apr 2022 03:53:46 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v2 0/3] staging: vme: Restructuring menuconfig and tree
Message-ID: <cover.1649721450.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mnzhopgrmzo5kgdj"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mnzhopgrmzo5kgdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch series modify the vme_user driver's place in
menuconfig (1/3), fixes a missing `depends on` line in a Kconfig file
(2/3), and rearrages the directory tree for the driver allowing a more
straightforward comprehension of its contents (3/3).

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>

Bruno Moreira-Guedes (3):
  staging: vme: Adjusted VME_USER in Kconfig
  staging: vme: Fix missing `depends on` at KConfig
  staging: vme: "drivers/staging/vme" tree cleanup

 MAINTAINERS                                          | 2 +-
 drivers/staging/Kconfig                              | 2 ++
 drivers/staging/Makefile                             | 2 +-
 drivers/staging/vme/Makefile                         | 2 --
 drivers/staging/{vme/devices =3D> vme_user}/Kconfig    | 2 +-
 drivers/staging/{vme/devices =3D> vme_user}/Makefile   | 0
 drivers/staging/{vme/devices =3D> vme_user}/vme_user.c | 0
 drivers/staging/{vme/devices =3D> vme_user}/vme_user.h | 0
 drivers/vme/Kconfig                                  | 2 --
 9 files changed, 5 insertions(+), 7 deletions(-)
 delete mode 100644 drivers/staging/vme/Makefile
 rename drivers/staging/{vme/devices =3D> vme_user}/Kconfig (93%)
 rename drivers/staging/{vme/devices =3D> vme_user}/Makefile (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.c (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.h (100%)

--=20
2.35.1


--mnzhopgrmzo5kgdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYlUh+gAKCRAZtd3tyEY2
kpMsAP9wfC+zTcnd/S0kjFyUc8rojGzBJsHhIx8Rwq6YXQIMKAD/R7hm08SbS5TE
/RoiuhqA54lIdJKL4fT/SqEMEvMtpwo=
=SnJU
-----END PGP SIGNATURE-----

--mnzhopgrmzo5kgdj--
