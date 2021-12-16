Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969C347741D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbhLPOMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:12:53 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:20899 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbhLPOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639663909; x=1671199909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lEArm4L3rzKNYcbWHVsHPV1Ug//Fk01TwtXeWoxZlLg=;
  b=ZTVxWEFsx5aTor5LjjViqCY+mrIjsWV2jNpKs6dHOJbgIlqTcOJS6Y+F
   iPf+0NNb//AI0xWeQnAtbhV60+6wI60u0XGJMJkSrUb5hmRZLBWZEyjSC
   X4KrPun4VGiU4XpZDneOkvCHdvz5LR4Z6gHCilKfxOpucJkC974Gx61un
   MsqP9H6YpBmjzI4v9gMuPQLSC5Ov8banScf0FtzCsWJzftkU1/vVPNH0m
   gxKmCrjqRv26V7McreMLrp+4P8hH6VrJ+EHSxNEXbiJxhpp4idGsOmdXg
   K1IN+dSg9GzMCxUySN+gyqiIEm+p61AMGysYDPylx8TBBkF+oKBw2NMWc
   w==;
IronPort-SDR: nqZB61dQLUey6GePl0xOp+5+bV9UZEjJ1Ytzslfo3ZG3NCT9u7w57eT7Rj9UgzAhXv4hRovO/+
 GmipbgXHXVyENecP5cvHl97jScRz4L5s1LArShujTQxbaqzlot7PuWRFGablpMXJyJj47aleah
 XKNR92zTenEdf0wG0vwfBGZeDQChS972MLvW91bF7m2UR6Y7hhPvin3N5uBVeztW+AzaVrao3p
 cFD1QujCPVo3fxWe3RneTH19QcVjeCXTwJpaRSLhE9kgKqPgiXYYXn8Qnopmr9OiLEpnOBiFSd
 MJ2nWjG6KYIYCEk2jXrE3xcY
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="146894028"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2021 07:11:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 07:11:48 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Dec 2021 07:11:45 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] ARM: configs: at91: sama7: add config for cpufreq
Date:   Thu, 16 Dec 2021 16:13:38 +0200
Message-ID: <20211216141338.35144-9-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216141338.35144-1-claudiu.beznea@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add config flags for CPUFreq. This includes enabling CPUFreq support,
CPUFreq DT driver and governors, default one being the conservative
governor.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 95c2a7ed4816..689e9afcb5b2 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -26,6 +26,12 @@ CONFIG_FORCE_MAX_ZONEORDER=15
 CONFIG_UACCESS_WITH_MEMCPY=y
 # CONFIG_ATAGS is not set
 CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk ignore_loglevel"
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
2.32.0

