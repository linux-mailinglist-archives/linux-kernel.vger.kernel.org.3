Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBEE49353A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351877AbiASHIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:08:14 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:18131 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiASHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:08:14 -0500
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Wed, 19 Jan 2022
 15:08:12 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/4] irqchip/meson-gpio: Add support for Meson-S4 SoC
Date:   Wed, 19 Jan 2022 15:08:05 +0800
Message-ID: <20220119070809.15563-1-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for GPIO interrupt controller of Meson-S4 SoC
Which has something different with current other meson chips. To
support the new chips, current gpio irqchip driver need to rework as
below:
1. support more than 8 gpio irq lines.
2. add a set trigger type callback function.

With above work, add support for S4 gpio irqchip

Changes since v1 at [0]:
- fix leaking issue
- fix some typos
- change implementation of new feature.

[0] https://lore.kernel.org/linux-amlogic/20220108084218.31877-1-qianggui.song@amlogic.com/

Qianggui Song (4):
  dt-bindings: interrupt-controller: New binding for Meson-S4 SoCs
  irqchip/meson-gpio: support more than 8 channels gpio irq line
  irqchip/meson-gpio: add select trigger type callback
  irqchip/meson-gpio: Add support for meson s4 SoCs

 .../amlogic,meson-gpio-intc.txt               |   1 +
 drivers/irqchip/irq-meson-gpio.c              | 105 ++++++++++++++++--
 2 files changed, 97 insertions(+), 9 deletions(-)

-- 
2.34.1

