Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4320D506269
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbiDSDBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbiDSDBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:01:23 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 6F22F27140
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:58:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650337122; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: To: To: From: From: Date:
 Sender: Sender; bh=Kadp6rfgGJvN7qZeAf+AMQzkEbabEcTUzAKSdc/5biE=; b=qtZHmD0xn7DyiOiZYgd4VURYZIokLEjdQ7V8gVtygLnxSHi1K8p9bN8/LB4u1qOw1854tBfQ
 aMpQmV/ZJv8rZh3ELVDdHlutUPC9US40ngjv9Pwz/SXnziyDnY5ivoVT1NB9xZ4ibpqpjWSX
 vBBgA/fsGGb41mK5JArn3Gm6TmYbnq3Bkkek2dM0HwnW3g/aSYHHPwtVOZxtDaXu5zm9N0Tx
 Ajre1GjC6/HCxnrKHR1JsF/NXeHFVu6YWMhw9NL2Ug9hIJhi+Kkpr+CelJhICPTUmc1dDsaP
 GsERW8wZD8CRH8G4zvFLmLasyC4CUwhUn1SI016Zy7rQVvM9prlBFA==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 625e255f1f77778b07c4a92d (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 19 Apr 2022 02:58:39 GMT
Sender: codeagain@codeagain.dev
Date:   Mon, 18 Apr 2022 23:58:35 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH 2/2] Docs: Update kernel series in changes.rst
Message-ID: <a124c3c34e627c124673640aed177c10e401b052.1650336366.git.codeagain@codeagain.dev>
References: <cover.1650336366.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oefgg65gzpmk5xb5"
Content-Disposition: inline
In-Reply-To: <cover.1650336366.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oefgg65gzpmk5xb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The file 'Documentation/process/changes.rst' states the listed
requirements are for the 4.x kernel version. However, there are
requirements updated for the 5.x version, so this patch updates it to
match the current kernel version.

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
 Documentation/process/changes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/chan=
ges.rst
index 41a44e5f47e6..08515b11cf92 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -7,7 +7,7 @@ Intro
 =3D=3D=3D=3D=3D
=20
 This document is designed to provide a list of the minimum levels of
-software necessary to run the 4.x kernels.
+software necessary to run the 5.x kernels.
=20
 This document is originally based on my "Changes" file for 2.0.x kernels
 and therefore owes credit to the same people as that file (Jared Mauch,
--=20
2.35.3


--oefgg65gzpmk5xb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl4lWwAKCRAZtd3tyEY2
kvoPAQDJhnM4s1asjT1tuwbuECzVkwb2ammAYM3ToPdTWq4S0gD/RdfXb5bNIdIO
m9jECO45ycrvVMEzFEIYKGXzjR805gM=
=B3+m
-----END PGP SIGNATURE-----

--oefgg65gzpmk5xb5--
