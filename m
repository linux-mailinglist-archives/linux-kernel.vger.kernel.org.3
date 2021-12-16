Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8447740F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbhLPOLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:11:44 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10982 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbhLPOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639663900; x=1671199900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ETLnfefiwEYOdcgZaQpwwBczz13QcWsMBfwE7C7NDns=;
  b=pC8ekzu2hDt8EaATnQcgkTWv0xCp7WaOLtuXjfXU3lAby5oFMh6T5Vig
   1KgyBtHVjH/ZGV4NqPkUa6vKpxpr9+AkL82oEyg6/jjNgcy7XVEhrcI3p
   7UZ9eAsiryy5uM1sI8h4eUa+Cmy8q42eDx5onyHso5RQm7SCApQZNNxTz
   mScqqXbyRV0V+1dRucioesaM6tIFyPCDPG8WShJ0f4rDjJwq6PsttQ7ki
   anSA3OeyTuMEdRE0CkMzs/NKRUq4P2RaJwIlSEw9ebNPJHFG0JUkmx6+N
   2w8fEhAbxPaa3PwwRy1lSFiQe6P5Z0q/ffQAQPfrhsh20G8I+UrUhJ4Wc
   A==;
IronPort-SDR: srvkGP2fxoT2yxO7Jus8qyfLvgbgbOAGwDXtdZ0fXSYJCzi1YRcQTBIzFXxNtX04C/gtaYxrIM
 IIZEo9GJzS5qSpaCwmmh4Hylpr7qAiymgBM7Sqd6KC1msgub2MD/rbZzAlzKOUwwoEqJBcGvQq
 n1DkfcUBGfvbQmn1H9y90r60YvI1sWGP9wbBiZfu+0MMztUb0ZaruVeZ9HBVQ+MxyKoYgAHjqa
 Oa+kZp7ivwTGKqYEjNsDeewCQwZ1ftHKblxuxGRsYsRTOjXLV/RIVBE+HqIjDK43eSk8H+n82W
 A6vdBMOqjM94MMwLb3UQB+Cr
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="147461459"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2021 07:11:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 07:11:39 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Dec 2021 07:11:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] ARM: at91: Kconfig: select PM_OPP
Date:   Thu, 16 Dec 2021 16:13:35 +0200
Message-ID: <20211216141338.35144-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216141338.35144-1-claudiu.beznea@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
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

