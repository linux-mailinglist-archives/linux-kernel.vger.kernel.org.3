Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91A0527375
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 20:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiENSZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiENSZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 14:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365FD39816;
        Sat, 14 May 2022 11:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10EE60EAE;
        Sat, 14 May 2022 18:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD8AC340EE;
        Sat, 14 May 2022 18:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652552717;
        bh=0hAn4hFVmWaKNbsjYfARH4EVVaVmrjHsvEpeOj9MhyU=;
        h=From:To:Cc:Subject:Date:From;
        b=UzMB1IO3hnPK65GUml6VuhBelYaHHdBKwwsz5HoYm1aiRYxZ5McIEK7uGWtq5rGo+
         z2sVeLE8ne5fH7T2x+P/Z05ZulN0EAt8CkyyD0WeQ3rlq9ED6P/bsSdNux8iLhwNX3
         bpuyTWbXAdBmutz4R+MOEc3SXyyeWzWm1WdImdV1Ss+0lbuHw4m7r+s/JNCKnBbo+f
         7LAvmso8Iim/0ezgoTjBjS+YmzFn3Brtm1Lvo73NBKuOQXxaQRQfjtcpFVKM3DA+Gd
         ipUA6yycP9pt3UVizYnPgknuiz05BCqZXdcOsroeQIsOhRH7NFAT9fmwvOjo17n9s7
         c9i1i2PIvEomA==
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
        Ian Rogers <irogers@google.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.18: 5th batch
Date:   Sat, 14 May 2022 15:25:08 -0300
Message-Id: <20220514182508.843245-1-acme@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo


Tests at the end of this message.

The following changes since commit c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a:

  Linux 5.18-rc6 (2022-05-08 13:54:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-05-14

for you to fetch changes up to c46721e4604f260918e660550a16d1e28637d66c:

  MAINTAINERS: Add James and Mike as Arm64 performance events reviewers (2022-05-10 12:52:46 -0300)

----------------------------------------------------------------
perf tools fixes for v5.18: 5th batch

- Fix two NDEBUG warnings in 'perf bench numa'.

- Fix ARM coresight `perf test` failure.

- Sync linux/kvm.h with the kernel sources.

- Add James and Mike as Arm64 performance events reviewers.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      tools headers UAPI: Sync linux/kvm.h with the kernel sources

Ian Rogers (1):
      perf bench: Fix two numa NDEBUG warnings

Jeremy Linton (1):
      perf tests: Fix coresight `perf test` failure.

Mathieu Poirier (1):
      MAINTAINERS: Add James and Mike as Arm64 performance events reviewers

 MAINTAINERS                                  |  3 ++-
 tools/include/uapi/linux/kvm.h               | 10 +++++++++-
 tools/perf/bench/numa.c                      |  2 ++
 tools/perf/tests/shell/test_arm_coresight.sh |  1 -
 4 files changed, 13 insertions(+), 3 deletions(-)

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

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.18.0-rc6.tar.xz
  $ time dm
   1   121.79 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    70.62 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3    67.92 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4    72.83 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5    77.26 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6    78.44 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7    81.07 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8   108.25 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9   121.27 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10   128.91 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11   139.95 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12   127.90 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13   128.80 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  14   119.58 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
  15    64.60 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  16    92.21 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  17    90.49 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  18    91.70 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.1
  19    64.80 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  20   101.63 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-14) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  21   118.67 amazonlinux:devel             : Ok   gcc (GCC) 11.2.1 20220401 (Red Hat 11.2.1-10) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
  22   107.02 archlinux:base                : Ok   gcc (GCC) 11.2.0 , clang version 13.0.1
  23   100.92 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  24   108.64 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-13) , clang version 13.0.0 (Red Hat 13.0.0-3.module_el8.6.0+1074+380cef3f)
  25    59.74 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.0.1 20220504 (prerelease) releases/gcc-11.3.0-64-g043949882d , clang version 14.0.1
  26    81.77 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  27    88.28 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
  28   100.61 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  29   116.29 debian:experimental           : Ok   gcc (Debian 11.3.0-1) 11.3.0 , Debian clang version 13.0.1-4
  30    24.46 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.3.0-1) 11.3.0 
  31    20.25 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  32    22.25 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  33    22.55 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  34    22.60 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  35    68.70 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  36    80.54 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  37    18.24 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  38    81.84 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  39    95.50 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  40    97.39 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  41   109.33 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  42   115.84 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  43   118.54 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  44   111.25 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  45   106.44 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  46   105.23 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  47   111.95 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  48    20.65 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  49    18.54 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  50   114.28 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  51   125.79 fedora:36                     : Ok   gcc (GCC) 12.0.1 20220413 (Red Hat 12.0.1-0) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
  52   126.63 fedora:rawhide                : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc37)
  53    96.42 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  54    82.27 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  55    43.12 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          declaration is not a prototype [-Werror,-Wstrict-prototypes]
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
          'yylex'
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.18.0-rc6/tools/build/Makefile.build:139: util] Error 2
  56   107.44 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  57     6.58 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
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
  58     6.58 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
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
  59   117.65 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  60   125.29 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  61   120.46 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  62   133.32 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  63   133.32 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  64   154.19 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20220316 [revision 6a1150d1524aeda3381b2171712e1a6611d441d6] , clang version 13.0.1
  65   113.57 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  66   116.49 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
  67    85.46 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  68    19.64 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  69    19.74 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  70    19.24 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  71    19.54 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  72    19.70 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  73    19.64 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  74    90.27 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  75    20.87 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    21.35 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    17.54 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78    20.64 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  79    21.96 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  80    22.56 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  81   101.23 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  82    19.14 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  83    20.16 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  84    18.94 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  85    89.68 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 

     LINK    /tmp/build/perf/perf
   /usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a(BackendUtil.cpp.o): in function `(anonymous namespace)::EmitAssemblyHelper::EmitAssemblyWithNewPassManager(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >)':
   (.text._ZN12_GLOBAL__N_118EmitAssemblyHelper30EmitAssemblyWithNewPassManagerEN5clang13BackendActionESt10unique_ptrIN4llvm17raw_pwrite_streamESt14default_deleteIS5_EE+0x1f15): undefined reference to `getPollyPluginInfo()'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)
   make[2]: *** [Makefile.perf:677: /tmp/build/perf/perf] Error 1
   make[1]: *** [Makefile.perf:240: sub-make] Error 2
   make: *** [Makefile:70: all] Error 2

  86    23.26 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  87    88.18 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  88   101.01 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  89   105.43 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
  90   127.93 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
  BUILD_TARBALL_HEAD=c46721e4604f260918e660550a16d1e28637d66c
  91 7040.56

  real	119m12.357s
  user	1m12.907s
  sys	1m1.869s
  [perfbuilder@five ~]$ 


  [acme@quaco perf-urgent]$ uname -a
  Linux quaco 5.16.13-200.fc35.x86_64 #1 SMP PREEMPT Tue Mar 8 22:50:58 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  [acme@quaco perf-urgent]$ git log --oneline -1
  c46721e4604f2609 (HEAD -> perf/urgent, five/perf/urgent, acme.korg/tmp.perf/urgent) MAINTAINERS: Add James and Mike as Arm64 performance events reviewers
  [acme@quaco perf-urgent]$ perf -v
  perf version 5.18.rc6.gc46721e4604f
  [acme@quaco perf-urgent]$ sudo su -
  [sudo] password for acme: 
  [root@quaco ~]# perf -vv
  perf version 5.18.rc6.gc46721e4604f
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

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  ⬢[acme@toolbox perf-urgent]$ git log --oneline -1 ; time make -C tools/perf build-test
  c46721e4604f2609 (HEAD -> perf/urgent) MAINTAINERS: Add James and Mike as Arm64 performance events reviewers
  make: Entering directory '/var/home/acme/git/perf-urgent/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.rAjfWmhR8P
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.54fZP5XPne
  - /var/home/acme/git/perf-urgent/tools/perf/BUILD_TEST_FEATURE_DUMP: make FEATURE_DUMP_COPY=/var/home/acme/git/perf-urgent/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
  make FEATURE_DUMP_COPY=/var/home/acme/git/perf-urgent/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libelf_O: make NO_LIBELF=1
           make_no_backtrace_O: make NO_BACKTRACE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_no_gtk2_O: make NO_GTK2=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
           make_with_libpfm4_O: make LIBPFM4=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
         make_with_coresight_O: make CORESIGHT=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_install_O: make install
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                    make_doc_O: make doc
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
                   make_tags_O: make tags
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
               make_no_slang_O: make NO_SLANG=1
            make_install_bin_O: make install-bin
              make_no_libbpf_O: make NO_LIBBPF=1
                   make_help_O: make help
         make_install_prefix_O: make install prefix=/tmp/krava
        make_with_babeltrace_O: make LIBBABELTRACE=1
                   make_pure_O: make
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
            make_no_demangle_O: make NO_DEMANGLE=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
             make_no_libperl_O: make NO_LIBPERL=1
                 make_no_sdt_O: make NO_SDT=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
              make_clean_all_O: make clean all
             make_util_map_o_O: make util/map.o
                 make_perf_o_O: make perf.o
                  make_debug_O: make DEBUG=1
  OK
  make: Leaving directory '/var/home/acme/git/perf-urgent/tools/perf'
  
  real	4m35.366s
  user	56m16.294s
  sys	14m14.077s
  ⬢[acme@toolbox perf-urgent]$
