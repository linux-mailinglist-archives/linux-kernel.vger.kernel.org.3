Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5147B54BDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbiFNWeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiFNWeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:34:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F41D25C46;
        Tue, 14 Jun 2022 15:34:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LN3BX6HBvz4xXj;
        Wed, 15 Jun 2022 08:33:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655246037;
        bh=OWV3XBMgJCK4V+jIDJ5aUoVALutHtEtz+lth47xTA1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JxEo0MWK5umTb0QaMy9Y54yg300D5V/falPuwoC1vtz32ctMABBcgFivzcabhmKGF
         e1x7Mite6OppkYsS6+fQaldbrLsYeiUN7ufCmzxlAAqeKT0BD/W9kqX7unAdY7Xjew
         B49ibg6zlkduWJraZz0ZCANHGbXyF7Xan509UBS56elRJ/XdItOyEIio6hdRskgEoW
         4L6ud8gbeozrsZ2de2C5O46OoBj2oEM1vD22mQPEX/WClZeWeOMvsybvc3RMXdbWuT
         fjhvBAAM+utQTVY4FzT0rWJmeydhEYIi3NU4rGQou2APfJ8liCjBgO6UfUa4LKUk62
         z/1kELcUO+ayw==
Date:   Wed, 15 Jun 2022 08:33:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20220615083355.5be9ead7@canb.auug.org.au>
In-Reply-To: <20220611195513.58207a99@canb.auug.org.au>
References: <20220611195513.58207a99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M5A5HR8UzFSEDdGPf9rDDm6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M5A5HR8UzFSEDdGPf9rDDm6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 11 Jun 2022 19:55:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> In commit
>=20
>   4768e2f5653e ("drm/amd/display: dml: move some variables to heap")

This is now commit 9a0efb51178c.

> Fixes tag
>=20
>   Fixes: d03037269bf2 ("drm/amd/display: DML changes for DCN32/321")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Maybe you meant
>=20
> Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")

--=20
Cheers,
Stephen Rothwell

--Sig_/M5A5HR8UzFSEDdGPf9rDDm6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKpDNMACgkQAVBC80lX
0GzrXgf9Gv3MeSXi7vdtRT2N/yNhiA/P+xv57J4ncikmzh6wGwX6pp9IM4G9P9xJ
UpzMohsPl/hzcPR5elpil+gCqE3QHwERlF3vc1QCPk+6mcIFhMW4IuSTXcmnS0dZ
NaKwjuM3vTeKKKNO5NSKI05DKkkLUK3BHywzls6xYLY1eK8AEOS4Mm2s6omvoEGR
84secJ7GNEwGpwXprrhtIgK41manrzctWnD4z7U0yCpukHH+J2XbZybBXD7qlAKj
o7Jq1ROU2wNBNOwFRXJ48bb5FKTe4/snX4CUyuqsSp1OScgH6MAfV+YLr5bOri8k
0PNdNjd18KwT9EifQaTC83PPNb9U4A==
=A0wQ
-----END PGP SIGNATURE-----

--Sig_/M5A5HR8UzFSEDdGPf9rDDm6--
