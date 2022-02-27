Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B424C5ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiB0Uqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiB0Uq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:46:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C5654AF;
        Sun, 27 Feb 2022 12:45:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6Fs80g2pz4xcd;
        Mon, 28 Feb 2022 07:45:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645994749;
        bh=3tw3vuPtaYAkC42fiIjpu+VlMpBP1Rxcwy8GU4WGqC8=;
        h=Date:From:To:Cc:Subject:From;
        b=ZSSFwPRVJcoe2BBoge9hm8G2WV3c5tCWOoytkLGrmlLqNdvt9RvS/AdwtLqbZafMH
         8FDA9AroUjfp6B7isn8PARf96dozEiyOnIC7C+jheMgXuCNHDaZlvXsak4DWORto3M
         QDrQOdhHCSbQ1zpIwCAigSdeeJrkZW/L+22W8d6cfgMwRw011l2RBF6KhMn3Wy/buZ
         P02Zr2NBSYltiBHsaDG2uEr2YTAKdk1vKQ7Li7U8XZXduOZ58DilwPEcFtgNtxjvDz
         hOyQ8Sy99pMQmWv6ET4hsI1Gc5tU8E1ULXkRYfUHCili9hkfavX1TjZx2+UdlKv4Mz
         hIFbPznx5cMIw==
Date:   Mon, 28 Feb 2022 07:45:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the arm-soc tree
Message-ID: <20220228074547.3c0371cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6oAaX+vz7yS.NKLyC3ldX0k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6oAaX+vz7yS.NKLyC3ldX0k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  4fcfd917c9eb ("ARM: mstar: Add OPP table for infinity3")
  9affaa4ad7cc ("ARM: mstar: Add OPP table for infinity")
  79f700c24b13 ("ARM: mstar: Link cpupll to second core")
  62a2718bf4c2 ("ARM: mstar: Link cpupll to cpu")
  6979b5fedb92 ("ARM: mstar: Add cpupll to base dtsi")
  c952e5075de1 ("dt-bindings: clk: mstar msc313 cpupll binding description")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/6oAaX+vz7yS.NKLyC3ldX0k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIb4vsACgkQAVBC80lX
0GziMwf9E42uBmROaUYvBppg7wOA765Ygz//RWYDkDKAT2MX+iHIKvOAn9UODGQ/
EA0kBUMrijcm+B5G4WeDDYGjf9+DQsjvcdLxmxPpq1VJoxZ6/xpu/qcSrrh7sf6A
jbS4fjXKK6ReLGXVYXveczLVZqdrMuadK62sIia5BSGxVtt4uckDvtDJwE7sbhWj
LeAwG0nP3yv/OiJpUZ/myhe8tgfpgW8JDbNCzVJKnFJZLdLbEeG1WmebGR0bxEYZ
Oap/Xv0q4ZpDgyp215SZrna/5lxIBOjlrP1BVUZQszJpmYppZpO+rUQopNat6Gh1
hFHW3PqqwCp10iqHrZFDLz5ZJkEZkw==
=UMUQ
-----END PGP SIGNATURE-----

--Sig_/6oAaX+vz7yS.NKLyC3ldX0k--
