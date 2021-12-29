Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E328D481024
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 06:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhL2FoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 00:44:01 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:54478 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhL2Fn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 00:43:56 -0500
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24953:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Wed, 29 Dec 2021 13:43:09 +0800 (CST)
From:   Xiantao Hu <xt.hu@cqplus1.com>
To:     wim@linux-watchdog.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     wells.lu@sunplus.com, qinjian@cqplus1.com,
        Xiantao Hu <xt.hu@cqplus1.com>
Subject: [PATCH v4 0/2] Add watchdog driver for Sunplus SP7021 SoC
Date:   Wed, 29 Dec 2021 13:43:06 +0800
Message-Id: <20211229054308.63168-1-xt.hu@cqplus1.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for watchdog driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Xiantao Hu (2):
  watchdog: Add Sunplus SP7021 WDT devicetree bindings documentation
  watchdog: Add watchdog driver for Sunplus SP7021

 .../bindings/watchdog/sunplus,sp7021-wdt.yaml |  47 +++
 MAINTAINERS                                   |   7 +
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/sunplus_wdt.c                | 278 ++++++++++++++++++
 5 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
 create mode 100644 drivers/watchdog/sunplus_wdt.c

-- 
2.33.1

