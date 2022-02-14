Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7AB4B5238
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiBNN4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:56:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiBNN4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:56:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792065A2;
        Mon, 14 Feb 2022 05:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644846966; x=1676382966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2adZHzbNbrqAYiiCJa+cCCwwilXc4/CtmowXbjAh+IU=;
  b=AWzcwtBz3oV6BFPBTVu2fnRTUKg8ycO8eZHxvor2ZkOqR5j5xVuf7Yr7
   T/F7PvmY5U4+9eyBuyWy+Ufl1yGhYsLJ5+sc4fqmyMx7EYOPS/V4AbgCd
   8Q7NQkVWke98QdhFzLH/F/gmtrtpwGdcQqTvrKVKOgFOZZmGUEilgSGer
   bOK1mV2LBxabBgBqqxO1ddmT0lpq1+pgY/GXQijdUJoTTe7d9wjo5n3FD
   rGsOwvdBcnMJXnnez5jL8TTh60lz9lPhr2oHBBMwAwqqr5Y2S5fps2EIb
   qvtFMCrh0kljVi/i1t5X/jUg1uA6toM3Qu9CDYIf74/PEfD7nrb6c1oju
   w==;
IronPort-SDR: 4TxOMrANn67xj1ALI0ajgUT2e4VduH1rcREVUcrtTcLCrC4S1myXJ+J/PA322ApiM1bIsPgoM/
 VRkONhRHqzw4KrJjbi6I5HHSzj+E/fN4SxlXxtQ/QHVyN0eoHFR9gTKli3212vBAwCdO3DX/XC
 XcufeG7L7gKvk9xEtHTIoX2zE6YdWQFm2+pJAi0o0UmGC1jwpXbN07lTJsxsTm7rNTufGFakU1
 JzmPsaT4/A27DZCpbTHU3D9SNKUjBeJgT0xeNTJg/toi8MzQBRAS2nrPwgLc1xlwLlF00dGtP8
 J8SX+m39W+Uo2QqeI7nI0drN
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="85633717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2022 06:56:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 14 Feb 2022 06:56:04 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 14 Feb 2022 06:55:58 -0700
From:   <conor.dooley@microchip.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert@linux-m68k.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <lewis.hanly@microchip.com>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <ivan.griffin@microchip.com>,
        <atishp@rivosinc.com>
Subject: [PATCH v7 00/11] Update the Icicle Kit device tree
Date:   Mon, 14 Feb 2022 13:58:30 +0000
Message-ID: <20220214135840.168236-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

This series updates the Microchip Icicle Kit device tree by adding a
host of peripherals, and some updates to the memory map. In addition,
the device tree has been split into a third part, which contains "soft"
peripherals that are in the fpga fabric.

Several of the entries are for peripherals that have not get had their
drivers upstreamed, so in those cases the dt bindings are included where
appropriate in order to avoid the many "DT compatible string <x> appears
un-documented" errors.

Depends on mpfs clock driver binding (on clk/next) to provide 
dt-bindings/clock/microchip,mpfs-clock.h for the device tree
and on the other changes to the icicle/mpfs device tree from geert
that are already in linux/riscv/for-next.

Additionally, the interrupt-extended warnings on the plic/clint are 
cleared by [1] & [2].

[1] https://lore.kernel.org/linux-riscv/cover.1639744468.git.geert@linux-m68k.org/
[2] https://lore.kernel.org/linux-riscv/cover.1639744106.git.geert@linux-m68k.org/

Changes from v6:
- Dropped i2c patch, as its in i2c-next
- Added ack on gpio, reviewed-by on rtc
- Dropped child nodes from sysctrl binding entirely, added a link to
  the online documenation for the services the system controller can
  provide
- Dropped the #pwm-cells and replaced with a ref, a la Krzysztof's
  series

Changes from v5:
- reworded the descriptions in the pwm binding to (hopefully) add
  clarity
- added -mask to the custom properties and made them 32 bit
- renamed the i2c binding to corei2c, since it is not mpfs specific
- removed the child nodes of the system controller in example/dts &
  will create them in the driver.
  @Rob, I assume keeping them documented is the correct thing to do?
- removed the dependancy on the clock binding from the examples
- reformatted rtc interrupts as per Rob's suggestion

Changes from v4:
- dont include icicle_kit_defconfig, accidentally added in v3
- drop prescaler from mpfs-rtc & calculate the value instead
- use corei2c as a fallback device for mpfs-i2c
- drop spi dt-binding (on spi-next)
  commit 2da187304e556ac59cf2dacb323cc78ded988169
- drop usb dt-binding (on usb-next)

Changes from v3:
- drop "mailbox: change mailbox-mpfs compatible string", already upstream:
  commit f10b1fc0161cd99e ("mailbox: change mailbox-mpfs compatible string")
- fix copy paste error in microchip,mpfs-mailbox dt-binding
- remove whitespace in syscontroller dt entry

Changes from v2:
- dropped plic int header & corresponding defines in dts{,i}
- use $ref to drmode in mpfs-musb binding
- split changes to dts{,i} again: functional changes to existing
  elements now are in a new patch
- drop num-cs property in mpfs-spi binding
- dont make the system controller a simple-mfd
- move the separate bindings for rng/generic system services into the 
  system controller binding
- added an instance corei2c as i2c2 in the fabric dtsi
- add version numbering to corepwm and corei2c compat string (-rtl-vN)

Conor Dooley (11):
  dt-bindings: soc/microchip: update syscontroller compatibles
  dt-bindings: soc/microchip: add info about services to mpfs sysctrl
  dt-bindings: rtc: add bindings for microchip mpfs rtc
  dt-bindings: gpio: add bindings for microchip mpfs gpio
  dt-bindings: pwm: add microchip corepwm binding
  riscv: dts: microchip: use clk defines for icicle kit
  riscv: dts: microchip: add fpga fabric section to icicle kit
  riscv: dts: microchip: refactor icicle kit device tree
  riscv: dts: microchip: update peripherals in icicle kit device tree
  riscv: dts: microchip: add new peripherals to icicle kit device tree
  MAINTAINERS: update riscv/microchip entry

 .../bindings/gpio/microchip,mpfs-gpio.yaml    |  79 ++++++
 ...ilbox.yaml => microchip,mpfs-mailbox.yaml} |   6 +-
 .../bindings/pwm/microchip,corepwm.yaml       |  81 ++++++
 .../bindings/rtc/microchip,mfps-rtc.yaml      |  58 ++++
 .../microchip,mpfs-sys-controller.yaml        |  40 +++
 ...icrochip,polarfire-soc-sys-controller.yaml |  35 ---
 MAINTAINERS                                   |   2 +
 .../dts/microchip/microchip-mpfs-fabric.dtsi  |  25 ++
 .../microchip/microchip-mpfs-icicle-kit.dts   | 115 ++++++--
 .../boot/dts/microchip/microchip-mpfs.dtsi    | 254 ++++++++++++++----
 10 files changed, 591 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
 rename Documentation/devicetree/bindings/mailbox/{microchip,polarfire-soc-mailbox.yaml => microchip,mpfs-mailbox.yaml} (82%)
 create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
 create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi

-- 
2.35.1

