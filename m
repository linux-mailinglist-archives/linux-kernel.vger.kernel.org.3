Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4DC591D2C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 01:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiHMXq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 19:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiHMXq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 19:46:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BF8B99B;
        Sat, 13 Aug 2022 16:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7473160F4D;
        Sat, 13 Aug 2022 23:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD22C433D6;
        Sat, 13 Aug 2022 23:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660434413;
        bh=0oQ8Y7CYx4A6TMdg5kbovHtt6qnT3W5/QsboMIB6ESE=;
        h=From:To:Cc:Subject:Date:From;
        b=pbz2qUvlKH5seNFxMv240r+5XCpTrMEGQaodZMcVcKBtU+28bMRa0dmh2OnX/W5av
         ukJ9wnyoft0vE08dZbrJeDRocyuK7hIpldoibJvpCv4EDnp8AdJk8GERXtX01ET7ZK
         U/weJJfQPXJJjI6GOr0nf25Y3v36stQBMYNHOFl9AfAfsPit+R+mqVMGWMgjEFN/Hu
         iNrBPPNm94WjqRaT6qp/YcAhHfAY8XMeqKT4b4M2dHIsBtQ5B6WSCGCuWxAzeUW9/x
         un/gO08hfs2mizSsozTugrMXMS2Cv327oMYEVVWJ+jQpSSyczjil9CM7yDwzACgj8S
         Lcwy/VwAC1XFA==
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
        Abaci Robot <abaci@linux.alibaba.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Claire Jensen <cjense@google.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.20: 2nd batch
Date:   Sat, 13 Aug 2022 20:46:41 -0300
Message-Id: <20220813234641.663182-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The following changes since commit eb555cb5b794f4e12a9897f3d46d5a72104cd4a7:

  Merge tag '5.20-rc-ksmbd-server-fixes' of git://git.samba.org/ksmbd (2022-08-08 20:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-08-13

for you to fetch changes up to 7391db6459388d47d657aad633cb55fc04a8d4fb:

  perf test: Refactor shell tests allowing subdirs (2022-08-13 15:13:20 -0300)

----------------------------------------------------------------
perf tools changes for v6.0: 2nd batch

- 'perf c2c' now supports ARM64, adjust its output to cope with differences with
  what is in x86_64. Now go find false sharing on ARM64 (at least Neoverse) as well!

- Refactor the JSON processing, making the output more compact and thus reducing the
  size of the resulting perf binary.

- Improvements for 'perf offcpu' profiling, including tracking child processes.

- Update Intel JSON metrics and events files for broadwellde, broadwellx,
  cascadelakex, haswellx, icelakex, ivytown, jaketown, knightslanding,
  sapphirerapids, skylakex and snowridgex.

- Add 'perf stat' JSON output and a 'perf test' entry for it.

- Ignore memfd and anonymous mmap events if jitdump present.

- Refactor 'perf test' shell tests allowing subdirs.

- Fix an error handling path in 'parse_perf_probe_command()'

- Fixes for the guest Intel PT tracing patchkit in the 1st batch of this merge window.

- Print debuginfod queries if -v option is used, to explain delays in processing when
  debuginfo servers are enabled to fetch DSOs with richer symbol tables.

- Improve error message for 'perf record -p not_existing_pid'

- Fix openssl and libbpf feature detection.

- Add PMU pai_crypto event description for IBM z16 on 'perf list'.

- Fix typos and duplicated words on comments in various places.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (8):
      perf script: Fix reference to perf insert instead of perf inject
      perf machine: Fix missing free of machine->kallsyms_filename
      perf parse-events: Fix segfault when event parser gets an error
      perf tests: Fix Track with sched_switch test for hybrid case
      perf tools: Do not pass NULL to parse_events()
      perf script: Fix missing guest option documentation
      perf inject: Fix missing guestmount option documentation
      perf tools: Tidy guest option documentation

Ali Saidi (2):
      perf tools: Sync addition of PERF_MEM_SNOOPX_PEER
      perf arm-spe: Use SPE data source for neoverse cores

Arnaldo Carvalho de Melo (1):
      Revert "perf build: Suppress openssl v3 deprecation warnings in libcrypto feature test"

Brian Robbins (1):
      perf inject jit: Ignore memfd and anonymous mmap events if jitdump present

Carsten Haitzler (1):
      perf test: Refactor shell tests allowing subdirs

Christophe JAILLET (1):
      perf probe: Fix an error handling path in 'parse_perf_probe_command()'

Claire Jensen (2):
      perf stat: Add JSON output option
      perf test: JSON format checking

Ian Rogers (20):
      perf jevents: Clean up pytype warnings
      perf jevents: Simplify generation of C-string
      perf jevents: Add JEVENTS_ARCH make option
      perf vendor events: Remove bad broadwellde uncore events
      perf vendor events: Remove bad ivytown uncore events
      perf vendor events: Remove bad jaketown uncore events
      perf jevent: Add an 'all' architecture argument
      perf jevents: Remove the type/version variables
      perf jevents: Provide path to JSON file on error
      perf jevents: Sort JSON files entries
      perf pmu-events: Hide pmu_sys_event_tables
      perf pmu-events: Avoid passing pmu_events_map
      perf pmu-events: Hide pmu_events_map
      perf test: Use full metric resolution
      perf pmu-events: Move test events/metrics to JSON
      perf pmu-events: Don't assume pmu_event is an array
      perf pmu-events: Hide the pmu_events
      perf metrics: Copy entire pmu_event in find metric
      perf jevents: Compress the pmu_events_table
      perf jevents: Fold strings optimization

Leo Yan (14):
      perf arm64: Add missing -I for tools/arch/arm64/include/ to find asm/sysreg.h when building arm_spe.h
      perf mem: Print snoop peer flag
      perf mem: Add statistics for peer snooping
      perf c2c: Output statistics for peer snooping
      perf c2c: Add dimensions for peer load operations
      perf c2c: Add dimensions of peer metrics for cache line view
      perf c2c: Add mean dimensions for peer operations
      perf c2c: Use explicit names for display macros
      perf c2c: Rename dimension from 'percent_hitm' to 'percent_costly_snoop'
      perf c2c: Refactor node header
      perf c2c: Refactor display string
      perf c2c: Sort on peer snooping for load operations
      perf c2c: Use 'peer' as default display for Arm64
      perf c2c: Update documentation for new display option 'peer'

Martin Liška (3):
      perf build-id: Fix coding style, replace 8 spaces by tabs
      perf build-id: Print debuginfod queries if -v option is used
      perf record: Improve error message of -p not_existing_pid

Namhyung Kim (4):
      perf offcpu: Check process id for the given workload
      perf offcpu: Parse process id separately
      perf offcpu: Track child processes
      perf offcpu: Update offcpu test for child process

Roberto Sassu (4):
      tools, build: Retry detection of bfd-related features
      bpftool: Complete libbfd feature detection
      perf build: Remove FEATURE_CHECK_LDFLAGS-disassembler-{four-args,init-styled} setting
      tools build: Switch to new openssl API for test-libcrypto

Thomas Richter (1):
      perf list: Add PMU pai_crypto event description for IBM z16

Yang Jihong (2):
      perf kvm: Fix subcommand matching error
      perf sched latency: Fix subcommand matching error

Yang Li (1):
      perf stat: Remove duplicated include in builtin-stat.c

Zhengjun Xing (11):
      perf vendor events: Update metrics for broadwellde
      perf vendor events: Update events and metrics for broadwellx
      perf vendor events: Update events and metrics for cascadelakex
      perf vendor events: Update events and metrics for haswellx
      perf vendor events: Update events and metrics for icelakex
      perf vendor events: Update metrics for ivytown
      perf vendor events: Update metrics for jaketown
      perf vendor events: Update events for knightslanding
      perf vendor events: Update metrics for sapphirerapids
      perf vendor events: Update events and metrics for skylakex
      perf vendor events: Update events for snowridgex

shaomin Deng (5):
      perf test: Fix double word in comments
      perf script: Delete repeated word "from"
      perf trace: Fix double word in comments
      perf tools: Fix double word in comments
      perf scripting python: Delete repeated word in comments

 tools/bpf/bpftool/Makefile                         |     6 +-
 tools/build/feature/Makefile                       |    14 +-
 tools/build/feature/test-libcrypto.c               |    21 +-
 tools/include/uapi/linux/perf_event.h              |     2 +-
 tools/perf/Documentation/guest-files.txt           |    16 +
 tools/perf/Documentation/guestmount.txt            |    11 +
 tools/perf/Documentation/perf-c2c.txt              |    31 +-
 tools/perf/Documentation/perf-inject.txt           |     4 +
 tools/perf/Documentation/perf-kvm.txt              |    25 +-
 tools/perf/Documentation/perf-script.txt           |     8 +-
 tools/perf/Documentation/perf-stat.txt             |    21 +
 tools/perf/Makefile.config                         |    13 +-
 tools/perf/Makefile.perf                           |     3 +-
 tools/perf/arch/arm/util/cs-etm.c                  |     2 +-
 tools/perf/arch/arm64/util/arm-spe.c               |     2 +-
 tools/perf/arch/arm64/util/pmu.c                   |     4 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |     2 +-
 tools/perf/arch/x86/util/intel-bts.c               |     2 +-
 tools/perf/arch/x86/util/intel-pt.c                |     2 +-
 tools/perf/arch/x86/util/iostat.c                  |     2 +-
 tools/perf/arch/x86/util/topdown.c                 |     2 +-
 tools/perf/builtin-c2c.c                           |   454 +-
 tools/perf/builtin-kvm.c                           |     8 +-
 tools/perf/builtin-record.c                        |    11 +-
 tools/perf/builtin-sched.c                         |     2 +-
 tools/perf/builtin-script.c                        |     2 +-
 tools/perf/builtin-stat.c                          |     7 +-
 tools/perf/builtin-trace.c                         |     2 +-
 tools/perf/pmu-events/Build                        |     6 +-
 tools/perf/pmu-events/arch/s390/cf_z16/pai.json    |  1101 +
 .../pmu-events/arch/test/test_soc/cpu/metrics.json |    64 +
 .../arch/x86/broadwellde/bdwde-metrics.json        |     6 +
 .../arch/x86/broadwellde/uncore-cache.json         |    97 -
 .../arch/x86/broadwellde/uncore-other.json         |    13 -
 .../arch/x86/broadwellx/bdx-metrics.json           |     6 +
 .../arch/x86/broadwellx/uncore-cache.json          |   163 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |     6 +
 .../arch/x86/cascadelakex/uncore-memory.json       |  4424 ++-
 .../arch/x86/cascadelakex/uncore-other.json        | 23162 ++++++++++-
 .../arch/x86/cascadelakex/uncore-power.json        |   201 +
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   411 +-
 .../pmu-events/arch/x86/haswellx/uncore-cache.json |   173 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |     6 +
 .../arch/x86/icelakex/uncore-memory.json           |  1523 +
 .../pmu-events/arch/x86/icelakex/uncore-other.json | 38506 ++++++++++++++++++-
 .../pmu-events/arch/x86/icelakex/uncore-power.json |   225 +
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |     6 +
 .../pmu-events/arch/x86/ivytown/uncore-cache.json  |    90 -
 .../arch/x86/ivytown/uncore-interconnect.json      |     1 -
 .../pmu-events/arch/x86/ivytown/uncore-other.json  |    13 -
 .../pmu-events/arch/x86/ivytown/uncore-power.json  |    19 -
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |     6 +
 .../pmu-events/arch/x86/jaketown/uncore-cache.json |    30 -
 .../pmu-events/arch/x86/jaketown/uncore-other.json |    13 -
 .../pmu-events/arch/x86/jaketown/uncore-power.json |    11 -
 .../arch/x86/knightslanding/uncore-other.json      |   213 +
 .../arch/x86/sapphirerapids/spr-metrics.json       |     6 +
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |     6 +
 .../arch/x86/skylakex/uncore-memory.json           |  3566 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json | 23442 ++++++++++-
 .../pmu-events/arch/x86/skylakex/uncore-power.json |   201 +
 .../arch/x86/snowridgex/uncore-other.json          |   111 +-
 tools/perf/pmu-events/empty-pmu-events.c           |   204 +-
 tools/perf/pmu-events/jevents.py                   |   496 +-
 tools/perf/pmu-events/pmu-events.h                 |    40 +-
 tools/perf/tests/Build                             |     1 +
 tools/perf/tests/builtin-test-list.c               |   207 +
 tools/perf/tests/builtin-test-list.h               |    12 +
 tools/perf/tests/builtin-test.c                    |   152 +-
 tools/perf/tests/code-reading.c                    |     2 +-
 tools/perf/tests/event-times.c                     |     2 +-
 tools/perf/tests/evsel-roundtrip-name.c            |     4 +-
 tools/perf/tests/expand-cgroup.c                   |    25 +-
 tools/perf/tests/hists_cumulate.c                  |     2 +-
 tools/perf/tests/hists_filter.c                    |     4 +-
 tools/perf/tests/hists_link.c                      |     4 +-
 tools/perf/tests/hists_output.c                    |     2 +-
 tools/perf/tests/keep-tracking.c                   |     4 +-
 tools/perf/tests/parse-metric.c                    |    77 +-
 tools/perf/tests/perf-time-to-tsc.c                |     4 +-
 tools/perf/tests/pmu-events.c                      |   466 +-
 .../perf/tests/shell/lib/perf_json_output_lint.py  |    96 +
 tools/perf/tests/shell/record_offcpu.sh            |    57 +-
 tools/perf/tests/shell/stat+json_output.sh         |   147 +
 tools/perf/tests/switch-tracking.c                 |    24 +-
 tools/perf/util/Build                              |     1 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |     1 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |    12 +
 tools/perf/util/arm-spe.c                          |   130 +-
 tools/perf/util/bpf-loader.c                       |     2 +-
 tools/perf/util/bpf_off_cpu.c                      |    53 +-
 tools/perf/util/bpf_skel/off_cpu.bpf.c             |    38 +-
 tools/perf/util/build-id.c                         |    26 +-
 tools/perf/util/events_stats.h                     |     2 +-
 tools/perf/util/jitdump.c                          |     9 +-
 tools/perf/util/machine.c                          |     1 +
 tools/perf/util/mem-events.c                       |    46 +-
 tools/perf/util/mem-events.h                       |     3 +
 tools/perf/util/metricgroup.c                      |   275 +-
 tools/perf/util/metricgroup.h                      |     5 +-
 tools/perf/util/parse-events.c                     |    22 +-
 tools/perf/util/parse-events.h                     |     4 +
 tools/perf/util/perf_api_probe.c                   |     2 +-
 tools/perf/util/pmu.c                              |   139 +-
 tools/perf/util/pmu.h                              |    10 +-
 tools/perf/util/probe-event.c                      |     6 +-
 tools/perf/util/record.c                           |     2 +-
 tools/perf/util/s390-sample-raw.c                  |    50 +-
 .../util/scripting-engines/trace-event-python.c    |     2 +-
 tools/perf/util/stat-display.c                     |   383 +-
 tools/perf/util/stat.c                             |     1 +
 tools/perf/util/stat.h                             |     2 +
 112 files changed, 95286 insertions(+), 6479 deletions(-)
 create mode 100644 tools/perf/Documentation/guest-files.txt
 create mode 100644 tools/perf/Documentation/guestmount.txt
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/pai.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
 create mode 100644 tools/perf/tests/builtin-test-list.c
 create mode 100644 tools/perf/tests/builtin-test-list.h
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

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

Another regression alt:sisyphus, will be eventually on the non-default libllvm build.

debian experimental has a problem with a change in the prototype of a binutils function
used for disassembling BPF code, a fix is being discussed and will soon be merged.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  [perfbuilder@five linux-perf-tools-build]$ export BUILD_TARBALL=http://192.168.86.14/perf/perf-5.19.0.tar.xz
  [perfbuilder@five linux-perf-tools-build]$ time dm
   1   177.29 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2   206.57 almalinux:9                   : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
   3    30.52 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0
   4   121.17 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   5   137.09 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   6   128.09 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
   7   136.82 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
   8   138.83 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
   9   138.02 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  10   129.60 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
  11   131.71 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 14.0.6
  12    26.07 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1)
  13    85.06 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
  14    91.70 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  15    90.77 alt:sisyphus                  : FAIL gcc version 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) (GCC) 
      CC      /tmp/build/perf/util/parse-events-flex.o
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
  16   103.02 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  17   125.59 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
  18   130.98 archlinux:base                : Ok   gcc (GCC) 12.1.1 20220730 , clang version 14.0.6
  19   102.70 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  20   112.46 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-15) , clang version 14.0.0 (Red Hat 14.0.0-1.module_el8.7.0+1142+5343df54)
  21    33.18 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.1.1 20220803 releases/gcc-12.1.0-322-g3df2f03587 
  22    21.64 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 
  23    83.36 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
  24    99.10 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  25   128.01 debian:experimental           : Ok   gcc (Debian 12.1.0-7) 12.1.0 , Debian clang version 14.0.6-2
  26    25.37 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0 
  27    20.94 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0
  28    22.75 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
  29    23.85 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0
  30    24.05 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  31    25.15 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) 
  32    18.83 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  33    25.05 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) 
  34    27.47 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) 
  35    28.16 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) 

  $ uname -a
  Linux quaco 5.18.10-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 7 17:21:38 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -1
  7391db6459388d47 (HEAD -> perf/core, five/perf/core) perf test: Refactor shell tests allowing subdirs
  $ perf -v
  perf version 5.19.g7391db645938
  $ sudo su -
  [root@quaco ~]# perf -vv
  perf version 5.19.g7391db645938
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

  ⬢[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools/perf build-test
  7391db6459388d47 (HEAD -> perf/core) perf test: Refactor shell tests allowing subdirs
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.SZ20bcjXd6
              make_with_gtk2: cd . && make GTK2=1 -j32  DESTDIR=/tmp/tmp.GpsMpT9COG
 make_install_prefix_slash_O: cd . && make install prefix=/tmp/krava/ FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.VHQcYiPs1t DESTDIR=/tmp/tmp.B0OdwJWu7C
                 make_tags_O: cd . && make tags FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.T1QeaMZU3A DESTDIR=/tmp/tmp.uiz2oL9wn4
                  make_doc_O: cd . && make doc FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.FBaps4ilnA DESTDIR=/tmp/tmp.oCHdrZIaiV
           make_no_libnuma_O: cd . && make NO_LIBNUMA=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.aI5vuqZY0i DESTDIR=/tmp/tmp.wtqt6ajNro
            make_no_libelf_O: cd . && make NO_LIBELF=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.653HvdI5i3 DESTDIR=/tmp/tmp.71hRSu8pxb
              make_no_gtk2_O: cd . && make NO_GTK2=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.98V5mNpQAJ DESTDIR=/tmp/tmp.mGGVYAosZM
         make_with_libpfm4_O: cd . && make LIBPFM4=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.NtUGlW9xHd DESTDIR=/tmp/tmp.69gjgr4i5j
         make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.ndwwUYVumG DESTDIR=/tmp/tmp.ZHk3GontyW
                 make_help_O: cd . && make help FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.i8q578FiTw DESTDIR=/tmp/tmp.6RrkC7rwbM
               make_no_sdt_O: cd . && make NO_SDT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.z47aXWVgjt DESTDIR=/tmp/tmp.nXgpt2WSCW
          make_no_auxtrace_O: cd . && make NO_AUXTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.7N7gzWNjfL DESTDIR=/tmp/tmp.Nbg76CVMo4
              make_no_newt_O: cd . && make NO_NEWT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.dsKXy9gF2Y DESTDIR=/tmp/tmp.hZF7lyc9Ip
       make_with_coresight_O: cd . && make CORESIGHT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.gzym1Qu46I DESTDIR=/tmp/tmp.IbltcWbTOQ
               make_perf_o_O: cd . && make perf.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.V5A1FWqWUB DESTDIR=/tmp/tmp.3BJYOoSgmv
            make_no_libbpf_O: cd . && make NO_LIBBPF=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.SvKXCVo3A1 DESTDIR=/tmp/tmp.EOCvmG9CHy
      make_with_babeltrace_O: cd . && make LIBBABELTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.nfcjia4wl5 DESTDIR=/tmp/tmp.MgnZw9Vnke
      make_no_libbpf_DEBUG_O: cd . && make NO_LIBBPF=1 DEBUG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.tVt4HNdyJb DESTDIR=/tmp/tmp.BA3S8OgpJC
            make_clean_all_O: cd . && make clean all FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.2T1MAnkjQg DESTDIR=/tmp/tmp.QXlBmoS7bs
          make_no_demangle_O: cd . && make NO_DEMANGLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.oQ64H9uivI DESTDIR=/tmp/tmp.jXO2QCruM6
           make_no_libperl_O: cd . && make NO_LIBPERL=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.7HJiLBqXU2 DESTDIR=/tmp/tmp.T46UJviBYo
             make_no_slang_O: cd . && make NO_SLANG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.JwXTYHM207 DESTDIR=/tmp/tmp.fr9oOUvBas
           make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.AoFAiFL33Q DESTDIR=/tmp/tmp.vhKEBu3bZn
         make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.QrgrUzp146 DESTDIR=/tmp/tmp.WqiW8yQnxQ
                make_no_ui_O: cd . && make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.AaDVsSjCDj DESTDIR=/tmp/tmp.KiZ0hnUWfU
     make_util_pmu_bison_o_O: cd . && make util/pmu-bison.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.ZEiBMW9Q77 DESTDIR=/tmp/tmp.ee497EEGOO
              make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.5gt3xUvGWv DESTDIR=/tmp/tmp.LP4rDx4shL
           make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.xfQzGYVo7Y DESTDIR=/tmp/tmp.Q83W7lR8Md
       make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.LWmbDZpO8O DESTDIR=/tmp/tmp.sK1fNAyI4F
              make_install_O: cd . && make install FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.O3NQyGNbG9 DESTDIR=/tmp/tmp.i6m4PTomUp
          make_install_bin_O: cd . && make install-bin FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.t0sOgIOJnD DESTDIR=/tmp/tmp.aJK1WUn8Ud
make_no_libdw_dwarf_unwind_O: cd . && make NO_LIBDW_DWARF_UNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.7iQOeQ7spL DESTDIR=/tmp/tmp.HnDOxrbgYu
         make_no_backtrace_O: cd . && make NO_BACKTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.AQszhoMTyW DESTDIR=/tmp/tmp.YkJhlcc7Ov
                 make_pure_O: cd . && make FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.5WJhuYg07N DESTDIR=/tmp/tmp.bzs06O5PJJ
         make_no_libcrypto_O: cd . && make NO_LIBCRYPTO=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.afmXclK6im DESTDIR=/tmp/tmp.CIJdyzfy2i
         make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.HyxO6xI2pg DESTDIR=/tmp/tmp.VPO0u1wDIT
                make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.TLkKjlbDpW DESTDIR=/tmp/tmp.ho2VzeWmaX
       make_with_clangllvm_O: cd . && make LIBCLANGLLVM=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.EGN2TbUi41 DESTDIR=/tmp/tmp.stN1LEJ3iU
       make_no_syscall_tbl_O: cd . && make NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.q3iMgZJ4bX DESTDIR=/tmp/tmp.MD18kbpxO2
          make_no_libaudit_O: cd . && make NO_LIBAUDIT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.Y6ndYFneYv DESTDIR=/tmp/tmp.kizc9ZluCe
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'

  real	6m3.691s
  user	68m2.741s
  sys	16m4.482s

  ⬢[acme@toolbox perf]$⬢[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools/perf build-test
  7391db6459388d47 (HEAD -> perf/core) perf test: Refactor shell tests allowing subdirs
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.SZ20bcjXd6
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.GpsMpT9COG
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                   make_tags_O: make tags
                    make_doc_O: make doc
             make_no_libnuma_O: make NO_LIBNUMA=1
              make_no_libelf_O: make NO_LIBELF=1
                make_no_gtk2_O: make NO_GTK2=1
           make_with_libpfm4_O: make LIBPFM4=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                   make_help_O: make help
                 make_no_sdt_O: make NO_SDT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                make_no_newt_O: make NO_NEWT=1
         make_with_coresight_O: make CORESIGHT=1
                 make_perf_o_O: make perf.o
              make_no_libbpf_O: make NO_LIBBPF=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
              make_clean_all_O: make clean all
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_libperl_O: make NO_LIBPERL=1
               make_no_slang_O: make NO_SLANG=1
             make_util_map_o_O: make util/map.o
           make_no_libunwind_O: make NO_LIBUNWIND=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
         make_install_prefix_O: make install prefix=/tmp/krava
                make_install_O: make install
            make_install_bin_O: make install-bin
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_pure_O: make
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                  make_debug_O: make DEBUG=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  
  real	6m3.691s
  user	68m2.741s
  sys	16m4.482s
  ⬢[acme@toolbox perf]$
