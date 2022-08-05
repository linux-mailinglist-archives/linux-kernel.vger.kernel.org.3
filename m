Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6038B58B0F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiHEU4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbiHEU4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:56:20 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7981316598
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:56:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 505C5615CC86;
        Fri,  5 Aug 2022 22:56:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uMRZS_T2Xetd; Fri,  5 Aug 2022 22:56:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D6E4761F1103;
        Fri,  5 Aug 2022 22:56:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uvmJT0NlT9GO; Fri,  5 Aug 2022 22:56:14 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id B4ED7615CC86;
        Fri,  5 Aug 2022 22:56:14 +0200 (CEST)
Date:   Fri, 5 Aug 2022 22:56:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <922167294.69837.1659732974689.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v5.20-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: 5VRBCTVDHJud0aUhCqSEMUnPdvZZ3Q==
Thread-Topic: UML changes for v5.20-rc1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.20-rc1

for you to fetch changes up to af3e16101cee95efaa72095fe06c15ec0b8eb195:

  um: include sys/types.h for size_t (2022-07-17 23:47:18 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- KASAN support for x86_64
- noreboot command line option, just like qemu's -no-reboot
- Various fixes and cleanups

----------------------------------------------------------------
Benjamin Beichler (1):
      um: Remove straying parenthesis

Christopher Obbard (1):
      um: random: Don't initialise hwrng struct with zero

David Gow (2):
      arch: um: Fix build for statically linked UML w/ constructors
      mm: Add PAGE_ALIGN_DOWN macro

Guenter Roeck (1):
      um: Replace to_phys() and to_virt() with less generic function names

Haowen Bai (1):
      um: remove unused variable

Jason A. Donenfeld (3):
      um: include linux/stddef.h for __always_inline
      um: add "noreboot" command line option for PANIC_TIMEOUT=-1 setups
      um: include sys/types.h for size_t

Johannes Berg (1):
      um: x86: print RIP with symbol

Juerg Haefliger (3):
      um: Kconfig: Fix indentation
      um/drivers: Kconfig: Fix indentation
      x86/um: Kconfig: Fix indentation

Patricia Alfonso (1):
      UML: add support for KASAN under x86_64

Peter Zijlstra (1):
      um: Add missing apply_returns()

Tobias Klauser (1):
      um: remove unused mm_copy_segments

 arch/um/Kconfig                         | 17 ++++++++++-
 arch/um/drivers/Kconfig                 | 54 ++++++++++++++++-----------------
 arch/um/drivers/random.c                |  2 +-
 arch/um/include/asm/common.lds.S        |  2 ++
 arch/um/include/asm/kasan.h             | 37 ++++++++++++++++++++++
 arch/um/include/asm/page.h              |  4 +--
 arch/um/include/asm/processor-generic.h |  5 ---
 arch/um/include/asm/xor.h               |  2 +-
 arch/um/include/shared/mem.h            |  4 +--
 arch/um/include/shared/user.h           |  3 +-
 arch/um/kernel/dyn.lds.S                |  6 +++-
 arch/um/kernel/mem.c                    | 19 ++++++++++++
 arch/um/kernel/stacktrace.c             |  2 +-
 arch/um/kernel/um_arch.c                |  4 +++
 arch/um/kernel/uml.lds.S                |  1 +
 arch/um/os-Linux/mem.c                  | 22 ++++++++++++++
 arch/um/os-Linux/skas/process.c         | 23 +++++++++++---
 arch/um/os-Linux/umid.c                 |  3 +-
 arch/um/os-Linux/user_syms.c            |  4 +--
 arch/x86/um/Kconfig                     | 10 +++---
 arch/x86/um/Makefile                    |  3 +-
 arch/x86/um/shared/sysdep/stub_64.h     |  1 +
 arch/x86/um/sysrq_64.c                  |  4 +--
 arch/x86/um/vdso/Makefile               |  3 ++
 include/linux/mm.h                      |  3 ++
 mm/kasan/shadow.c                       | 29 ++++++++++++++++--
 26 files changed, 207 insertions(+), 60 deletions(-)
 create mode 100644 arch/um/include/asm/kasan.h
