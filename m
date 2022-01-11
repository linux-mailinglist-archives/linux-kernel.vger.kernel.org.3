Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3448AD98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbiAKM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiAKM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:27:38 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FA5C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 04:27:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so1739113wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 04:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=BMXiwlo1PrjMbvh9aSWyghABCzpHcaQxJA5ad36lYRM=;
        b=jV3fdrvY02+fg0caks2AlsVzdnTS9PHz227GgmBgsvp8Al+aUdpfmT9ncCT+BPglDC
         VGEiiczF2C9tF/VfzS6/NYbX8MM4jazKPBDmCeWSajzLfdSsQ/B+evhH84HJVGrUu+BG
         mCM8XbX5BzawIZ2BM2ZI44+gO+DmNjxs7zQEuZUeoeduv+B5+a2bdGdkJJViTrhw5tkn
         UrzK1ai3MkzaA85qgnP08ANPrpmX8pgowW6hsCVecanmdsWZtLZ7aozbaxMI7tAlP6dn
         rYeKncVuiYynXH6CguMo/CKhoi8mTJG2eUfOgvhEwUbE6Y/M8DlljrX0zw1Vsuz1Swsb
         L0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=BMXiwlo1PrjMbvh9aSWyghABCzpHcaQxJA5ad36lYRM=;
        b=UJU4PHsQTXnd3ISQ2x7wxNZP7r3JlvQ1s4Ge/P7e04pDhLotyo4TJB6j1dpDUXNLzQ
         HTkDsSt/vJ3+cpQ9zKjp1txxn/O03exM49xPywdrg5Pk8LNp9PY7z440AjIQMpybn9O2
         YLDca7azNVysn8uIrRSo0KowfjjbCxXDaVeqy/Zj5mBAmjJ66OtyGtEbw+O7KP+l+V/n
         fzN3drLK/b93uN18zJ+UsbH2X/CClq9EeKFDrnrjjgDS8opVqX1QNrPi1OOf/8RONUG+
         A3WY38UHmtn6IFbzcrLyRTEDImvxXEfW9cCZE/yBqayy1ds87ALj5/TboOpmfOecJHp6
         EVNQ==
X-Gm-Message-State: AOAM532YvXI5NQBi37CGoYI+YWk760DEm7mxKJE4mOCpdMYUjv1HzDM6
        h+n4o+LFJ6fUujh5uWy3rhoU7b5AYLFgLA==
X-Google-Smtp-Source: ABdhPJweDbuhok2eSxNmw58Z4hg/sMIT/suFTfH33ZBbyioC8JjMsrTujbRKbB+ODwaJGIJwJQNepg==
X-Received: by 2002:a05:600c:5126:: with SMTP id o38mr2278745wms.81.1641904056704;
        Tue, 11 Jan 2022 04:27:36 -0800 (PST)
Received: from google.com ([31.124.24.179])
        by smtp.gmail.com with ESMTPSA id bg12sm2245497wmb.5.2022.01.11.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 04:27:36 -0800 (PST)
Date:   Tue, 11 Jan 2022 12:27:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.17
Message-ID: <Yd13sbAfR1aBKOkh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.17

for you to fetch changes up to e565615c5486935e3b6080dc06a94c6fbd0b4264:

  mfd: google,cros-ec: Fix property name for MediaTek rpmsg (2021-12-29 15:29:00 +0000)

----------------------------------------------------------------
 - New Device Support
   - Add support for Lakefield PCH to Intel LPSS PCI

 - Remove Device Support
   - Remove support for ROHM BD70528 Power Management IC

 - New Functionality
   - Add support for SMBus and I2C mode to Dialog DA9062/61 PMIC
   - Enable I2C4 on Microsoft Surface Go & Go 2

 - Fix-ups
   - Device Tree changes (inc. YAML conversion); maxim,max77686,
                          rohm,bd9571mwv, syscon, brcm,twd, google,cros-ec
   - Use __maybe_unused instead of #ifery; atmel-flexcom
   - Allow the Regmap API to handle endianess internally; ntxec
   - Utilise I2C's .resume_noirq call-back; atmel-flexcom
   - Remove unused code; ti_am335x_tscadc
   - Use CPU-id instead of ACPI _HRV to ID variants; intel_soc_pmic_core
   - Allow device to power-off right from .probe(); tps65910
   - Trivial (whitespace, typos, etc); da9063

 - Bug Fixes
   - Fix ordering issues during probe; intel-lpss-acpi
   - Fix correct clock speed; intel-lpss-pci

----------------------------------------------------------------
Alexandre Ghiti (1):
      dt-bindings: mfd: Fix typo "DA9093" -> "DA9063"

Andrej Picej (1):
      mfd: da9062: Support SMBus and I2C mode

Andy Shevchenko (1):
      mfd: intel-lpss: Fix too early PM enablement in the ACPI ->probe()

Claudiu Beznea (2):
      mfd: atmel-flexcom: Remove #ifdef CONFIG_PM_SLEEP
      mfd: atmel-flexcom: Use .resume_noirq

Dario Binacchi (1):
      mfd: ti_am335x_tscadc: Drop the CNTRLREG_TSC_8WIRE macro

Dmitry Osipenko (1):
      mfd: tps65910: Set PWR_OFF bit during driver probe

Ed Schaller (1):
      mfd: intel-lpss: Add Intel Lakefield PCH PCI IDs

Geert Uytterhoeven (1):
      dt-bindings: mfd: bd9571mwv: Convert to json-schema

Hans de Goede (2):
      mfd: intel-lpss: Fix I2C4 not being available on the Microsoft Surface Go & Go 2
      mfd: intel_soc_pmic: Use CPU-id check instead of _HRV check to differentiate variants

Jonathan Neuschäfer (1):
      mfd: ntxec: Change return type of ntxec_reg8 from __be16 to u16

Krzysztof Kozlowski (2):
      regulator: dt-bindings: maxim,max77686: Convert to dtschema
      dt-bindings: mfd: maxim,max77686: Convert to dtschema

Linus Walleij (1):
      dt-bindings: mfd: Add Freecom system controller

Matthias Brugger (1):
      mfd: google,cros-ec: Fix property name for MediaTek rpmsg

Matti Vaittinen (4):
      dt-bindings: mfd: regulator: Drop BD70528 support
      gpio: bd70528 Drop BD70528 support
      mfd: bd70528: Drop BD70528 support
      MAINTAINERS: bd70528: Drop ROHM BD70528 drivers

Mauro Carvalho Chehab (1):
      mfd: Kconfig: Change INTEL_SOC_PMIC_CHTDC_TI to bool

Oleksandr Suvorov (1):
      mfd: stmpe: Support disabling sub-functions

Orlando Chamberlain (1):
      mfd: intel-lpss-pci: Fix clock speed for 38a8 UART

Rafał Miłecki (1):
      dt-bindings: mfd: Add Broadcom's Timer-Watchdog block

Sam Protsenko (1):
      dt-bindings: mfd: syscon: Add samsung,exynos850-sysreg

 Documentation/devicetree/bindings/mfd/bd9571mwv.txt                    |  69 ------
 Documentation/devicetree/bindings/mfd/brcm,twd.yaml                    |  61 ++++++
 Documentation/devicetree/bindings/mfd/da9063.txt                       |   2 +-
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml              |   2 +-
 Documentation/devicetree/bindings/mfd/max77686.txt                     |  26 ---
 Documentation/devicetree/bindings/mfd/maxim,max77686.yaml              | 132 ++++++++++++
 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt            | 102 ---------
 Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml              | 127 +++++++++++
 Documentation/devicetree/bindings/mfd/syscon.yaml                      |   2 +
 Documentation/devicetree/bindings/regulator/max77686.txt               |  71 -------
 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml        |  83 ++++++++
 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt |  68 ------
 MAINTAINERS                                                            |  10 +-
 drivers/gpio/Kconfig                                                   |  11 -
 drivers/gpio/Makefile                                                  |   1 -
 drivers/gpio/gpio-bd70528.c                                            | 230 --------------------
 drivers/mfd/Kconfig                                                    |  23 +-
 drivers/mfd/Makefile                                                   |   1 -
 drivers/mfd/atmel-flexcom.c                                            |  11 +-
 drivers/mfd/da9062-core.c                                              |  12 ++
 drivers/mfd/intel-lpss-acpi.c                                          |   7 +-
 drivers/mfd/intel-lpss-pci.c                                           |  21 +-
 drivers/mfd/intel-lpss.c                                               |   1 +
 drivers/mfd/intel-lpss.h                                               |   1 +
 drivers/mfd/intel_soc_pmic_core.c                                      |  28 +--
 drivers/mfd/rohm-bd70528.c                                             | 314 ---------------------------
 drivers/mfd/stmpe.c                                                    |   2 +-
 drivers/mfd/tps65910.c                                                 |  22 +-
 include/linux/mfd/ntxec.h                                              |   2 +-
 include/linux/mfd/rohm-bd70528.h                                       | 389 ----------------------------------
 include/linux/mfd/rohm-generic.h                                       |   1 -
 include/linux/mfd/ti_am335x_tscadc.h                                   |   1 -
 32 files changed, 476 insertions(+), 1357 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/bd9571mwv.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/brcm,twd.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77686.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd9571mwv.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
 delete mode 100644 drivers/gpio/gpio-bd70528.c
 delete mode 100644 drivers/mfd/rohm-bd70528.c
 delete mode 100644 include/linux/mfd/rohm-bd70528.h

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
