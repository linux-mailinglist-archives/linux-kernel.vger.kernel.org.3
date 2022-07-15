Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5237575F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiGOKK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiGOKKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4744507F;
        Fri, 15 Jul 2022 03:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8606A621FC;
        Fri, 15 Jul 2022 10:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4643C3411E;
        Fri, 15 Jul 2022 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657879821;
        bh=nCsXa5ZFGrbu262yYQWKqZiivsswmtmgAQogIcWjQtw=;
        h=From:To:Cc:Subject:Date:From;
        b=gLCsfMlixBVJcXktim2Jc6xKKjjgqCF5UQqTMYtIqlU98ouxW3KqtiVdIDbr45tWA
         YvKcD8spwpBS/7yzZFWUVlq5N4k6gsK7v3uXSxo2iWutg1GmibYlU/IWNK0MAVdLO3
         jjOltYi/ifFU6BFeKtclqExuIIA83zz+0urjSJl+7GfelLdBG7PA9so7HT3jiEy1vA
         DEJBNvtmxI1MHlACTVZQlZOezDnOQErrR2Gb8mMUt+xr4BXQIkRJX//5+aNmGfg6DK
         ykNO3m1LtXtPjSsJaiM7xu5yC+4B/VsgH/TNk9ez7mCJFTW2X6oZd28Gk6451zW9XX
         LsLW4mVxGHP/w==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 5.20
Date:   Fri, 15 Jul 2022 13:10:21 +0300
Message-Id: <20220715101021.30109-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 5.20-rc1 merge
window. It contains driver updates. The details are in the signed tag.

All patches have been in linux-next during the last few days. No issues have
been reported so far. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.20-rc1

for you to fetch changes up to a6339ac8a1048f316c95c3fcbe22497cfdcc8da0:

  Merge branch 'icc-rpm' into icc-next (2022-07-12 10:05:55 +0300)

----------------------------------------------------------------
interconnect changes for 5.20

Here are the interconnect changes for the 5.20-rc1 merge window consisting
of two new drivers, misc driver improvements and new device managed API.

 Core change:
- Add device managed bulk API

 Driver changes:
- New driver for NXP i.MX8MP platforms
- New driver for Qualcomm SM6350 platforms
- Multiple bucket support for Qualcomm RPM-based drivers.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Bryan O'Donoghue (1):
      interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth

Georgi Djakov (3):
      Merge branch 'icc-sm6350' into icc-next
      Merge branch 'icc-imx8mp' into icc-next
      Merge branch 'icc-rpm' into icc-next

Leo Yan (6):
      interconnect: qcom: msm8939: Use icc_sync_state
      dt-bindings: interconnect: Update property for icc-rpm path tag
      interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
      interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
      interconnect: qcom: icc-rpm: Support multiple buckets
      interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values

Luca Weiss (4):
      interconnect: qcom: icc-rpmh: Support child NoC device probe
      dt-bindings: interconnect: qcom: Split out rpmh-common bindings
      dt-bindings: interconnect: Add Qualcomm SM6350 NoC support
      interconnect: qcom: Add SM6350 driver support

Peng Fan (9):
      dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
      dt-bindings: interconnect: add fsl,imx8mp.h
      interconnect: add device managed bulk API
      interconnect: imx: fix max_node_id
      interconnect: imx: set src node
      interconnect: imx: introduce imx_icc_provider
      interconnect: imx: configure NoC mode/prioriry/ext_control
      interconnect: imx: Add platform driver for imx8mp
      PM / devfreq: imx: Register i.MX8MP interconnect device

 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml         |   6 +-
 Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml    |   6 +-
 .../devicetree/bindings/interconnect/qcom,rpmh-common.yaml      |  43 +
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml   |  22 +-
 .../devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml      |  82 ++
 drivers/devfreq/imx-bus.c                                       |   1 +
 drivers/interconnect/bulk.c                                     |  42 +
 drivers/interconnect/imx/Kconfig                                |   4 +
 drivers/interconnect/imx/Makefile                               |   2 +
 drivers/interconnect/imx/imx.c                                  |  84 +-
 drivers/interconnect/imx/imx.h                                  |  49 +-
 drivers/interconnect/imx/imx8mm.c                               |   2 +-
 drivers/interconnect/imx/imx8mn.c                               |   2 +-
 drivers/interconnect/imx/imx8mp.c                               | 259 ++++
 drivers/interconnect/imx/imx8mq.c                               |   2 +-
 drivers/interconnect/qcom/Kconfig                               |   9 +
 drivers/interconnect/qcom/Makefile                              |   5 +
 drivers/interconnect/qcom/icc-common.c                          |  34 +
 drivers/interconnect/qcom/icc-common.h                          |  13 +
 drivers/interconnect/qcom/icc-rpm.c                             | 168 ++-
 drivers/interconnect/qcom/icc-rpm.h                             |   6 +
 drivers/interconnect/qcom/icc-rpmh.c                            |  30 +-
 drivers/interconnect/qcom/icc-rpmh.h                            |   1 -
 drivers/interconnect/qcom/msm8939.c                             |   1 +
 drivers/interconnect/qcom/sm6350.c                              | 493 ++++++++
 drivers/interconnect/qcom/sm6350.h                              | 139 ++
 drivers/interconnect/qcom/sm8450.c                              |   1 +
 include/dt-bindings/interconnect/fsl,imx8mp.h                   |  59 +
 include/dt-bindings/interconnect/qcom,sm6350.h                  | 148 +++
 include/linux/interconnect.h                                    |   7 +
 30 files changed, 1627 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
 create mode 100644 drivers/interconnect/imx/imx8mp.c
 create mode 100644 drivers/interconnect/qcom/icc-common.c
 create mode 100644 drivers/interconnect/qcom/icc-common.h
 create mode 100644 drivers/interconnect/qcom/sm6350.c
 create mode 100644 drivers/interconnect/qcom/sm6350.h
 create mode 100644 include/dt-bindings/interconnect/fsl,imx8mp.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h
