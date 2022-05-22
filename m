Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF98F530453
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349455AbiEVP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349184AbiEVP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:58:23 -0400
Received: from herzl.nuvoton.co.il (unknown [212.199.177.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB53B296;
        Sun, 22 May 2022 08:58:17 -0700 (PDT)
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 24MFotZs031609;
        Sun, 22 May 2022 18:50:55 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 2AB4663A4A; Sun, 22 May 2022 18:50:55 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 00/19] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Sun, 22 May 2022 18:50:27 +0300
Message-Id: <20220522155046.260146-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset  adds initial support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family. 

The Nuvoton Arbel NPCM8XX SoC is a fourth-generation BMC.
The NPCM8XX computing subsystem comprises a quadcore ARM 
Cortex A35 ARM-V8 architecture.

This patchset adds minimal architecture and drivers such as:
Clocksource, Clock, Reset, and WD.

Some of the Arbel NPCM8XX peripherals are based on Poleg NPCM7XX.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Tomer Maimon (19):
  dt-bindings: timer: npcm: Add npcm845 compatible string
  clocksource: timer-npcm7xx: Add NPCM845 timer support
  dt-bindings: serial: 8250: Add npcm845 compatible string
  tty: serial: 8250: Add NPCM845 UART support
  dt-bindings: watchdog: npcm: Add npcm845 compatible string
  watchdog: npcm_wdt: Add NPCM845 watchdog support
  dt-binding: clk: npcm845: Add binding for Nuvoton NPCM8XX Clock
  clk: npcm8xx: add clock controller
  dt-bindings: reset: add syscon property
  reset: npcm: using syscon instead of device data
  dt-bindings: reset: npcm: Add support for NPCM8XX
  reset: npcm: Add NPCM8XX support
  dt-bindings: arm: npcm: Add maintainer
  dt-bindings: arm: npcm: Add nuvoton,npcm845 compatible string
  dt-bindings: arm: npcm: Add nuvoton,npcm845 GCR compatible string
  arm64: npcm: Add support for Nuvoton NPCM8XX BMC SoC
  arm64: dts: nuvoton: Add initial NPCM8XX device tree
  arm64: dts: nuvoton: Add initial NPCM845 EVB device tree
  arm64: defconfig: Add Nuvoton NPCM family support

 .../devicetree/bindings/arm/npcm/npcm.yaml    |   7 +
 .../bindings/arm/npcm/nuvoton,gcr.yaml        |   2 +
 .../bindings/clock/nuvoton,npcm845-clk.yaml   |  68 ++
 .../bindings/reset/nuvoton,npcm-reset.txt     |  19 +-
 .../devicetree/bindings/serial/8250.yaml      |   1 +
 .../bindings/timer/nuvoton,npcm7xx-timer.yaml |   2 +
 .../bindings/watchdog/nuvoton,npcm-wdt.txt    |   3 +-
 MAINTAINERS                                   |   3 +
 arch/arm64/Kconfig.platforms                  |  11 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 197 +++++
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  |  50 ++
 .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  77 ++
 arch/arm64/configs/defconfig                  |   3 +
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-npcm8xx.c                     | 767 ++++++++++++++++++
 drivers/clocksource/timer-npcm7xx.c           |   1 +
 drivers/reset/reset-npcm.c                    | 164 +++-
 drivers/tty/serial/8250/8250_of.c             |   1 +
 drivers/watchdog/npcm_wdt.c                   |   1 +
 .../dt-bindings/clock/nuvoton,npcm8xx-clock.h |  50 ++
 .../dt-bindings/reset/nuvoton,npcm8xx-reset.h | 124 +++
 24 files changed, 1526 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
 create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
 create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
 create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
 create mode 100644 drivers/clk/clk-npcm8xx.c
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
 create mode 100644 include/dt-bindings/reset/nuvoton,npcm8xx-reset.h

-- 
2.33.0

