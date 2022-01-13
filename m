Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2A48DA04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiAMOsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:11 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31589 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiAMOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085285; x=1673621285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8B+mjGEHiWRvOo09WcjQMA43OD+N7/Tq2fPJzC7/86M=;
  b=QVs41uZG8auz1+IFt1uF+8xoERLZB51H3OmjBXfdmQvxTyoquz4Uwy8p
   A2HlxetBt3eDfkpynPLoUNtG2iFBUNBJGWtY1QdZvTi4YgMmuUge+3L6Q
   +dOaFf1AeRjNB0JN+H2WEcnPpLD8QUsKaO6MbcxvziqvMu+zuv5zdHxsO
   FLOqCTcl7uldpvX+1wm2NuUddU2uF9FBHtVqz3B0ESLp9YbixD8TdOTx3
   sUuJ/DazXScOh5YrFr55ZoiSBftZzNwJUn1p1p+qhncid6Vu1GlcbIl3t
   d2kyQzGVuQBSaDPCEQm7TD4w1XyqMT340GhDItBXDvCUviOf8+CKwJF3Y
   A==;
IronPort-SDR: x5fH9fXkDlx/sXNG4ZpdDTYwDS6Je59q4Tu3bZITHBYf86MfWCalZcTv97QA90DW9pSdw0ctPV
 0ZHmWspbloYi6m9cGbAub9oQz8OYCpcy1YNhMykZSm/noZuu2P8r5vqeMY5/VqFxp4sAOCojBP
 YHfQe54NS24//kf7r+ykoDTzdjHaPAFwgyoVEmUAFTTohDzFoI4q6Ag4OAmjzzInw8ld0jBFym
 32Lp7AB1v36lyP4CVkAxtfWV02AA/DOYylpP1MDjdw+czk9F5EDDyRcFO06pryfIjYQ+JwPa7e
 0uwQPYAeCVVf7Npt6DF6VVGl
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="158557508"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:48:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:48:04 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:48:02 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 03/10] ARM: at91: ddr: fix typo to align with datasheet naming
Date:   Thu, 13 Jan 2022 16:48:53 +0200
Message-ID: <20220113144900.906370-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo on UDDRC_PWRCTL.SELFREF_SW bitmask to align with datasheet
naming.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 4 ++--
 include/soc/at91/sama7-ddr.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index fdb4f63ecde4..abe4ced33eda 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -159,7 +159,7 @@ sr_ena_1:
 
 	/* Switch to self-refresh. */
 	ldr	tmp1, [r2, #UDDRC_PWRCTL]
-	orr	tmp1, tmp1, #UDDRC_PWRCTRL_SELFREF_SW
+	orr	tmp1, tmp1, #UDDRC_PWRCTL_SELFREF_SW
 	str	tmp1, [r2, #UDDRC_PWRCTL]
 
 sr_ena_2:
@@ -276,7 +276,7 @@ sr_dis_5:
 
 	/* Trigger self-refresh exit. */
 	ldr	tmp1, [r2, #UDDRC_PWRCTL]
-	bic	tmp1, tmp1, #UDDRC_PWRCTRL_SELFREF_SW
+	bic	tmp1, tmp1, #UDDRC_PWRCTL_SELFREF_SW
 	str	tmp1, [r2, #UDDRC_PWRCTL]
 
 sr_dis_6:
diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
index 817b360efbb8..fee1b11bddca 100644
--- a/include/soc/at91/sama7-ddr.h
+++ b/include/soc/at91/sama7-ddr.h
@@ -53,7 +53,7 @@
 #define		UDDRC_STAT_OPMODE_MSK		(0x7 << 0)	/* Operating mode mask */
 
 #define UDDRC_PWRCTL				(0x30)		/* UDDRC Low Power Control Register */
-#define		UDDRC_PWRCTRL_SELFREF_SW	(1 << 5)	/* Software self-refresh */
+#define		UDDRC_PWRCTL_SELFREF_SW		(1 << 5)	/* Software self-refresh */
 
 #define UDDRC_DFIMISC				(0x1B0)		/* UDDRC DFI Miscellaneous Control Register */
 #define		UDDRC_DFIMISC_DFI_INIT_COMPLETE_EN (1 << 0)	/* PHY initialization complete enable signal */
-- 
2.32.0

