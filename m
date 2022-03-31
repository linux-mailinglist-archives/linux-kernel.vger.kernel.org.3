Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33B4ED2EA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiCaEP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCaEPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:15:06 -0400
X-Greylist: delayed 247 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 20:48:12 PDT
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D352976F0;
        Wed, 30 Mar 2022 20:48:11 -0700 (PDT)
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-05.nifty.com with ESMTP id 22V3TdnN022336;
        Thu, 31 Mar 2022 12:29:39 +0900
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 22V3SnTf021405;
        Thu, 31 Mar 2022 12:28:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 22V3SnTf021405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648697329;
        bh=ebHiMyRXav+yYbj4YhCL/RfqMUHBooyu6ftffopVXqQ=;
        h=From:Date:Subject:To:Cc:From;
        b=ZGlny3DA71k8ikJLnGyRECTgQyO7xB3etGAcHL4IWMO2Ll4b1J0pvlKnJM6AWNI/S
         vehegfWxV6DWJKljebu7hHx/yBy9HapwmdQFKVXH1vMK1S1tG7vvjNshvcQ3MV01dZ
         sgeWR0KJJfkyuqGs5cIduOFXEjYAScCNprr0D9KZJ+t84TRxO6vcayUiX7EFvKskrZ
         el+I+pNisq47KJy//MUN31nF4DYYOAoYdfPbJG4DCoazZMpyTv9PPXToP0kI0IrFiM
         Jp9qzvuPHejQroq+g7vy2v5GWh18a1Gb/0ojfp5VA6Jmaq+hsu078C2rqfsQC2sJ3/
         5dyf7fD8EwWMA==
X-Nifty-SrcIP: [209.85.214.174]
Received: by mail-pl1-f174.google.com with SMTP id x2so22249710plm.7;
        Wed, 30 Mar 2022 20:28:49 -0700 (PDT)
X-Gm-Message-State: AOAM531+3HbmcqDSOE5+ATyjEQKbPeMoGSO27dzEpnosi7tjKWvLt/+a
        ma2aPaSiZb0eUCQ9cfe+Pc3yYBjHSJ121+6EbKM=
X-Google-Smtp-Source: ABdhPJy9ZE47MB+xD259EDGtBKxUDhqoi9uMl1Rs9lqYW9wobU0i+Q3DHJM1+HZ9gz0lLLrx7ELC6Su6RTCswDVVQZ8=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr3171203plp.162.1648697328481; Wed, 30
 Mar 2022 20:28:48 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 31 Mar 2022 12:28:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ1OPH-WFLyUfmVMUE4in7tbcdNME-Cp=OvJfUAJAPZ9g@mail.gmail.com>
Message-ID: <CAK7LNAQ1OPH-WFLyUfmVMUE4in7tbcdNME-Cp=OvJfUAJAPZ9g@mail.gmail.com>
Subject: [GIT PULL v2] Kbuild updates for v5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is v2 for the remaining Kbuild changes.

I dropped the
"# CONFIG_FOO is not set"   to CONFIG_FOO=n
change in Kconfig.

Thank you.




The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v5.18-v2

for you to fetch changes up to e9c281928c24dfeb86b11c31b53757b6a127f8aa:

  kbuild: Make $(LLVM) more flexible (2022-03-31 12:03:46 +0900)

----------------------------------------------------------------
Kbuild updates for v5.18

 - Add new environment variables, USERCFLAGS and USERLDFLAGS to allow
   additional flags to be passed to user-space programs.

 - Fix missing fflush() bugs in Kconfig and fixdep

 - Fix a minor bug in the comment format of the .config file

 - Make kallsyms ignore llvm's local labels, .L*

 - Fix UAPI compile-test for cross-compiling with Clang

 - Extend the LLVM= syntax to support LLVM=<suffix> form for using a
   particular version of LLVm, and LLVM=<prefix> form for using custom
   LLVM in a particular directory path.

 - Clean up Makefiles

----------------------------------------------------------------
Changbin Du (1):
      kallsyms: ignore all local labels prefixed by '.L'

Elliot Berman (1):
      kbuild: Add environment variables for userprogs flags

Masahiro Yamada (10):
      kbuild: unify cmd_copy and cmd_shipped
      kbuild: replace $(if A,A,B) with $(or A,B)
      kconfig: add fflush() before ferror() check
      kconfig: fix missing '# end of' for empty menu
      certs: include certs/signing_key.x509 unconditionally
      certs: simplify empty certs creation in certs/Makefile
      usr/include: replace extra-y with always-y
      arch: syscalls: simplify uapi/kapi directory creation
      fixdep: use fflush() and ferror() to ensure successful write to files
      kbuild: add --target to correctly cross-compile UAPI headers with Clang

Nathan Chancellor (1):
      kbuild: Make $(LLVM) more flexible

 Documentation/kbuild/kbuild.rst             | 11 +++++++++++
 Documentation/kbuild/llvm.rst               | 31
+++++++++++++++++++++++++------
 Documentation/kbuild/makefiles.rst          |  2 ++
 Makefile                                    | 44
++++++++++++++++++++++++++------------------
 arch/alpha/kernel/syscalls/Makefile         |  3 +--
 arch/arm/tools/Makefile                     |  3 +--
 arch/ia64/kernel/syscalls/Makefile          |  3 +--
 arch/m68k/kernel/syscalls/Makefile          |  3 +--
 arch/microblaze/boot/Makefile               |  2 +-
 arch/microblaze/boot/dts/Makefile           |  2 +-
 arch/microblaze/kernel/syscalls/Makefile    |  3 +--
 arch/mips/kernel/syscalls/Makefile          |  3 +--
 arch/parisc/kernel/syscalls/Makefile        |  3 +--
 arch/powerpc/kernel/syscalls/Makefile       |  3 +--
 arch/s390/kernel/syscalls/Makefile          |  3 +--
 arch/sh/kernel/syscalls/Makefile            |  3 +--
 arch/sparc/kernel/syscalls/Makefile         |  3 +--
 arch/x86/entry/syscalls/Makefile            |  3 +--
 arch/xtensa/kernel/syscalls/Makefile        |  3 +--
 certs/Makefile                              | 37
+++++++++++--------------------------
 certs/system_certificates.S                 |  3 ---
 fs/unicode/Makefile                         |  2 +-
 init/Kconfig                                |  8 ++++----
 scripts/Makefile.build                      |  3 +--
 scripts/Makefile.clean                      |  2 +-
 scripts/Makefile.lib                        | 16 ++++++----------
 scripts/basic/fixdep.c                      | 46
+++++++++++++++++++---------------------------
 scripts/kallsyms.c                          |  2 +-
 scripts/kconfig/confdata.c                  | 27 +++++++++++++++------------
 tools/bpf/bpftool/Makefile                  |  4 ++--
 tools/build/Makefile                        |  2 +-
 tools/counter/Makefile                      |  2 +-
 tools/gpio/Makefile                         |  2 +-
 tools/hv/Makefile                           |  2 +-
 tools/iio/Makefile                          |  2 +-
 tools/lib/api/Makefile                      |  2 +-
 tools/lib/bpf/Makefile                      |  2 +-
 tools/lib/perf/Makefile                     |  2 +-
 tools/lib/subcmd/Makefile                   |  2 +-
 tools/objtool/Makefile                      |  2 +-
 tools/pci/Makefile                          |  2 +-
 tools/perf/Makefile.perf                    |  4 ++--
 tools/power/x86/intel-speed-select/Makefile |  2 +-
 tools/scripts/Makefile.include              | 22 ++++++++++++++--------
 tools/scripts/utilities.mak                 |  2 +-
 tools/spi/Makefile                          |  6 +++---
 tools/testing/selftests/lib.mk              |  8 +++++++-
 tools/tracing/rtla/Makefile                 |  2 +-
 tools/usb/Makefile                          |  2 +-
 usr/Makefile                                |  4 ++--
 usr/include/Makefile                        |  7 +++++--
 51 files changed, 188 insertions(+), 174 deletions(-)


--
Best Regards
Masahiro Yamada
