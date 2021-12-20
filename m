Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787EC47A5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhLTISx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:18:53 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3983 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhLTISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639988332; x=1671524332;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ISW5FkR//LYmJW1LVpg55ZKZkD0EVr7TmFhR8/yLhh0=;
  b=uB/hFe52bWopHxvvTN+M4zcQqIaauL4zNzYnHkQIYvjvIirsgAwS1fMN
   jVcsfbH0Yne+Jbo6fqQtOu4hXphQ4JWIwRl/E2yoGzjQWHAsCBwHYZwEe
   WHRXaNdRe2NqJNMrYMSX8da2dHxR8LpANlj6+V2AvvMQ/c+VyM/NfvlIC
   YhgNDDRkxsIiiVUdDLTMBPtX0VF1uYuSvDsSbV1dV5mS0PQUgdgqlUFNp
   Z2NANiny+1v4I9uwrScD32oc4pRyQrqqw526aLy4e8LiDb1sbuh++LMvF
   MvjtLF86mnvyuwTwgWxjvk/t/DawICeR0XV8EXyJR6YXJeJSkW3FdUFvN
   w==;
IronPort-SDR: T9WJgY+YiPzajydBuXNayNkmGQnueWYu0BBe7aEYd8+dcVUQuIEOXOnbpB4Pc05lw5uDnHzzGS
 I2CgZf8WKGmZNWWBz0ds++M6/aQtlnJjK/WEDjPjIYQhz6BvI89g+bT6K32jRfPaEYX5Q1kjOZ
 i8Eq+Mq959DCWK3l20T7FX6Nve8rQjQrI7k+QaPI6VzcWpyYGBh/23eEBv7icVzYF6SrCvP9jm
 /ljDZP5DhaDgPRqayFh1mx05YMtK+9iXZK95/FbJaZ8T8OPjHI/rcI0fx3QG1agzs/DR4V8NmE
 XTbt0woaiwmy16RN68lNUaBm
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="147786972"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2021 01:18:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 01:18:50 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 20 Dec 2021 01:18:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5: fix compilation warning
Date:   Mon, 20 Dec 2021 10:20:58 +0200
Message-ID: <20211220082058.21687-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compilation warning:
"Warning (unit_address_vs_reg): /memory: node has a reg or ranges
property, but no unit name".

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 8961d2851df3..cc75d0593729 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -108,7 +108,7 @@ map1 {
 	};
 
 	/* 512 M */
-	memory {
+	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x20000000>;
 	};
-- 
2.32.0

