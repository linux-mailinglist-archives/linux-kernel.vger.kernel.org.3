Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E158A863
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbiHEI66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiHEI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:58:55 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C543B74E26;
        Fri,  5 Aug 2022 01:58:53 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.9; Fri, 5 Aug 2022
 16:58:51 +0800
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
Subject: [PATCH V3 0/6] Add S4 SoC PLL and Peripheral clock controller
Date:   Fri, 5 Aug 2022 16:57:10 +0800
Message-ID: <20220805085716.5635-1-yu.tu@amlogic.com>
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

V2 -> V3: Use two clock controller.
V1 -> V2: Change format as discussed in the email.

Link:https://lore.kernel.org/all/20220728054202.6981-1-yu.tu@amlogic.com/

 .../bindings/clock/amlogic,s4-clkc.yaml       |   92 +
 .../bindings/clock/amlogic,s4-pll-clkc.yaml   |   51 +
 MAINTAINERS                                   |    1 +
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   34 +
 drivers/clk/meson/Kconfig                     |   25 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/s4-pll.c                    |  891 ++++
 drivers/clk/meson/s4-pll.h                    |   88 +
 drivers/clk/meson/s4.c                        | 3878 +++++++++++++++++
 drivers/clk/meson/s4.h                        |  232 +
 include/dt-bindings/clock/amlogic,s4-clkc.h   |  131 +
 .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |   30 +
 12 files changed, 5455 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/s4-pll.c
 create mode 100644 drivers/clk/meson/s4-pll.h
 create mode 100644 drivers/clk/meson/s4.c
 create mode 100644 drivers/clk/meson/s4.h
 create mode 100644 include/dt-bindings/clock/amlogic,s4-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h


base-commit: 08fc500fe3d4b1f0603fb97ad353f246a3d52d2d
-- 
2.33.1

