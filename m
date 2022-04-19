Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E043506263
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbiDSC76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbiDSC7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:59:55 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id C96862654C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:57:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650337033; h=Content-Type: MIME-Version: Message-ID:
 Subject: Subject: To: To: From: From: Date: Sender: Sender;
 bh=1rL2vp7V7+wKoQ87BcU2C7fDdhb8wqUApGLXA1ggxm4=; b=X+i/tTZunSsLh+1tST1TJqOKs1U7SBysYbsFOs3JCs6mQeoEa8NEHFFCwAZXkMY4paqeHk4w
 YEQ589maBHvwSkCsaJEUnbuBWVqnlB8QZ7PwJmPTuNJ3a2oWVsoUZPIuuaLgXxODZvFH1wVe
 Lcr8uDbGv2SDGDaiY7qZuHEW46fVDRHp5WmP+zRO8ijL4CS7Ll2zQ5a4NzeFqS6PgQ+0IP2s
 HIJT3LA0/ulg36OGoft2s41nqSjhYD97JmVto6bWzuC3iTw4Q2D9jHiZhu/wUOW1nKqlwT3C
 pgJo4vQpRdjAnlKLV7JP5C4AS2Vrn1eF5eef4XCirt0T3yO/XZ4QrA==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 625e2507487c9ee854800176 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 19 Apr 2022 02:57:11 GMT
Sender: codeagain@codeagain.dev
Date:   Mon, 18 Apr 2022 23:57:06 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH 0/2] Docs: Update information at changes.rst
Message-ID: <cover.1650336366.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bpzzsdc6houvacyh"
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


--bpzzsdc6houvacyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add and update information at 'Documentation/process/changes.rst'. The
text has outdated kernel version and misses the 'cpio' build
requirement, necessary for the `kernel/gen_kheaders.sh` script called by
the install target.

The PATCH 1/2 fixes the missing cpio requirement, while PATCH 2/2 fixes
the kernel version.

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
Bruno Moreira-Guedes (2):
  Docs: Add cpio requirement to changes.rst
  Docs: Update kernel series in changes.rst

 Documentation/process/changes.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--=20
2.35.3


--bpzzsdc6houvacyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl4lAgAKCRAZtd3tyEY2
kpd3AP9O+BHCyMUtLB86c1qgQEfZhDCee86AS1T4mqPw/ZIdOAD+KaTrWFtyqDTT
7m3mQ+XzO7ShHw1XylPSkQr76iV3sgQ=
=zLsk
-----END PGP SIGNATURE-----

--bpzzsdc6houvacyh--
