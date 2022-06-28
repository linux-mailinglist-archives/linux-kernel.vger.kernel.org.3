Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4852755E98F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbiF1NtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbiF1NtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:49:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0AB19003
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656424147; x=1687960147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Mfoa7XBIJajd+Vj3ReaDjEFsciZ6yUYqRM9HOhXHq4=;
  b=hQVgtY9hao9IjldXyHRHfCe6/8APWeaU3yLbbTlUGMSM9wO4G4qKvkMC
   bNpBzllkI0CZktcTle4lb1K+8ztUzBVn69UP962qOGzLGfW7T/15BV2lb
   juSl3WsjoGUggwd7tUAFbvHjwJ8HPoUjpnMI+T4HH7/ejTEncNiW8/SWe
   3U3Cp8hX+KFPPkUgi8vCx5EeT6GyNKIIHYClkWscT1Z7q77SY4ty91g1g
   QlQ8xDPIEHbh74upXG7HCGerz9uhn07YXzfLSRajwQ8ya+fsKRAxOTkTS
   GxMkxc2TkHZSBS59AuK08sYeJDx7gZBO3RkWQmFB53a60KDG2aAiZ7JIX
   w==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="162404105"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 06:49:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 06:49:03 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 06:49:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <arm@kernel.org>,
        <soc@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ARM: at91: fixes for 5.19
Date:   Tue, 28 Jun 2022 16:51:30 +0300
Message-ID: <20220628135130.3114878-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnd, Olof, ARM SoC maintainers,

Please pull the following AT91 fixes for 5.19.

Thank you,
Claudiu Beznea

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/ tags/at91-fixes-5.19

for you to fetch changes up to 91d60e259c0f58c855f88f3fe5b7909aec563525:

  ARM: at91: pm: Mark at91_pm_secure_init as __init (2022-06-28 12:55:32 +0300)

----------------------------------------------------------------
AT91 fixes for 5.19

It contains 3 SoC fixes and 2 DT fixes:
SoC:
- fix the wakeup from RTC and RTT for ULP1 mode
- fix section mismatch warning
- fix SAM9X60 SiP detection

DT:
- fixes the EEPROMs compatibles for sama5d2_icp and sam9x60ek and EEPROM
  size for sam9x60ek

----------------------------------------------------------------
Claudiu Beznea (3):
      ARM: at91: pm: use proper compatible for sama5d2's rtc
      ARM: at91: pm: use proper compatibles for sam9x60's rtc and rtt
      ARM: at91: pm: use proper compatibles for sama7g5's rtc and rtt

Eugen Hristev (2):
      ARM: dts: at91: sam9x60ek: fix eeprom compatible and size
      ARM: dts: at91: sama5d2_icp: fix eeprom compatibles

Fabio Estevam (1):
      ARM: at91: pm: Mark at91_pm_secure_init as __init

Mihai Sain (1):
      ARM: at91: fix soc detection for SAM9X60 SiPs

 arch/arm/boot/dts/at91-sam9x60ek.dts   |  3 +--
 arch/arm/boot/dts/at91-sama5d2_icp.dts |  6 +++---
 arch/arm/mach-at91/pm.c                | 12 ++++++------
 drivers/soc/atmel/soc.c                | 12 ++++++------
 4 files changed, 16 insertions(+), 17 deletions(-)
