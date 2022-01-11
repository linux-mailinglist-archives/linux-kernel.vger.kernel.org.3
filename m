Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9019548AF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbiAKO3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241903AbiAKO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:29:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB072C061756
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:29:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h2so56934379lfv.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfbEUWQRPTSmW9Z0a4zTdahfkoFdikCnHbbV8mBRI98=;
        b=N3pPsmz/pH2Pkaf1jHMLAaFk+skr0PgoCzZ0cxq0t3SzqnljyYyFcM2XYRHwp8pSTI
         pqeHWPQqs7Jng3nQRG+LY2mPWORnF2BoSXpcexXYSgyv+2w0O3UrLhPKZ0D2T0Qjd4nU
         B3uxtDUQdzzTZjL/W0uf9r+1gwu504cB8h7dLvTgA/9lbqjRIVV0iKaS9w7791TbHntE
         Jh+oEKw21YONqvu3Br8GjaJmtuIjDEp4NASAQQJHf07xnQdvPNAoqAzIaFRWtmb5lzYs
         v5ZsJXXk1bGTLVSJpHCc3sa0PpyJ1yJbBqTwea5ojstwCQeYEFGFEQTb9MEC2U8ZMcby
         JGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfbEUWQRPTSmW9Z0a4zTdahfkoFdikCnHbbV8mBRI98=;
        b=YaqOIoPn5fMd4QZKRZSFKxtZhnFOYHn5ioOmD9+mjAm59SgSlHylv+GStxndG4e/wI
         cLxD14EPWffh8Md3xL/EDiL5Pg/3NcypM9xKFGuFFjSnYDrxWHT9cgm64ppuRQ2b93/L
         LnKK8UOOzirmHtiQUuf1bQLVdYi8hC4Ex2c6VWp2ctp40j3D43gk9h8wWGEGYQT8TfHV
         x3Wy5Utsqymh3kUK0Z/JDIjIBhzQvCrkPKVYxGSFVegUWSms0kJDiDDTaXsLsxIDvC95
         2AcTpwDu080K7QuAR6FZSKL8/MacS0ck1tC3cJL7wEdCCXAsOifOOSuMcSuMDi2s1buV
         fT2g==
X-Gm-Message-State: AOAM533xTBOmfybchPiBvy2WC8yoQz69Jol2+HcSBggjAFS1ILV829he
        9QnnOogMW6tmCwYd5B8+/rHjFZZMOaDhcN6p
X-Google-Smtp-Source: ABdhPJxVC3FYcz5K4lr2iboLO0p6c7QZN9oR2c1BVTsurrAtm+38uQEE8/wksPpOLQ4K4evP9I/DPw==
X-Received: by 2002:a2e:a601:: with SMTP id v1mr3124371ljp.286.1641911350984;
        Tue, 11 Jan 2022 06:29:10 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id m3sm951149lfr.60.2022.01.11.06.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 06:29:09 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.17
Date:   Tue, 11 Jan 2022 15:29:09 +0100
Message-Id: <20220111142909.27773-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the PR with updates for MMC for v5.17, no changes for MEMSTICK this time.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ff31ee0a0f471776f67be5e5275c18d17736fc6b:

  mmc: mmci: stm32: clear DLYB_CR after sending tuning command (2021-12-21 13:03:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17

for you to fetch changes up to 356f3f2c5756bbb67a515760966a40fc7043cdda:

  dt-bindings: mmc: synopsys-dw-mshc: integrate Altera and Imagination (2021-12-28 17:55:21 +0100)

----------------------------------------------------------------
MMC core:
 - Use common polling loop for CMD1
 - Add support for DT compatibles for card quirks and use it for ti,wl1251
 - Fixup storing of the OCR mask for MMC_QUIRK_NONSTD_SDIO

MMC host:
 - dw_mmc: Add support for MMC_GEN_CMDs
 - dw_mmc: Fixup calculation of the data timeout
 - dw_mmc-exynos: Add support for the ARTPEC-8 variant
 - jz4740: Add support for bi-directional DMA channels
 - mmci: Add support for eMMC HS200 mode for the stm32 sdmmc variant
 - mmci: Add support for stm32 sdmmc variant revision v2.2
 - mtk-sd: A couple of various minor improvements
 - omap_hsmmc: Drop redundant initialization for the ti,wl1251 chip
 - sdhci-esdhc-imx: Add support for the i.MXRT series variant
 - sdhci-esdhc-imx: Add Haibo Chen as maintainer
 - sdhci-pci: Add support for the Intel ADL variant
 - sdhci-pci-gli: GL975[50]: Add support for the Apple ARM64 variant
 - sdhci-pci-o2micro: Improve support for SDR104/HS200

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Add PCI ID for Intel ADL

Andy Shevchenko (2):
      mmc: mmc_spi: Convert 'multiple' to be boolean in mmc_spi_data_do()
      mmc: mmc_spi: Use write_or_read temporary variable in mmc_spi_data_do()

AngeloGioacchino Del Regno (5):
      mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling
      mmc: mtk-sd: Use BIT() and GENMASK() macros to describe fields
      mmc: mtk-sd: Take action for no-sdio device-tree parameter
      mmc: mtk-sd: Fix usage of devm_clk_get_optional()
      mmc: mtk-sd: Assign src_clk parent to src_clk_cg for legacy DTs

Biju Das (1):
      mmc: tmio: reinit card irqs in reset routine

Christophe JAILLET (1):
      mmc: pwrseq: Use bitmap_free() to free bitmap

Dan Carpenter (1):
      mmc: dw_mmc: clean up a debug message

David Heidelberg (1):
      dt-bindings: mmc: PL18x stop relying on order of dma-names

Florian Fainelli (1):
      dt-bindings: mmc: Convert Broadcom STB SDHCI binding to YAML

Fred Ai (2):
      mmc: sdhci-pci-o2micro: Improve card input timing at SDR104/HS200 mode
      mmc: sdhci-pci-o2micro: Restore the SD clock's base clock frequency

H. Nikolaus Schaller (3):
      mmc: core: provide macro and table to match the device tree to apply quirks
      mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc
      mmc: omap_hsmmc: Revert special init for wl1251

Haibo Chen (1):
      MAINTAINERS: Add i.MX sdhci maintainer

Hector Martin (2):
      mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF platforms
      mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads as 32-bit reads.

Huijin Park (2):
      mmc: core: change __mmc_poll_for_busy() parameter type
      mmc: core: adjust polling interval for CMD1

Jacky Bai (1):
      dt-bindings: mmc: imx-esdhc: Add imx8ulp compatible string

Jesse Taube (2):
      dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT compatible string
      mmc: sdhci-esdhc-imx: Add sdhc support for i.MXRT series

Joel Stanley (1):
      mmc: core: Fix blk_status_t handling

John Keeping (4):
      mmc: dw_mmc: add common capabilities to replace caps
      mmc: dw_mmc: hi3798cv200: use common_caps
      mmc: dw_mmc: rockchip: use common_caps
      mmc: dw_mmc: exynos: use common_caps

Jérôme Pouiller (2):
      mmc: core: rewrite mmc_fixup_device()
      mmc: core: allow to match the device tree to apply quirks

Krzysztof Kozlowski (1):
      dt-bindings: mmc: synopsys-dw-mshc: integrate Altera and Imagination

Martin Blumenstingl (1):
      mmc: meson-mx-sdhc: Drop unused MESON_SDHC_NUM_BUILTIN_CLKS macro

Mårten Lindahl (6):
      mmc: dw_mmc: Avoid hung state if GEN_CMD transfer fails
      mmc: dw_mmc: Allow lower TMOUT value than maximum
      dt-bindings: mmc: exynos-dw-mshc: Add support for ARTPEC-8
      mmc: dw_mmc-exynos: Add support for ARTPEC-8
      mmc: dw_mmc: Add driver callbacks for data read timeout
      mmc: dw_mmc: Do not wait for DTO in case of error

Paul Cercueil (2):
      dt-bindings: mmc: ingenic: Support using bi-directional DMA channel
      mmc: jz4740: Support using a bi-directional DMA channel

Petr Vorel (1):
      dt-bindings: mmc: sdhci-msm: Add compatible string for msm8994

Rob Herring (1):
      dt-bindings: mmc: Add missing properties used in examples

Sergey Shtylyov (3):
      mmc: meson-mx-sdhc: add IRQ check
      mmc: meson-mx-sdio: add IRQ check
      mmc: au1xmmc: propagate errors from platform_get_irq()

Ulf Hansson (4):
      mmc: core: Fixup storing of OCR for MMC_QUIRK_NONSTD_SDIO
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next

Yann Gautier (4):
      dt-bindings: mmc: mmci: Add st,stm32-sdmmc2 compatible
      mmc: mmci: Add support for sdmmc variant revision v2.2
      mmc: mmci: increase stm32 sdmmcv2 clock max freq
      mmc: mmci: add hs200 support for stm32 sdmmc

lizhe (1):
      mmc: core: Remove redundant driver match function

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   3 +
 .../devicetree/bindings/mmc/arm,pl18x.yaml         |  19 +-
 .../devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt |  53 --
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml           | 100 ++++
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   2 +
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   8 +
 .../devicetree/bindings/mmc/img-dw-mshc.txt        |  28 --
 .../devicetree/bindings/mmc/ingenic,mmc.yaml       |  37 +-
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   6 +
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |   2 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |  23 -
 .../bindings/mmc/socionext,uniphier-sd.yaml        |   6 +
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |   5 +-
 MAINTAINERS                                        |   7 +
 drivers/mmc/core/block.c                           |   4 +-
 drivers/mmc/core/bus.c                             |  11 -
 drivers/mmc/core/card.h                            |  36 ++
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/mmc/core/mmc_ops.c                         |  89 ++--
 drivers/mmc/core/mmc_ops.h                         |   2 +-
 drivers/mmc/core/pwrseq_simple.c                   |   2 +-
 drivers/mmc/core/queue.c                           |   2 +-
 drivers/mmc/core/quirks.h                          |  64 ++-
 drivers/mmc/core/sd.c                              |   2 +-
 drivers/mmc/core/sdio.c                            |   5 +-
 drivers/mmc/host/au1xmmc.c                         |   4 +-
 drivers/mmc/host/dw_mmc-exynos.c                   | 110 ++++-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   9 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |  11 +-
 drivers/mmc/host/dw_mmc.c                          |  56 ++-
 drivers/mmc/host/dw_mmc.h                          |  13 +
 drivers/mmc/host/jz4740_mmc.c                      |  19 +-
 drivers/mmc/host/meson-mx-sdhc-clkc.c              |   2 -
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |   5 +
 drivers/mmc/host/meson-mx-sdio.c                   |   5 +
 drivers/mmc/host/mmc_spi.c                         |  16 +-
 drivers/mmc/host/mmci.c                            |   7 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c                |   5 +-
 drivers/mmc/host/mtk-sd.c                          | 550 +++++++++++----------
 drivers/mmc/host/omap_hsmmc.c                      |  36 --
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   4 +
 drivers/mmc/host/sdhci-pci-core.c                  |   1 +
 drivers/mmc/host/sdhci-pci-gli.c                   |  34 ++
 drivers/mmc/host/sdhci-pci-o2micro.c               |  62 ++-
 drivers/mmc/host/sdhci-pci.h                       |   1 +
 drivers/mmc/host/tmio_mmc_core.c                   |  15 +-
 47 files changed, 930 insertions(+), 554 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
