Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C128B5261AB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380191AbiEMMRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380186AbiEMMR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:17:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7E29B02A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652444243; x=1683980243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=801V6lsXCptv+F1vOY2jyhDHT7zZq1ih5XI439rzglc=;
  b=yOws5y3v9wLTEd884l+PaiZAPt59J6Dg3MXUfBCiMNuVpdzwZMLJ4PyP
   KdThDlheeZ5uP/FveHHOlVleF9ylNLf/J/KWxzL5f27nx+VcPCebaJk1f
   8+SY80srjbaoSVVwDWa+XZNY+RqPVhg2jBjxH5LNDreg3nUIrWoq7XVG1
   he3Hzbk/JjRUA9UEDOx2o16wWlF1ups2MjfoS2jbKIgWRwwaUFvvsDVHB
   SZ16J4PbnaHYJJth9CwEwnZXRzwBfeuTb6BzDUieIffwBpH04vNNsmlhw
   IwRAzaLh6dutMRoWXx2xBMt6lMDRIT+Qk2GI041vY1odrULlZ+X74fv+u
   A==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="163935065"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 05:17:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 05:17:22 -0700
Received: from ROU-LT-M43238L.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 13 May 2022 05:17:19 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <kavyasree.kotagiri@microchip.com>, <clement.leger@bootlin.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: soc for 5.19
Date:   Fri, 13 May 2022 14:17:01 +0200
Message-ID: <20220513121701.77683-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the at91 and Polarfire soc changes for 5.19.
Thanks to Claudiu who did most of the work collecting the patches for this
pull-request!

Please pull.

Thanks, best regards,
  Nicolas

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-soc-5.19

for you to fetch changes up to 6041558ebf1fc87d1e0bdeb51e985807dab06bed:

  ARM: at91: debug: add lan966 support (2022-05-13 13:42:03 +0200)

----------------------------------------------------------------
AT91 & POLARFIRE SoC #1 for 5.19:

- Power Management: add possibility to implement
  specific pm quirks for some SoCs
- Kconfig update for AT91 PIT64 and LAN966 low-level debugging
- sama5d2: add secure calls to OP-TEE and secure suspend

----------------------------------------------------------------
Claudiu Beznea (5):
      ARM: at91: pm: keep documentation inline with structure members
      ARM: at91: pm: introduce macros for pm mode replacement
      ARM: at91: pm: use kernel documentation style
      ARM: at91: pm: add quirks for pm
      ARM: at91: Kconfig: implement PIT64B selection

Clément Léger (2):
      ARM: at91: add code to handle secure calls
      ARM: at91: pm: add support for sama5d2 secure suspend

Kavyasree Kotagiri (1):
      ARM: at91: debug: add lan966 support

 arch/arm/Kconfig.debug          |  22 ++
 arch/arm/mach-at91/Kconfig      |  20 +-
 arch/arm/mach-at91/Makefile     |   2 +-
 arch/arm/mach-at91/pm.c         | 431 ++++++++++++++++++++++++++++++++---
 arch/arm/mach-at91/sam_secure.c |  46 ++++
 arch/arm/mach-at91/sam_secure.h |  18 ++
 arch/arm/mach-at91/sama5.c      |   2 +
 7 files changed, 506 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-at91/sam_secure.c
 create mode 100644 arch/arm/mach-at91/sam_secure.h

-- 
Nicolas Ferre
