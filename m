Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA465778F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 02:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiGRAAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 20:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 20:00:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B228B84D;
        Sun, 17 Jul 2022 17:00:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmMXY1lg0z4xL4;
        Mon, 18 Jul 2022 09:59:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658102398;
        bh=y25cKpL4mmsIwu6PRnBc2l75aGiWNToeCVWmIij4Gdg=;
        h=Date:From:To:Cc:Subject:From;
        b=Fm8UeIJNv9AVk6r6x5BD1LU5Oy0uA+k5A+7na8iRACq1kWZZ+ag9R0RdMAY0e3fnO
         ZGE6Dj99zOTF36wR4hl0O+SsMl0aLY5ax3QGQ0H1B0MmE0pgJA7AmaSXx1jAP6bwhp
         JbZ+bJxvnCWWr2TvHHSEhbiof2zQtk2PsLaQpFfzROP01TFoQbqwY9If498aBxt0/V
         PMhNVF402KB6dkB52vuXkOkDyqyA4qeu1Ly91pu64XCZIuddMX9pKh5XqPiNnIQeBQ
         qdvLuXLSwC8GmZm6qT7nimbvfUM3CRstihNb/h0hPxSq/dKzyLuvxmkBSjWVczcKdN
         0+KlzZhTFKsGQ==
Date:   Mon, 18 Jul 2022 09:59:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: linux-next: manual merge of the arm-soc tree with the spdx tree
Message-ID: <20220718095956.7282e081@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QMh0T+vFGcvl48pfwSKPgbc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QMh0T+vFGcvl48pfwSKPgbc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in:

  arch/arm/mach-davinci/board-dm644x-evm.c
  arch/arm/mach-davinci/board-dm646x-evm.c
  arch/arm/mach-davinci/board-neuros-osd2.c
  arch/arm/mach-davinci/dm644x.c
  arch/arm/mach-davinci/dm646x.c

between commit:

  0fdebc5ec2ca ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
gpl-2.0_56.RULE (part 1)")

from the spdx tree and commits:

  7dd33764486d ("ARM: davinci: Delete DM644x board files")
  b4aed01de486 ("ARM: davinci: Delete DM646x board files")

from the arm-soc tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/QMh0T+vFGcvl48pfwSKPgbc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLUonwACgkQAVBC80lX
0GwdgQgAnrN78ZfE9DbTwAEFFnVrBwl90JTR+/VPTilDluGpyXSD05JN7JTMl5ig
2/X8AVv2ZYWddJa+n8YVWTn+ToDRPSdldhwDCDAfToZ2K2JqxC/Ck/wFoZJoPCvA
S0g3Vh8llljrZLSLIT5TSslKEZ7kC3Q7BVi/8NpyKkr+H49q3f1jMZENlhDgknjv
0ywPbK++24q4xU3HIotd4ZDSaE3a1s29GhrgazTT+bqHMRCXPfCXAGe1P0aYJP/a
hxm6cwzmzPJYw3ZkrvXML33jfU43lLUQNlGjA95BohcJ81VqpPiRGFF1v3+T/x4O
hTFr7wF70eR4YuZJlcgIwJqgaHrkuw==
=8hZ5
-----END PGP SIGNATURE-----

--Sig_/QMh0T+vFGcvl48pfwSKPgbc--
