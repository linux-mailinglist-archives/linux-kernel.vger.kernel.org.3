Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A29A4E1DE1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbiCTVL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244387AbiCTVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:11:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F2160C12;
        Sun, 20 Mar 2022 14:10:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KM9Ps17K5z4xPv;
        Mon, 21 Mar 2022 08:10:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647810626;
        bh=gHQtle1L42oxMgdPyJfIo2OZZHlUIp6gKrUv9V2v/1k=;
        h=Date:From:To:Cc:Subject:From;
        b=ohEP3OV5AOFrFH7kTQlzbQIB1k3uoY9TscYraB0YlT+qH9gWOES/T+mXQoOoYdJoE
         SPSv8w5A7xF1v9r5zHUbEeohiT5jm8JfDo9k9eL/4oYhNOdvLNvtHuaYHVUyq7zaIY
         3aUWTUj9vbat7MwX4yoFFGtkjij4ZIbGldnh2kURwngxnVPm3SBXULjLcB6pd6v1OY
         AZZWPC15wp3PCjKBIUzbO8bahbiJfKf656LiZ+FsxxddhlKY8etYzOBEeVBvCeUpEO
         sgrIM/EEsNJQ1nzOA0rd0EJcvdIw3c3ufM/yxPCdnE+n+SksrBTNHDgdsy8oGb0xJU
         MfikjfxctTR8A==
Date:   Mon, 21 Mar 2022 08:10:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the watchdog tree
Message-ID: <20220321081023.72569774@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/43MW_JTXoFbS67SI2kiKu.S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/43MW_JTXoFbS67SI2kiKu.S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1f7590ac16e7 ("watchdog: rti-wdt: Add missing pm_runtime_disable() in pro=
be function")

Fixes tag

  Fixes: 2d63908 ("watchdog: Add K3 RTI watchdog support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This an be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/43MW_JTXoFbS67SI2kiKu.S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI3mD8ACgkQAVBC80lX
0GxPFggAmKwILfcxW6X1LwqrD6vKehh6FmXGFkOKs+9HPxEpq3WtHCADAAbJSzST
bJ7Dq1oZniv65FPXXG9ea3ENIpj/nl5duDk3aPowLUkHzhOiWpU3d3tESFCiIIuC
o0gAb5Tn+iAWYdz4JHxhnRB6U/insL1UNMzKbPqfvrmTjIsewT2cETYkoBhuffVl
cpR2c3iExYVvnlJ9xyz/aEdDers2xTxfE91X5HfahhA4XvTtjOi7Ib2g2ll0OP9n
p2X/ivuOIouh3yceSRWyinFB17m55McXSTbFQD4oxVic4HbBpvBoxRbe3gS8heUY
aV/GpbEATDy6Qxt3cFxLAT8rChbvVg==
=U1lm
-----END PGP SIGNATURE-----

--Sig_/43MW_JTXoFbS67SI2kiKu.S--
