Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6527A59CE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbiHWC1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiHWC1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:27:34 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BD5B053;
        Mon, 22 Aug 2022 19:27:32 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.9; Tue, 23 Aug 2022
 10:27:30 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V4 0/6] Add S4 SoC PLL and Peripheral clock controller
Date:   Tue, 23 Aug 2022 10:26:24 +0800
Message-ID: <20220823022630.25007-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add PLL and Peripheral clock controller driver for S4 SOC.

Yu Tu (6):
  dt-bindings: clock: meson: add S4 SoC PLL clock controller bindings
  arm64: dts: meson: add S4 Soc PLL clock controller in DT
  clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
  dt-bindings: clk: meson: add S4 SoC peripheral clock controller
    bindings
  arm64: dts: meson: add S4 Soc Peripheral clock controller in DT
  clk: meson: s4: add s4 SoC peripheral clock controller driver

V3 -> V4: change format and clock flags.
V2 -> V3: Use two clock controller.
V1 -> V2: Change format as discussed in the email.

Link:https://lore.kernel.org/all/20220805085716.5635-7-yu.tu@amlogic.com/

 .../clock/amlogic,s4-peripherals-clkc.yaml    |  105 +
 .../bindings/clock/amlogic,s4-pll-clkc.yaml   |   51 +
 MAINTAINERS                                   |    1 +
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   34 +
 drivers/clk/meson/Kconfig                     |   25 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/s4-peripherals.c            | 3813 +++++++++++++++++
 drivers/clk/meson/s4-peripherals.h            |  218 +
 drivers/clk/meson/s4-pll.c                    |  880 ++++
 drivers/clk/meson/s4-pll.h                    |   88 +
 .../clock/amlogic,s4-peripherals-clkc.h       |  131 +
 .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |   30 +
 12 files changed, 5378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/s4-peripherals.c
 create mode 100644 drivers/clk/meson/s4-peripherals.h
 create mode 100644 drivers/clk/meson/s4-pll.c
 create mode 100644 drivers/clk/meson/s4-pll.h
 create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h


base-commit: 08fc500fe3d4b1f0603fb97ad353f246a3d52d2d
-- 
2.33.1

