Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFA946CA16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbhLHBiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:38:55 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:28137 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbhLHBix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:38:53 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1B818lbH089266;
        Wed, 8 Dec 2021 09:08:47 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Dec 2021 09:33:45 +0800
From:   Tommy Haung <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>, tommy-huang <tommy_huang@aspeedtech.com>
Subject: [PATCH v5 6/7] arm:boot:dts:aspeed-g6 Add more gfx reset control
Date:   Wed, 8 Dec 2021 09:33:36 +0800
Message-ID: <20211208013337.13806-7-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
References: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1B818lbH089266
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tommy-huang <tommy_huang@aspeedtech.com>

Add more gfx reset control for ast2600.

Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index e38c3742761b..b92b24609660 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -356,7 +356,9 @@
 				reg = <0x1e6e6000 0x1000>;
 				reg-io-width = <4>;
 				clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
-				resets = <&syscon ASPEED_RESET_GRAPHICS>;
+				resets = <&syscon ASPEED_RESET_CRT>,
+					 <&syscon ASPEED_RESET_GRAPHICS>;
+				reset-names = "crt", "engine";
 				syscon = <&syscon>;
 				status = "disabled";
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

