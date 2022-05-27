Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1FC536268
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352905AbiE0MTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353798AbiE0MG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:06:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A414AF73
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:55:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z17so2519245wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=TIFCeWr6PzS1JgvbzpZhdEauTuuaS1OJePQF0iA2O1o=;
        b=akfROt1e7damrHOtyxjyGFPUuGcHtowMQRCinMk4WZ11P/RNljQvLdMSKDrnmtukvq
         OJFz2ACs4NGkRxxEkFYPq4RKNoMvcQRMXN7MMNQt6wgyqhirXXTbDKe0XHh96oLQZR+M
         ZhyZUwrjMBemMg7oh91d5Qh23VW7VJ5JeRS3KBZ31G+WF+39fCC7QaBUSXn5eZv6mYmM
         1Bzzek24DB3ofao7erWvO44VTeT+s1ve8Ej9u/V1NWL4MYEIATtCL2V2K39idqpoM6cq
         s1Y3YzGyBLn7nN3CfxWRGyf3Vo4ftJQy3IoSw2hW7tElLLpQiT1R7OEq+yT7c1guqDNY
         57Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=TIFCeWr6PzS1JgvbzpZhdEauTuuaS1OJePQF0iA2O1o=;
        b=z5lTRRCtR+KthHyAgvhp+/gY0RNQMbEeQRpee8zYtMBsqJjgH5saS32H+xK5wYEmKY
         mhDet4BCMm2XSFjfpeILLoXVseFRbN4y5hiZ1cZYZP0QnWRMnBEdljirLImmInK4qzMZ
         se6iu/KkAm9RzCEhbqcsp3PR5cYlrVgR/Teb8vgQDelGdZifnqsnrYaaqHnDtQ2KG1+L
         eZIfuG1LVmX99Yn9RiBuHC8Mtevw1JHpjNfbhcC1Vt0M19fOcW4Q5xS77focpTKK61LZ
         V9VmL1CbS9YcxPdX6LBwJpllJNJlNcuBbqEoPLW/rclyHydaC+oXs+2WX5CDB4JwA5SY
         iGKQ==
X-Gm-Message-State: AOAM532dd4u/3smISEczhaK6TkFzGU7T8Z/3+bmLGjzUdJ3MbT2hW1tM
        drT6Fd/11J5I16HGMWKrhCtw8ZIAEKVOQQ==
X-Google-Smtp-Source: ABdhPJwAb0JonQncODhWj/HKBzbzWek0B9gF+3dVNPz7WMf/91tvfDGDC4p54o2Op9sOGxV1uD5/zw==
X-Received: by 2002:a05:600c:3511:b0:397:7b1b:8a44 with SMTP id h17-20020a05600c351100b003977b1b8a44mr6562911wmq.46.1653652543266;
        Fri, 27 May 2022 04:55:43 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600002a900b0020d07d90b71sm1508497wry.66.2022.05.27.04.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 04:55:42 -0700 (PDT)
Date:   Fri, 27 May 2022 12:55:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.19
Message-ID: <YpC8PScrQLKP8pyO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Good afternoon Linus,

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.19

for you to fetch changes up to f93afd8e7567fa9dcf0089ff4ce5a713bfb5dae7:

  dt-bindings: cros-ec: Fix a typo in description (2022-05-23 16:11:31 +0100)

----------------------------------------------------------------
 - New Device Support
   - Add support for {Power,Home} Keys to MediaTek MT6359
   - Add support for SC2730 to Spreadtrum SPRD SC27XX SPI
   - Add support for additional Alder Lake-P I2C Controllers to Intel LPSS PCI

 - Fix-ups
   - Convert GPIO to GPIOD; hi655x-pmic
   - Only register devices that exist; cros_ec_dev
   - Remove unused code; syscon, reg-mux
   - Rework .remove() API to return void; twl-core, rt4831
   - Trivial - whitespace, spelling, coding style; tps65218, sprd-sc27xx-spi,
                                                   google,cros-ec
   - DT binding changes; samsung,exynos5433-lpass, rockchip,rk805,
                         rockchip,rk808, rockchip,rk809, rockchip,rk817,
			 rockchip,rk818, wlf,arizona

 - Bug Fixes
   - Fix error handling bugs; ipaq-micro, davinci_voicecodec

----------------------------------------------------------------
Chris Morgan (1):
      dt-bindings: mfd: rk808: Convert bindings to yaml

Cixi Geng (2):
      mfd: sprd: Add SC2730 PMIC to SPI device ID table
      mfd: sprd: Jugle {of,spi}_device_id tables into numerical order

Daniel Ammann (1):
      mfd: tps65218: Fix trivial typo in comment

Fabien Parent (2):
      mfd: mt6359: Add missing defines necessary for mtk-pmic-keys support
      mfd: mt6397-core: Add resources for PMIC keys for MT6359

Gaggery Tsai (1):
      mfd: intel-lpss: Add support for ADL-P i2c6 and i2c7

Krzysztof Kozlowski (2):
      dt-bindings: mfd: samsung,exynos5433-lpass: Fix 'dma-channels/requests' properties
      dt-bindings: mfd: wlf,arizona: Add spi-max-frequency

Lv Ruyi (1):
      mfd: ipaq-micro: Fix error check return value of platform_get_irq()

Maíra Canal (1):
      mfd: hi655x-pmic: Replace legacy gpio interface for gpiod interface

Rob Herring (1):
      dt-bindings: Drop undocumented i.MX iomuxc-gpr bindings in examples

Stephen Boyd (2):
      mfd: cros_ec_dev: Only register PCHG device if present
      dt-bindings: cros-ec: Fix a typo in description

Uwe Kleine-König (3):
      mfd: twl6030: Make twl6030_exit_irq() return void
      mfd: twl4030: Make twl4030_exit_irq() return void
      mfd: rt4831: Improve error reporting for problems during .remove()

Yang Yingliang (1):
      mfd: davinci_voicecodec: Fix possible null-ptr-deref davinci_vc_probe()

 .../devicetree/bindings/mfd/google,cros-ec.yaml    |   2 +-
 Documentation/devicetree/bindings/mfd/rk808.txt    | 465 ---------------------
 .../devicetree/bindings/mfd/rockchip,rk805.yaml    | 219 ++++++++++
 .../devicetree/bindings/mfd/rockchip,rk808.yaml    | 257 ++++++++++++
 .../devicetree/bindings/mfd/rockchip,rk809.yaml    | 284 +++++++++++++
 .../devicetree/bindings/mfd/rockchip,rk817.yaml    | 330 +++++++++++++++
 .../devicetree/bindings/mfd/rockchip,rk818.yaml    | 282 +++++++++++++
 .../bindings/mfd/samsung,exynos5433-lpass.yaml     |   4 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   8 -
 .../devicetree/bindings/mfd/wlf,arizona.yaml       |   1 +
 Documentation/devicetree/bindings/mux/reg-mux.yaml |   1 -
 drivers/mfd/cros_ec_dev.c                          |  19 +
 drivers/mfd/davinci_voicecodec.c                   |   6 +-
 drivers/mfd/hi655x-pmic.c                          |  27 +-
 drivers/mfd/intel-lpss-pci.c                       |   2 +
 drivers/mfd/ipaq-micro.c                           |   2 +-
 drivers/mfd/mt6397-core.c                          |  13 +
 drivers/mfd/rt4831.c                               |   7 +-
 drivers/mfd/sprd-sc27xx-spi.c                      |   3 +-
 drivers/mfd/twl-core.c                             |   8 +-
 drivers/mfd/twl-core.h                             |   4 +-
 drivers/mfd/twl4030-irq.c                          |   7 +-
 drivers/mfd/twl6030-irq.c                          |   3 +-
 include/linux/mfd/hi655x-pmic.h                    |   4 +-
 include/linux/mfd/mt6359/registers.h               |   2 +
 include/linux/mfd/tps65218.h                       |   2 +-
 26 files changed, 1442 insertions(+), 520 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/rk808.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
 
-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
