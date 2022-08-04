Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E89589B07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiHDL3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiHDL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:29:19 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1E2A255
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:29:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq11so25255772lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+RR8vD410ieO39VRvqFKwpFSST1YILrNtEQ6x6zAg0=;
        b=hfFhln88ZYBI8XfQ0iJ8591XcmbqQe84Sst2gtDagDn/7s1Rc6oN56+lPtonqzDtM9
         1OZNiu+Rf+TtAahjFkLz3Zd6JWdLd8uqTdvuEWaRq2xQxEnviHxDUlqzIrqmk2E3079L
         D7UIo/moXSKOoZYOSj09BVmMGPwq1u4J4TNlNdy4IbAqcsi6WAgu0/QNZyulMM88tp5e
         w/SJdYPRE1GxNBteYZQ+IevsgHUEy9ufgpBfaC2kLgGSpgLEHlnBwjm5VHsozgySFrrF
         ARVugh8VsDr4olNYNXRRejlDr0jhCNUK3hV9zyoNNMTvsaBFIXIcs//lNnCwQ95vIx9C
         lnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+RR8vD410ieO39VRvqFKwpFSST1YILrNtEQ6x6zAg0=;
        b=a9qk7xYGgTykJL2XapbMVzH3s7S6lLvYngqBTNWgbnVwiVSKUCxfqCINIw0YLK9ZNM
         S2GH6a69RUhNtdxZYCKIMedrGYloWe6ETiYUyzxnivQr/Wwv/o+68zQn0NPvA99cG9f9
         zQh3ERTRCM2tHKEx3Yp/dixwXCWW8KIvrd9nSJftpqW6GGRCIq10CCht3eXfvjAgbqpY
         xA74o6JnTjN+FObOYvYUw50RB3xPg/zpzi6uWNczTtZVHoKUZ+dhmyYbEpjdCD+lZwS6
         dLV8/e4i2yMG7dkDoLb9TacFwkg4g1FPMPho/N9bpZPXu14XVPH4DTItPu47GRmrO6eu
         mNeg==
X-Gm-Message-State: ACgBeo03Lfpz785HObugvSPSue3MSO5/OYkqTJyzGIX+tUVB3VB+MeuS
        wIIfHQFoTccERoh1MQvsH23nOA==
X-Google-Smtp-Source: AA6agR6p3sUCxEH8mLSNiyb11S/MOlHnZBFXFXaKkDE/PgDZ17LbyULL6ji6MqztzUVt1r31xYTcdg==
X-Received: by 2002:a05:6512:1682:b0:48a:b5df:b917 with SMTP id bu2-20020a056512168200b0048ab5dfb917mr603233lfb.478.1659612556295;
        Thu, 04 Aug 2022 04:29:16 -0700 (PDT)
Received: from localhost.localdomain (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id r27-20020a2eb61b000000b0025e4cf9d0c1sm88736ljn.115.2022.08.04.04.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 04:29:15 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.20
Date:   Thu,  4 Aug 2022 13:29:14 +0200
Message-Id: <20220804112914.14380-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the PR with MMC and MEMSTICK updates for v5.20-rc1. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 51189eb9ddc88851edc42f539a0f9862fd0630c2:

  mmc: sdhci-omap: Fix a lockdep warning for PM runtime init (2022-07-13 12:29:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.20

for you to fetch changes up to 527f36f5efa45b6a897190cabf982e2d207887da:

  mmc: mediatek: add support for SDIO eint wakup IRQ (2022-07-26 16:58:32 +0200)

----------------------------------------------------------------
MMC core:
 - Add support for the asynchronous SDIO wakeup interrupts
 - Skip redundant evaluation of eMMC HS400 caps when no-MMC-cap
 - Add support to store error stats from host drivers
 - Extend debugfs to show error stats from host drivers
 - Add single I/O read support in the recovery path for 4k sector cards

MMC host:
 - dw_mmc-exynos: Convert corresponding DT bindings to the dtschema
 - dw_mmc-rockchip: Add support for the Rockchip RV1126 variant
 - mmc_spi: Convert corresponding DT bindings to the dtschema
 - mtk-sd: Extend support for interrupts/pinctrls for SDIO low-power mode
 - mtk-sd: Add support for SDIO wake irqs
 - mtk-sd: Add support for the Mediatek MT8188 variant
 - renesas_sdhi: Drop redundant manual tap correction for newer SoCs
 - renesas_sdhi: Add support for the R-Car S4-8 and generic Gen4 variants
 - sdhci/cqhci: Add support to capture stats from host errors
 - sdhci-brcmstb: Add ability to increase max clock rate for SDIO on 72116b0
 - sdhci-msm: Add support for the MSM8998 and SM8450 variant
 - sdhci-of-at91: Fixup UHS-I mode by rewriting of MC1R
 - sdhci-of-dwcmshc: Add support for the Rockchip rk3588 variant
 - sdhci-of-dwcmshc: Enable reset support for the Rockchip variants
 - sdhci-pci-gli: Improve I/O read/write performance for GL9763E
 - sdhci-s3c: Convert corresponding DT bindings to the dtschema
 - tmio: Avoid glitches when resetting

MEMSTICK core:
 - A couple of minor fixes and cleanups

----------------------------------------------------------------
Alexander Stein (1):
      mmc: core: Do not evaluate HS400 capabilities if bus has no MMC capability

Axe Yang (3):
      dt-bindings: mmc: mtk-sd: extend interrupts and pinctrls properties
      mmc: core: Add support for SDIO wakeup interrupt
      mmc: mediatek: add support for SDIO eint wakup IRQ

Bhupesh Sharma (1):
      dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings

ChanWoo Lee (1):
      mmc: core: Replace with already defined values for readability

Christian Loehle (1):
      mmc: block: Add single read for 4k sector cards

Christophe JAILLET (3):
      memstick/ms_block: Fix some incorrect memory allocation
      memstick/ms_block: Fix a memory leak
      memstick/ms_block: Use the bitmap API when applicable

Conor Dooley (1):
      dt-bindings: mmc: convert mmc-spi-slot to yaml

Eugen Hristev (1):
      mmc: sdhci-of-at91: fix set_uhs_signaling rewriting of MC1R

Fabien Parent (1):
      mmc: mtk-sd: fix typo

Fabio Estevam (1):
      mmc: mxcmmc: Silence a clang warning

Jagan Teki (1):
      dt-bindings: mmc: rockchip-dw-mshc: Document Rockchip RV1126

Jason Lai (1):
      mmc: host: Improve I/O read/write performance for GL9763E

Johnson Wang (1):
      dt-bindings: mmc: Add compatible for MediaTek MT8188

Kamal Dasu (3):
      dt-bindings: mmc: Add Broadcom optional sdio_freq clock
      mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
      mmc: sdhci-brcmstb: use clk_get_rate(base_clk) in PM resume

Konrad Dybcio (1):
      dt-bindings: mmc: sdhci-msm: Document the SM8450 compatible

Krzysztof Kozlowski (7):
      dt-bindings: mmc: samsung,exynos-dw-mshc: convert to dtschema
      dt-bindings: mmc: samsung,exynos-dw-mshc: document Exynos5420 SMU
      dt-bindings: mmc: samsung,s3c6410-sdhci: convert to dtschema
      dt-bindings: mmc: sdhci-msm: fix reg-names entries
      dt-bindings: mmc: sdhci-msm: constrain reg-names per variants
      dt-bindings: mmc: sdhci-msm: add MSM8998
      mmc: sdhci-msm: drop redundant of_device_id entries

Lad Prabhakar (2):
      mmc: renesas_sdhi: Get the reset handle early in the probe
      mmc: renesas_sdhi: Fix typo's

Liang He (4):
      mmc: sdhci-of-esdhc: Fixup use of of_find_compatible_node()
      mmc: core: quirks: Add of_node_put() when breaking out of loop
      mmc: cavium-octeon: Add of_node_put() when breaking out of loop
      mmc: cavium-thunderx: Add of_node_put() when breaking out of loop

Miaoqian Lin (1):
      mmc: sdhci-of-esdhc: Fix refcount leak in esdhc_signal_voltage_switch

Nathan Chancellor (1):
      mmc: sdhci-brcmstb: Initialize base_clk to NULL in sdhci_brcmstb_probe()

Ren Zhijie (1):
      mmc: sdhci-pci-gli: Fix build error unused-function

Robert Marko (1):
      dt-bindings: mmc: sdhci-msm: document resets

Sebastian Reichel (1):
      mmc: sdhci-of-dwcmshc: rename rk3568 to rk35xx

Seunghui Lee (2):
      mmc: core: Use mmc_card_* macro and add a new for the sd_combo type
      mmc: mxcmmc: Use mmc_card_sdio macro

Shaik Sajida Bhanu (5):
      mmc: core: Capture eMMC and SD card errors
      mmc: sdhci: Capture eMMC and SD card errors
      mmc: debugfs: Add debug fs entry for mmc driver
      mmc: debugfs: Add debug fs error state entry for mmc driver
      mmc: cqhci: Capture eMMC and SD card errors

Takeshi Saito (1):
      mmc: renesas_sdhi: newer SoCs don't need manual tap correction

Ulf Hansson (1):
      mmc: Merge branch fixes into next

Uwe Kleine-König (5):
      mmc: dw_mmc: exynos: Obviously always return success in remove callback
      mmc: dw_mmc: hi3789cv200: Obviously always return success in remove callback
      mmc: dw_mmc: rockchip: Obviously always return success in remove callback
      mmc: sdhci-of-arasan: Obviously always return success in remove callback
      mmc: sdhci-st: Obviously always return success in remove callback

Wei Yongjun (1):
      mmc: debugfs: Fix file release memory leak

Wolfram Sang (5):
      mmc: renesas_sdhi: add R-Car Gen4 fallback compatibility string
      dt-bindings: mmc: renesas,sdhi: Document R-Car S4-8 and generic Gen4 support
      dt-bindings: mmc: renesas,sdhi: R-Car V3U is R-Car Gen4
      dt-bindings: mmc: renesas,sdhi: Add R-Car Gen4 clock requirements
      mmc: tmio: avoid glitches when resetting

Xiang wangx (1):
      mmc: mmci: Fix typo in comment

Yifeng Zhao (2):
      mmc: sdhci-of-dwcmshc: add reset call back for rockchip Socs
      mmc: sdhci-of-dwcmshc: add support for rk3588

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml           |  32 +++-
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |  94 ----------
 .../devicetree/bindings/mmc/mmc-spi-slot.txt       |  29 ----
 .../devicetree/bindings/mmc/mmc-spi-slot.yaml      |  77 ++++++++
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |  62 ++++++-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   7 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   1 +
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       | 160 +++++++++++++++++
 .../bindings/mmc/samsung,s3c6410-sdhci.yaml        |  81 +++++++++
 .../devicetree/bindings/mmc/samsung-sdhci.txt      |  32 ----
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |  82 +++++++--
 drivers/memstick/core/ms_block.c                   |  15 +-
 drivers/mmc/core/block.c                           |  32 ++--
 drivers/mmc/core/bus.c                             |   4 +-
 drivers/mmc/core/core.c                            |  10 +-
 drivers/mmc/core/debugfs.c                         |  80 +++++++++
 drivers/mmc/core/host.c                            |   2 +-
 drivers/mmc/core/quirks.h                          |   4 +-
 drivers/mmc/core/sd.c                              |   4 +-
 drivers/mmc/core/sdio.c                            |  30 +++-
 drivers/mmc/host/cavium-octeon.c                   |   1 +
 drivers/mmc/host/cavium-thunderx.c                 |   4 +-
 drivers/mmc/host/cqhci-core.c                      |   9 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   4 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   4 +-
 drivers/mmc/host/mmci.c                            |   2 +-
 drivers/mmc/host/mtk-sd.c                          |  88 +++++++++-
 drivers/mmc/host/mxcmmc.c                          |   4 +-
 drivers/mmc/host/renesas_sdhi.h                    |   1 +
 drivers/mmc/host/renesas_sdhi_core.c               |  42 +++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  11 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |  76 +++++++-
 drivers/mmc/host/sdhci-msm.c                       |  29 +---
 drivers/mmc/host/sdhci-of-arasan.c                 |   5 +-
 drivers/mmc/host/sdhci-of-at91.c                   |   9 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 193 ++++++++++++++++-----
 drivers/mmc/host/sdhci-of-esdhc.c                  |   7 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |  34 ++++
 drivers/mmc/host/sdhci-st.c                        |   5 +-
 drivers/mmc/host/sdhci.c                           |  59 +++++--
 drivers/mmc/host/sdhci.h                           |   3 +
 drivers/mmc/host/tmio_mmc.c                        |   2 +-
 drivers/mmc/host/tmio_mmc.h                        |   6 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  28 ++-
 include/linux/mmc/card.h                           |   9 +-
 include/linux/mmc/host.h                           |  26 +++
 include/linux/mmc/mmc.h                            |   6 +
 include/linux/mmc/sdio.h                           |   5 +
 49 files changed, 1152 insertions(+), 362 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
