Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB73048947B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbiAJI5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:57:35 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:24076 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbiAJI5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:57:06 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Mon, 10 Jan 2022
 16:56:49 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V4 0/5] the UART driver compatible with
Date:   Mon, 10 Jan 2022 16:55:59 +0800
Message-ID: <20220110085604.18042-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the common Clock code to describe the UART baud rate
clock makes it easier for the UART driver to be compatible
with the baud rate requirements of the UART IP on different
meson chips. Add Meson S4 SoC compatible.

Yu Tu (5):
  dt-bindings: serial: meson: Drop compatible = amlogic,meson-gx-uart.
  tty: serial: meson: Request the register region in meson_uart_probe()
  tty: serial: meson: The UART baud rate calculation is described using
    the common clock code.
  tty: serial: meson: Make the bit24 and bit [26,27] of the UART_REG5
    register writable
  tty: serial: meson: Added S4 SOC compatibility.

V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
discussed in the email
V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
the DTS before it can be deleted
V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
in the email.

Link:https://lore.kernel.org/linux-amlogic/20211230102110.3861-4-yu.tu@amlogic.com/

 .../bindings/serial/amlogic,meson-uart.yaml   |  10 +-
 drivers/tty/serial/meson_uart.c               | 244 ++++++++++++------
 2 files changed, 177 insertions(+), 77 deletions(-)

-- 
2.33.1

