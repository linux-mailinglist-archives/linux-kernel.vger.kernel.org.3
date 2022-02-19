Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897134BC492
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiBSB2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:28:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiBSB2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:28:03 -0500
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Feb 2022 17:27:45 PST
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4CD5C353
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:27:45 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A1B551A0564;
        Sat, 19 Feb 2022 02:22:09 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 65DE61A008E;
        Sat, 19 Feb 2022 02:22:09 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 5881940050;
        Fri, 18 Feb 2022 18:22:08 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for fix (v5.17)
Date:   Fri, 18 Feb 2022 19:22:08 -0600
Message-Id: <20220219012208.21835-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following changes for soc/fsl drivers.

Regards,
Leo

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v5.17

for you to fetch changes up to a222fd8541394b36b13c89d1698d9530afd59a9c:

  soc: fsl: qe: Check of ioremap return value (2022-02-18 17:11:23 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver fixes for v5.17

- Add missing SoC compatible in existing binding
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
