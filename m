Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37392492E97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348864AbiARTnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:43:16 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:33954 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348857AbiARTnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:43:14 -0500
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 20IJgrbE026463;
        Wed, 19 Jan 2022 04:42:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 20IJgrbE026463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642534974;
        bh=LNvWzZoXdQgjKsY/TuZQXMxlMKkxTYTgfKxIGj0AYOY=;
        h=From:Date:Subject:To:Cc:From;
        b=ccBA/DIbNW6kEdm2Sd7RlPMEggElLy/LSK70wciIB/RBYGHgf+2NjemghjpumBmEY
         nEFJRos+XFdE2RI7ZOIEzGXadf+yTaWA9+1UG4BDG4xUunX+bPHTIkkHP1rw1d25kb
         TbKVJNgZVp4yQ9L5cCZgzvW58COIwOESdVWdh2GLMRICxyjGDlduEltTJpWM4BdOb2
         Jq53zMyAUVx5IAyrwGTTHNaqc+PKzwQfYI6jV5oCwGfXMX4jZoxXXRJTIZpJ2/vyBU
         NLaFsmpW+nUtDv3T04TAylrdGgaRCu7mqG7FZQ2x9o8MA6C4Uc7Eys0SfGjDoJZk9c
         /9qvCHzSLgZhQ==
X-Nifty-SrcIP: [209.85.215.174]
Received: by mail-pg1-f174.google.com with SMTP id 8so137318pgc.10;
        Tue, 18 Jan 2022 11:42:54 -0800 (PST)
X-Gm-Message-State: AOAM533d6+c+TLA6v1Wbx8PI1joDWMhTX+prBJqGyHCvQrMhrIQcVkxQ
        0JHE6RtX01aD13YojdcYYHWY8GU6b6OYAVxc6RI=
X-Google-Smtp-Source: ABdhPJx+BM5pnypS6Zvw++CZxvDPLbOIwS69tzu4dV+GB5aMmXGWxPkdGd842xNcKryUL7mriUdoRZcaEdLnp3nD+48=
X-Received: by 2002:a65:66c5:: with SMTP id c5mr15815564pgw.126.1642534973320;
 Tue, 18 Jan 2022 11:42:53 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 19 Jan 2022 04:42:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAShL3dfQ0Ter2avCvGPjrd0YTJau-S4+8rJyWXmu0tG0Q@mail.gmail.com>
Message-ID: <CAK7LNAShL3dfQ0Ter2avCvGPjrd0YTJau-S4+8rJyWXmu0tG0Q@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kbuild updates.
Thanks.


You will see a trivial conflict in scripts/link-vmlinux.sh
(commit 72b3942a173c in the mainline
vs 7d153696e5db from this PR)
The fix is available in linux-next.




The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5=
:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v5.17

for you to fetch changes up to c4d7f40b250c1a4d74ed259e84807f58032507b6:

  kbuild: add cmd_file_size (2022-01-14 02:57:43 +0900)

----------------------------------------------------------------
Kbuild updates for v5.17

 - Add new kconfig target 'make mod2noconfig', which will be useful to
   speed up the build and test iteration.

 - Raise the minimum supported version of LLVM to 11.0.0

 - Refactor certs/Makefile

 - Change the format of include/config/auto.conf to stop double-quoting
   string type CONFIG options.

 - Fix ARCH=3Dsh builds in dash

 - Separate compression macros for general purposes (cmd_bzip2 etc.) and
   the ones for decompressors (cmd_bzip2_with_size etc.)

 - Misc Makefile cleanups

----------------------------------------------------------------
Josh Triplett (1):
      kconfig: Add `make mod2noconfig` to disable module options

Masahiro Yamada (25):
      certs: move the 'depends on' to the choice of module signing keys
      nds32: remove unused BUILTIN_DTB from arch/nds32/Makefile
      certs: remove meaningless $(error ...) in certs/Makefile
      certs: check-in the default x509 config file
      certs: remove noisy messages while generating the signing key
      certs: use 'cmd' to hide openssl output in silent builds more simply
      certs: use if_changed to re-generate the key when the key type is cha=
nged
      kbuild: move headers_check.pl to usr/include/
      kbuild: remove headers_check stub
      certs: use $< and $@ to simplify the key generation rule
      certs: unify duplicated cmd_extract_certs and improve the log
      certs: remove unneeded -I$(srctree) option for system_certificates.o
      certs: refactor file cleaning
      certs: remove misleading comments about GCC PR
      kbuild: stop using config_filename in scripts/Makefile.modsign
      certs: simplify $(srctree)/ handling and remove config_filename macro
      kbuild: do not include include/config/auto.conf from shell scripts
      kbuild: do not quote string values in include/config/auto.conf
      certs: move scripts/extract-cert to certs/
      microblaze: use built-in function to get CPU_{MAJOR,MINOR,REV}
      sh: rename suffix-y to suffix_y
      kbuild: drop $(size_append) from cmd_zstd
      kbuild: rename cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}
      arch: decompressor: remove useless vmlinux.bin.all-y
      kbuild: add cmd_file_size

Miguel Ojeda (1):
      doc: kbuild: fix default in `imply` table

Nathan Chancellor (6):
      Documentation: Raise the minimum supported version of LLVM to 11.0.0
      mm, slab: Remove compiler check in __kmalloc_index
      arch/Kconfig: Remove CLANG_VERSION check in HAS_LTO_CLANG
      Revert "ARM: 9070/1: Make UNWINDER_ARM depend on ld.bfd or ld.lld 11.=
0.0+"
      gcov: Remove compiler version check
      init/Kconfig: Drop linker version check for LD_ORPHAN_WARN

=C5=81ukasz Stelmach (1):
      streamline_config.pl: show the full Kconfig name

 Documentation/kbuild/kconfig-language.rst     |   2 +-
 Documentation/process/changes.rst             |   2 +-
 MAINTAINERS                                   |   1 -
 Makefile                                      |  15 +--
 arch/Kconfig                                  |   3 +-
 arch/arc/Makefile                             |   4 +-
 arch/arc/boot/dts/Makefile                    |   4 +-
 arch/arm/Kconfig.debug                        |   2 -
 arch/arm/boot/compressed/Makefile             |   8 +-
 arch/h8300/boot/compressed/Makefile           |   4 +-
 arch/h8300/boot/dts/Makefile                  |   6 +-
 arch/microblaze/Makefile                      |   8 +-
 arch/mips/boot/compressed/Makefile            |  12 +--
 arch/nds32/Makefile                           |   6 --
 arch/nds32/boot/dts/Makefile                  |   7 +-
 arch/nios2/boot/dts/Makefile                  |   2 +-
 arch/openrisc/boot/dts/Makefile               |   7 +-
 arch/parisc/boot/compressed/Makefile          |  24 +++--
 arch/powerpc/boot/Makefile                    |   2 +-
 arch/riscv/boot/dts/canaan/Makefile           |   4 +-
 arch/s390/boot/compressed/Makefile            |  28 +++---
 arch/sh/boot/Makefile                         |  16 ++--
 arch/sh/boot/compressed/Makefile              |  22 ++---
 arch/sh/boot/dts/Makefile                     |   4 +-
 arch/x86/boot/compressed/Makefile             |  12 +--
 arch/xtensa/Makefile                          |   2 +-
 arch/xtensa/boot/dts/Makefile                 |   5 +-
 certs/.gitignore                              |   1 +
 certs/Kconfig                                 |   4 +-
 certs/Makefile                                | 125 +++++++---------------=
---
 certs/default_x509.genkey                     |  17 ++++
 {scripts =3D> certs}/extract-cert.c             |   2 +-
 drivers/acpi/Makefile                         |   2 +-
 drivers/base/firmware_loader/builtin/Makefile |   4 +-
 include/linux/slab.h                          |   3 +-
 include/uapi/linux/soundcard.h                |   2 +-
 init/Kconfig                                  |   1 -
 init/Makefile                                 |   2 +-
 kernel/gcov/Kconfig                           |   1 -
 net/wireless/Makefile                         |   4 +-
 scripts/.gitignore                            |   1 -
 scripts/Kbuild.include                        |  47 ----------
 scripts/Makefile                              |  11 +--
 scripts/Makefile.lib                          |  35 +++++--
 scripts/Makefile.modinst                      |   4 +-
 scripts/gen_autoksyms.sh                      |  11 +--
 scripts/kconfig/Makefile                      |   3 +-
 scripts/kconfig/conf.c                        |  17 ++--
 scripts/kconfig/confdata.c                    |  24 ++---
 scripts/kconfig/streamline_config.pl          |   2 +-
 scripts/link-vmlinux.sh                       |  47 +++++-----
 scripts/min-tool-version.sh                   |   2 +-
 scripts/remove-stale-files                    |   2 +
 scripts/setlocalversion                       |   9 +-
 usr/Makefile                                  |   7 +-
 usr/include/Makefile                          |   6 +-
 {scripts =3D> usr/include}/headers_check.pl     |   0
 57 files changed, 242 insertions(+), 366 deletions(-)
 create mode 100644 certs/default_x509.genkey
 rename {scripts =3D> certs}/extract-cert.c (98%)
 rename {scripts =3D> usr/include}/headers_check.pl (100%)


--=20
Best Regards
Masahiro Yamada
