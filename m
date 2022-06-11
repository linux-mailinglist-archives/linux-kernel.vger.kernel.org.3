Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604B254736E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiFKJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiFKJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:55:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E6E018;
        Sat, 11 Jun 2022 02:55:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LKtVW4lpTz4xXg;
        Sat, 11 Jun 2022 19:55:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654941315;
        bh=Oxwts3TEmw7fsmjHq7CsECLDet+E9N56KaFBSPnM8No=;
        h=Date:From:To:Cc:Subject:From;
        b=h8PHER7vwmgar4Ul/LrpQY22qxUzDzZx8GXrgw6uONbpp5ETheKJCNZul/t6WCcG1
         hG0lYQ8ZQM9w1LYoe6wxJNN7yRs97sOYd9KCRybzoKj3Nu+Nuy7EkI1VITMsBWUQhA
         CS9l3dRgNx+5HZvWVWpZV2jRIPLIaYPpDIx6d2myQsKECmAF2lwmX2bCE9xkqWQ92l
         MoeGjmUeNh+umOh1XFG4V+VeV+HcZOvobnNfQ5+sepqdGQ6V66Jk4nb94hHVr1PV2g
         GVH75O70SMz8qwM9AI6M2hXyph+3E0FEt03xA5tpPTwIYFcM1qamBzS83vI5pg25hi
         xAfpphjSafz/Q==
Date:   Sat, 11 Jun 2022 19:55:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20220611195513.58207a99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zz5z8M3ouNN5uPi5BRCU=b6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zz5z8M3ouNN5uPi5BRCU=b6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4768e2f5653e ("drm/amd/display: dml: move some variables to heap")

Fixes tag

  Fixes: d03037269bf2 ("drm/amd/display: DML changes for DCN32/321")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")

--=20
Cheers,
Stephen Rothwell

--Sig_/Zz5z8M3ouNN5uPi5BRCU=b6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKkZoEACgkQAVBC80lX
0GzwHAgAm2SymXvik7VrMC/X3IXrOr4CJ6n6PNcB5HoSmU/Hzv+2bTPHrZKRxGXe
0J8u4UaEgARLwlNrzR3tgSOF/QWM08uHrNPxXr3apIm9dWEXAAGwvpjOqNc7DNfO
X/c6P2KYnPSU4f8akQuqO3z3T/rMCh9MWVgMcp0JbgzN4zTmjvkEopEwIlHqzgf5
7W6vyTbP2x9d8RaDkb5ICOS5S4flrctqYxaizpqPGYwIjEHpqbuHBsCvXdaILT3Q
F1KQRBBlUfUJJqlJX4MVV4QQAiarb+zAGh7hbqCoJQQDoNLHRnP92KptBoJIhjg3
XdMOcf2XNAdXm/W7Ozenvd6ELqTogg==
=Lnh/
-----END PGP SIGNATURE-----

--Sig_/Zz5z8M3ouNN5uPi5BRCU=b6--
