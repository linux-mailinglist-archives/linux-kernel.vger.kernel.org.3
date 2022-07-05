Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B252D56654E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiGEIoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGEIoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:44:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36461034
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657010659; x=1688546659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XAdgFKI91yLdNA/2RVNY+qkaB/6LuZCuxN9UEX+97FI=;
  b=UHZCjxccbY46CMgm/OScz2njVNk0eMTMo1ZyXL90/h15rU5/rw+3LyVc
   2eS8Lw7sFFqIYGbJf6Ip+QnWWxFIpY+xFsGSIDm4rEjh2LVMlnF8X/+fk
   VRYtbU9Q/Y660LXhiEvzlnUMcFAOVrgPlAW6tMnbnoMJ8traGUlGH0W0i
   f7xxYCmClqcsnxFaBlZQuo61bK1rZtmN2qDMxYttWn+oigUV0hp1fZC/U
   bdn1FUUAsJtv0fpbAdXglxf2l0ugqHc/hAKzuUXeXB+kfwxVPZVPQ4hs3
   jIGib6nXDIkP/dBuGnDukn18iMlCwVcrgSBh3IEihW5HGmkE3BEQgXyDU
   g==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="166387716"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 01:44:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 01:44:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 01:44:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <arm@kernel.org>,
        <soc@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] AT91 device tree changes for v5.20
Date:   Tue, 5 Jul 2022 11:46:37 +0300
Message-ID: <20220705084637.818216-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnd, Olof, ARM SoC maintainers,

Please pull the following AT91 fixes for v5.20.

Thank you,
Claudiu Beznea

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.20

for you to fetch changes up to 4dd1a613e464e9036d5163fc8ec5f7dc6e394b53:

  ARM: dts: lan966x: Add UDPHS support (2022-07-05 10:42:18 +0300)

----------------------------------------------------------------
AT91 DT for v5.20

It contains:
- compilation warning fixes for SAMA5D2
- updates for all AT91 device tree to use generic name for reset
  controller
- reset controller node for SAMA7G5
- MCAN1 and UDPHS nodes for LAN966 SoCs
- Flexcom3 bindings were updated for lan966x-pcb8291.dts board to cope
  with reality

----------------------------------------------------------------
Claudiu Beznea (4):
      ARM: dts: at91: sama5d2: fix compilation warning
      ARM: dts: at91: sama5d2: fix compilation warning
      ARM: dts: at91: use generic name for reset controller
      ARM: dts: at91: sama7g5: add reset-controller node

Herve Codina (2):
      dt-bindings: usb: atmel: Add Microchip LAN9662 compatible string
      ARM: dts: lan966x: Add UDPHS support

Kavyasree Kotagiri (2):
      ARM: dts: lan966x: Add mcan1 node.
      ARM: dts: lan966x: Cleanup flexcom3 usart pinctrl settings.

 .../devicetree/bindings/usb/atmel-usb.txt          |  3 +++
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi          |  2 ++
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi        |  2 ++
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          |  2 ++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  2 ++
 arch/arm/boot/dts/at91sam9260.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  2 +-
 arch/arm/boot/dts/lan966x-pcb8291.dts              | 18 ++++-----------
 arch/arm/boot/dts/lan966x.dtsi                     | 26 ++++++++++++++++++++++
 arch/arm/boot/dts/sam9x60.dtsi                     |  2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     | 24 +++++++++-----------
 arch/arm/boot/dts/sama5d3.dtsi                     |  2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |  2 +-
 arch/arm/boot/dts/sama7g5.dtsi                     |  7 ++++++
 19 files changed, 69 insertions(+), 37 deletions(-)
