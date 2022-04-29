Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E96514A13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359625AbiD2NAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbiD2NAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AECBC9B78;
        Fri, 29 Apr 2022 05:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF3062175;
        Fri, 29 Apr 2022 12:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3709EC385A7;
        Fri, 29 Apr 2022 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651237039;
        bh=mnhHtahTyMyfdg8BqKE6S8Wu+5JRxfi6iavSLfvwnpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Dl+EBOT7CzUgQJDGZmgcJnyPsTYG82cWKh2SDvCpl8Xmnueynl0lSXqstSwCDWJyQ
         kz12oUwbNXKsVFsIfKRlgTUYtONobRw5iPdAvq5a7tSJUM2JB03LvPSwwU9A2iCyeX
         /1e1bN/fw98YtMsUFPz5IhAnwJoM031XJSUlBdWlpVrtuJfS1Wzsa3aOaacMn+cBbw
         Dz3M7+SHYzREnTKpo7kh9OCMI2G+VephTmrI1HZogGqLyr42P9W9RKysQBJpkfdZx7
         qKHIDK+3AOvsaeYHzS6AmQn1IcuE6ORI9D4XBZC3HfRKjMqcGtVpF4um59peH46H2j
         r0FIpLZdN+T0A==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Timothy Hayes <timothy.hayes@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.18: 4th batch
Date:   Fri, 29 Apr 2022 09:57:12 -0300
Message-Id: <20220429125712.527713-1-acme@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message.

The following changes since commit 8f4dd16603ce834d1c5c4da67803ea82dd282511:

  Merge branch 'akpm' (patches from Andrew) (2022-04-27 13:44:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-04-29

for you to fetch changes up to a5d20d42a2f2dc2b2f9e9361912062732414090d:

  perf symbol: Remove arch__symbols__fixup_end() (2022-04-28 10:51:40 -0300)

----------------------------------------------------------------
perf tools fixes for v5.18: 4th batch

- Fix Intel PT (Processor Trace) timeless decoding with perf.data directory.

- ARM SPE (Statistical Profiling Extensions) address fixes, for synthesized
  events and for SPE events with physical addresses.  Add a simple 'perf test'
  entry to make sure this doesn't regress.

- Remove arch specific processing of kallsyms data to fixup symbol end address,
  fixing excessive memory consumption in the annotation code.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf intel-pt: Fix timeless decoding with perf.data directory

Namhyung Kim (3):
      perf symbol: Pass is_kallsyms to symbols__fixup_end()
      perf symbol: Update symbols__fixup_end()
      perf symbol: Remove arch__symbols__fixup_end()

Timothy Hayes (3):
      perf arm-spe: Fix addresses of synthesized SPE events
      perf arm-spe: Fix SPE events with phys addresses
      perf test: Add perf_event_attr test for Arm SPE

 tools/perf/arch/arm64/util/arm-spe.c               | 10 ++++++
 tools/perf/arch/arm64/util/machine.c               | 21 ------------
 tools/perf/arch/powerpc/util/Build                 |  1 -
 tools/perf/arch/powerpc/util/machine.c             | 25 ---------------
 tools/perf/arch/s390/util/machine.c                | 16 ----------
 tools/perf/tests/attr/README                       |  1 +
 .../tests/attr/test-record-spe-physical-address    | 12 +++++++
 tools/perf/util/arm-spe.c                          |  5 +--
 tools/perf/util/session.c                          |  2 +-
 tools/perf/util/symbol-elf.c                       |  2 +-
 tools/perf/util/symbol.c                           | 37 ++++++++++++++++------
 tools/perf/util/symbol.h                           |  3 +-
 12 files changed, 56 insertions(+), 79 deletions(-)
 delete mode 100644 tools/perf/arch/powerpc/util/machine.c
 create mode 100644 tools/perf/tests/attr/test-record-spe-physical-address

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
Gwith a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one.

There is still the mageia:7 distro + clang 8 failure, seemingly unrelated to
the patches in this series, it'll be investigated. It builds just fine with gcc
8.4.

There is also a strange one with openmandriva:4.2 and openmandriva:cooker,
where on the feature build test it doesn't manage to find libpthread, because
the pthread functions (and the ones in librt, IIRC) are on the main libc, so a
test for that is needed to avoid adding '-lpthread and -lrt' in distros where
this is the case. It's in the TODO list.

Ubuntu 20.04 is failing on a corner case where perf links with libllvm and libclang,
which isn't the default perf build.

And finally there is a problem when linking with libtraceevent-devel dynamicly on
fedora:36, will be investigated.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.18.0-rc4.tar.xz
  $ time dm
   1   117.46 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    69.22 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3    68.52 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4    71.93 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5    76.74 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6    76.54 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7    79.57 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8   107.73 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9   120.38 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10   126.20 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11   137.15 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12   124.58 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13   129.53 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  14   117.58 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
  15    62.79 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  16    90.88 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  17    90.90 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  18    91.30 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.1
  19    66.01 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  20   101.82 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  21   119.86 amazonlinux:devel             : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
  22   106.71 archlinux:base                : Ok   gcc (GCC) 11.2.0 , clang version 13.0.1
  23   101.01 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  24   111.25 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.0 (Red Hat 13.0.0-3.module_el8.6.0+1074+380cef3f)
  25    87.22 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.0.1 20220414 (experimental) releases/gcc-11.2.0-1079-g537dca0ff5 , clang version 13.0.0
  26    85.99 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  27    86.88 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
  28   102.92 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  29   123.21 debian:experimental           : Ok   gcc (Debian 11.2.0-20) 11.2.0 , Debian clang version 13.0.1-3+b2
  30    25.07 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  31    20.65 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  32    22.45 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  33    23.26 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  34    33.18 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  35    69.62 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  36    83.67 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  37    18.35 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  38    83.25 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  39    93.59 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  40    96.38 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  41   107.82 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  42   115.15 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  43   118.65 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  44   110.53 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  45   107.36 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  46   104.83 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  47   111.76 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  48    20.44 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  49    18.53 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  50   113.57 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  51    31.17 fedora:36                     : FAIL gcc version 12.0.1 20220413 (Red Hat 12.0.1-0) (GCC) 
    + make PYTHON=python3 ARCH= CROSS_COMPILE= EXTRA_CFLAGS= LIBTRACEEVENT_DYNAMIC=1 -C tools/perf O=/tmp/build/perf
    make: Entering directory '/git/perf-5.18.0-rc4/tools/perf'
      BUILD:   Doing 'make -j32' parallel build
    Makefile.config:728: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
    Makefile.config:1011: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
    Makefile.config:1118: *** Error: No libtraceevent devel library found, please install libtraceevent-devel.  Stop.

  52   126.51 fedora:rawhide                : Ok   gcc (GCC) 12.0.1 20220413 (Red Hat 12.0.1-0) , clang version 14.0.0 (Fedora 14.0.0-1.fc37)
  53    97.82 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  54    82.85 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  55    43.42 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.18.0-rc4/tools/build/Makefile.build:139: util] Error 2
  56   107.75 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  57     6.48 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
    In file included from builtin-bench.c:22:
    bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:64,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
  58     6.48 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
    In file included from builtin-bench.c:22:
    bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:64,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
  59   114.64 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  60   121.05 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  61   117.54 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  62   131.60 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  63   130.78 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  64   153.08 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20220316 [revision 6a1150d1524aeda3381b2171712e1a6611d441d6] , clang version 13.0.1
  65   113.76 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  66   117.17 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
  67    84.36 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  68    19.65 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  69    19.75 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  70    24.66 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  71    19.74 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  72    19.94 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  73    19.74 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  74    88.76 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  75    21.15 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    21.75 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    17.33 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78    20.85 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  79    22.35 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  80    22.75 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  81   103.47 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  82    19.03 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  83    20.24 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  84    19.34 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  85    89.07 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 
      LINK    /tmp/build/perf/perf
    /usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a(BackendUtil.cpp.o): in function `(anonymous namespace)::EmitAssemblyHelper::EmitAssemblyWithNewPassManager(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >)':
    (.text._ZN12_GLOBAL__N_118EmitAssemblyHelper30EmitAssemblyWithNewPassManagerEN5clang13BackendActionESt10unique_ptrIN4llvm17raw_pwrite_streamESt14default_deleteIS5_EE+0x1f15): undefined reference to `getPollyPluginInfo()'
    clang: error: linker command failed with exit code 1 (use -v to see invocation)
    make[2]: *** [Makefile.perf:677: /tmp/build/perf/perf] Error 1
    make[1]: *** [Makefile.perf:240: sub-make] Error 2

  86    23.06 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  87    86.97 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  88   101.22 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  89   105.13 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
  90   126.71 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
BUILD_TARBALL_HEAD=a5d20d42a2f2dc2b2f9e9361912062732414090d
91 6969.13

real	117m57.209s
user	1m4.634s
sys	0m58.710s
[perfbuilder@five ~]$ 

[acme@quaco perf]$ uname -a
Linux quaco 5.16.13-200.fc35.x86_64 #1 SMP PREEMPT Tue Mar 8 22:50:58 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
[acme@quaco perf]$ git log --oneline -1
a5d20d42a2f2dc2b (HEAD -> perf/urgent, seventh/perf/urgent, five/perf/urgent) perf symbol: Remove arch__symbols__fixup_end()
[acme@quaco perf]$ perf -v
perf version 5.18.rc4.ga5d20d42a2f2
[acme@quaco perf]$ sudo su -
[sudo] password for acme: 
[root@quaco ~]# perf -vv
perf version 5.18.rc4.ga5d20d42a2f2
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ OFF ]  # HAVE_LIBPFM
[root@quaco ~]# perf test
  1: vmlinux symtab matches kallsyms                                 : Ok
  2: Detect openat syscall event                                     : Ok
  3: Detect openat syscall event on all cpus                         : Ok
  4: Read samples using the mmap interface                           : Ok
  5: Test data source output                                         : Ok
  6: Parse event definition strings                                  : Ok
  7: Simple expression parser                                        : Ok
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
  9: Parse perf pmu format                                           : Ok
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 11: DSO data read                                                   : Ok
 12: DSO data cache                                                  : Ok
 13: DSO data reopen                                                 : Ok
 14: Roundtrip evsel->name                                           : Ok
 15: Parse sched tracepoints fields                                  : Ok
 16: syscalls:sys_enter_openat event fields                          : Ok
 17: Setup struct perf_event_attr                                    : Ok
 18: Match and link multiple hists                                   : Ok
 19: 'import perf' in python                                         : Ok
 20: Breakpoint overflow signal handler                              : Ok
 21: Breakpoint overflow sampling                                    : Ok
 22: Breakpoint accounting                                           : Ok
 23: Watchpoint                                                      :
 23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
 23.2: Write Only Watchpoint                                         : Ok
 23.3: Read / Write Watchpoint                                       : Ok
 23.4: Modify Watchpoint                                             : Ok
 24: Number of exit events of a simple workload                      : Ok
 25: Software clock events period values                             : Ok
 26: Object code reading                                             : Ok
 27: Sample parsing                                                  : Ok
 28: Use a dummy software event to keep tracking                     : Ok
 29: Parse with no sample_id_all bit set                             : Ok
 30: Filter hist entries                                             : Ok
 31: Lookup mmap thread                                              : Ok
 32: Share thread maps                                               : Ok
 33: Sort output of hist entries                                     : Ok
 34: Cumulate child hist entries                                     : Ok
 35: Track with sched_switch                                         : Ok
 36: Filter fds with revents mask in a fdarray                       : Ok
 37: Add fd to a fdarray, making it autogrow                         : Ok
 38: kmod_path__parse                                                : Ok
 39: Thread map                                                      : Ok
 40: LLVM search and compile                                         :
 40.1: Basic BPF llvm compile                                        : Ok
 40.2: kbuild searching                                              : Ok
 40.3: Compile source for BPF prologue generation                    : Ok
 40.4: Compile source for BPF relocation                             : Ok
 41: Session topology                                                : Ok
 42: BPF filter                                                      :
 42.1: Basic BPF filtering                                           : Ok
 42.2: BPF pinning                                                   : Ok
 42.3: BPF prologue generation                                       : Ok
 43: Synthesize thread map                                           : Ok
 44: Remove thread map                                               : Ok
 45: Synthesize cpu map                                              : Ok
 46: Synthesize stat config                                          : Ok
 47: Synthesize stat                                                 : Ok
 48: Synthesize stat round                                           : Ok
 49: Synthesize attr update                                          : Ok
 50: Event times                                                     : Ok
 51: Read backward ring buffer                                       : Ok
 52: Print cpu map                                                   : Ok
 53: Merge cpu map                                                   : Ok
 54: Probe SDT events                                                : Ok
 55: is_printable_array                                              : Ok
 56: Print bitmap                                                    : Ok
 57: perf hooks                                                      : Ok
 58: builtin clang support                                           :
 58.1: builtin clang compile C source to IR                          : Skip (not compiled in)
 58.2: builtin clang compile C source to ELF object                  : Skip (not compiled in)
 59: unit_number__scnprintf                                          : Ok
 60: mem2node                                                        : Ok
 61: time utils                                                      : Ok
 62: Test jit_write_elf                                              : Ok
 63: Test libpfm4 support                                            :
 63.1: test of individual --pfm-events                               : Skip (not compiled in)
 63.2: test groups of --pfm-events                                   : Skip (not compiled in)
 64: Test api io                                                     : Ok
 65: maps__merge_in                                                  : Ok
 66: Demangle Java                                                   : Ok
 67: Demangle OCaml                                                  : Ok
 68: Parse and process metrics                                       : Ok
 69: PE file support                                                 : Ok
 70: Event expansion for cgroups                                     : Ok
 71: Convert perf time to TSC                                        :
 71.1: TSC support                                                   : Ok
 71.2: Perf time to TSC                                              : Ok
 72: dlfilter C API                                                  : Ok
 73: Sigtrap                                                         : Ok
 74: x86 rdpmc                                                       : Ok
 75: Test dwarf unwind                                               : Ok
 76: x86 instruction decoder - new instructions                      : Ok
 77: Intel PT packet decoder                                         : Ok
 78: x86 bp modify                                                   : Ok
 79: x86 Sample parsing                                              : Ok
 80: build id cache operations                                       : Ok
 81: daemon operations                                               : Ok
 82: perf pipe recording and injection test                          : Ok
 83: Add vfs_getname probe to get syscall args filenames             : Ok
 84: probe libc's inet_pton & backtrace it with ping                 : Ok
 85: Use vfs_getname probe to get syscall args filenames             : Ok
 86: Zstd perf.data compression/decompression                        : Ok
 87: perf record tests                                               : Ok
 88: perf stat csv summary test                                      : Ok
 89: perf stat metrics (shadow stat) test                            : Ok
 90: perf all metricgroups test                                      : Ok
 91: perf all metrics test                                           : FAILED!
 92: perf all PMU test                                               : Ok
 93: perf stat --bpf-counters test                                   : Ok
 94: Check Arm64 callgraphs are complete in fp mode                  : Skip
 95: Check Arm CoreSight trace data recording and synthesized samples: Skip
 96: Check Arm SPE trace data recording and synthesized samples      : Skip
 97: Check open filename arg using perf trace + vfs_getname          : Ok
[root@quaco ~]#

⬢[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools/perf build-test
a5d20d42a2f2dc2b (HEAD -> perf/urgent) perf symbol: Remove arch__symbols__fixup_end()
make: Entering directory '/var/home/acme/git/perf/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.CUHJOlfBnq
              make_with_gtk2: cd . && make GTK2=1 -j32  DESTDIR=/tmp/tmp.cMmJ9FESFE
- /var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
cd . && make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
         make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.YAPzmdwWz1 DESTDIR=/tmp/tmp.mpxGJzfDil
make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.SKlehWzpDZ DESTDIR=/tmp/tmp.umOtUR8ffM
                make_no_ui_O: cd . && make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.LTJzMYo5nj DESTDIR=/tmp/tmp.zWlErYNUdI
                 make_help_O: cd . && make help FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.nJLRRr6r9b DESTDIR=/tmp/tmp.odOd3FkKZK
              make_no_newt_O: cd . && make NO_NEWT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.B6yKVRCw13 DESTDIR=/tmp/tmp.wJ64ijxIBQ
               make_perf_o_O: cd . && make perf.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.r8CqZ0vNJP DESTDIR=/tmp/tmp.kiWOG61ssL
         make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.6Niv8UBZOl DESTDIR=/tmp/tmp.RzoSq7H720
          make_install_bin_O: cd . && make install-bin FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.YmY2LMUbtM DESTDIR=/tmp/tmp.CUreMpIvvC
           make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.4ZKG55243x DESTDIR=/tmp/tmp.niVQIqBylZ
       make_no_syscall_tbl_O: cd . && make NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.z7hE122NPo DESTDIR=/tmp/tmp.3arzy7wTsK
                make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.Lpr1DTZ9b9 DESTDIR=/tmp/tmp.pzKkyrNJ8I
            make_clean_all_O: cd . && make clean all FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.CmmxCyIacx DESTDIR=/tmp/tmp.avCsNs8XRZ
                 make_tags_O: cd . && make tags FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.NBM7FpbAXq DESTDIR=/tmp/tmp.lIzV6nQ7ep
              make_install_O: cd . && make install FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.IrCTnF327v DESTDIR=/tmp/tmp.6HsTuEflfn
 make_install_prefix_slash_O: cd . && make install prefix=/tmp/krava/ FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.YKm6N9fZ7P DESTDIR=/tmp/tmp.rQJryoLckb
          make_no_libaudit_O: cd . && make NO_LIBAUDIT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.STHxXtPKHf DESTDIR=/tmp/tmp.WZV6ESpkfi
      make_with_babeltrace_O: cd . && make LIBBABELTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.9e3mvv0ykN DESTDIR=/tmp/tmp.oxMoFDIg67
          make_no_demangle_O: cd . && make NO_DEMANGLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.mjcp6kBS60 DESTDIR=/tmp/tmp.bUiQDSE3IS
             make_no_slang_O: cd . && make NO_SLANG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.zNCWJ4ZI03 DESTDIR=/tmp/tmp.qPJrxfnVD2
         make_no_backtrace_O: cd . && make NO_BACKTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.6o2D0WISPG DESTDIR=/tmp/tmp.BUDTr8U6X9
     make_util_pmu_bison_o_O: cd . && make util/pmu-bison.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.4YV3Qzg1fh DESTDIR=/tmp/tmp.r2RKukr51M
          make_no_auxtrace_O: cd . && make NO_AUXTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.MJtzE0TGkV DESTDIR=/tmp/tmp.lSC7McN6xC
            make_no_libelf_O: cd . && make NO_LIBELF=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.UNl6QVULKp DESTDIR=/tmp/tmp.5G7rJaqyzm
       make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.N2SJqL05Hq DESTDIR=/tmp/tmp.7giKofpFsb
         make_with_libpfm4_O: cd . && make LIBPFM4=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.xsdj17zaQW DESTDIR=/tmp/tmp.b66f3ida1A
              make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.PtYYGEroH9 DESTDIR=/tmp/tmp.OKSgqBc2J1
                 make_pure_O: cd . && make FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.kJf2U4Gl8O DESTDIR=/tmp/tmp.lhWKghuFtg
           make_no_libnuma_O: cd . && make NO_LIBNUMA=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.yBmxj7omrX DESTDIR=/tmp/tmp.MguWlWoVfH
       make_libbpf_dynamic_O: cd . && make LIBBPF_DYNAMIC=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.KyAq9r5my0 DESTDIR=/tmp/tmp.1yMdnthLz0
            make_no_libbpf_O: cd . && make NO_LIBBPF=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.KqXNOfr9eH DESTDIR=/tmp/tmp.eGW9b7E4lR
              make_no_gtk2_O: cd . && make NO_GTK2=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.F43w8rrvQr DESTDIR=/tmp/tmp.mz9NKGdAN4
         make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.6jxfIxcls2 DESTDIR=/tmp/tmp.xhYbkTsKpB
           make_no_libperl_O: cd . && make NO_LIBPERL=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.077gsxpPYh DESTDIR=/tmp/tmp.AGtf7Fv6Ik
           make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.JjRPGVHTDV DESTDIR=/tmp/tmp.HlzG9aa4JZ
       make_with_coresight_O: cd . && make CORESIGHT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.7TWETpCrg2 DESTDIR=/tmp/tmp.V49IqYitAe
                  make_doc_O: cd . && make doc FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.8WlSYNo8v0 DESTDIR=/tmp/tmp.olMYi5nXLS
       make_with_clangllvm_O: cd . && make LIBCLANGLLVM=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.HOQWy9mDcJ DESTDIR=/tmp/tmp.ctmsWCOrcJ
         make_no_libcrypto_O: cd . && make NO_LIBCRYPTO=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.ZB9aFVtcYE DESTDIR=/tmp/tmp.CkFRSkrLSv
      make_no_libbpf_DEBUG_O: cd . && make NO_LIBBPF=1 DEBUG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.pyg4fpX4le DESTDIR=/tmp/tmp.LddACVrr0q
               make_no_sdt_O: cd . && make NO_SDT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.1k2Iwtk3Wa DESTDIR=/tmp/tmp.dlFLlGNfix
OK
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

real	4m29.117s
user	55m41.705s
sys	13m3.120s
⬢[acme@toolbox perf]$

