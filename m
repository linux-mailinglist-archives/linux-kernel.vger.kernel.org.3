Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF574506268
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbiDSDAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiDSDAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:00:31 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 7880726ADB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:57:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650337070; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: To: To: From: From: Date:
 Sender: Sender; bh=7L1sYb6w42tY8ZZhWtLebw/isZSIhXjV323yjszy98s=; b=lMf79yOHWpRrRrrFkoyi81lyqOpxd4XnjNscTh+QtarZ4SSQUdu9v0qx4L0OqOocMB1PRxga
 7xYi7iIJ1jE7z6jktzHij7jhzYM7LBN5ZkwTygmIBdrAo7Fw8H6xfzdsp2IPuVKqwQ3B4DmU
 ZH3eCRtwgn7u+I7erF7wpzMQrQ8OR62yG0pV5QT407mw5esjfKSPVSEFTxODd58pYj6USFF/
 9FGX+D5erxppUhpJa04147iBjoLR9wlPfF7UtGka87O9NjP+F6cfkVf3awaDwpzQsxaNKsNU
 JlBsvm5qwinwI99mspsszGH0TJpwA+ARDtj8Vx3WDj7aZHCoJegv+Q==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 625e252c1f77778b07c4392f (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 19 Apr 2022 02:57:48 GMT
Sender: codeagain@codeagain.dev
Date:   Mon, 18 Apr 2022 23:57:44 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH 1/2] Docs: Add cpio requirement to changes.rst
Message-ID: <16abd8eb6a5c8398a030ae5d8919d5c8e92e2af1.1650336366.git.codeagain@codeagain.dev>
References: <cover.1650336366.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tnq77z332i66f2ik"
Content-Disposition: inline
In-Reply-To: <cover.1650336366.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tnq77z332i66f2ik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The install target requires cpio to run the `kernel/gen_kheaders.sh`
script, but it's missing in the requirements list at
'Documentation/process/changes.rst'. This patch adds it to the list.

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
 Documentation/process/changes.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/process/changes.rst b/Documentation/process/chan=
ges.rst
index a337e8eabfe1..41a44e5f47e6 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -56,6 +56,7 @@ iptables               1.4.2            iptables -V
 openssl & libcrypto    1.0.0            openssl version
 bc                     1.06.95          bc --version
 Sphinx\ [#f1]_         1.7              sphinx-build --version
+cpio                   any              cpio --version
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=20
 .. [#f1] Sphinx is needed only to build the Kernel documentation
@@ -458,6 +459,11 @@ mcelog
=20
 - <http://www.mcelog.org/>
=20
+cpio
+----
+
+- <https://www.gnu.org/software/cpio/>
+
 Networking
 **********
=20
--=20
2.35.3


--tnq77z332i66f2ik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl4lKAAKCRAZtd3tyEY2
klFxAP9Ap0gSen+3JB1yYbom2DWiCNDV5QiR9vvNqc7UOusYpgEAptihhB2CI+U/
OO4dXnvQfPKWLTFBSwQrKVL3PzfX+wU=
=G9sw
-----END PGP SIGNATURE-----

--tnq77z332i66f2ik--
