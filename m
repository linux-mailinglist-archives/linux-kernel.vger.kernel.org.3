Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8A056C8FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiGIK1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:27:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6165B05A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 03:27:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lg5ts0KPDz4xDB;
        Sat,  9 Jul 2022 20:27:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1657362453;
        bh=hVO2Da4U3cecxK4Fis5al3/r7JwnZM+2jTviFaRdUrw=;
        h=From:To:Cc:Subject:Date:From;
        b=qzd3uo0Ob+4zm1EzoZYFhFRIqy8BMaakEymhMaqkPpPfuuV1CCf4be0YVmb/I20sh
         j6b9auE6jPZ6wtmul8+Q5QZthodtLWU5VZMLnSvYUpNwPqAghMpA0r7Omi4ZptNnQM
         u+h417ueKy2aMK0sxKY+K55NlCH1wZEA8AXUPdf06Je+PqOJCRQ+RwpnUpKf7Kudlf
         /w3JwHZTWCZ10cO8EmLfZ+YigouCHb5Zp+crTDGfSYiNeoQpnVsDD5GGObNTK9zb22
         UdO6yqR3zWJQLkvj4CYW6uu4D9/RkGbMvhsHVBj3ec07Bev/PVgDQb/hrsMj8dyoql
         GlcrzeJFpm8Bw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason@zx2c4.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.19-5 tag
Date:   Sat, 09 Jul 2022 20:27:31 +1000
Message-ID: <87ilo6a8do.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull another powerpc fix for 5.19:

The following changes since commit ac790d09885d36143076e7e02825c541e8eee899:

  powerpc/memhotplug: Add add_pages override for PPC (2022-06-29 20:43:16 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-5

for you to fetch changes up to 887502826549caa7e4215fd9e628f48f14c0825a:

  powerpc/powernv: delay rng platform device creation until later in boot (2022-07-04 21:11:47 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.19 #5

 - On Power8 bare metal, fix creation of RNG platform devices, which are needed
   for the /dev/hwrng driver to probe correctly.

Thanks to: Jason A. Donenfeld, Sachin Sant.

- ------------------------------------------------------------------
Jason A. Donenfeld (1):
      powerpc/powernv: delay rng platform device creation until later in boot


 arch/powerpc/platforms/powernv/rng.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmLJV5YACgkQUevqPMjh
pYDt0A/+LXncrh6Vivnm7RXfvjmkoEZL/mry68cCmwYxPhN0NH4wfCsMWhcUeheh
ZXLeV6J42e9JwO+v1b3ENQuBjoiB3AR2YdzeisaSfumapfs0sDxqZnz9e4cKNb1h
oEgrOKdNQ0A0+3fzC50G6o6Y4EGYCqth6JSFqPBexZV9aiO66lpObVip9U4kRWjU
dfHHJ9xRSOaAvQawxBr2GTssFyOGQHUyKGS2bqGradSGEv754bRB0Lu34hJ/NddA
aKjPzclZu1QROKQzqQiQNF0q9n8Ac9xPsrv701gXcnb0EqhSFxn8pxoavXF9SgRF
OvPUmjJQbPgpVG0ltsxvcwHkAn5MdAdNLtH2gkI0ikqMjOzp7MmY90VqPgFwnfYs
M/RBNhwElpeUwxJ227mT73Nykr3PZJy7ht5G3jo8ngXa6JeCQSv6W9bpQcA9mqZa
MJza02CMsXysP/hHcsStJN8IIHKyfqNcKcsqwR2ZAFrgP02rhLUFRd8YO/GbE8aP
aV4rEJ++71FUEy5GRMJYEdChvdPGO4qW3nMyjZz5JRKv5oxjidyXPM6bxUNV0BSy
PHGiC1Ig6Ty+InsrYrzGyfsbvMwMO9dYvQtJ2HTV+yNafpRTKrG21J85ApRmM/lI
r2X5HWAIyWUrzNMIvC9ddhkfEx3hPHdRDJT8WlYnIZicM4Vucqw=
=1BAn
-----END PGP SIGNATURE-----
