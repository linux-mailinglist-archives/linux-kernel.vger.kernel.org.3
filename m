Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26BD50A37E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389710AbiDUPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiDUPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:00:32 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 804AB434AC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:57:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650553061; h=Content-Type: MIME-Version: Message-ID:
 Subject: Subject: To: To: From: From: Date: Sender: Sender;
 bh=IxYl4DcXb9pJAGg4/VecgEAwiR+sMI4uj3Y/4g9SOKI=; b=PqdpHop702XlByCMY+1K6W9r7AgPIbnI2R0+IJvs5Uk8sxWx5JCJfpNx3u0XbYA+AKk+j7kk
 fZoFEl+3iKUm1C6yq7kPPjleorxQYDYqMhkaaip8vscGKFc9WeORlUQKEKO9noNyccHgbUyi
 0Zl1OLBr3WBe9UocAZrGZbryj/9zBEU1ImjGFFp1+Ih75X/fn4iLd8uGk0b1gilrtzf67tj5
 s0e5rJcgJC0inqnnE3dmbSN31zHjZCEzw7DsUgO7+VWWz1z+PdXs9z8HlOFwhya6EJHI3C9l
 a3JYwNi25VGqGimVTpDFd1bkJAcMd2bCC8nkllkKXlv28C8yVRPESA==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.33.mhnet.com.br
 [170.84.57.33]) by smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 626170e3b77b16c56e3b9bb5 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 21 Apr 2022 14:57:39 GMT
Sender: codeagain@codeagain.dev
Date:   Thu, 21 Apr 2022 11:57:34 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v4 0/3] staging: vme: Cleanup driver tree old structures
Message-ID: <cover.1650544175.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k7aonxtqs75wcypj"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k7aonxtqs75wcypj
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

  Version:  v1  v2  v3  v4
[PATCH 1/3] *   -   *   -
[PATCH 2/3] -   *   *   -
[PATCH 3/3] -   *   *   *

CHANGELOG
v4:
  * Remove extraneous patch from set (Greg)
  * Improve changelog format (Alison)
  * Update commit message in PATCH 3/3

v3:
  * Update Changelog to cover letter (Alison)
  * Update commit messages and logs (Alison, Greg)
  * Rename patches 2/3 and 3/3

v2:
  * Add new patch to set: 2/3
  * Add new patch to set: 3/3

OBSERVATIONS
As Martyn confirmed the devices are still being manufactured I'll keep
going on with this patch meanwhile.

PATCHES
[PATCH 1/3] staging: vme: Move vme_user to staging KConfig
[PATCH 2/3] staging: vme: Add VME_BUS dependency to Kconfig
[PATCH 3/3] staging: vme: Move 'vme/devices/' to 'vme_user/'
---
Bruno Moreira-Guedes (3):
  staging: vme: Move vme_user to staging KConfig
  staging: vme: Add VME_BUS dependency to Kconfig
  staging: vme: Move 'vme/devices/' to 'vme_user/'

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


--k7aonxtqs75wcypj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYmFw3gAKCRAZtd3tyEY2
kiVkAQDcKXdUoLot3+kaFYzScp207pt5Zls7kUn0r7OqAc1jzAEAgiTLF1mmMFXy
PiN7xerBl6bKMe0MfXDelwxdLOUpPQ8=
=Y80d
-----END PGP SIGNATURE-----

--k7aonxtqs75wcypj--
