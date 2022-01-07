Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469E1487099
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbiAGCkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:40:02 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:12313 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbiAGCkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:40:02 -0500
Received: from droid10-sz.amlogic.com (10.28.8.20) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 7 Jan 2022
 10:39:58 +0800
From:   Zelong Dong <zelong.dong@amlogic.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <khilman@baylibre.com>, <narmstrong@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 0/3] reset: meson-s4: add reset driver
Date:   Fri, 7 Jan 2022 10:39:28 +0800
Message-ID: <20220107023931.13251-1-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.20]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset adds Reset controller driver support for Meson-S4 SoC.
Meson-S4 Reset Controller has 6 banks (the number of reset register)
and the level-reset register offset is 0x40.


Zelong Dong (3):
  dt-bindings: reset: Add compatible for Meson-S4 Reset Controller
  dt-bindings: reset: add bindings for the Meson-S4 SoC Reset Controller
  reset: reset-meson: add support for the Meson-S4 SoC Reset Controller

 .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
 drivers/reset/reset-meson.c                   |   6 +
 .../reset/amlogic,meson-s4-reset.h            | 125 ++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-s4-reset.h

-- 
2.34.1

