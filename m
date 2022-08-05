Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119CE58AAA8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbiHEMTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiHEMTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:19:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06C28709
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:19:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a7so4754651ejp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=HO4kC4nNlnQFlc8G8Nch+zBVqAbftzSR6y0K4mCpcH4=;
        b=Q8ibbL+jSGTCKibqPgl9QTeN/9uRKy5Ayj41IGiv58kG+oL7A1HWoRdKKLSuacBz71
         3slBzyhL3HJm34bV9Ja342qVx1tq1I0jABW59O3i7lsX+aCn1lCQ9FLy8GDbzMvXDMD6
         +kyXoexlvW4STHlEsCKZ1ZSUKnpb5dBjnQ4BG08/nILOmy0fg91Sw1fB0ThImRaaxWn8
         UHAVuCJeKhkNbfGR1eCAg56w+NIJqsWaBARgQI55qtvH78jG1cUpA0g/HVt2cGDloyzm
         2DcCJl+hsZHDjNhdZiLkSgkiB5pu3Ebnv4mYQImojJKAPV0sW3TGa5zjciy9GW+hn3HT
         0aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HO4kC4nNlnQFlc8G8Nch+zBVqAbftzSR6y0K4mCpcH4=;
        b=ID8wzeJ+rNqPDDCeKHHmBewOXz6Wset+O+07aUmTyWTiRE1YNFUjQcNwt18gHdBeLW
         KCkZV2GXZKTjyRo8aDNtUIhHvEpdbrpbc0yyLVWOnNv83o8yJmxVdgh4G3Uvjb+4mC7w
         DxM8q2J0Yhex0E3sow8DKh5w3ZD17hagKJ00t8WRqypSBC91j3HIOUx4zPypLej7J0nK
         Bh76qF0fyUPLpCJfNVpWGlPZwaTvNbgdoa5dWjpIXj9eP9/bmozIXRodJIfaATnr2HXm
         zm8YMgKFCLTCxzEhhQbVOtXlu1MaFxADwAknlhxxyVtwwM4Y81diX4ReYnJ8qvaN5Aw9
         d6IQ==
X-Gm-Message-State: ACgBeo0pOWJQHNdCzrPGgpaQ7PMi80GDw7Ze3opkAJ9/38zE4is3G7VV
        Sh5Y0GUP15JaUXIvlhvCHCFTqw==
X-Google-Smtp-Source: AA6agR5D7QIau7/K3B5Rpnw537SaJBhGRUmTRgJ5l36RUL394ZSxU98Yj8nsSV6NPcwWlt5LAQATiA==
X-Received: by 2002:a17:907:7f1d:b0:730:da23:5b56 with SMTP id qf29-20020a1709077f1d00b00730da235b56mr4093968ejc.140.1659701941168;
        Fri, 05 Aug 2022 05:19:01 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-5241-be09-b892-f882-607f-7a79.rev.sfr.net. [2a02:8440:5241:be09:b892:f882:607f:7a79])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b0072b3464c043sm1506111ejc.116.2022.08.05.05.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:19:00 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: [PATCH v3 00/10] Add support for TI TPS65219 PMIC.
Date:   Fri,  5 Aug 2022 14:18:42 +0200
Message-Id: <20220805121852.21254-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports
- 3 Buck regulators and 4 LDOs
- low-power standby mode
- warm/soft reset
- basic fault handling (via interrupts).
- power button

Not implemented
- DVS

1-Regulators:
Full implementation and test
Visual check: cat /sys/kernel/debug/regulator/regulator_summary
Full validation requires userspace-consumer and virtual-regulator
LDO1 is not used and output can be probbed on TP84.

2-Reset WARM/COLD
test procedure: launch reboot on the console and check visually

warm vs. cold can be configured on the kernel command-line at boot time.
Default is cold, but adding `reboot=w`
to kernel command allow testing warm reboot.

Alternative:
`# echo warm > /sys/kernel/reboot/mode` 

3-SW Shutdown
test procedure: launch halt on the console and check visually

Note: enters in competition with other source during probe

Board Test Points can be used to check voltage after system shutdown.
baseport is not handling wakeup.
A power OFF/ON cycle is needed to recover.

4-Interrupt Pin (nINT):

Interrupt occurring on PMIC TPS65219 is propagated to SOC
through EXTINTn pin connected to gic500 interrupt controller

Interrupt lines for TPS65219 shows-up on console:
cat /proc/interrupts

Validation:
Create a Residual Voltage interrupt and handling and interrupt source is cleared.
`tps65219 0-0030: Registered residual voltage for LDO1`
`533:          1          0  tps65219_irq  35 Edge      LDO1_RV`

Mapped to power button (use TP90 to GND to emulate a physical button)

5-PB Startup and Shutdown:
New implementation to support both rising and falling edge.

TPS65219 has different interrupts compared to other TPS6521* chips.
TPS65219 defines two interrupts for the powerbutton one for push and one
for release.


Interrupt support: cat proc/interrupts
`557:          0          0  tps65219_irq  47 Edge      tps65219-pwrbutton.1.auto`
`558:          0          0  tps65219_irq  48 Edge      tps65219-pwrbutton.1.auto`

TPS65219 has a multipurpose pin called EN/PB/VSENSE that can be either:
- EN in which case it functions as an enable pin.
- VSENSE which compares the voltages and triggers an automatic on/off request.
- PB in which case it can be configured to trigger an interrupt to the SoC.
ti,power-button reflects the last one of those options
where the board has a button wired to the pin and triggers
an interrupt on pressing it.

6-Changes vs v1:

6.1- Regulators:
- Further to Mark Brown review:
Use standard regmap helpers for set_voltage, enable and disable.
tps65219_set_mode, return -EINVAL in default statement for clarity.
Reshaped irq handler to report events through the notification API:
regulator_notifier_call_chain().
Use standard regulator events (consumer.h).

6.2- Device tree
- Further to Nishanth Menon review:
add tag DONOTMERGE
Board support is pending waiting for TI commitment.
This device tree is needed for driver test purpose but should not go upstream.

6.3- Bindings
- Further to Rob Herring review:
Squash interrupt commit into regulator dt-binding.
Squash pwrbutton commit into regulator dt-binding.
Remove interrupt-controller/cells properties because no consumer for those interrupts.

- Further to Mark Brown review:
Remove constraints on regulator-name.

- Pending for decision from Lee Jones further to Mark Brown review
The entire binding document should probably be in MFD if it's going to
have properties for other functions added to it.

6.4- Misc
- Further to Mark Brown review:
Use C++ (//) formatting for file header block including SPDX License
in mfd, regulator and pwrbutton.

7-Changes vs v2:

7.1- Bindings
- Further to Markus Schneider-Pargmann review:
Fix description and align name with dts: ti,power-button

7.2- Maintainers
- Further to Nishanth Menon review:
On behalf of Markus SP. Remove MAINTAINERS-OMAP2-support-add-tps65218-pwrbutton.patch
from the series.
Not needed, driver is not missing, went through INPUT tree instead.

Jerome Neanne (9):
  DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC support for AM642 SK
    board.
  DONOTMERGE: arm64: dts: ti: Add pinmux and irq mapping for TPS65219
    external interrupts
  DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button
  regulator: dt-bindings: Add TI TPS65219 PMIC bindings
  mfd: drivers: Add TI TPS65219 PMIC support
  mfd: drivers: Add interrupts support to TI TPS65219 PMIC
  regulator: drivers: Add TI TPS65219 PMIC regulators support
  Input: Add tps65219 interrupt driven powerbutton
  arm64: defconfig: Add tps65219 as modules

Markus Schneider-Pargmann (1):
  mfd: tps65219: Add power-button support

 .../bindings/regulator/ti,tps65219.yaml       | 173 +++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 115 +++++
 arch/arm64/configs/defconfig                  |   3 +
 drivers/input/misc/Kconfig                    |  10 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/tps65219-pwrbutton.c       | 150 ++++++
 drivers/mfd/Kconfig                           |  15 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/tps65219.c                        | 437 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/tps65219-regulator.c        | 416 +++++++++++++++++
 include/linux/mfd/tps65219.h                  | 364 +++++++++++++++
 14 files changed, 1697 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
 create mode 100644 drivers/input/misc/tps65219-pwrbutton.c
 create mode 100644 drivers/mfd/tps65219.c
 create mode 100644 drivers/regulator/tps65219-regulator.c
 create mode 100644 include/linux/mfd/tps65219.h

-- 
2.17.1

