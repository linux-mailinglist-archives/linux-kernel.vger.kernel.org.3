Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5705070FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352851AbiDSOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352550AbiDSOvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:51:40 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 1F2623A5DC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:48:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650379738; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: To: To: From: From: Date:
 Sender: Sender; bh=GjGIZv1fDSI8+XOsFgpIg9UmNpf9tCa3JfKCPZn26Ls=; b=d6aTpJ1W/dmj1BW1Qlnel6aouYyUyehYVu9pVaBJnf3K+AFL5j4ht1Z1hhDFyYQaYdi/dQRA
 W6KBrgZ3nG0wSkVxZFKteywNBqx1rYngk3H94STKyxwsv89VaGe/z+ZsRCsP0qfzXK68In77
 W+Y3lrymf+L/OPU2Y3f3uegaNSeompmZSLMJ0F3UAsuI7LLWNymAMUTEyZKw7MnkpyzP8zvc
 pWa4C2IhHt/ZIh8fWK4o6zLvSaBE9FoMl4kf/J2s7a6syznYv5H9M2wuHAWG2wcvIavOzaYW
 zhusK6DzhtkVSSTu52FBORywPCSVV32xaxpXPA2U1RkTzDY5zrSyjQ==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.33.mhnet.com.br
 [170.84.57.33]) by smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 625ecbd8487c9ee854b06238 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 19 Apr 2022 14:48:56 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 19 Apr 2022 11:48:52 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v2 2/2] Docs: Replace version by 'current' in changes.rst
Message-ID: <664bdcbb2b33b866de200ac9c05fa020ecb27ffd.1650376049.git.codeagain@codeagain.dev>
References: <cover.1650376049.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="smwaj257h7s7n5bg"
Content-Disposition: inline
In-Reply-To: <cover.1650376049.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--smwaj257h7s7n5bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The file 'Documentation/process/changes.rst' states the listed
requirements are for the 4.x kernel version. However, there are
requirements updated for the 5.x version, as there might be in other
future versions. This patch updates it to 'latest' so the document won't
be outdated in the future.

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
 Documentation/process/changes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/chan=
ges.rst
index 41a44e5f47e6..34415ae1af1b 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -7,7 +7,7 @@ Intro
 =3D=3D=3D=3D=3D
=20
 This document is designed to provide a list of the minimum levels of
-software necessary to run the 4.x kernels.
+software necessary to run the current kernel version.
=20
 This document is originally based on my "Changes" file for 2.0.x kernels
 and therefore owes credit to the same people as that file (Jared Mauch,
--=20
2.35.3


--smwaj257h7s7n5bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl7L1AAKCRAZtd3tyEY2
kjxuAQC2/iSX96CmxkNiFSJlO8cmjxx+nY1jpNuRRBKM/h1rKwEAkBFye8E5g73s
zA5bJaF1FVz9nhBQP1YPEpjT6CgxcAY=
=ytKt
-----END PGP SIGNATURE-----

--smwaj257h7s7n5bg--
