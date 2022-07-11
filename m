Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346EC5708AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiGKRJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiGKRJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:09:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C18BE23BFF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:09:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEF7D16A3;
        Mon, 11 Jul 2022 10:09:37 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 718003F792;
        Mon, 11 Jul 2022 10:09:36 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [GIT PULL] CoreSight changes for v5.20
Date:   Mon, 11 Jul 2022 18:08:53 +0100
Message-Id: <20220711170853.1136768-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the CoreSight updates for v5.20 below. Kindly consider pulling.

Thanks
	Suzuki



The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git  tags/coresight-next-v5.20

for you to fetch changes up to 4d45bc82df667ad9e9cb8361830e54fc1264e993:

  coresight: etm4x: avoid build failure with unrolled loops (2022-07-11 09:22:35 +0100)

----------------------------------------------------------------
CoreSight self-hosted tracing changes for v5.20.

 - Fixes LOCKDEP warnings on module unload with configfs
 - Conversion of DT bindings to DT schema
 - Branch broadcast support for perf cs_etm
 - Etm4x driver fixes for build failures with Clang and unrolled loops

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

----------------------------------------------------------------
Bagas Sanjaya (1):
      Documentation: coresight: Escape coresight bindings file wildcard

James Clark (4):
      coresight: Add config flag to enable branch broadcast
      Documentation: coresight: Turn numbered subsections into real subsections
      Documentation: coresight: Link config options to existing documentation
      Documentation: coresight: Expand branch broadcast documentation

Mike Leach (2):
      coresight: configfs: Fix unload of configurations on module exit
      coresight: syscfg: Update load and unload operations

Nick Desaulniers (1):
      coresight: etm4x: avoid build failure with unrolled loops

Rob Herring (3):
      dt-bindings: arm: Rename Coresight filenames to match compatible
      dt-bindings: arm: Convert CoreSight bindings to DT schema
      dt-bindings: arm: Convert CoreSight CPU debug to DT schema

Suzuki K Poulose (1):
      coresight: Clear the connection field properly

 .../bindings/arm/arm,coresight-catu.yaml           | 101 ++++++
 .../bindings/arm/arm,coresight-cpu-debug.yaml      |  81 +++++
 .../{coresight-cti.yaml => arm,coresight-cti.yaml} |   5 +-
 .../bindings/arm/arm,coresight-dynamic-funnel.yaml | 126 +++++++
 .../arm/arm,coresight-dynamic-replicator.yaml      | 126 +++++++
 .../bindings/arm/arm,coresight-etb10.yaml          |  92 +++++
 .../devicetree/bindings/arm/arm,coresight-etm.yaml | 156 ++++++++
 .../bindings/arm/arm,coresight-static-funnel.yaml  |  90 +++++
 .../arm/arm,coresight-static-replicator.yaml       |  91 +++++
 .../devicetree/bindings/arm/arm,coresight-stm.yaml | 101 ++++++
 .../devicetree/bindings/arm/arm,coresight-tmc.yaml | 131 +++++++
 .../bindings/arm/arm,coresight-tpiu.yaml           |  91 +++++
 ...{ete.yaml => arm,embedded-trace-extension.yaml} |   3 +-
 .../{trbe.yaml => arm,trace-buffer-extension.yaml} |   2 +-
 .../bindings/arm/coresight-cpu-debug.txt           |  49 ---
 .../devicetree/bindings/arm/coresight.txt          | 402 ---------------------
 .../trace/coresight/coresight-etm4x-reference.rst  |  17 +-
 Documentation/trace/coresight/coresight.rst        |  58 ++-
 MAINTAINERS                                        |   8 +-
 drivers/hwtracing/coresight/coresight-config.h     |   2 +
 drivers/hwtracing/coresight/coresight-core.c       |   1 +
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   2 +
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  14 +
 drivers/hwtracing/coresight/coresight-etm4x.h      |   3 +-
 drivers/hwtracing/coresight/coresight-syscfg.c     | 299 ++++++++++++---
 drivers/hwtracing/coresight/coresight-syscfg.h     |  13 +
 include/linux/coresight-pmu.h                      |   2 +
 27 files changed, 1542 insertions(+), 524 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml
 rename Documentation/devicetree/bindings/arm/{coresight-cti.yaml => arm,coresight-cti.yaml} (98%)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
 rename Documentation/devicetree/bindings/arm/{ete.yaml => arm,embedded-trace-extension.yaml} (95%)
 rename Documentation/devicetree/bindings/arm/{trbe.yaml => arm,trace-buffer-extension.yaml} (94%)
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight.txt
