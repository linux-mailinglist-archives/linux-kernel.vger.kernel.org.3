Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B2047FAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 09:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhL0IG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 03:06:56 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:59793 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhL0IGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 03:06:55 -0500
Received: from droid09-sz.software.amlogic (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Mon, 27 Dec 2021
 16:06:53 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] pinctrl: meson-s4: add pinctrl driver
Date:   Mon, 27 Dec 2021 16:06:47 +0800
Message-ID: <20211227080649.32275-1-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Pin controller driver support for Meson-A1 Soc
which shares the same register layout with previous Meson-S4

Note that since dt-binding header file patch(already get ack) has been removed
from this patch set, compiling need header file in patch 2 of [0].

Changes since v1 at [0]:
- fix typos in commit message
- fix coding style problem in pinctrl-meson-s4.c
- change tdm groups makeup and split mclk groups

[0] https://lore.kernel.org/linux-amlogic/20211214022100.14841-1-qianggui.song@amlogic.com/

Qianggui Song (2):
  dt-bindings: pinctrl: meson: Add compatible for S4
  pinctrl: meson: add pinctrl driver support for Meson-S4 Soc

 .../bindings/pinctrl/meson,pinctrl.txt        |    1 +
 drivers/pinctrl/meson/Kconfig                 |    6 +
 drivers/pinctrl/meson/Makefile                |    1 +
 drivers/pinctrl/meson/pinctrl-meson-s4.c      | 1289 +++++++++++++++++
 4 files changed, 1297 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-s4.c

-- 
2.34.1

