Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BEE5310D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiEWMS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiEWMSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:18:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC703F302
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:18:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u23so25270334lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bKFK1FI+v7CeqJJnuz5Mjvxd1npSusc8cUiXrXnUKi0=;
        b=E9zNNFQ/2YQ6Jpb0ZgSgRtO8Bk4oth8EvQuVVj8/NEWksG8qpWv3O76z1667DlVP6Q
         Xo7UIl9jLcVOBjCW75QFpbPweSK4Uq5PyV6eWANFcm45Wb1s1JtOg4nB/iGc+7lhR/sl
         01HPOFAOUPC3hjHY2v7aiJrojHCc4e/fBSh/e7YBDw7pWkrPUQnUQ0l0KPovpptKP4X2
         +kLyqQyd49nPUo99zzrKF5cOdPFlDe6SY08OeLlk2GrL10HtUcQGABWqyWECfnXPwocp
         X56P/bt0W0xiGBYreXoyiVKftQIMYL5JRU3H79B5v4j39K8MNx3JdvMXlJU4St7MqHXt
         heMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bKFK1FI+v7CeqJJnuz5Mjvxd1npSusc8cUiXrXnUKi0=;
        b=tnhhi2t2sRmaaKd/zg2vhjgSbUN81TKeIMCIBQ73GWJVeu9hteaSdIkZfrNUdgHGrC
         C24fGM8UHOsx1oqSOfyDJ1je+3QiUyRP5exxtlKw3ei5tkf7zcwQtdrvjqi9RosAaPbk
         b3pXNsVPDk+LB2GFE7ZgdZr5/JMkn+JDks48NLAaPTt5P+iON1RwNRNti+yUmSS72J8a
         rDcnBNqMy0i0++FzTNUDiO8glUXUY9k4L1KW9BTRM1ctzynkcfCH9QqydJd1jYVf1JKq
         jIAekEgFQOb5qCQ2GNuJh4BHtqop8gQHm6UzDFu8O/MepIyUsIZeXW0uJSVvDnrv1Qrb
         u6nA==
X-Gm-Message-State: AOAM530oyO4kZ7fEnXcLXQXjr5otqB55SComQDUMp2txvTnrj7Gii4l2
        Oq87WVlTRnQVMTE1SDBVR0bLmLw3eo1WWA==
X-Google-Smtp-Source: ABdhPJx9OFtKD57tcbXVLRgn4sKthQ622fkO8wtVUZKJu4rMiW/tL+KTRgLmr3tQPqqTKDDuTWVapA==
X-Received: by 2002:a05:6512:152a:b0:478:66e4:5dfe with SMTP id bq42-20020a056512152a00b0047866e45dfemr6378483lfb.288.1653308318440;
        Mon, 23 May 2022 05:18:38 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-137.NA.cust.bahnhof.se. [155.4.133.137])
        by smtp.gmail.com with ESMTPSA id p13-20020ac24ecd000000b0047255d21122sm1958796lfr.81.2022.05.23.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:18:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.19
Date:   Mon, 23 May 2022 14:18:36 +0200
Message-Id: <20220523121836.27442-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the PR with updates for MMC v5.19-rc1. Details about the highlights are
as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3e5a8e8494a8122fe4eb3f167662f406cab753b9:

  mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC (2022-05-04 12:31:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19

for you to fetch changes up to ded2c4c345001a129293db4bc1fa9ae236ceb0d9:

  mmc: sdhci-of-arasan: Add NULL check for data field (2022-05-16 15:49:31 +0200)

----------------------------------------------------------------
MMC core:
 - Support zero-out using TRIM for eMMC
 - Allow to override the busy-timeout for the ioctl-cmds

MMC host:
 - Continued the conversion of DT bindings into the JSON schema
 - jz4740: Apply DMA engine limits to maximum segment size
 - mmci_stm32: Use a buffer for unaligned DMA requests
 - mmc_spi: Enabled high-speed modes via parsing of DT
 - omap: Make clock management to be compliant with CCF
 - renesas_sdhi: Support eMMC HS400 mode for R-Car V3H ES2.0
 - renesas_sdhi: Don't allow support for eMMC HS400 for R-Car V3M/D3
 - sdhci_am654: Fix problem when SD card slot lacks the card detect line
 - sdhci-esdhc-imx: Add support for the imx8dxl variant
 - sdhci-brcmstb: Enable support for clock gating to save power
 - sdhci-msm: Add support for the sdx65 variant
 - sdhci-msm: Add support for the sm8150 variant
 - sdhci-of-dwcmshc: Add support for the Rockchip rk3588 variant
 - sdhci-pci-gli: Add workaround to allow GL9755 to enter ASPM L1.2

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: mmc: imx-esdhc: Add i.MX8DXL compatible string

Adam Ford (1):
      dt-bindings: mmc: imx-esdhc: Update compatible fallbacks

Aidan MacDonald (1):
      mmc: jz4740: Apply DMA engine limits to maximum segment size

Al Cooper (2):
      mmc: sdhci-brcmstb: Re-organize flags
      mmc: sdhci-brcmstb: Enable Clock Gating to save power

Aswath Govindraju (1):
      dt-bindings: mmc: sdhci-am654: Add flag to force setting of TESTCD bit

Bean Huo (2):
      mmc: sdhci-omap: Use of_device_get_match_data() helper
      mmc: core: Allows to override the timeout value for ioctl() path

Ben Chuang (1):
      mmc: sdhci-pci-gli: A workaround to allow GL9755 to enter ASPM L1.2

Bhupesh Sharma (4):
      dt-bindings: mmc: sdhci-msm: Convert bindings to yaml
      mmc: sdhci-msm: Add SoC specific compatibles
      dt-bindings: mmc: sdhci-msm: Add compatible string for sm8150
      mmc: sdhci-msm: Add compatible string check for sm8150

Chris Packham (3):
      dt-bindings: mmc: xenon: Convert to JSON schema
      dt-bindings: mmc: convert orion-sdio to JSON schema
      dt-bindings: mmc: convert sdhci-dove to JSON schema

Christian Löhle (1):
      mmc: mmc_spi: parse speed mode options

Geert Uytterhoeven (1):
      mmc: renesas_sdhi: Add missing checks for the presence of quirks

Heiner Kallweit (1):
      mmc: meson-gx: switch to device-managed dmam_alloc_coherent()

Janusz Krzysztofik (1):
      mmc: omap: Make it CCF clk API compatible

Krzysztof Kozlowski (2):
      dt-bindings: mmc: brcm,sdhci-brcmstb: correct number of reg entries
      dt-bindings: mmc: brcm,sdhci-brcmstb: cleanup example

Lad Prabhakar (1):
      MAINTAINERS: Add linux-renesas-soc@vger.kernel.org list for Renesas TMIO/SDHI driver

Linus Walleij (4):
      mmc: mmci: Break IRQ status loop when all zero
      dt-bindings: mmc: Add small binding note on level shifters
      mmc: core: Add CIDs for cards to the entropy pool
      mmc: mmci: Remove custom ios handler

Minghao Chi (1):
      mmc: core: use kobj_to_dev()

Rohit Agarwal (2):
      dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
      mmc: sdhci-msm: Add compatible string check for sdx65

Sai Krishna Potthuri (1):
      mmc: sdhci-of-arasan: Add NULL check for data field

Sebastian Reichel (1):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add rk3588

Sergey Shtylyov (1):
      mmc: core: block: fix sloppy typing in mmc_blk_ioctl_multi_cmd()

Tinghan Shen (1):
      dt-bindings: mmc: mtk-sd: increase reg items

Ulf Hansson (4):
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      mmc: sdhci-brcmstb: Fix compiler warning

Vignesh Raghavendra (1):
      drivers: mmc: sdhci_am654: Add the quirk to set TESTCD bit

Vincent Whitchurch (1):
      mmc: core: Support zeroout using TRIM for eMMC

Wan Jiabing (1):
      mmc: atmel-mci: Simplify if(chan) and if(!chan)

Wolfram Sang (13):
      mmc: renesas_sdhi: remove outdated headers
      mmc: renesas_sdhi: R-Car D3 also has no HS400
      mmc: renesas_sdhi: make setup selection more understandable
      mmc: renesas_sdhi: remove a stale comment
      mmc: renesas_sdhi: make 'fixed_addr_mode' a quirk
      mmc: renesas_sdhi: make 'dmac_only_one_rx' a quirk
      mmc: renesas_sdhi: style fix for proper function bodies
      mmc: renesas_sdhi: R-Car V3M also has no HS400
      mmc: renesas_sdhi: R-Car V3H ES2.0 gained HS400 support
      mmc: renesas_sdhi: remove superfluous specific M3W entry
      mmc: core: improve API to make clear that mmc_sw_reset is for cards
      mmc: improve API to make clear hw_reset callback is for cards
      mmc: sh_mmcif: move platform_data header to proper location

Yann Gautier (1):
      mmc: mmci: stm32: use a buffer for unaligned DMA requests

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml           |  20 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  31 ++-
 .../bindings/mmc/marvell,dove-sdhci.yaml           |  44 ++++
 .../bindings/mmc/marvell,orion-sdio.yaml           |  44 ++++
 .../bindings/mmc/marvell,xenon-sdhci.txt           | 173 -------------
 .../bindings/mmc/marvell,xenon-sdhci.yaml          | 275 +++++++++++++++++++++
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   5 +-
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |  15 +-
 .../devicetree/bindings/mmc/orion-sdio.txt         |  16 --
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |   7 +
 .../devicetree/bindings/mmc/sdhci-dove.txt         |  14 --
 .../devicetree/bindings/mmc/sdhci-msm.txt          | 123 ---------
 .../devicetree/bindings/mmc/sdhci-msm.yaml         | 194 +++++++++++++++
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   1 +
 MAINTAINERS                                        |   3 +-
 arch/sh/boards/board-sh7757lcr.c                   |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   2 +-
 arch/sh/boot/romimage/mmcif-sh7724.c               |   2 +-
 drivers/mmc/core/block.c                           |  52 ++--
 drivers/mmc/core/core.c                            |   7 +-
 drivers/mmc/core/mmc.c                             |  11 +-
 drivers/mmc/core/queue.c                           |   2 +
 drivers/mmc/core/sd.c                              |   7 +
 drivers/mmc/host/atmel-mci.c                       |   9 +-
 drivers/mmc/host/bcm2835.c                         |   2 +-
 drivers/mmc/host/dw_mmc.c                          |   2 +-
 drivers/mmc/host/jz4740_mmc.c                      |  20 ++
 drivers/mmc/host/meson-gx-mmc.c                    |  21 +-
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |   2 +-
 drivers/mmc/host/mmci.c                            |   6 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c                |  88 +++++--
 drivers/mmc/host/mtk-sd.c                          |   2 +-
 drivers/mmc/host/of_mmc_spi.c                      |   4 +
 drivers/mmc/host/omap.c                            |  23 +-
 drivers/mmc/host/renesas_sdhi.h                    |   2 +
 drivers/mmc/host/renesas_sdhi_core.c               |   2 -
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  76 +++---
 drivers/mmc/host/sdhci-brcmstb.c                   |  67 +++--
 drivers/mmc/host/sdhci-msm.c                       |  25 ++
 drivers/mmc/host/sdhci-of-arasan.c                 |   3 +
 drivers/mmc/host/sdhci-omap.c                      |   9 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |  10 +
 drivers/mmc/host/sdhci.c                           |   2 +-
 drivers/mmc/host/sdhci_am654.c                     |  23 +-
 drivers/mmc/host/sh_mmcif.c                        |   2 +-
 drivers/mmc/host/sunxi-mmc.c                       |   2 +-
 drivers/mmc/host/uniphier-sd.c                     |   2 +-
 include/linux/amba/mmci.h                          |   6 -
 include/linux/mmc/core.h                           |   2 +-
 include/linux/mmc/host.h                           |   2 +-
 include/linux/{mmc => platform_data}/sh_mmcif.h    |   2 -
 51 files changed, 963 insertions(+), 503 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,dove-sdhci.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-dove.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
 rename include/linux/{mmc => platform_data}/sh_mmcif.h (99%)
