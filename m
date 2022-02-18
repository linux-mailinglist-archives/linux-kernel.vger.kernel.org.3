Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673484BAFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiBRCyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:54:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiBRCyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:54:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9A4B1CF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:54:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K0GVk1YC7z4xbw;
        Fri, 18 Feb 2022 13:54:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1645152846;
        bh=wKL5cto37whZCPGNWavrz2fGxMBZcjXVsOEmMKW6V98=;
        h=From:To:Cc:Subject:Date:From;
        b=hzFiKxgC2qDXrsPusqA5nD8Ks+pKHpq6ACCTJ40V1F+eK88VFNGqS7tBRDy5ptb4W
         08htaYwCADTpgu+QnLKBuT9I4nMuhFuw0aiqcR0nCmtpJYWEKN+qsmvHIZFoIPWcKG
         vZN2uZ3cXaSF1ORDSdsZSWO4agiDvPqv7l8XCOcwOBqtCUEzwjaYHF/SN2oFgR/lfK
         KjXE4oWKkgRyrzdJeokdc9RV2+jLZmb1aEMHslBLNEKCgYddPtL8+9jf2R//5ayvat
         xr/BnTS7yUu1Z8ahHJL2gUQzl4dJ1BKogVpEHTDRJN32RPJtg9MvueVAqx4pWha8Hr
         +4K8JaktLFAzw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     anders.roxell@linaro.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-4 tag
Date:   Fri, 18 Feb 2022 13:54:05 +1100
Message-ID: <87pmnknauq.fsf@mpe.ellerman.id.au>
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

Please pull some more powerpc fixes for 5.17:

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-4

for you to fetch changes up to fe663df7825811358531dc2e8a52d9eaa5e3515e:

  powerpc/lib/sstep: fix 'ptesync' build error (2022-02-15 22:31:35 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.17 #4

 - Fix boot failure on 603 with DEBUG_PAGEALLOC and KFENCE.

 - Fix 32-build with newer binutils that rejects 'ptesync' etc.

Thanks to: Anders Roxell, Christophe Leroy, Maxime Bizon.

- ------------------------------------------------------------------
Anders Roxell (1):
      powerpc/lib/sstep: fix 'ptesync' build error

Christophe Leroy (1):
      powerpc/603: Fix boot failure with DEBUG_PAGEALLOC and KFENCE


 arch/powerpc/kernel/head_book3s_32.S | 4 ++--
 arch/powerpc/lib/sstep.c             | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmIPBSwACgkQUevqPMjh
pYBjmg//RUzlssNhvaB8m/X6cfZHA03rkQgVhPzUtTGryyge5aT6GqxPfD4+5Vdf
e1vdZJNzt1pIVt4yBYZmTKv2qkyDjJ0TdYJ+r2/neNY3T6IL4oOscPKnp2yn3n5C
N5NJk48fxgXRnnkjBQVFeukaHGEs2F6PbI/z7Dn4on7MiinGBewlPaPRCQUee+i6
eQNQ82tfUMKfgJoaTm71SuZghRUU89scl9V/0/BSkrNNWOuHpxcG/Amq4ap8IxEE
oMEAfhBxKBKqvb3tGDnoljEB8T8RaGpzx0yeice7+3NfqjUw4lE2E7ahbUqFoom5
nJiCbuX5hsYn5GRC/ucNvWka50EInuqs4MFsdGP82v/ruH2O+/V9Dl8JLGfyuc+8
9MSHatRS/3np+M/CZnPJgLS1rutbmWP9hCQ/fs4LzOe8KJboN3R00LXxcNIuK6p5
GV8qthSAKD4rvrjPw26OLUXwZRjpf7hMeOoDZTfWqscIN1E3G3EbCUbQ4EMxwCf2
Qc5DkB30XzHeYK4n/Ee+aNiqhGkI0i9ODSBS7JytEANGWdSQBPAC9n5wW00aln0V
Df/KfCaafZzGEKhdHJTDNzGM8QoCwLvg24jP24VSa1OOz1bOL8hCGxNw/FUS0Ykk
lWw+PYO4/uBx07VeaA2in3zj7mNlwnNNyP2aA3HIRyA2t7LL1BQ=
=h/wV
-----END PGP SIGNATURE-----
