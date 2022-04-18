Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FE550603A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiDRXcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiDRXci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:32:38 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id AA6BAAE43
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:29:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650324596; h=Content-Type: MIME-Version: Message-ID:
 Subject: Subject: To: To: From: From: Date: Sender: Sender;
 bh=vzqFYCUJwk1+an4GHI9rSJK5ONK4gma9ml5pjiRuVh8=; b=Jz7kUYqNbN2EUT2K5sXpbMJ0ozHAdAu7ru8YAMWxO/e34V6lhOfqcKH74QcqI5jTrBL5UB0W
 GjOdMlApSNcBy8Q3ZVueAVRVkmgC91Qt4Yde1/l20GXW0DqrrQvQUKwNP7uuIVmbiexV/E2Q
 fjqli5iEmqIjCIITbciJ9IwMS7dedh7d+cR02ecl3vX5AMlrdv1lAf6i0zbQmYcqrgWu3pvy
 j1mYLXVZz4cxe/TAWcnMixI2jPpSm/hBfBSu+2chxwxJJojGukTymS1mQWiUz2gKTxoYIKca
 unnPjfvANIaLmSDBy5cxELZTwt1lO3v3P1P34+UX5nmE+VzeU10U2g==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 625df473487c9ee854f55f2a (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 18 Apr 2022 23:29:55 GMT
Sender: codeagain@codeagain.dev
Date:   Mon, 18 Apr 2022 20:29:49 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v3 0/3] staging: vme: Cleanup driver tree old structures
Message-ID: <cover.1650321310.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q2kxa542hsfldolc"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q2kxa542hsfldolc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch series modify the vme_user driver's place in
menuconfig (1/3), fixes a missing `depends on` line in a Kconfig file
(2/3), and rearrages the directory tree for the driver allowing a more
straightforward comprehension of its contents (3/3).

The 'vme_user/' driver is the only remaining vme-family driver in the
'staging/' tree, but its structure, entry in menuconfig and building
routines are still attached to the 'vme/' subtree now outside
'staging/'. The present patchset fixes it.

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
CHANGE SUMMARY

  Version:  v1  v2  v3
[PATCH 1/3] *   -   *
[PATCH 2/3] -   *   *
[PATCH 3/3] -   *   *

CHANGELOG
[PATCH 0/3] staging: vme: Restructuring menuconfig and tree
v1:
  Created PATCH 1/3 as a single patch
v2:
  Added PATCH 2/3 and 3/3, turning it into a patchset
v3:
  Fixed and improved commit messages according to previous comments by
  Greg and Alison (to whom I'm indebted for their kind reviews). The
  commit titles got changed to be more specific and use the present
  imperative tense as for Alison's suggestions. The message body got
  fixed according to Greg formatting comments. The changelogs were moved
  to the cover letter as per another suggestion by Alison, and I added
  missing details (like the update in the MAINTAINERS I failed to
  mention in v2) and made textual improvements for clarity that I also
  noticed.

[PATCH 1/3] staging: vme: Move vme_user to staging KConfig
v1:
 - Sourced "drivers/staging/vme/devices/Kconfig" in
   "drivers/staging/Kconfig" and unsourced in "drivers/vme/Kconfig".
v3:
 - Modified the commit subject and text body.

[PATCH 2/3] staging: vme: Add VME_BUS dependency to Kconfig
v2:
 - Added this patch to the patchset.
v3:
 - Modified the commit subject and text body.

[PATCH 3/3] staging: vme: Move 'vme/devices' to 'vme_user/'
v2:
 - Added this patch to the patchset
v3
 - Modified the commit subject and text body.

Bruno Moreira-Guedes (3):
  staging: vme: Adjusted VME_USER in Kconfig
  staging: vme: Fix missing `depends on` at KConfig
  staging: vme: "drivers/staging/vme" tree cleanup

 MAINTAINERS                                          | 2 +-
 drivers/staging/Kconfig                              | 1 +
 drivers/staging/Makefile                             | 2 +-
 drivers/staging/vme/Makefile                         | 2 --
 drivers/staging/{vme/devices =3D> vme_user}/Kconfig    | 2 +-
 drivers/staging/{vme/devices =3D> vme_user}/Makefile   | 0
 drivers/staging/{vme/devices =3D> vme_user}/vme_user.c | 0
 drivers/staging/{vme/devices =3D> vme_user}/vme_user.h | 0
 drivers/vme/Kconfig                                  | 2 --
 9 files changed, 4 insertions(+), 7 deletions(-)
 delete mode 100644 drivers/staging/vme/Makefile
 rename drivers/staging/{vme/devices =3D> vme_user}/Kconfig (93%)
 rename drivers/staging/{vme/devices =3D> vme_user}/Makefile (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.c (100%)
 rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.h (100%)

--=20
2.35.3


--q2kxa542hsfldolc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl30bQAKCRAZtd3tyEY2
kn6pAP4158LdkTRNmvunY82m1T4P60jVTXIJrPQ1wCmCMGtpPQD/aPBy5PYYyls8
issxKcmW2UE0FFGN0+LkCpfkEIsmNAE=
=whXS
-----END PGP SIGNATURE-----

--q2kxa542hsfldolc--
