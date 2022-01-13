Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD248DA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiAMOsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49479 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiAMOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085293; x=1673621293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ETLnfefiwEYOdcgZaQpwwBczz13QcWsMBfwE7C7NDns=;
  b=D68I5aWoBljAth9l1J0FYAZnmsJ0fUsRO4cKDf1wZrD66ziMr6NY5Yyb
   98SwDAtpfUH8uP56D3HniFf/MVzNhiG/r9bc4TPO9ttezjNE6Fwp1K6Wz
   JjVLbr4MtTCiWlf2txYTitnK04bcuz6GGCXz7Tcn6pehiUM/ShtNUiigX
   ukDpUpdl00DyXVhH9d3NBf4nQm9oN6i+xs4GsyGhG97pg5RGjYgKNO98M
   ooFtNXXGfLc4Y+bPyUBianLIdlvEe9Clb+0KWmsc+4bs4/H1PBUkxJLbL
   QbyjKscQsOh0alyf46ls2PwsY6YxQwZWjm7+SFGNBecSwwTHNc89NX9mt
   g==;
IronPort-SDR: Mg7DNJx4adEtCFggnFGvM+9W9ev5zIVUBoV9cxUPHIUiarrw/vAM7BfCJsg9Ze9bojFhqxyJq+
 YmIBflWMehGz9rZy9JXqxoxQVExkCzKhCPdY9cyZtUlB1N280lSo3NTr8ZDJJJVAGg/cvcyrUI
 FdroKqPRo2vgP3bkMEANIYDWsm+dkT5s4QHxBbd9h4Spd7rtCbUTnJqT4wrNspbBqaCnA3oOdN
 +Btuy4slUxG77EZWTSiX5Jb/qtE+FI8T2O4hO0gc4NlV2sBofuHAMo/0VilQqRWX4DMV1I5xgB
 tOExXO55u0fl06HdCW9ukuid
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="149553977"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:48:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:48:10 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:48:08 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 05/10] ARM: at91: Kconfig: select PM_OPP
Date:   Thu, 13 Jan 2022 16:48:55 +0200
Message-ID: <20220113144900.906370-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select PM_OPP. This is requested for CPUFreq driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 02f6b108fd5d..279810381256 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -63,6 +63,7 @@ config SOC_SAMA7G5
 	select HAVE_AT91_GENERATED_CLK
 	select HAVE_AT91_SAM9X60_PLL
 	select HAVE_AT91_UTMI
+	select PM_OPP
 	select SOC_SAMA7
 	help
 	  Select this if you are using one of Microchip's SAMA7G5 family SoC.
-- 
2.32.0

