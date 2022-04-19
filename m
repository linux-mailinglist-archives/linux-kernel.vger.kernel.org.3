Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB7507138
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbiDSPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbiDSPBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:01:04 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 76BBC3B01D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:58:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650380301; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: To: To: From: From: Date:
 Sender: Sender; bh=uM5EMjf3NP4QzCk0UqXPKFMY+n748Cl/JUdN11a6lQk=; b=rqgjvnsaKP7ZGtPWI1xZTeXyk3SS/yhhQg+uYCfajA7a8COb3LwOG0By8iQWV0NwMl9SYGDc
 kb7EYByNnzTg2RWcFuaq9qC+H/whE+bAw3/e40iPkY4+fcs4djp8RWXcQIsKL2c4+pg10n+R
 ecq6O7oAsAZqL5uf68CCaRPwetvZT7Z4dqat162w8s4ZMAmU3Yp6/1MTTuaF0bHvOHTtuc36
 UY8KbuRiV/Kj76FB52Y2nehkk+gJv7Qi3/nM7K+CSKuv8V/xe0D2wkfaKRslfdtrUrpfbPEH
 7TGCEiSzW/kyZmDrLRy/345Bnra6KZhaMlwrSMV+oSete+nzaxByCg==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (dynamic-user.170.84.57.33.mhnet.com.br
 [170.84.57.33]) by smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 625ecbb3c172fc5066005442 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 19 Apr 2022 14:48:19 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 19 Apr 2022 11:48:15 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH v2 1/2] Docs: Add cpio requirement to changes.rst
Message-ID: <16abd8eb6a5c8398a030ae5d8919d5c8e92e2af1.1650376049.git.codeagain@codeagain.dev>
References: <cover.1650376049.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ro2gw6s6psca55fi"
Content-Disposition: inline
In-Reply-To: <cover.1650376049.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ro2gw6s6psca55fi
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


--ro2gw6s6psca55fi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl7LrwAKCRAZtd3tyEY2
khKiAPwMG6OI0lpf1AqUjruuyLLHmrs28B7fL3Coejgkddt3ywEAlONSYrtnoWbg
xSXIjuZTI63w/6yE6VW9SjVVJ1KOFws=
=juu4
-----END PGP SIGNATURE-----

--ro2gw6s6psca55fi--
