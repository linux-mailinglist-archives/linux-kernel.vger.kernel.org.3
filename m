Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23299473AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbhLNCgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:36:08 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:20270 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLNCgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:36:07 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 21:36:06 EST
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Tue, 14 Dec 2021
 10:21:02 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] pinctrl: meson-s4: add pinctrl driver
Date:   Tue, 14 Dec 2021 10:20:57 +0800
Message-ID: <20211214022100.14841-1-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Pin controller driver support for Meson-S4 SoC
which shares the same register layout with previous Meson-A1

Qianggui Song (3):
  dt-bindings: pinctrl: meson: Add compatible for S4
  dt-bindings: gpio: Add a header file for Amlogic Meson S4
  pinctrl: meson: add pinctrl driver support for Meson-S4 Soc

 .../bindings/pinctrl/meson,pinctrl.txt        |    1 +
 drivers/pinctrl/meson/Kconfig                 |    6 +
 drivers/pinctrl/meson/Makefile                |    1 +
 drivers/pinctrl/meson/pinctrl-meson-s4.c      | 1229 +++++++++++++++++
 include/dt-bindings/gpio/meson-s4-gpio.h      |   99 ++
 5 files changed, 1336 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-s4.c
 create mode 100644 include/dt-bindings/gpio/meson-s4-gpio.h

-- 
2.34.1

