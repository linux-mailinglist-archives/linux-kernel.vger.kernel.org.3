Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993124D6006
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344343AbiCKKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245290AbiCKKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:47:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD2151C2DBA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:46:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95E2C16A3;
        Fri, 11 Mar 2022 02:46:15 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2E903F7D8;
        Fri, 11 Mar 2022 02:46:14 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [GIT PULL] [v2] coresight: Changes for v5.18 
Date:   Fri, 11 Mar 2022 10:45:57 +0000
Message-Id: <20220311104557.154755-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303230301.255049-1-suzuki.poulose@arm.com>
References: <20220303230301.255049-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please find coresight updates for v5.18 below. This is an updated pull
request which fixes the missing s-o-b tags for the committer.

Changes since previous request:
  - Fix missing S-o-b tags for committer
  - Added a new tag coresight-next-v5.18-v2

Thanks
Suzuki


The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.18-v2

for you to fetch changes up to 286f950545e0d9c8aa802cbfc9676860bbc49179:

  coresight: Drop unused 'none' enum value for each component (2022-03-11 10:07:57 +0000)

----------------------------------------------------------------
coresight: changes for v5.18

The coresight update for v5.18 includes
  - TRBE erratum workarounds for Arm Cortex-A510
  - Fixes for leaking root namespace PIDs into non-root namespace
    trace sessions
  - Miscellaneous fixes and cleanups

Updated tag to reflect missing committer s-o-b tags.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

----------------------------------------------------------------
Anshuman Khandual (4):
      coresight: trbe: Work around the ignored system register writes
      coresight: trbe: Work around the invalid prohibited states
      coresight: trbe: Work around the trace data corruption
      coresight: Drop unused 'none' enum value for each component

James Clark (2):
      coresight: Fix TRCCONFIGR.QE sysfs interface
      coresight: no-op refactor to make INSTP0 check more idiomatic

Leo Yan (4):
      coresight: etm4x: Add lock for reading virtual context ID comparator
      coresight: etm4x: Don't use virtual contextID for non-root PID namespace
      coresight: etm4x: Don't trace PID for non-root PID namespace
      coresight: etm3x: Don't trace PID for non-root PID namespace

Miaoqian Lin (1):
      coresight: syscfg: Fix memleak on registration failure in cscfg_create_device

Rafael J. Wysocki (1):
      hwtracing: coresight: Replace acpi_bus_get_device()

Sudeep Holla (1):
      coresight: trbe: Move check for kernel page table isolation from EL0 to probe

 arch/arm64/Kconfig                                 |   6 +-
 drivers/hwtracing/coresight/coresight-core.c       |   3 -
 drivers/hwtracing/coresight/coresight-etm3x-core.c |   4 +
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  12 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  38 ++++++-
 drivers/hwtracing/coresight/coresight-platform.c   |   8 +-
 drivers/hwtracing/coresight/coresight-syscfg.c     |   2 +-
 drivers/hwtracing/coresight/coresight-trbe.c       | 125 +++++++++++++++------
 drivers/hwtracing/coresight/coresight-trbe.h       |   8 --
 include/linux/coresight.h                          |   5 -
 10 files changed, 149 insertions(+), 62 deletions(-)
