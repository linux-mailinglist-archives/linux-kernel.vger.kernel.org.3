Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0203659AB70
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 07:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbiHTFDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 01:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiHTFDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 01:03:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C81CFE7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 22:03:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M8mjL3lSYz4x1N;
        Sat, 20 Aug 2022 15:03:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1660971798;
        bh=0sEwRnMPVEFaHqD7f0oYGXuiqcZfbLWw3WJeTLYhpEE=;
        h=From:To:Cc:Subject:Date:From;
        b=GaGnWo+YIlJOiBvorJosIxFan2VN8Wfk9oyJ/U3kmyl1y3Q4vhP5+kNDxiKhc/NtJ
         7fH2uEPK7ZsBLU013RlREKMKobZszY0dpobZTyZZXFFBaa29duT0IyXnwYL5317JQL
         ueOjtzD7YrLvlfbmHSZnkZLlnwNG6nc29pm07wq+HkIGX9c8yFc8gpUYgO+AsiznJ3
         mQSM9YMkm4+UMlVGWkDEWFGqjKD4UZKsxmoQ2ubxeoxRA+2XAMQM34X68+kiRVvtfT
         3kgapA20bV5mFMhUdU3TJlsUeMudfHwdVzAjrkoHfpr8zNhJSuGqwSlpI7IrVMoqJ2
         S2oqB5z/7bZXQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ruscur@russell.cc
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-3 tag
Date:   Sat, 20 Aug 2022 15:03:18 +1000
Message-ID: <87wnb3ld61.fsf@mpe.ellerman.id.au>
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

Please pull some more powerpc fixes for 6.0:

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-3

for you to fetch changes up to f889a2e89ea5b4db5cf09765ee5e310be43c7b6f:

  selftests/powerpc: Add missing PMU selftests to .gitignores (2022-08-15 20:59:17 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.0 #3

 - Fix atomic sleep warnings at boot due to get_phb_number() taking a mutex with a
   spinlock held on some machines.

 - Add missing PMU selftests to .gitignores.

Thanks to: Guenter Roeck, Russell Currey.

- ------------------------------------------------------------------
Michael Ellerman (1):
      powerpc/pci: Fix get_phb_number() locking

Russell Currey (1):
      selftests/powerpc: Add missing PMU selftests to .gitignores


 arch/powerpc/kernel/pci-common.c                                | 16 ++++++++++------
 tools/testing/selftests/powerpc/pmu/event_code_tests/.gitignore | 20 ++++++++++++++++++++
 tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore   | 18 ++++++++++++++----
 3 files changed, 44 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/pmu/event_code_tests/.gitignore
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmMAHQUACgkQUevqPMjh
pYAcqQ//TOGd1WWZmmOR7skVfa7mRdrHG0z5vZ0Zsx6e7TvgzugjrwCDIt19WIhG
PL8j+UnkPZ4/3d5xz9/tnXT/QPPVSsUAbPAtzCb25f5TdSNOaqiDNlIIinUTikZm
qTyf+Rbhfp3eIGZNOIDeYbWvuqKvVxEsJRffWfInzZ8QxbI7QJdIbO0biTxR8Tb5
oEDnK2KWxn97K20Vlnw1u7sWvfaxQv+xMtFg4ztRRoQIw7ArPJt2tlleSqHHa1ts
YEAoNJpWPZalWFNv71jdAJ0db1YKH61pMRATM1Axbq9sTRkERHAePHAvnQ5PW0r+
ojVSMj9RWF/e+zqfaU7f8IyYrXKBTCryoOLozWjmFoAlWF5MB4F7p4nVi0A9DBxx
MAZsuvlwG/SlkXzhImxJeUFyNt4p5AR+ogWdNoYtq6Tddrkr3J2g6wmxqpBamhfy
GpXiesZ5XbLRCBixn3RiEKd6ngiqWPE1Bi4Dh9Pe7qJXEmn94DwnSP9FmMMy7pg7
1uZRi2Fc+7+JkMPs3WvuDXaPmZt+IsKHEfwCokCyxMHmMz9bFQz3ibndmo2WaiKK
LKatWmKeOdfEDiQUnMNug5hItad+wN1x2gcmseuMXVVket0go9odlEqzvnrZoGf7
6D/ktlBdS8OFonqENuqdbH61Q93U3CqYKDXfB3royghRPlPLkCo=
=Agbh
-----END PGP SIGNATURE-----
