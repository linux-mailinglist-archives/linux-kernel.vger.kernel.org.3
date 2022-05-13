Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6C5266F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382395AbiEMQX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382381AbiEMQXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:23:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA53E0DD
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652459025; x=1683995025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lTvVHKhQrF/jC75hKWqlkRNNj2gcD0kUzpx0or4f8Mw=;
  b=vzpa7179ItQMbSmlCUniOC3jpR0EX05xVBHev+LpShq7cg1s7LzeplvH
   2f6q75tQSECjxHkTs2zbfLTo7NQrOQfswXpYatJEct6S3IzwSen1/sn8k
   eqJMqTObD5Xjc/f0a4QSGpsvAJTq/ELCeKhPlZb1OyL39hpd9kxptxLp1
   ykftdGHnmub5Cxi2QDSZTYjMuGZ5hGS4HNeI9RWL5nihxL+iwkHZywuq0
   q63nIy4ZjJga3i9BAz3Rqjb1PvInLfE+cI/5xfbjS8ZXv9w/D6LCrnJob
   swJty63dcpAD0Hqa+6zCjSsm4/d3DAdVpmlZLbKsHeF2mCkhb1ksmQ/qy
   w==;
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="155977387"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2022 09:23:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 13 May 2022 09:23:43 -0700
Received: from ROU-LT-M43238L.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 13 May 2022 09:23:40 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: dt for 5.19
Date:   Fri, 13 May 2022 18:23:38 +0200
Message-ID: <20220513162338.87717-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Here is the first batch of dt changes for 5.19.
Thanks to Claudiu for having collected this series of patches.
It's a bit late in the process but we might have another batch to prepare for
5.19: not a big deal if it's delayed, so tell me if it's closed for this cycle.

Please pull. Thanks, best regards,
  Nicolas

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.19

for you to fetch changes up to 46a9556d977e290a18890fb4cf07d19b0da16f31:

  ARM: dts: kswitch-d10: enable networking (2022-05-13 16:42:43 +0300)

----------------------------------------------------------------
AT91 & LAN966 DT #1 for 5.19:

- at91: DT compliance updates to gic and dataflash nodes
- lan966: addition to many basic nodes for various peripherals
- lan966: Kontron KSwitch D10: support for this new board
  and its network switch

----------------------------------------------------------------
Eugen Hristev (1):
      ARM: dts: at91: sama7g5: remove interrupt-parent from gic node

Krzysztof Kozlowski (1):
      ARM: dts: at91: use generic node name for dataflash

Michael Walle (14):
      ARM: dts: lan966x: rename pinctrl nodes
      ARM: dts: lan966x: swap dma channels for crypto node
      ARM: dts: lan966x: add sgpio node
      ARM: dts: lan966x: add missing uart DMA channel
      ARM: dts: lan966x: add all flexcom usart nodes
      ARM: dts: lan966x: add flexcom SPI nodes
      ARM: dts: lan966x: add flexcom I2C nodes
      ARM: dts: lan966x: add basic Kontron KSwitch D10 support
      ARM: dts: lan966x: add hwmon node
      ARM: dts: lan966x: add MIIM nodes
      ARM: dts: lan966x: add reset switch reset node
      ARM: dts: lan966x: add serdes node
      ARM: dts: lan966x: add switch node
      ARM: dts: kswitch-d10: enable networking

 .../devicetree/bindings/mfd/atmel-flexcom.txt      |   2 +-
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/at91rm9200ek.dts                 |   4 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |   2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |   2 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |   2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   2 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   2 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |   2 +-
 .../dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts |  94 ++++++
 .../dts/lan966x-kontron-kswitch-d10-mmt-8g.dts     |  39 +++
 .../boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi  | 190 +++++++++++
 arch/arm/boot/dts/lan966x-pcb8291.dts              |   2 +-
 arch/arm/boot/dts/lan966x.dtsi                     | 353 ++++++++++++++++++++-
 arch/arm/boot/dts/sama7g5.dtsi                     |   1 -
 arch/arm/boot/dts/usb_a9263.dts                    |   2 +-
 16 files changed, 687 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi

-- 
Nicolas Ferre
