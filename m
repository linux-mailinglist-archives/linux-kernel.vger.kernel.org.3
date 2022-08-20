Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2A059AA61
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbiHTBLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 21:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbiHTBLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 21:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFDB104479;
        Fri, 19 Aug 2022 18:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B25236192D;
        Sat, 20 Aug 2022 01:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D697C433D6;
        Sat, 20 Aug 2022 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660957878;
        bh=lcx7/443ZlMbcOxSt/VaSC2qYul+xTTYQ1M1z0eBq2o=;
        h=From:To:Cc:Subject:Date:From;
        b=dnb1fvL/5PtNH5vCgm4/J9nQFmuL78XIPrrn5OxI7WsHyUEVzDjdaTaq0EpqJgUx0
         9W9OkVELa26ip0c2a2RoR2fHwNxBCH3NwDZaUdLvRGasRHpW4K6y8cXAITiz61nId7
         YCnZazEQ8aiM9Szm9LH1IIRk5IkYRQvkHGqgPDX1jJOhjgQ3rRtEEEey0blJitGv2K
         /Q6CK27SX/5tQBqGFUVNsmncnciT3TiZF/2Ni1cgYKM/1yP6Snw3Nlb5gXoyCAgjkt
         zNdRkbpRH/XLv7X6uyHSdWtG6nOiF6aOXsPzajGuQVVagL8rDp9emSSnhi/Pszn1Di
         ShLUMNO6uFfIw==
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
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.0: 1st batch
Date:   Fri, 19 Aug 2022 22:11:09 -0300
Message-Id: <20220820011109.25811-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The following changes since commit 4c2d0b039c5cc0112206a5b22431b577cb1c57ad:

  Merge tag 'net-6.0-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-08-18 19:37:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-08-19

for you to fetch changes up to f52679b78877f17e95a317e18a4c9c46cc3d845a:

  perf tools: Support reading PERF_FORMAT_LOST (2022-08-19 15:56:56 -0300)

----------------------------------------------------------------
perf tools fixes for v6.0: 1st batch

- Fix alignment for cpu map masks in event encoding.

- Support reading PERF_FORMAT_LOST, perf tool counterpart for a feature
  that was added in this merge window.

- Sync perf tools copies of kernel headers: socket, msr-index, fscrypt,
  cpufeatures, i915_drm, kvm, vhost, perf_event.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (10):
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers kvm s390: Sync headers with the kernel sources
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools headers UAPI: Sync KVM's vmx.h header with the kernel sources
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources

Ian Rogers (4):
      perf cpumap: Const map for max()
      perf cpumap: Synthetic events and const/static
      perf cpumap: Compute mask size in constant time
      perf cpumap: Fix alignment for masks in event encoding

Namhyung Kim (4):
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      libperf: Handle read format in perf_evsel__read()
      libperf: Add a test case for read formats
      perf tools: Support reading PERF_FORMAT_LOST

 tools/arch/s390/include/uapi/asm/kvm.h             |   1 +
 tools/arch/x86/include/asm/cpufeatures.h           |   6 +-
 tools/arch/x86/include/asm/msr-index.h             |   8 +
 tools/arch/x86/include/uapi/asm/kvm.h              |  10 +-
 tools/arch/x86/include/uapi/asm/vmx.h              |   4 +-
 tools/include/uapi/drm/i915_drm.h                  | 387 ++++++++++++++++-----
 tools/include/uapi/linux/fscrypt.h                 |   3 +-
 tools/include/uapi/linux/kvm.h                     | 108 ++++++
 tools/include/uapi/linux/perf_event.h              |   5 +-
 tools/include/uapi/linux/vhost.h                   |   9 +
 tools/lib/perf/cpumap.c                            |   2 +-
 tools/lib/perf/evsel.c                             |  79 ++++-
 tools/lib/perf/include/perf/cpumap.h               |   2 +-
 tools/lib/perf/include/perf/event.h                |  50 ++-
 tools/lib/perf/include/perf/evsel.h                |   4 +-
 tools/lib/perf/tests/test-evsel.c                  | 161 +++++++++
 tools/perf/tests/cpumap.c                          |  19 +-
 tools/perf/tests/sample-parsing.c                  |  14 +-
 tools/perf/trace/beauty/include/linux/socket.h     |  16 +-
 tools/perf/util/cpumap.c                           |  80 ++++-
 tools/perf/util/cpumap.h                           |   4 +-
 tools/perf/util/event.h                            |  25 +-
 tools/perf/util/evsel.c                            |  29 +-
 .../util/scripting-engines/trace-event-python.c    |  19 +-
 tools/perf/util/session.c                          |  65 ++--
 tools/perf/util/synthetic-events.c                 |  99 +++---
 tools/perf/util/synthetic-events.h                 |   2 +-
 27 files changed, 976 insertions(+), 235 deletions(-)

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

The sole problem at this point is on alt:sisyphus, on the non-default libllvm
build.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.14/perf/perf-6.0.0-rc1.tar.xz
  [perfbuilder@five ~]$ time dm
     1   126.59 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
     2   117.87 almalinux:9                   : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
     3    27.66 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 
     4   118.57 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
     5   130.00 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
     6   120.27 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
     7   130.01 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
     8   130.70 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
     9   134.32 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
    10   125.81 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
    11   128.11 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 14.0.6
    12    24.55 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) 
    13    80.94 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
    14    91.99 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
    15    91.77 alt:sisyphus                  : FAIL gcc version 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) (GCC) 
        CC      /tmp/build/perf/util/expr.o
        LD      /tmp/build/perf/util/intel-pt-decoder/perf-in.o
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
    16   104.42 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
    17   124.88 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
    18   131.49 archlinux:base                : Ok   gcc (GCC) 12.1.1 20220730 , clang version 14.0.6
    19   103.92 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
    20   112.86 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-15) , clang version 14.0.0 (Red Hat 14.0.0-1.module_el8.7.0+1142+5343df54)
    21    34.38 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.1.1 20220811 releases/gcc-12.1.0-341-g28a7b5df3b 
    22    21.84 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 
    23    85.57 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
    24   103.12 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    25   127.31 debian:experimental           : Ok   gcc (Debian 12.1.0-7) 12.1.0 , Debian clang version 14.0.6-2
    26    25.36 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0 
    27    20.95 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
    28    22.85 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    29    23.96 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
    30    23.85 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) 
    31    25.25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) 
    32    18.83 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
    33    25.26 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) 
    34    25.86 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) 
    35    30.87 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) 
    36   109.74 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
    37   112.84 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    38   114.64 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
    39   115.24 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
    40    98.39 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    41   120.97 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
    42   132.21 fedora:34                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
    43    20.83 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
    44    19.23 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
    45   132.62 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
    46   132.82 fedora:36                     : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
    47   133.42 fedora:37                     : Ok   gcc (GCC) 12.1.1 20220628 (Red Hat 12.1.1-3) , clang version 14.0.5 (Fedora 14.0.5-5.fc37)
    48   123.01 fedora:rawhide                : Ok   gcc (GCC) 12.1.1 20220810 (Red Hat 12.1.1-4) , clang version 14.0.5 (Fedora 14.0.5-6.fc38)
    49   111.74 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
    50   124.77 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
    51    40.30 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] 
    52   131.59 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
    53   126.07 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
    54   144.12 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    55   144.42 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 13.0.1
    56   171.82 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 12.1.1 20220629 [revision 7811663964aa7e31c3939b859bbfa2e16919639f] , clang version 14.0.6
    57   118.97 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
    58   112.26 oraclelinux:9                 : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9.4.0.2) , clang version 13.0.1 (Red Hat 13.0.1-1.0.1.el9)
    59   112.15 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.1 (Red Hat 13.0.1-2.module+el8.6.0+987+d36ea6a1)
    60   114.76 rockylinux:9                  : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
    61    23.84 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 
    62    19.64 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    63    20.14 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    64    20.14 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    65    94.28 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    66    21.44 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    67    21.65 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    68    17.63 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    69    21.14 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    70    22.35 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    71    22.45 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    72   107.23 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    73    19.84 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    74    20.44 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    75    19.34 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    76    29.07 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0 
    77    23.35 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
    78   114.06 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
    79   116.95 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
    80   134.92 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
    81   109.85 ubuntu:22.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 11.2.0-16ubuntu1) 11.2.0 
    82   125.01 ubuntu:22.10                  : Ok   gcc (Ubuntu 11.3.0-5ubuntu1) 11.3.0 , Ubuntu clang version 14.0.6-2
  BUILD_TARBALL_HEAD=f52679b78877f17e95a317e18a4c9c46cc3d845a
  83 6715.68
  
  real	113m33.220s
  user	1m1.982s
  sys	0m43.633s
  [perfbuilder@five ~]$ 

  [acme@quaco perf-urgent]$ uname -a
  Linux quaco 5.18.17-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Aug 11 14:36:06 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  [acme@quaco perf-urgent]$ git log --oneline -1
  f52679b78877f17e (HEAD -> perf/urgent, seventh/perf/urgent, five/perf/urgent) perf tools: Support reading PERF_FORMAT_LOST
  [acme@quaco perf-urgent]$ perf -v
  perf version 6.0.rc1.gf52679b78877
  [acme@quaco perf-urgent]$ sudo su -
  [sudo] password for acme: 
  [root@quaco ~]# perf -vv
  perf version 6.0.rc1.gf52679b78877
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
    4: mmap interface tests                                            :
    4.1: Read samples using the mmap interface                         : Ok
    4.2: User space counter reading of instructions                    : Ok
    4.3: User space counter reading of cycles                          : Ok
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
   74: Test dwarf unwind                                               : Ok
   75: x86 instruction decoder - new instructions                      : Ok
   76: Intel PT packet decoder                                         : Ok
   77: x86 bp modify                                                   : Ok
   78: x86 Sample parsing                                              : Ok
   79: build id cache operations                                       : Ok
   80: daemon operations                                               : Ok
   81: Arnaldo Carvalho de Melo <acme@kernel.org>, 2017                : Ok
   82:                                                                 : Ok
   83: perf pipe recording and injection test                          : Ok
   84: Add vfs_getname probe to get syscall args filenames             : Ok
   85: probe libc's inet_pton & backtrace it with ping                 : Ok
   86: Use vfs_getname probe to get syscall args filenames             : Ok
   87: Zstd perf.data compression/decompression                        : Ok
   88: perf record tests                                               : Ok
   89: perf record offcpu profiling tests                              : Ok
   90: perf stat CSV output linter                                     : Ok
   91: perf stat csv summary test                                      : Ok
   92: perf stat JSON output linter                                    : Ok
   93: perf stat metrics (shadow stat) test                            : Ok
   94: perf stat tests                                                 : Ok
   95: perf all metricgroups test                                      : Ok
   96: perf all metrics test                                           : FAILED!
   97: perf all PMU test                                               : Ok
   98: perf stat --bpf-counters test                                   : Ok
   99: Check Arm64 callgraphs are complete in fp mode                  : Skip
  100: Check Arm CoreSight trace data recording and synthesized samples: Skip
  101: Check Arm SPE trace data recording and synthesized samples      : Skip
  102: Check Arm SPE doesn't hang when there are forks                 : Skip
  103: Check branch stack sampling                                     : Ok
  104: Miscellaneous Intel PT testing                                  : Ok
  105: Check open filename arg using perf trace + vfs_getname          : Ok
  [root@quaco ~]#

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  ⬢[acme@toolbox perf-urgent]$ git log --oneline -1 ; time make -C tools/perf build-test
  f52679b78877f17e (HEAD -> perf/urgent) perf tools: Support reading PERF_FORMAT_LOST
  make: Entering directory '/var/home/acme/git/perf-urgent/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.vhiAzUzRxp
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.POWkCP9DN9
                 make_no_sdt_O: make NO_SDT=1
         make_with_coresight_O: make CORESIGHT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
         make_install_prefix_O: make install prefix=/tmp/krava
              make_clean_all_O: make clean all
            make_no_demangle_O: make NO_DEMANGLE=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libunwind_O: make NO_LIBUNWIND=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_util_map_o_O: make util/map.o
            make_no_libaudit_O: make NO_LIBAUDIT=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libperl_O: make NO_LIBPERL=1
                 make_perf_o_O: make perf.o
                make_install_O: make install
                make_no_newt_O: make NO_NEWT=1
                   make_tags_O: make tags
                   make_help_O: make help
                    make_doc_O: make doc
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
           make_with_libpfm4_O: make LIBPFM4=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
            make_install_bin_O: make install-bin
                  make_debug_O: make DEBUG=1
                make_no_gtk2_O: make NO_GTK2=1
           make_no_backtrace_O: make NO_BACKTRACE=1
               make_no_slang_O: make NO_SLANG=1
                   make_pure_O: make
  OK
  make: Leaving directory '/var/home/acme/git/perf-urgent/tools/perf'
  
  real	4m31.768s
  user	59m49.023s
  sys	13m23.899s
  ⬢[acme@toolbox perf-urgent]$
