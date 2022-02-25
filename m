Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1234A4C4314
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiBYLIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiBYLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:08:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519A61680B3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645787279; x=1677323279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8FsoNF2tMXyFoXs3+t8dZx7wo5mEegZv38u3HgPYn98=;
  b=sDQgbHy3AoSD8800p9+zVedS4onqNIeDAsDAdcmvwF48N5k+TTfwFTMv
   /vItT7sxWWV8ydZfO4KRoPy9w397cVJWSJ7z28qZbe3Pd+8mfvciq2T28
   Eik3Mih1W7KntfylJcxLQiSNZVnxe3xr8zokNYA3gqrq+UpSREsrf5E79
   R3F5sot6W2I+X47//1pSiBIXQ0rXRAAG7tanj/OXqOGKf3mU/DvfSA8PI
   NUou9CeGvsBV34QjA25jaQbNwni5ZX+fWqQsYFDyCzxv+TCubZsJRfu16
   v3TI0VTfjeFvHMmb0snLhnxcWiqjX7+3kHUJFZGKmUfvzNwRSRSIwZ6td
   A==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="147273535"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 04:07:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 04:07:56 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 04:07:54 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Michael Walle <michael@walle.cc>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [GIT PULL] ARM: at91: dt for 5.18
Date:   Fri, 25 Feb 2022 12:07:35 +0100
Message-ID: <20220225110735.18080-1-nicolas.ferre@microchip.com>
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

Here are the dt changes for 5.18. They include both at91 changes and lan966
first DT patches which I'm happy to take as part of our pull request.

Please pull. Thanks, best regards,
  Nicolas

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.18

for you to fetch changes up to 3c8a9c2e2daf51bd3dcaedd321ecc79f10227c41:

  ARM: dts: at91: sama7g5: add opps (2022-02-25 11:32:22 +0100)

----------------------------------------------------------------
AT91 & LAN966 DT #1 for 5.18:

- lan966x basic DT and associated evaluation board pcb8291 (2-ports)
- documentation for an upcoming Kontron switch board featuring a LAN9668
- one fix for an old bug we have with PMECC on sama5d2 in some corner
  cases
- sama7g5 and its EK: crypto, CAN and DVFS operating points

----------------------------------------------------------------
Claudiu Beznea (4):
      ARM: dts: at91: remove status = "okay" from soc specific dtsi
      ARM: dts: at91: fix low limit for CPU regulator
      ARM: dts: at91: sama7g5ek: set regulator voltages for standby state
      ARM: dts: at91: sama7g5: add opps

Hari Prasath (2):
      ARM: dts: at91: sama7g5: Add can controllers of sama7g5
      ARM: dts: at91: sama7g5: Enable can0 and can1 support in sama7g5-ek

Kavyasree Kotagiri (1):
      ARM: dts: add DT for lan966 SoC and 2-port board pcb8291

Michael Walle (1):
      dt-bindings: arm: at91: add Kontron's new KSwitches

Tudor Ambarus (3):
      ARM: dts: at91: sama5d2: Fix PMERRLOC resource size
      ARM: dts: at91: Use the generic "crypto" node name for the crypto IPs
      ARM: dts: at91: sama7g5: Add crypto nodes

 .../devicetree/bindings/arm/atmel-at91.yaml        |   9 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/at91-sama7g5ek.dts               |  32 ++-
 arch/arm/boot/dts/lan966x-pcb8291.dts              |  64 ++++++
 arch/arm/boot/dts/lan966x.dtsi                     | 237 +++++++++++++++++++++
 arch/arm/boot/dts/sam9x60.dtsi                     |  10 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  11 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   6 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   9 +-
 arch/arm/boot/dts/sama7g5.dtsi                     | 169 ++++++++++++++-
 10 files changed, 522 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/boot/dts/lan966x-pcb8291.dts
 create mode 100644 arch/arm/boot/dts/lan966x.dtsi

-- 
Nicolas Ferre
