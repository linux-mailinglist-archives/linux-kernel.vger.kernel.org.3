Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479864C447C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiBYMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiBYMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:20:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542051C3D24
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645791594; x=1677327594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YhgrNVrQwjQIynq2blNcMbH5depjlPJlQS23JcppBuY=;
  b=sU4IASAgSsMyL9Tdfc1FGqnwG4b7+f0JZqw9H0Z8/JA19YP6b/hc4/tW
   +/p6/ZUCcBFLJyAybZDEc4zxOcnGbul2EZpa1QOQ5ByH1bOWm4qi3+g8W
   iVm5p6X0Tsf7Z/wzk+2U32zUtRcaRint7KyKCwHTMqS5aav4gZdgXf8+8
   DHkI5Uq3qKyNSk0aBBOL+YCDO+I+fLh7MbOIGFq4fEZ/y6qjudbsAUGc9
   qdGba4utjyvMU97b4qlmfEenzPa44XrWG0zQwAzTEiYM59REo+YVwdU3j
   9+7LiBV9rt13R1RgAj9DHrmJ7AVmJr/+59c+9I8k1kRKQ+fRJ5sk6NY3D
   w==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="87014336"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 05:19:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 05:19:53 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 05:19:50 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [GIT PULL] ARM: at91: soc for 5.18
Date:   Fri, 25 Feb 2022 13:19:43 +0100
Message-ID: <20220225121943.71494-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the soc changes for 5.18 for two MPU families from Microchip: AT91 and
Polarfire as we agreed with Conor and discussed with Arnd.

Please pull. Thanks, best regards,
  Nicolas

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-soc-5.18

for you to fetch changes up to d0054a470c33902f5ae88835ed8a8ecc3cf8faa4:

  soc: add microchip polarfire soc system controller (2022-02-25 12:50:59 +0100)

----------------------------------------------------------------
AT91 & POLARFIRE SoC #1 for 5.18:

- sama7g5: CPU idle support with CPUFreq operating points defined in DT
- polarfire: addition of the soc system controller

----------------------------------------------------------------
Claudiu Beznea (5):
      ARM: at91: ddr: remove CONFIG_SOC_SAMA7 dependency
      ARM: at91: ddr: align macro definitions
      ARM: at91: ddr: fix typo to align with datasheet naming
      ARM: at91: PM: add cpu idle support for sama7g5
      ARM: at91: Kconfig: select PM_OPP

Conor Dooley (1):
      soc: add microchip polarfire soc system controller

 arch/arm/mach-at91/Kconfig                  |   1 +
 arch/arm/mach-at91/pm.c                     |  27 +++-
 arch/arm/mach-at91/pm_suspend.S             |   4 +-
 drivers/soc/Kconfig                         |   1 +
 drivers/soc/Makefile                        |   1 +
 drivers/soc/microchip/Kconfig               |  10 ++
 drivers/soc/microchip/Makefile              |   1 +
 drivers/soc/microchip/mpfs-sys-controller.c | 194 ++++++++++++++++++++++++++++
 include/linux/clk/at91_pmc.h                |   4 +
 include/soc/at91/sama7-ddr.h                |  15 +--
 include/soc/microchip/mpfs.h                |   4 +-
 11 files changed, 248 insertions(+), 14 deletions(-)
 create mode 100644 drivers/soc/microchip/Kconfig
 create mode 100644 drivers/soc/microchip/Makefile
 create mode 100644 drivers/soc/microchip/mpfs-sys-controller.c

-- 
Nicolas Ferre
