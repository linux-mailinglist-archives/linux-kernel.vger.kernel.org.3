Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB14E963F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbiC1MLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiC1MK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:10:59 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84673E5F9;
        Mon, 28 Mar 2022 05:09:17 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 22SC93bM012079;
        Mon, 28 Mar 2022 21:09:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 22SC93bM012079
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648469343;
        bh=c+gGW+Hvo3/XEWQflB1H1elV17VcXaSFdPpwtt/xXBs=;
        h=From:Date:Subject:To:Cc:From;
        b=na13MT7aDkurjoM8uu48kfDnv+m67IUwPnGIaICUE2OCmimlu+kRUEeMMBTqq/hsm
         DtgRQs1MCKBxfw87BVMEWzGl7kIivHa7iBCPyRcOb1huwC5hPhmp2S2QzIrEroQLhK
         DKaRxvDH6GTBTGSNiYMT0dUuunqOr1feSKX+U9MxYZnDz8w6Lf/R/Ek5I+t6qZ5j/5
         L8behEnweKSrQ+TC7wU2QRtoKDn+uZ/JZJ+RzQs3t2t09GPISLLqNr8QsvhDH1L0DA
         Vrv2DVQE5S3KXubXzApUDZv1suwbOfS8qTV4pHZiMrdY3s+6faFs0uFrlNizV8p+DH
         EBYyBe3zOTu5w==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso15290891pjb.5;
        Mon, 28 Mar 2022 05:09:03 -0700 (PDT)
X-Gm-Message-State: AOAM533LX6BIUrl1DF/cnHuMiSajpOcY0Y1joip/hgFgijCzJGYdBPGd
        D/kY9aqebZsYaUtOLwiwMeLakmGDR0p8xbLtzbU=
X-Google-Smtp-Source: ABdhPJwYfzvKemZswJY8637ay3aUSXZUmXezfQifjzzQkJ5SZ8jAGwqS70Lj09Aejd1Tj0brVbU9PJR8pr4wk7HTjDQ=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr25875877plr.136.1648469342649; Mon, 28
 Mar 2022 05:09:02 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 28 Mar 2022 21:08:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATL4v40ZHJ+Ym3k_fVe4ddmMA3wFQXb5RaTz9hmPebeuQ@mail.gmail.com>
Message-ID: <CAK7LNATL4v40ZHJ+Ym3k_fVe4ddmMA3wFQXb5RaTz9hmPebeuQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v5.18-rc1
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


Please pull the remaining Kbuild changes.

You will see conflicts in the top Makefile.
The fix-up is available in linux-next.
(6c4457c324cd9855352e3eb1f965105901e47a6d)


Thank you.



The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v5.18

for you to fetch changes up to b0324de9dfba0e05ea7991a91b002c1441bf27e1:

  kbuild: Make $(LLVM) more flexible (2022-03-18 13:45:14 +0900)

----------------------------------------------------------------
Kbuild updates for v5.18

 - Add new environment variables, USERCFLAGS and USERLDFLAGS to allow
   additional flags to be passed to user-space programs.

 - Fix missing fflush() bugs in Kconfig and fixdep

 - Fix a minor bug in the comment format of the .config file

 - Make kallsyms ignore llvm's local labels, .L*

 - Change the .config format to use CONFIG_FOO=n instead of
   "# CONFIG_FOO is not set"

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

Masahiro Yamada (11):
      kbuild: unify cmd_copy and cmd_shipped
      kbuild: replace $(if A,A,B) with $(or A,B)
      kconfig: add fflush() before ferror() check
      kconfig: fix missing '# end of' for empty menu
      certs: include certs/signing_key.x509 unconditionally
      certs: simplify empty certs creation in certs/Makefile
      kconfig: change .config format to use =n instead of "is not set"
      usr/include: replace extra-y with always-y
      arch: syscalls: simplify uapi/kapi directory creation
      fixdep: use fflush() and ferror() to ensure successful write to files
      kbuild: add --target to correctly cross-compile UAPI headers with Clang

Nathan Chancellor (1):
      kbuild: Make $(LLVM) more flexible

 Documentation/kbuild/kbuild.rst                             | 11 +++++++
 Documentation/kbuild/llvm.rst                               | 31
++++++++++++++----
 Documentation/kbuild/makefiles.rst                          |  2 ++
 Makefile                                                    | 44
++++++++++++++-----------
 arch/alpha/kernel/syscalls/Makefile                         |  3 +-
 arch/arm/tools/Makefile                                     |  3 +-
 arch/ia64/kernel/syscalls/Makefile                          |  3 +-
 arch/m68k/kernel/syscalls/Makefile                          |  3 +-
 arch/microblaze/boot/Makefile                               |  2 +-
 arch/microblaze/boot/dts/Makefile                           |  2 +-
 arch/microblaze/kernel/syscalls/Makefile                    |  3 +-
 arch/mips/kernel/syscalls/Makefile                          |  3 +-
 arch/parisc/kernel/syscalls/Makefile                        |  3 +-
 arch/powerpc/kernel/syscalls/Makefile                       |  3 +-
 arch/s390/kernel/syscalls/Makefile                          |  3 +-
 arch/sh/kernel/syscalls/Makefile                            |  3 +-
 arch/sparc/kernel/syscalls/Makefile                         |  3 +-
 arch/x86/entry/syscalls/Makefile                            |  3 +-
 arch/xtensa/kernel/syscalls/Makefile                        |  3 +-
 certs/Makefile                                              | 37
+++++++--------------
 certs/system_certificates.S                                 |  3 --
 fs/unicode/Makefile                                         |  2 +-
 init/Kconfig                                                |  8 ++---
 scripts/Makefile.build                                      |  3 +-
 scripts/Makefile.clean                                      |  2 +-
 scripts/Makefile.lib                                        | 16 ++++------
 scripts/basic/fixdep.c                                      | 46
+++++++++++----------------
 scripts/kallsyms.c                                          |  2 +-
 scripts/kconfig/confdata.c                                  | 42
++++++++++++------------
 scripts/kconfig/merge_config.sh                             | 19 ++++++-----
 scripts/kconfig/streamline_config.pl                        |  2 +-
 scripts/kconfig/tests/choice/alldef_expected_config         |  6 ++--
 scripts/kconfig/tests/choice/allmod_expected_config         |  4 +--
 scripts/kconfig/tests/choice/allno_expected_config          |  6 ++--
 scripts/kconfig/tests/choice/allyes_expected_config         |  8 ++---
 scripts/kconfig/tests/choice/oldask1_config                 |  2 +-
 scripts/kconfig/tests/inter_choice/expected_config          |  2 +-
 scripts/kconfig/tests/new_choice_with_dep/config            |  2 +-
 scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py     |  7 ++--
 scripts/kconfig/tests/no_write_if_dep_unmet/expected_config |  2 +-
 tools/bpf/bpftool/Makefile                                  |  4 +--
 tools/build/Makefile                                        |  2 +-
 tools/counter/Makefile                                      |  2 +-
 tools/gpio/Makefile                                         |  2 +-
 tools/hv/Makefile                                           |  2 +-
 tools/iio/Makefile                                          |  2 +-
 tools/lib/api/Makefile                                      |  2 +-
 tools/lib/bpf/Makefile                                      |  2 +-
 tools/lib/perf/Makefile                                     |  2 +-
 tools/lib/subcmd/Makefile                                   |  2 +-
 tools/objtool/Makefile                                      |  2 +-
 tools/pci/Makefile                                          |  2 +-
 tools/perf/Makefile.perf                                    |  4 +--
 tools/power/x86/intel-speed-select/Makefile                 |  2 +-
 tools/scripts/Makefile.include                              | 22 ++++++++-----
 tools/scripts/utilities.mak                                 |  2 +-
 tools/spi/Makefile                                          |  6 ++--
 tools/testing/selftests/lib.mk                              |  8 ++++-
 tools/tracing/rtla/Makefile                                 |  2 +-
 tools/usb/Makefile                                          |  2 +-
 usr/Makefile                                                |  4 +--
 usr/include/Makefile                                        |  7 ++--
 62 files changed, 224 insertions(+), 213 deletions(-)

-- 
Best Regards
Masahiro Yamada
