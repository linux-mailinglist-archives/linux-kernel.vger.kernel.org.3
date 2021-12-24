Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DF047EF92
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352927AbhLXO3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:29:48 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:9063 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352862AbhLXO3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:29:43 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="105108379"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 23:29:40 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 96CD34000ABD;
        Fri, 24 Dec 2021 23:29:39 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-serial@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 00/10] serial: Use platform_get_irq*() variants to fetch IRQ's
Date:   Fri, 24 Dec 2021 14:29:06 +0000
Message-Id: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series aims to drop using platform_get_resource() for IRQ types
in preparation for removal of static setup of IRQ resource from DT core
code.

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (10):
  serial: altera: Use platform_get_irq_optional() to get the interrupt
  serial: 8250_bcm7271: Use platform_get_irq() to get the interrupt
  serial: 8250_bcm7271: Propagate error codes from brcmuart_probe()
  serial: meson: Use platform_get_irq() to get the interrupt
  serial: pxa: Use platform_get_irq() to get the interrupt
  serial: altera_jtaguart: Use platform_get_irq_optional() to get the
    interrupt
  serial: vt8500: Use platform_get_irq() to get the interrupt
  serial: ar933x: Use platform_get_irq() to get the interrupt
  serial: bcm63xx: Use platform_get_irq() to get the interrupt
  serial: pmac_zilog: Use platform_get_irq() to get the interrupt

 drivers/tty/serial/8250/8250_bcm7271.c | 23 +++++++++++++----------
 drivers/tty/serial/altera_jtaguart.c   | 11 +++++++----
 drivers/tty/serial/altera_uart.c       |  9 +++++----
 drivers/tty/serial/ar933x_uart.c       | 12 +++++-------
 drivers/tty/serial/bcm63xx_uart.c      | 10 +++++-----
 drivers/tty/serial/meson_uart.c        | 11 ++++++-----
 drivers/tty/serial/pmac_zilog.c        | 12 ++++++++----
 drivers/tty/serial/pxa.c               | 12 ++++++++----
 drivers/tty/serial/vt8500_serial.c     | 12 ++++++++----
 9 files changed, 65 insertions(+), 47 deletions(-)

-- 
2.17.1

