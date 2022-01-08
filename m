Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61911488282
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiAHImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:42:25 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:35571 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiAHImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:42:22 -0500
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Sat, 8 Jan 2022
 16:42:20 +0800
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
Subject: [PATCH 0/4] irqchip/meson-gpio: Add support for Meson-S4 SoC
Date:   Sat, 8 Jan 2022 16:42:14 +0800
Message-ID: <20220108084218.31877-1-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for GPIO interrupt controller of Meson-S4 SoC
Which has somethings different with current other meson chips. To
support the new chips, current gpio irqchip driver need to rework as
below:
1. support more than 8 gpio irq line.
2. add a set trigger type callback function.

With above work, add support for S4 gpio irqchip

Qianggui Song (4):
  dt-bindings: interrupt-controller: New binding for Meson-S4 SoCs
  irqchip/meson-gpio: support more than 8 channels gpio irq line
  irqchip/meson-gpio: add select trigger type callback
  irqchip/meson-gpio: Add support for meson s4 SoCs

 .../amlogic,meson-gpio-intc.txt               |  1 +
 drivers/irqchip/irq-meson-gpio.c              | 97 ++++++++++++++++---
 2 files changed, 86 insertions(+), 12 deletions(-)

-- 
2.34.1

