Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08ED550CC4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiFSTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiFSTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:32:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8DCE9;
        Sun, 19 Jun 2022 12:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC1DCB80DDB;
        Sun, 19 Jun 2022 19:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048CEC34114;
        Sun, 19 Jun 2022 19:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655667168;
        bh=KzY1R7EXRN08xnUMYOeVuTknO1SngU7AjYDwY4X55n4=;
        h=From:To:Cc:Subject:Date:From;
        b=qOf/eb/bL+pWg+lLLA/B9fAdMEQS/nGdyHWsmPgprvA2Vt7q/KaJemuDD9F7WJfeB
         DBAiGfCB5GKohy40Ag8/bL5O+XUid2w2vTMkY+Luc69x1VWXlGz4yh2nobU5l3SjoF
         oxr5bDuwl4R+MckZzRo/Jwflj7T8eWJwmOPyp2GL7D1aJIdxdxvMGJpcpcbNvAYC/m
         fUb60gsJ6acZpDOL28dFaFr5OCLF4GZGld5JdI2WI2ZrkCvW1/Qt6qqvU5GrE9m56O
         lO/K/rxIBD6vpVqmCqY/508vpYcDxnrZb3uJEeaA4mxNF4D98ahrS9w08xrUPKkjwP
         wZJK+LDdj2DRA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.19: 1st batch
Date:   Sun, 19 Jun 2022 16:32:40 -0300
Message-Id: <20220619193240.802856-1-acme@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling, there are some more header sync
activity for next week, still recovering the french no-mask bonanza and
the brazilian omicron crash (maybe related?) (yeah, me+wife+kid
infected), sigh.

Best regards,

- Arnaldo

The following changes since commit 354c6e071be986a44b956f7b57f1884244431048:

  Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2022-06-18 21:51:12 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-06-19

for you to fetch changes up to 140cd9ec8fdddc0e2d1684e6b69bcd05efbc9549:

  tools headers UAPI: Sync linux/prctl.h with the kernel sources (2022-06-19 11:42:25 -0300)

----------------------------------------------------------------
perf tool fixes for v5.19, 1st batch:

- Don't set data source if it's not a memory operation in ARM SPE (Statistical
  Profiling Extensions).

- Fix handling of exponent floating point values in perf stat expressions.

- Don't leak fd on failure on libperf open.

- Fix 'perf test' CPU topology test for PPC guest systems.

- Fix undefined behaviour on breakpoint account 'perf test' entry.

- Record only user callchains on the "Check ARM64 callgraphs are complete in FP
  mode" 'perf test' entry.

- Fix "perf stat CSV output linter" test on s390.

- Sync batch of kernel headers with tools/perf/.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (4):
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources

Athira Rajeev (1):
      perf test topology: Use !strncmp(right platform) to fix guest PPC comparision check

Ian Rogers (5):
      perf unwind: Fix uninitialized variable
      libperf evsel: Open shouldn't leak fd on failure
      perf test: Fix variable length array undefined behavior in bp_account
      perf expr: Allow exponents on floating point values
      perf metrics: Ensure at least 1 id per metric

Leo Yan (1):
      perf arm-spe: Don't set data source if it's not a memory operation

Michael Petlan (1):
      perf test: Record only user callchains on the "Check Arm64 callgraphs are complete in fp mode" test

Thomas Richter (1):
      perf test: Fix "perf stat CSV output linter" test on s390

 tools/arch/arm64/include/asm/cputype.h             | 12 +++-
 tools/arch/x86/include/uapi/asm/kvm.h              | 11 ++--
 tools/include/uapi/linux/prctl.h                   |  9 +++
 tools/lib/perf/evsel.c                             | 17 ++++--
 tools/perf/tests/bp_account.c                      | 16 ++++-
 tools/perf/tests/expr.c                            |  2 +
 tools/perf/tests/shell/lib/perf_csv_output_lint.py | 48 ---------------
 tools/perf/tests/shell/stat+csv_output.sh          | 69 ++++++++++++++--------
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |  2 +-
 tools/perf/tests/topology.c                        |  2 +-
 tools/perf/trace/beauty/include/linux/socket.h     |  7 ++-
 tools/perf/util/arm-spe.c                          | 22 +++----
 tools/perf/util/expr.l                             |  2 +-
 tools/perf/util/metricgroup.c                      |  9 +++
 tools/perf/util/unwind-libunwind-local.c           |  2 +-
 15 files changed, 125 insertions(+), 105 deletions(-)
 delete mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
