Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A5491D27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350850AbiARDZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:25:51 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:14899 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353759AbiARDJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:09:58 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Tue, 18 Jan 2022
 11:09:52 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V6 0/5] Use CCF to describe the UART baud rate clock
Date:   Tue, 18 Jan 2022 11:09:06 +0800
Message-ID: <20220118030911.12815-1-yu.tu@amlogic.com>
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
  tty: serial: meson: Move request the register region to probe
  tty: serial: meson: Use devm_ioremap_resource to get register mapped
    memory
  tty: serial: meson: Describes the calculation of the UART baud rate
    clock using a clock frame
  tty: serial: meson: Make some bit of the REG5 register writable
  tty: serial: meson: Added S4 SOC compatibility

V5 -> V6: Change error format as discussed in the email.
V4 -> V5: Change error format.
V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
in the email.
V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
the DTS before it can be deleted
V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
discussed in the email

Link:https://lore.kernel.org/linux-amlogic/20220110104214.25321-4-yu.tu@amlogic.com/

 drivers/tty/serial/meson_uart.c | 217 ++++++++++++++++++++++----------
 1 file changed, 149 insertions(+), 68 deletions(-)


base-commit: 4d66020dcef83314092f2c8c89152a8d122627e2
-- 
2.33.1

