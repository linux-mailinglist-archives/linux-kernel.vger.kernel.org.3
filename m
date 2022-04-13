Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D56500136
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiDMVfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiDMVfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:35:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F31710FD;
        Wed, 13 Apr 2022 14:32:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KdwmP1dWRz4xL3;
        Thu, 14 Apr 2022 07:32:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649885557;
        bh=VZtR8HkE1+TZSDG5YYAGqR5GUnoGLn13HenXzbDS2tQ=;
        h=Date:From:To:Cc:Subject:From;
        b=UNoAM1Oe3NV8LPPNbISd2sUprziYugI7J1GM+OsLhb+6T12YLxmaslMeWNfUmgRb4
         YbsPFVs/COiZ81ko8Mml8EBFX3cvZ29+IdyYi3t5jSFfsL7eJLt4GwpOozgrs1xV5t
         h1nJhM+TtV2xrS1RuR1Wr6PCAe5zFFBS0ru4LW4C0Pk3sLGix5CUZNCF02lvRSqiB/
         Fh95Zct/D7Y0YXMcz7gRAiBf3pZYZ88O6NQXrttORsU+zNs6xRMAheMpgNs3AzUjUg
         7n+w10FfUce5amjw4RwYJNCsh1N9pdjW6Uket0ohaXhOtDdlQtcIIXjALQyDHrs6/j
         utXje7Y5YDybw==
Date:   Thu, 14 Apr 2022 07:32:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the phy tree
Message-ID: <20220414073236.1f955bff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//1MF6dsWpWLC_.QFKPq9vL_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//1MF6dsWpWLC_.QFKPq9vL_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8724489e5ffc ("phy: ti: Add missing pm_runtime_disable() in serdes_am654_=
probe")

Fixes tag

  Fixes: 71e2f5c ("phy: ti: Add a new SERDES driver for TI's AM654x SoC")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

In commit

  19974ef56750 ("phy: mapphone-mdm6600: Fix PM error handling in phy_mdm660=
0_probe")

Fixes tag

  Fixes: f7f50b2 ("phy: mapphone-mdm6600: Add runtime PM support for n_gsm =
on USB suspend")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_//1MF6dsWpWLC_.QFKPq9vL_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJXQXQACgkQAVBC80lX
0Gx/rgf9Hs947/qj9qBYdJCqgljroyiMHUCSJ4KP7G0XTxaNXRMltEFNmzTt8OnU
BGRtD0QcOIndRZgPr1BJbEOV94+C/Ffrm/LHNqa732+iTpxV/rDE11e5Ug/xOYIZ
O2cswSX//OqftC1+RcOmBqMAG/e9dcNWMaBKjV7XGRU5oj90OsBIF7kgI4S17Ywf
viU7qA0ggLJQXhDkTthym4gX+BUqeWsXv3SPlBas450mh9K5YnOtV2rSCrKlbLUH
CEWaqPmev3+Wjj4V6ZdpDgHu7208V9yuChYt3LNMvs7wFMncf+6SGeJEHD+2fUW7
FD7Zgnr06GPgLSDK6Pfz500EyuS0ag==
=aL79
-----END PGP SIGNATURE-----

--Sig_//1MF6dsWpWLC_.QFKPq9vL_--
