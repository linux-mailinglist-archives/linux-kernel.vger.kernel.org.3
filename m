Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEC4CE9E8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 08:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiCFHwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 02:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCFHwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 02:52:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EBE6EB2E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 23:51:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBDLd1jY2z4xZq;
        Sun,  6 Mar 2022 18:51:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646553097;
        bh=B5XtaoeoT0rBTwSnV/F7wwngkRnmYj50AHXgTV5L/xs=;
        h=From:To:Cc:Subject:Date:From;
        b=ZzwUG+a17wEYCLewAxXIC4+mo+VoHEj+eu6uk8qDjf9J1A7deoZt9fiyi8vhCsuJ1
         1Yd8P7i6dkBYj2Rh28qRROiuLjOtr2+KW+nZX7Rx+quGSgtYtnyTDpahV95t8qulVw
         903QozxkWNgtUGkGTtFy20KMW4v/mtSXveo6TeoS0zLnylZLpJrbEN3S9Ac1cCoK5C
         OvEbsDtSCLsLpwvLMAN51Nen+2fFjhQ7ULrUGOTmDv3+M0fQTpe4Xm6R+B960COdRg
         6vvIFkvcpjy6phU6kY+rXv4/f6iEEEYvHBTglWpjtTfZjG6M+B/aSionMGnmaoJ3ZZ
         c5mtXHNcUf4CQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        muriloo@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-5 tag
Date:   Sun, 06 Mar 2022 18:51:36 +1100
Message-ID: <87bkyjo6wn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull another powerpc fix for 5.17:

The following changes since commit fe663df7825811358531dc2e8a52d9eaa5e3515e:

  powerpc/lib/sstep: fix 'ptesync' build error (2022-02-15 22:31:35 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-5

for you to fetch changes up to 58dbe9b373df2828d873b1c0e5afc77485b2f376:

  powerpc/64s: Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set (2022-03-05 20:42:21 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.17 #5

Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set.

Thanks to: Murilo Opsfelder Araujo, Erhard F.

- ------------------------------------------------------------------
Murilo Opsfelder Araujo (1):
      powerpc/64s: Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set


 arch/powerpc/include/asm/book3s/64/mmu.h | 2 +-
 arch/powerpc/include/asm/kexec_ranges.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmIkZ+cACgkQUevqPMjh
pYCF1BAAnmZb6JbgLgztefPUyq9mx0q5FqcCqAhj6I+x/8T4qBGawbFpqazW6BIm
i1vHp2Yrj+S86qDQLo33LzO4nKK+EMDhgCAjFpryD8Kla0wDHBYDZy6JMd7LDYao
+j0EBB3w+HOWIUB50fb6EbEgRUFA1gMK4UaOxDRW5dnZCJ7h2qWB5Yev4i1Lzkmb
tPMvfPQYqMjzEcdMt07m7qHG72VxyBUgQbSMhE7VSKjmp9/oNPzxFFBmA0HoX6md
0pwXfXtvnVnMboSTHBYe6Ohk+kdA2P8P7agn/TW0kENP+RM+KePWVOAvAfqPjYCJ
dmqQsmn5ar46tlpPTS834ErDlCNNmfWuNAVILxUt3hQOyHQn4lDDZLR6EDKX22GX
OV9Hth5VPKqkiz8PmGAgcTE+A0s+kGU8DZN9LZefyBLV3Wb5/gHuxQFn8SCX71aE
EtcPJTP7IxZN8epI0b0ZEwM88i6RtFcteAlwYErGe9/UYBJK91zHj4FMWf83BI73
tmJkaVcDDezsbKGuibj3THB5SgzCcp/W5FrPjHWGXbrtYvjGuYp0HKraMGiLimlo
QV3uB/j7qMK0zHBXcypH0P6RrNN3NlaFiSMdl7KrdeWEsaGN8dQ8vKDYo3gJSKF+
lbUkYQV0d6RvHVZvgT11WC9o1SoKH2V5n9OGKNKUmz4RquAbCd8=
=7GLj
-----END PGP SIGNATURE-----
