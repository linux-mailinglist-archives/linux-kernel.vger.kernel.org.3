Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C387748714B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbiAGDhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:37:40 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57334 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345647AbiAGDhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:37:38 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A1F741A0307;
        Fri,  7 Jan 2022 04:37:37 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6873D1A0246;
        Fri,  7 Jan 2022 04:37:37 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 7426F4030F;
        Thu,  6 Jan 2022 20:37:36 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for next(v5.17)
Date:   Thu,  6 Jan 2022 21:37:36 -0600
Message-Id: <20220107033736.26762-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following new changes for soc/fsl drivers.

Regards,
Leo

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.17

for you to fetch changes up to 1ce93cb102e7fcf5d1849044d23ce92b5a71040a:

  soc: fsl: qe: Check of ioremap return value (2022-01-06 20:53:18 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.17

- Add new SoC compatible in existing binding
- Replace kernel.h with the necessary inclusions
- MAINTAINERS file fixes
- Fix memory allocation failure check in guts driver
- Various cleanups and minor fixes

----------------------------------------------------------------
Andy Shevchenko (3):
      soc: fsl: Replace kernel.h with the necessary inclusions
      soc: fsl: Correct MAINTAINERS database (QUICC ENGINE LIBRARY)
      soc: fsl: Correct MAINTAINERS database (SOC)

Christophe JAILLET (2):
      soc: fsl: guts: Revert commit 3c0d64e867ed
      soc: fsl: guts: Add a missing memory allocation failure check

Jason Wang (1):
      soc: fsl: qe: fix typo in a comment

Jiasheng Jiang (1):
      soc: fsl: qe: Check of ioremap return value

Li Yang (2):
      dt-bindings: qoriq-clock: add missing compatible for lx2160a
      dt-bindings: fsl,layerscape-dcfg: add missing compatible for lx2160a

 .../bindings/arm/freescale/fsl,layerscape-dcfg.txt         |  2 +-
 Documentation/devicetree/bindings/clock/qoriq-clock.txt    |  1 +
 MAINTAINERS                                                |  4 ++--
 drivers/soc/fsl/guts.c                                     | 14 +++++++++-----
 drivers/soc/fsl/qe/qe.c                                    |  4 ++--
 drivers/soc/fsl/qe/qe_io.c                                 |  2 ++
 include/soc/fsl/dpaa2-fd.h                                 |  3 ++-
 include/soc/fsl/qe/immap_qe.h                              |  3 ++-
 include/soc/fsl/qe/qe_tdm.h                                |  4 +++-
 include/soc/fsl/qe/ucc_fast.h                              |  2 +-
 include/soc/fsl/qe/ucc_slow.h                              |  2 +-
 11 files changed, 26 insertions(+), 15 deletions(-)
