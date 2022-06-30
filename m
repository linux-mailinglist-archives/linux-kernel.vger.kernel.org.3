Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934095626D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiF3XJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiF3XJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:09:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD658FF6;
        Thu, 30 Jun 2022 16:09:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LYvCj5btvz4xYN;
        Fri,  1 Jul 2022 09:09:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656630546;
        bh=QBTNcuUm751z0k80BSQeAPHxagbvkvhrF/MhPGElgIM=;
        h=Date:From:To:Cc:Subject:From;
        b=hR9GJ6/xLqNEtpml6gBusBL17BkWfzbkXRStStpSduPShT2COmXcr6C+DUYuntM/4
         CToOeHdo6YEx1PfZGdLfxPyxitjdYekC8Rx4tYfUwa1XS0x/WIL3jgxp1rrmQ43ICo
         iThAGBTkIZLVL1+lS5VANJm+T0BrOrNLYAC0G9aMz4BYler1QfkeqNPSr2DA+KsKGI
         D6Qa/o5inzZMMYBN7nDi+LWCA/H72fH014IsKudtpBX73IeOiWyny0D3ixXVtaNPmG
         4vaKgucCywTw4bWsET108rR4TS16Kbwuv+8HCimwbr3rkRSLjH1pm+b4GuS1Eik1tP
         ofOU2DARIEfag==
Date:   Fri, 1 Jul 2022 08:56:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20220701085657.230b2e13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pe/PFjYc42CpnmZK=c=P=GR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pe/PFjYc42CpnmZK=c=P=GR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commits

  41a2d4df3d72 ("drm/amd/display: Fix __nedf2 undefined for 32 bit compilat=
ion")
  916ae9cc5385 ("drm/amd/display: Fix __muldf3 undefined for 32 bit compila=
tion")
  f20eb84561de ("drm/amd/display: Fix __floatunsidf undefined for 32 bit co=
mpilation")

Fixes tag

  Fixes: 9b79abf79c414 ("drm/amd/display: add CLKMGR changes for DCN32/321")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 265280b99822 ("drm/amd/display: add CLKMGR changes for DCN32/321")

In commit

  204b022bcbbf ("drm/amd/display: Fix __umoddi3 undefined for 32 bit compil=
ation")

Fixes tag

  Fixes: 9b0e0d433f74 ("drm/amd/display: Add dependant changes for DCN32/32=
1")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: d3dfceb58de5 ("drm/amd/display: Add dependant changes for DCN32/321")

--=20
Cheers,
Stephen Rothwell

--Sig_/Pe/PFjYc42CpnmZK=c=P=GR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK+KjkACgkQAVBC80lX
0Gz3bgf/W/aaApNBPysZiDfpX0ddOI72IFtdSyeiNTseWCBGfEfLCUIxxURSPBk8
vT5Nj4oXvB6Smu0drN2o0qFaN66y7GOjfIrvahl5uJs+BbtUtt+RGbBuM3xd0Mjl
FuCkDa3U10uuC8EMxNBeC5OBznnQmIfA88VHBNEYEXsLuj2kRCTZjZT/HGg0zk9Q
A2prbZmYZls04fYt8z7jyK7VfSlguWtpV+4kiisLH9ddbkO9BHxN/0Zq4pKrNAB2
yLGLl4cew72Rys5RRVYrtKT7XJASSGegh6B0MFLPtaAwPvfq7Ff2Pz8OjkOWZB1z
76qoEB60p4698WpMeSUnOeNibLY/zA==
=yHLb
-----END PGP SIGNATURE-----

--Sig_/Pe/PFjYc42CpnmZK=c=P=GR--
