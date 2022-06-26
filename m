Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3955B351
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiFZR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:57:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E190DEDB;
        Sun, 26 Jun 2022 10:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BB049CE111D;
        Sun, 26 Jun 2022 17:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60999C34114;
        Sun, 26 Jun 2022 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656266238;
        bh=2D1EwM7J3P3HDFksuD/OedZtoKg0UK/+DRkeMAwuUwE=;
        h=From:To:Cc:Subject:Date:From;
        b=hIiEX3l8Los/gXkiCgRMywJoKYTFAZ+oSEdZudANnMLNe7tc2dTNQTajHKDOKz+/J
         7BeZAAeV3dOm/Zst6tVtCJD4MINU+UXvmSkB6DC+j1CIScUIWTVbAx/N9jtQZvcbtP
         kqNuXmC/jt61pqB08km/GEVXCgr+42nNIUiTsG1QWYOfqmKIon1Ws2HJPr/wz0zAVE
         /2B0KrV9k0LqshKZspEchoKsuxmhWJB9JUphAA7ZtANlqanV1VMHXu1Nchxu/n83CB
         qv2QW/FKhvSfgESR/vbBYcftExRBOie84WHdelEQeeh9vKltiib9HtfYWzktwVpfEe
         caiceU27uEKBg==
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
        Ali Saidi <alisaidi@amazon.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Gang Li <ligang.bdlg@bytedance.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Raul Silvera <rsilvera@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.19: 2nd batch
Date:   Sun, 26 Jun 2022 14:57:07 -0300
Message-Id: <20220626175707.1168954-1-acme@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Test results at the end of this message.

The following changes since commit 0840a7914caa14315a3191178a9f72c742477860:

  Merge tag 'char-misc-5.19-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2022-06-25 10:07:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-06-26

for you to fetch changes up to f8d866194082e703c86751cceb07f6243cde96d2:

  tools headers UAPI: Synch KVM's svm.h header with the kernel (2022-06-26 12:32:55 -0300)

----------------------------------------------------------------
perf tools fixes for v5.19: 2nd batch

- Enable ignore_missing_thread in 'perf stat', enabling counting with '--pid'
  when threads disappear during counting session setup.

- Adjust output data offset for backward compatibility in 'perf inject'.

- Fix missing free in copy_kcore_dir() in 'perf inject'.

- Fix caching files with a wrong build ID.

- Sync drm, cpufeatures, vhost and svn headers with the kernel.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (2):
      perf inject: Fix missing free in copy_kcore_dir()
      perf build-id: Fix caching files with a wrong build ID

Arnaldo Carvalho de Melo (5):
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      perf trace beauty: Fix generation of errno id->str table on ALT Linux
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools headers UAPI: Synch KVM's svm.h header with the kernel

Gang Li (1):
      perf stat: Enable ignore_missing_thread

Raul Silvera (1):
      perf inject: Adjust output data offset for backward compatibility

 tools/arch/x86/include/asm/cpufeatures.h       |   7 +-
 tools/arch/x86/include/asm/disabled-features.h |   8 +-
 tools/arch/x86/include/uapi/asm/svm.h          |  13 +
 tools/include/uapi/drm/i915_drm.h              | 353 +++++++++++++++++++------
 tools/include/uapi/linux/vhost.h               |  26 +-
 tools/perf/builtin-inject.c                    |   6 +-
 tools/perf/builtin-stat.c                      |   2 +
 tools/perf/trace/beauty/arch_errno_names.sh    |  14 +-
 tools/perf/util/build-id.c                     |  28 ++
 tools/perf/util/header.c                       |  14 +
 tools/perf/util/header.h                       |   2 +
 11 files changed, 369 insertions(+), 104 deletions(-)

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

Cross building on 32-bit MIPS debian is failing due to redefinition of 'struct flock'
on a 'perf trace' beautifier, to be investigated.

Another regression alt:sisyphus, will be eventually on the non-default libllvm build.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.19.0-rc3.tar.xz
  [perfbuilder@five ~]$ time dm
     1   182.93 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
     2   109.86 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
     3   108.92 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
     4   120.17 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
     5   131.60 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
     6   138.54 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
     7   124.69 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
     8   127.22 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
     9   118.88 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
    10    63.18 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
    11    92.00 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
    12    90.90 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
    13    88.29 alt:sisyphus                  : FAIL gcc version 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) (GCC) 
    
      LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
      LINK    /tmp/build/perf/libbpf/libbpf.a
    In file included from /usr/lib/llvm-13.0/include/clang/AST/ExprObjC.h:18,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/ConstructionContext.h:21,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/CFG.h:18,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/AnalysisDeclContext.h:22,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/PathDiagnostic.h:17,
                     from /usr/lib/llvm-13.0/include/clang/StaticAnalyzer/Core/AnalyzerOptions.h:17,
                     from /usr/lib/llvm-13.0/include/clang/Frontend/CompilerInvocation.h:22,
                     from util/c++/clang.cpp:14:
    /usr/lib/llvm-13.0/include/clang/AST/DeclBase.h: In instantiation of 'void clang::DeclContext::filtered_decl_iterator<SpecificDecl, Acceptable>::SkipToNextDecl() [with SpecificDecl = clang::ObjCPropertyDecl; bool (SpecificDecl::* Acceptable)() const = &clang::ObjCPropertyDecl::isInstanceProperty]':
    /usr/lib/llvm-13.0/include/clang/AST/DeclBase.h:2242:7:   required from 'clang::DeclContext::filtered_decl_iterator<SpecificDecl, Acceptable>::filtered_decl_iterator(clang::DeclContext::decl_iterator) [with SpecificDecl = clang::ObjCPropertyDecl; bool (SpecificDecl::* Acceptable)() const = &clang::ObjCPropertyDecl::isInstanceProperty]'
    /usr/lib/llvm-13.0/include/clang/AST/DeclObjC.h:984:43:   required from here
    /usr/lib/llvm-13.0/include/clang/AST/DeclObjC.h:976:30: error: the address '&clang::ObjCPropertyDecl::isInstanceProperty' will never be NULL [-Werror=address]
      976 |                              &ObjCPropertyDecl::isInstanceProperty>;
          |                              ^
    /usr/lib/llvm-13.0/include/clang/AST/DeclBase.h: In instantiation of 'void clang::DeclContext::filtered_decl_iterator<SpecificDecl, Acceptable>::SkipToNextDecl() [with SpecificDecl = clang::ObjCPropertyDecl; bool (SpecificDecl::* Acceptable)() const = &clang::ObjCPropertyDecl::isClassProperty]':
    /usr/lib/llvm-13.0/include/clang/AST/DeclBase.h:2242:7:   required from 'clang::DeclContext::filtered_decl_iterator<SpecificDecl, Acceptable>::filtered_decl_iterator(clang::DeclContext::decl_iterator) [with SpecificDecl = clang::ObjCPropertyDecl; bool (SpecificDecl::* Acceptable)() const = &clang::ObjCPropertyDecl::isClassProperty]'
    /usr/lib/llvm-13.0/include/clang/AST/DeclObjC.h:1001:44:   required from here
  
    14    64.09 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
    15   101.03 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-14) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
    16   106.65 amazonlinux:devel             : Ok   gcc (GCC) 11.2.1 20220401 (Red Hat 11.2.1-10) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
    17   106.63 archlinux:base                : Ok   gcc (GCC) 11.2.0 , clang version 13.0.1
    18    98.93 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
    19   113.70 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-13) , clang version 14.0.0 (Red Hat 14.0.0-1.module_el8.7.0+1142+5343df54)
    20    31.89 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.1.1 20220609 releases/gcc-12.1.0-129-g669fc7629e , clang version 14.0.4
    21    79.56 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
    22    85.80 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
    23   101.23 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    24   116.67 debian:experimental           : Ok   gcc (Debian 11.3.0-3) 11.3.0 , Debian clang version 13.0.1-6
    25    24.98 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0 
    26     6.98 debian:experimental-x-mips    : FAIL gcc version 11.2.0 (Debian 11.2.0-18) 
                       from trace/beauty/fcntl.c:10:
      /git/perf-5.19.0-rc3/tools/include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of 'struct flock'
        188 | struct flock {
            |        ^~~~~
      In file included from /git/perf-5.19.0-rc3/tools/include/uapi/linux/fcntl.h:5,
                       from trace/beauty/fcntl.c:10:
      /usr/mips-linux-gnu/include/asm/fcntl.h:64:8: note: originally defined here
         64 | struct flock {
            |        ^~~~~
      In file included from /usr/mips-linux-gnu/include/asm/fcntl.h:78,
                       from /git/perf-5.19.0-rc3/tools/include/uapi/linux/fcntl.h:5,
                       from trace/beauty/flock.c:5:
    29    22.75 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
    30    69.41 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
    31    80.84 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
    32    18.04 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
    33    82.06 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
    34    95.31 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
    35    98.09 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
    36   110.54 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
    37   116.26 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    38   119.96 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
    39   112.46 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
    40   117.20 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    41   105.26 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
    42   112.87 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
    43    20.47 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
    44    18.45 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
    45   114.50 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
    46   125.52 fedora:36                     : Ok   gcc (GCC) 12.0.1 20220413 (Red Hat 12.0.1-0) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
    47   125.74 fedora:rawhide                : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc37)
    48    97.25 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
    49    88.98 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
    50    43.52 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
            yychar = yylex (&yylval, &yylloc, scanner);
                     ^
      #define yylex           parse_events_lex
                              ^
      1 error generated.
      make[3]: *** [/git/perf-5.19.0-rc3/tools/build/Makefile.build:139: util] Error 2
    51   107.44 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
    52     6.29 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
      In file included from builtin-bench.c:22:
      bench/bench.h:68:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
         68 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
            |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      In file included from bench/bench.h:66,
                       from builtin-bench.c:22:
      /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
        394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
            |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
    53     6.28 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
      In file included from builtin-bench.c:22:
      bench/bench.h:68:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
         68 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
            |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      In file included from bench/bench.h:66,
                       from builtin-bench.c:22:
      /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
        394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
            |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
    54   116.55 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
    55   135.33 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
    56   119.87 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
    57   132.50 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    58   135.32 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 13.0.1
    59   154.50 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20220316 [revision 6a1150d1524aeda3381b2171712e1a6611d441d6] , clang version 13.0.1
    60   113.86 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
    61   116.60 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
    62    85.77 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
    63    19.36 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    64    19.24 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    65    19.74 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    66    19.95 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    67    90.97 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    68    21.47 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    69    21.56 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    70    17.73 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    71    20.85 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    72    22.26 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    73    22.46 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    74   101.22 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    75    19.24 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    76    20.25 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    77    19.14 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    78    88.78 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 
  LINK    /tmp/build/perf/perf
/usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a(BackendUtil.cpp.o): in function `(anonymous namespace)::EmitAssemblyHelper::EmitAssemblyWithNewPassManager(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >)':
(.text._ZN12_GLOBAL__N_118EmitAssemblyHelper30EmitAssemblyWithNewPassManagerEN5clang13BackendActionESt10unique_ptrIN4llvm17raw_pwrite_streamESt14default_deleteIS5_EE+0x1f15): undefined reference to `getPollyPluginInfo()'
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[2]: *** [Makefile.perf:676: /tmp/build/perf/perf] Error 1
  
    79    23.17 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
    80    98.34 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
    81   101.95 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
    82   104.85 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
    83   125.82 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
    84   126.23 ubuntu:22.10                  : Ok   gcc (Ubuntu 11.3.0-3ubuntu1) 11.3.0 , Ubuntu clang version 14.0.4-4
  BUILD_TARBALL_HEAD=f8d866194082e703c86751cceb07f6243cde96d2
  85 6827.13
  
  real	115m21.572s
  user	0m52.385s
  sys	0m56.465s
  [perfbuilder@five ~]$

  [acme@quaco perf-urgent]$ uname -a
  Linux quaco 5.17.11-300.fc36.x86_64 #1 SMP PREEMPT Wed May 25 15:04:05 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  [acme@quaco perf-urgent]$ git log --oneline -1
  f8d866194082e703 (HEAD -> perf/urgent, seventh/perf/urgent, five/perf/urgent, acme.korg/tmp.perf/urgent) tools headers UAPI: Synch KVM's svm.h header with the kernel
  [acme@quaco perf-urgent]$ perf -v
  perf version 5.19.rc3.gf8d866194082
  [acme@quaco perf-urgent]$ sudo su -
  [root@quaco ~]# perf -vv
  perf version 5.19.rc3.gf8d866194082
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
              debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ OFF ]  # HAVE_LIBCRYPTO_SUPPORT
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
    6: Parse event definition strings                                  :
    6.1: Test event parsing                                            : Ok
    6.2: Test parsing of "hybrid" CPU events                           : Skip (not hybrid)
    6.3: Parsing of all PMU events from sysfs                          : Ok
    6.4: Parsing of given PMU events from sysfs                        : Ok
    6.5: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
    6.6: Parsing of aliased events                                     : Ok
    6.7: Parsing of terms (event modifiers)                            : Ok
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
   88: perf record offcpu profiling tests                              : Ok
   89: perf stat CSV output linter                                     : Ok
   90: perf stat csv summary test                                      : Ok
   91: perf stat metrics (shadow stat) test                            : Ok
   92: perf stat tests                                                 : Ok
   93: perf all metricgroups test                                      : Ok
   94: perf all metrics test                                           : FAILED!
   95: perf all PMU test                                               : Ok
   96: perf stat --bpf-counters test                                   : Ok
   97: Check Arm64 callgraphs are complete in fp mode                  : Skip
   98: Check Arm CoreSight trace data recording and synthesized samples: Skip
   99: Check Arm SPE trace data recording and synthesized samples      : Skip
  100: Check Arm SPE doesn't hang when there are forks                 : Skip
  101: Miscellaneous Intel PT testing                                  : Ok
  102: Check open filename arg using perf trace + vfs_getname          : Ok
  [root@quaco ~]#

  ⬢[acme@toolbox perf-urgent]$ git log --oneline -1 ; time make -C tools/perf build-test
  f8d866194082e703 (HEAD -> perf/urgent) tools headers UAPI: Synch KVM's svm.h header with the kernel
  make: Entering directory '/var/home/acme/git/perf-urgent/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.DS2hqMFucK
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.Z8fjrRYSv9
  - /var/home/acme/git/perf-urgent/tools/perf/BUILD_TEST_FEATURE_DUMP: make FEATURE_DUMP_COPY=/var/home/acme/git/perf-urgent/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
  make FEATURE_DUMP_COPY=/var/home/acme/git/perf-urgent/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
            make_install_bin_O: make install-bin
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                make_no_newt_O: make NO_NEWT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
                   make_pure_O: make
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
             make_util_map_o_O: make util/map.o
           make_no_libunwind_O: make NO_LIBUNWIND=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
                make_no_gtk2_O: make NO_GTK2=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                    make_doc_O: make doc
                   make_help_O: make help
                 make_no_sdt_O: make NO_SDT=1
             make_no_libnuma_O: make NO_LIBNUMA=1
               make_no_slang_O: make NO_SLANG=1
              make_no_libelf_O: make NO_LIBELF=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
         make_with_coresight_O: make CORESIGHT=1
              make_clean_all_O: make clean all
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                  make_debug_O: make DEBUG=1
                make_install_O: make install
                   make_tags_O: make tags
         make_install_prefix_O: make install prefix=/tmp/krava
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_with_libpfm4_O: make LIBPFM4=1
                 make_perf_o_O: make perf.o
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_libperl_O: make NO_LIBPERL=1
           make_no_backtrace_O: make NO_BACKTRACE=1
  OK
  make: Leaving directory '/var/home/acme/git/perf-urgent/tools/perf'
  
  real	6m5.680s
  user	66m43.276s
  sys	15m41.801s
  ⬢[acme@toolbox perf-urgent]$
