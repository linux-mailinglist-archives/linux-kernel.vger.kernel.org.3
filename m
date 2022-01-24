Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8D4976E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbiAXBos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:44:48 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:10783 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiAXBor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:44:47 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20O1acU0011857;
        Mon, 24 Jan 2022 09:36:38 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWei-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Jan
 2022 09:43:53 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <sfr@canb.auug.org.au>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH next] docs/ABI: testing: aspeed-uart-routing: Escape asterisk
Date:   Mon, 24 Jan 2022 09:43:51 +0800
Message-ID: <20220124014351.9121-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20O1acU0011857
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Escape asterisk symbols to fix the following warning:

"WARNING: Inline emphasis start-string without end-string"

Fixes: c6807970c3bc ("soc: aspeed: Add UART routing support")
Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
index b363827da437..910df0e5815a 100644
--- a/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
+++ b/Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
@@ -1,4 +1,4 @@
-What:		/sys/bus/platform/drivers/aspeed-uart-routing/*/uart*
+What:		/sys/bus/platform/drivers/aspeed-uart-routing/\*/uart\*
 Date:		September 2021
 Contact:	Oskar Senft <osk@google.com>
 		Chia-Wei Wang <chiawei_wang@aspeedtech.com>
@@ -9,7 +9,7 @@ Description:	Selects the RX source of the UARTx device.
 		depends on the selected file.
 
 		e.g.
-		cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
+		cat /sys/bus/platform/drivers/aspeed-uart-routing/\*.uart_routing/uart1
 		[io1] io2 io3 io4 uart2 uart3 uart4 io6
 
 		In this case, UART1 gets its input from IO1 (physical serial port 1).
@@ -17,7 +17,7 @@ Description:	Selects the RX source of the UARTx device.
 Users:		OpenBMC.  Proposed changes should be mailed to
 		openbmc@lists.ozlabs.org
 
-What:		/sys/bus/platform/drivers/aspeed-uart-routing/*/io*
+What:		/sys/bus/platform/drivers/aspeed-uart-routing/\*/io\*
 Date:		September 2021
 Contact:	Oskar Senft <osk@google.com>
 		Chia-Wei Wang <chiawei_wang@aspeedtech.com>
-- 
2.25.1

