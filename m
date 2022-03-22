Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6934E3DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiCVLne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiCVLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:43:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CB57EB35
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:42:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m3so17308114lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ohGkyUku2elxBgQMe+Wzk69ckX2qDwZ29y2rezztfrI=;
        b=GWJjzP+T8LfzdkC/lgtEgqaH0Q96FYC/C0slY02APC0DRQyOX2KMXoU2kpdD70fSWC
         e64lf0o5nRn5KYn/CTE3W2OhzxlaFHD/P21CFNNQ1A02Z4f8+Marqmgzt6V0gbJSai6/
         57PiH9S4xvc0cMdn6MRwPpxYvZYQv6q6lKglYUnIg5uOIQw7f53jtK9E/jFxev+d13P+
         Kv7lcLNP22kOn4TVFzU1rtWhOYSZfPk1TiCIixL9Zg+kuj7oVBxwvt778gdpWNUbZ/C1
         qz3rmIJ+h2qU6ssPaSAAK2kgwyZjYvMfINyOdijHoCMhMiPkGZC5qaHD+ROlEBJ/ag02
         2Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ohGkyUku2elxBgQMe+Wzk69ckX2qDwZ29y2rezztfrI=;
        b=FuhTAygR+wYJ3rllER0Aoyh23A70qjiHEFfFG50o19CxzPyP+9TkqFPh1l40tHXmYv
         AdlrdFEXB5BeJSblz6AiwjBa6xTdmNO9jNGJGkgoqNn8IZOk6h9+3heBXK9YGz4FVmb9
         nUgmSJ5PKLT75NLO5V2/LiWJy+0EAhZv9kcZgAy9tuL5sPL7WJdTNJec5EJKd6miBBe/
         PoJYHXXP232xKw1O9TIQt7SGzA+79/sw1ymv7XgygHI016l6S4vRezzXjp7zWNqmjJC6
         eHjOlqG8pDceIx+q4pSTPwsrith6IsCfwXpUFQn0DDLjWcLwgEZCzt8t1yWaLPAwru/R
         9ZKw==
X-Gm-Message-State: AOAM5335A98yXSng7FiPIik38ZpAxDEGyOPv3qKanE+YgaK7EiCuJf93
        +LwSxON1NuqUjgNj69zrAT7mUQ==
X-Google-Smtp-Source: ABdhPJwqSAfEXqQbXnUK0X61C4Eer4DskAuzbJ6jm1N1F9586mdmsWY4vdW+TM2OinTfxpI1TDGBHg==
X-Received: by 2002:ac2:58f0:0:b0:44a:206c:255d with SMTP id v16-20020ac258f0000000b0044a206c255dmr10010176lfo.124.1647949321742;
        Tue, 22 Mar 2022 04:42:01 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id a1-20020a056512390100b004483b717210sm2175684lfu.79.2022.03.22.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 04:42:00 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.18
Date:   Tue, 22 Mar 2022 12:41:59 +0100
Message-Id: <20220322114159.358997-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the PR with the MMC updates for v5.18. There are no updates for MEMSTICK
this time. Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 1760fdb6fe9f796fbdb9b4106b3e0bbacc16b55c:

  mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND (2022-03-07 11:47:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18

for you to fetch changes up to dc3d879c6ffa25e90875237265898e49b2cabb7e:

  dt-bindings: mmc: renesas,sdhi: Document RZ/G2UL SoC (2022-03-17 11:06:29 +0100)

----------------------------------------------------------------
MMC core:
 - Convert to sysfs_emit() in favor of sprintf()
 - Improve fallback to speed modes if eMMC HS200 fails

MMC host:
 - dw_mmc: Allow variants to set minimal supported clock rate
 - dw-mmc-rockchip: Fix problems with invalid clock rates
 - litex_mmc: Add new DT based driver for the LiteX's LiteSDCard interface
 - litex_mmc: Add Gabriel Somlo and Joel Stanley as co-maintainers for LiteX
 - mtk-sd: Add support for the Mediatek MT8186 variant
 - renesas_sdhi: Add support for RZ/G2UL variant
 - renesas_sdhi: Add support for RZ/V2L variant
 - rtsx_pci: Adjust power-on sequence to conform to the SD spec
 - sdhci-am654: Add support for TI's AM62 variant
 - sdhci_am654: Fixup support for TI's AM64 variant
 - sdhci-esdhc-imx: Add support for the imx93 variant
 - sdhci-msm: Add support for the msm8953 variant
 - sdhci-pci-gli: Add support for runtime PM for the GL9763E variant
 - sdhci-pci-gli: Adjustments of the SSC function for the GL975x variants
 - sdhci-tegra: Add support for wake on SD card event
 - sunxi-mmc: Add support for Allwinner's F1c100s variant
 - sunxi-mmc: Add support for D1 MMC variant

----------------------------------------------------------------
Alexandre Bailon (1):
      mmc: mtk-sd: Silence delay phase calculation debug log

Allen-KH Cheng (1):
      dt-bindings: mmc: Add compatible for Mediatek MT8186

Andy Shevchenko (1):
      mmc: dw_mmc: Use device_property_string_array_count()

Aniruddha Rao (1):
      mmc: sdhci-tegra: Enable wake on SD card event

Aswath Govindraju (3):
      mmc: sdhci_am654: Fix the driver data of AM64 SoC
      dt-bindings: mmc: sdhci-am654: Add compatible string for AM62 SoC
      mmc: sdhci_am654: Add Support for TI's AM62 SoC

Bean Huo (4):
      mmc: wmt-sdmmc: Use of_device_get_match_data() helper
      mmc: sdhci-tegra: Use of_device_get_match_data() helper
      mmc: sdhci-of-at91: Use of_device_get_match_data() helper
      mmc: davinci: Use of_device_get_match_data() helper

Ben Chuang (4):
      mmc: sdhci-pci-gli: Reduce the SSC value at 205MHz for GL9750 and GL9755
      mmc: sdhci-pci-gli: Enable SSC at 50MHz and 100MHz for GL9750 and GL9755
      mmc: sdhci-pci-gli: Add a switch to enable/disable SSC for GL9750 and GL9755
      mmc: sdhci-pci-gli: Add runtime PM for GL9763E

Biju Das (1):
      dt-bindings: mmc: renesas,sdhi: Document RZ/G2UL SoC

Gabriel Somlo (3):
      MAINTAINERS: co-maintain LiteX platform
      dt-bindings: mmc: Add bindings for LiteSDCard
      mmc: Add driver for LiteX's LiteSDCard interface

Geert Uytterhoeven (2):
      mmc: sh_mmcif: Simplify division/shift logic
      mmc: host: Drop commas after SoC match table sentinels

Jesse Taube (1):
      dt-bindings: mmc: sunxi: add Allwinner F1c100s compatible

Jiasheng Jiang (1):
      mmc: davinci_mmc: Handle error for clk_enable

Lad Prabhakar (1):
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2L SoC

Luca Weiss (1):
      dt-bindings: mmc: sdhci-msm: Add msm8953 compatible

Peng Fan (1):
      dt-bindings: mmc: imx-esdhc: Add imx93 compatible string

Peter Geis (2):
      mmc: dw_mmc: Support setting f_min from host drivers
      mmc: dw-mmc-rockchip: Fix handling invalid clock rates

Ricky WU (1):
      mmc: rtsx: add 74 Clocks in power on flow

Samuel Holland (2):
      dt-bindings: mmc: sunxi: Add D1 MMC and eMMC compatibles
      mmc: sunxi-mmc: Add D1 MMC variant

Sergey Shtylyov (1):
      mmc: core: use sysfs_emit() instead of sprintf()

Ulf Hansson (5):
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      mmc: core: Improve fallback to speed modes if eMMC HS200 fails
      mmc: host: Return an error when ->enable_sdio_irq() ops is missing
      mmc: core: Drop HS400 caps unless 8-bit bus is supported too

Wen Zhiwei (1):
      mmc: dw_mmc: Fix potential null pointer risk

Wolfram Sang (1):
      mmc: tmio: remove outdated members from host struct

 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |   7 +
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   1 +
 .../devicetree/bindings/mmc/litex,mmc.yaml         |  78 +++
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   3 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   7 +-
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 MAINTAINERS                                        |   9 +-
 drivers/mmc/core/bus.c                             |   9 +-
 drivers/mmc/core/bus.h                             |   3 +-
 drivers/mmc/core/host.c                            |  24 +-
 drivers/mmc/core/mmc.c                             |  37 +-
 drivers/mmc/core/sd.c                              |  25 +-
 drivers/mmc/core/sdio.c                            |   5 +-
 drivers/mmc/core/sdio_bus.c                        |   7 +-
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/davinci_mmc.c                     |  12 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |  27 +-
 drivers/mmc/host/dw_mmc.c                          |  12 +-
 drivers/mmc/host/dw_mmc.h                          |   2 +
 drivers/mmc/host/litex_mmc.c                       | 661 +++++++++++++++++++++
 drivers/mmc/host/mtk-sd.c                          |   4 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  29 +-
 drivers/mmc/host/sdhci-of-at91.c                   |   6 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  10 +-
 drivers/mmc/host/sdhci-pci-gli.c                   | 133 ++++-
 drivers/mmc/host/sdhci-tegra.c                     |  15 +-
 drivers/mmc/host/sdhci_am654.c                     |  28 +-
 drivers/mmc/host/sh_mmcif.c                        |   7 +-
 drivers/mmc/host/sunxi-mmc.c                       |   9 +
 drivers/mmc/host/tmio_mmc.h                        |   4 -
 drivers/mmc/host/wmt-sdmmc.c                       |   7 +-
 34 files changed, 1076 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
 create mode 100644 drivers/mmc/host/litex_mmc.c
