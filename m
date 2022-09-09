Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D885B2ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiIIALH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIIALF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818BF979DD;
        Thu,  8 Sep 2022 17:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1854761E82;
        Fri,  9 Sep 2022 00:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB2BC433D6;
        Fri,  9 Sep 2022 00:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662682262;
        bh=/vtLYIDEkc1OukQK25Xmb1icKqJ0YxlEg0p7ZvjHnWU=;
        h=From:To:Cc:Subject:Date:From;
        b=fDfVcr25toAPSBHKQMLjsSKnQZ0Y/9FEYA+RZVSajREq27Ibs/VvF6ZkU3eGDGYee
         2U3sx7qzgFOhjhlmQq4ON0f3KshswNybadrO7t3h1JZrUxeY5jggpM/ySsq4GRQ0VT
         YJfzLwCNqafGIcB/1JHapuHlQMSbOwh3eBCrN7ZP9/79pNMvBq4FVdKMA/IIBTWmYN
         xnmU3iofBxugRSsZdNKLQy73oIBuNeY42hYqs2mvEL469p7SJoUgWhmtt1yZyXhgM5
         3cBGW/0aUWXP93ty9vfjnUMy2RPNgSJkmPCWUHPPCXbEepCW37jvxv/vABA0uwVuGt
         up6rOv49Nd0YA==
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
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Hongtao Yu <hoy@fb.com>, Ian Rogers <irogers@google.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        =?UTF-8?q?Tom=C3=A1=C5=A1=20Trnka?= <trnka@scm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Zixuan Tan <tanzixuan.me@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.0: 3rd batch
Date:   Thu,  8 Sep 2022 21:10:54 -0300
Message-Id: <20220909001054.1415163-1-acme@kernel.org>
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

The following changes since commit dcf8e5633e2e69ad60b730ab5905608b756a032f:

  tracing: Define the is_signed_type() macro once (2022-08-29 13:29:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-09-08

for you to fetch changes up to faf59ec8c3c3708c64ff76b50e6f757c6b4a1054:

  perf record: Fix synthesis failure warnings (2022-09-08 15:57:37 -0300)

----------------------------------------------------------------
perf tools fixes for v6.0: 3rd batch

- Fix per-thread mmaps for multi-threaded targets, noticed with 'perf top --pid' with
  multithreaded targets.

- Fix synthesis failure warnings in 'perf record'.

- Fix L2 Topdown metrics disappearance for raw events in 'perf stat'.

- Fix out of bound access in some CPU masks.

- Fix segfault if there is no CPU PMU table and a metric is sought, noticed when
  building with NO_JEVENTS=1.

- Skip dummy event attr check in 'perf script' fixing nonsensical warning about
  UREGS attribute not set, as 'dummy' events have no samples.

- Fix 'iregs' field handling with dummy events on hybrid systems in 'perf script'.

- Prevent potential memory leak in c2c_he_zalloc() in 'perf c2c'.

- Don't install data files with x permissions.

- Fix types for print format in dlfilter-show-cycles.

- Switch deprecated openssl MD5_* functions to new EVP API in 'genelf'.

- Remove redundant word 'contention' in 'perf lock' help message.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (3):
      libperf evlist: Fix per-thread mmaps for multi-threaded targets
      perf dlfilter dlfilter-show-cycles: Fix types for print format
      perf record: Fix synthesis failure warnings

Athira Rajeev (2):
      perf affinity: Fix out of bound access to "sched_cpus" mask
      tools/perf: Fix out of bound access to cpu mask array

Ian Rogers (1):
      perf metric: Return early if no CPU PMU table exists

Jiri Olsa (1):
      perf script: Skip dummy event attr check

Jiri Slaby (1):
      perf tools: Don't install data files with x permissions

Shang XiaoJing (1):
      perf c2c: Prevent potential memory leak in c2c_he_zalloc()

Yang Jihong (1):
      perf lock: Remove redundant word 'contention' in help message

Zhengjun Xing (2):
      perf stat: Fix L2 Topdown metrics disappear for raw events
      perf script: Fix Cannot print 'iregs' field for hybrid systems

Zixuan Tan (1):
      perf genelf: Switch deprecated openssl MD5_* functions to new EVP API

 tools/lib/perf/evlist.c                     | 50 +++++++++++++++++++++++++++++
 tools/perf/Makefile.perf                    | 24 +++++++-------
 tools/perf/builtin-c2c.c                    | 12 +++++--
 tools/perf/builtin-lock.c                   |  3 +-
 tools/perf/builtin-record.c                 | 34 +++++++++++++++-----
 tools/perf/builtin-script.c                 |  5 +++
 tools/perf/builtin-stat.c                   |  5 +--
 tools/perf/dlfilters/dlfilter-show-cycles.c |  4 +--
 tools/perf/util/affinity.c                  |  8 ++++-
 tools/perf/util/genelf.c                    | 20 ++++++------
 tools/perf/util/metricgroup.c               |  3 ++
 11 files changed, 129 insertions(+), 39 deletions(-)

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

In some cases clang can't be used, e.g.: asm goto, etc, so only gcc gets used.
As soon as gcc stops having the required features, the container reaches end of
life.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
Gwith a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ export BUILD_TARBALL=http://192.168.86.14/perf/perf-6.0.0-rc3.tar.xz
  $ time dm
   1   121.58 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2   115.34 almalinux:9                   : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
   3   119.86 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
   4   130.70 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
   5   131.72 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
   6   134.01 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
   7   123.58 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
   8   127.38 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 14.0.6
   9    24.55 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) 
  10    80.93 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  11    92.19 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  12    74.42 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) , ALT Linux Team clang version 13.0.1
  13   104.81 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  14   126.27 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
  15   130.89 archlinux:base                : Ok   gcc (GCC) 12.1.1 20220730 , clang version 14.0.6
  16   103.41 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  17   114.04 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-15) , clang version 14.0.0 (Red Hat 14.0.0-1.module_el8.7.0+1142+5343df54)
  18    35.08 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.2.1 20220822 releases/gcc-12.2.0-4-g55b6abd9f2 
  19    22.04 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 
  20    85.87 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
  21   102.71 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  22   127.22 debian:experimental           : Ok   gcc (Debian 12.2.0-1) 12.2.0 , Debian clang version 14.0.6-2
  23    26.36 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 12.2.0-1) 12.2.0 
  24    21.54 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  25    22.75 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  26    24.56 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
  27    23.64 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) 
  28    25.64 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) 
  29    18.84 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  30    25.15 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) 
  31    26.45 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) 
  32    28.57 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) 
  33    27.16 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) 
  34    27.26 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) 
  35    28.26 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) 
  36   115.33 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  37    99.39 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  38   118.06 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  39   127.79 fedora:34                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  40    20.94 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  41    18.73 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  42   131.12 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  43   132.32 fedora:36                     : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
  44   133.01 fedora:37                     : Ok   gcc (GCC) 12.2.1 20220819 (Red Hat 12.2.1-1) , clang version 14.0.5 (Fedora 14.0.5-6.fc37)
  45   121.51 fedora:38                     : Ok   gcc (GCC) 12.2.1 20220819 (Red Hat 12.2.1-1) , clang version 14.0.5 (Fedora 14.0.5-7.fc38)
  46   121.69 fedora:rawhide                : Ok   gcc (GCC) 12.2.1 20220819 (Red Hat 12.2.1-1) , clang version 14.0.5 (Fedora 14.0.5-7.fc38)
  47   111.63 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  48   123.37 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  49    40.40 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] 
  50    40.89 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 
  51   124.75 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  52   143.31 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  53   145.32 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 13.0.1
  54   172.42 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 12.1.1 20220629 [revision 7811663964aa7e31c3939b859bbfa2e16919639f] , clang version 14.0.6
  55   119.27 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  56   113.28 oraclelinux:9                 : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9.4.0.2) , clang version 13.0.1 (Red Hat 13.0.1-1.0.1.el9)
  57   111.34 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.1 (Red Hat 13.0.1-2.module+el8.6.0+987+d36ea6a1)
  58   114.34 rockylinux:9                  : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
  59    23.64 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 
  60    19.54 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  61    19.94 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  62    20.03 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  63    25.45 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  64    21.75 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  65    21.64 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  66    17.62 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  67    20.94 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  68    22.05 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  69    22.26 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  70   108.73 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  71    19.84 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  72    20.65 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  73    19.24 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  74    28.66 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0 
  75    23.15 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  76   115.14 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  77   118.66 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
  78   134.32 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
  79   112.25 ubuntu:22.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 11.2.0-16ubuntu1) 11.2.0 
  80   125.50 ubuntu:22.10                  : Ok   gcc (Ubuntu 11.3.0-5ubuntu1) 11.3.0 , Ubuntu clang version 14.0.6-2
  BUILD_TARBALL_HEAD=faf59ec8c3c3708c64ff76b50e6f757c6b4a1054
  81 6115.97

  real	103m29.912s
  user	1m2.998s
  sys	0m43.571s
  $ 


  [acme@quaco perf-urgent]$ uname -a
  Linux quaco 5.18.17-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Aug 11 14:36:06 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  [acme@quaco perf-urgent]$ git log --oneline -1
  faf59ec8c3c3708c (HEAD -> perf/urgent, seventh/perf/urgent, five/perf/urgent) perf record: Fix synthesis failure warnings
  [acme@quaco perf-urgent]$ perf -v
  perf version 6.0.rc3.gfaf59ec8c3c3
  [acme@quaco perf-urgent]$ sudo su -
  [sudo] password for acme: 
  [root@quaco ~]# perf -vv
  perf version 6.0.rc3.gfaf59ec8c3c3
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
   81: perf pipe recording and injection test                          : Ok
   82: Add vfs_getname probe to get syscall args filenames             : Ok
   83: probe libc's inet_pton & backtrace it with ping                 : Ok
   84: Use vfs_getname probe to get syscall args filenames             : Ok
   85: Zstd perf.data compression/decompression                        : Ok
   86: perf record tests                                               : Ok
   87: perf record offcpu profiling tests                              : Ok
   88: perf stat CSV output linter                                     : Ok
   89: perf stat csv summary test                                      : Ok
   90: perf stat JSON output linter                                    : Ok
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
  101: Check branch stack sampling                                     : Ok
  102: Miscellaneous Intel PT testing                                  : Ok
  103: Check open filename arg using perf trace + vfs_getname          : Ok
  [root@quaco ~]# 

  ⬢[acme@toolbox perf-urgent]$ git log --oneline -1 ; time make -C tools/perf build-test
  faf59ec8c3c3708c (HEAD -> perf/urgent) perf record: Fix synthesis failure warnings
  make: Entering directory '/var/home/acme/git/perf-urgent/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.990UrzRMWD
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.mlakiKX1iC
                make_install_O: make install
    failed to find: etc/bash_completion.d/perf
            make_no_auxtrace_O: make NO_AUXTRACE=1
                 make_perf_o_O: make perf.o
                 make_no_sdt_O: make NO_SDT=1
            make_install_bin_O: make install-bin
    failed to find: etc/bash_completion.d/perf
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
    failed to find: /tmp/krava/etc/bash_completion.d/perf
            make_no_libaudit_O: make NO_LIBAUDIT=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_libpython_O: make NO_LIBPYTHON=1
              make_no_libelf_O: make NO_LIBELF=1
                    make_doc_O: make doc
              make_clean_all_O: make clean all
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                  make_debug_O: make DEBUG=1
                   make_pure_O: make
         make_install_prefix_O: make install prefix=/tmp/krava
    failed to find: /tmp/krava/etc/bash_completion.d/perf
           make_no_libunwind_O: make NO_LIBUNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
               make_no_slang_O: make NO_SLANG=1
             make_no_libnuma_O: make NO_LIBNUMA=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
             make_no_libperl_O: make NO_LIBPERL=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
         make_with_coresight_O: make CORESIGHT=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
                make_no_newt_O: make NO_NEWT=1
             make_util_map_o_O: make util/map.o
                   make_tags_O: make tags
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
                   make_help_O: make help
           make_with_libpfm4_O: make LIBPFM4=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
  OK
  make: Leaving directory '/var/home/acme/git/perf-urgent/tools/perf'
  
  real	5m35.088s
  user	64m17.773s
  sys	15m1.968s
  ⬢[acme@toolbox perf-urgent]$
