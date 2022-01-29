Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A734E4A3295
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 00:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346425AbiA2XTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 18:19:01 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:45211 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiA2XTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 18:19:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JmVdF6Ns1z4xcF;
        Sun, 30 Jan 2022 10:18:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643498338;
        bh=wElqOFSKk2byU264G4vyvE7xfTalv00wUyLkKWnTm8Q=;
        h=Date:From:To:Cc:Subject:From;
        b=q8qNOrhS/cWB5Yjjm6NofK4yKzfl+2gbWW+lrDLKAqFPoyYkngkkNJyE7DbgKbXzb
         hAjmYsm848nUyDsaxkmlmxFxZ/Dw4x3kkxYoXO5+lkHeJJSqfX7w12wf+lNKl6QIck
         N2PS91cZNZ4NdAhLJBO1McQB4LSjAiEkUU42udXZVpH7eX/CvP7Fizmg/KtbiHZ/+d
         JzyOrWXlR/IWFaojcEs+ULcan45C8TAgO+xRJshrDX+NQK5Odugrsjl21xMx+dnNRH
         nOaAUfsxwSqodN+VxMv3lQIfmCH+veMhEe5v/ZWOz1Cgs4yVpr8jmrnLbYiXvw4auU
         BA0tNZxcpKrgg==
Date:   Sun, 30 Jan 2022 10:18:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20220130101856.15d88186@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LX5kI_ldja=wh/A=ngjVhm3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LX5kI_ldja=wh/A=ngjVhm3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  91f6d5f181f6 ("arm64: dts: imx8mq: fix lcdif port node")

Fixes tag

  Fixes: commit d0081bd02a03 ("arm64: dts: imx8mq: Add NWL MIPI DSI control=
ler")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/LX5kI_ldja=wh/A=ngjVhm3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH1y2AACgkQAVBC80lX
0GzISQgAjHQ5L0p5Q4dXEZ4QlKxiy09EEBFlB6wsxVDVi+ModTUQkSJWOF5y9KTG
ZR1eHSmr2pA24w406PmlOlUjWG1CTGRKjEqyIIROG5m7etRtnkNLIc8IlNyG3bbE
geXi4AIhppRrm+bkmMF7FCIyKO0bzKAPhOF0EM4r27L32vk8Fc1GcWjzyPOqPtuL
f43pIuvuNOFC0nL98NH93zKi41RAlmiuQyeK8j0yf1kBCsuMBe5/7UHhY0SlwwY1
TwbpKjFQwZpHeEF0cLwbKm3J/hZQ6dgJee4gGZ3+xQxX3HZN6YMhc4XHquUBcz7m
1FoMGo/eNC1BeEFZi6o35oGiGxDKRA==
=VwUO
-----END PGP SIGNATURE-----

--Sig_/LX5kI_ldja=wh/A=ngjVhm3--
