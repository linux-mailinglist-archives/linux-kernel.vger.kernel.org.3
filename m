Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B84583833
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiG1FnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiG1FnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:43:21 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5056BA2;
        Wed, 27 Jul 2022 22:43:20 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Thu, 28 Jul 2022
 13:43:17 +0800
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
Subject: [PATCH V2 0/3] Add S4 SoC clock controller driver
Date:   Thu, 28 Jul 2022 13:41:59 +0800
Message-ID: <20220728054202.6981-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add clock controller driver for S4 SOC.

Yu Tu (3):
  dt-bindings: clk: meson: add S4 SoC clock controller bindings
  arm64: dts: meson: add S4 Soc clock controller in DT
  clk: meson: s4: add s4 SoC clock controller driver

V1 -> V2: Change format as discussed in the email.

Link:https://lore.kernel.org/linux-amlogic/20220708062757.3662-1-yu.tu@amlogic.com/

 .../bindings/clock/amlogic,gxbb-clkc.txt      |    1 +
 MAINTAINERS                                   |    1 +
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   11 +
 drivers/clk/meson/Kconfig                     |   15 +
 drivers/clk/meson/Makefile                    |    1 +
 drivers/clk/meson/s4.c                        | 4732 +++++++++++++++++
 drivers/clk/meson/s4.h                        |  296 ++
 include/dt-bindings/clock/s4-clkc.h           |  146 +
 8 files changed, 5203 insertions(+)
 create mode 100644 drivers/clk/meson/s4.c
 create mode 100644 drivers/clk/meson/s4.h
 create mode 100644 include/dt-bindings/clock/s4-clkc.h


base-commit: b293bc9286ee21824e93f0fcfed3b78fdfee01e6
-- 
2.33.1

