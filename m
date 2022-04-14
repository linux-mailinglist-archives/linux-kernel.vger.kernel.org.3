Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7CF501787
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352114AbiDNPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353973AbiDNOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:41:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C26C12EC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649946812; x=1681482812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a9isROkySwnE11B+AHokM790DJBnMvG/rOrv3n4CWIo=;
  b=xM5qRN2Vq74VErva/GKDKxLEJ4F2jqS0+gUwUwnrZRQ36UKGNCzhSkGx
   AClsL8Kvt63IGgW8O1tIBDxy0mo/ZOG2biC0guPpx5kOax3pr1pQeHlqg
   I0MZnCRbgGkMVRGWpcbKTyhE/lcBY1gH3xmS/hRazj/UquDZ1rbSYNA4f
   USBvMeV/IF8lZvXggwXOOv1nzCZQJb1Gq+vg1Ce1kt6nF/XUxYISWC0RM
   nZxLrX+RsHx7o10c+4xe9lmdg++OviIU5RgxfQjggvqCf1i8xqrijIqAw
   PlZUOFuyUK4GDCWcWAGosj3bBgBWefF7snIzcuCJcOkQzB0QouSTESioi
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,260,1643698800"; 
   d="scan'208";a="152657359"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Apr 2022 07:33:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Apr 2022 07:33:30 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 14 Apr 2022 07:33:28 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: fixes for 5.18
Date:   Thu, 14 Apr 2022 16:33:18 +0200
Message-ID: <20220414143318.26363-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the fixes for 5.18 addressing DT issues. Please pull.

Thanks, best regards,
  Nicolas

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-fixes-5.18

for you to fetch changes up to 0c640d9544d0109da3889d71ae77301e556db977:

  ARM: dts: at91: fix pinctrl phandles (2022-04-13 18:48:01 +0200)

----------------------------------------------------------------
AT91 fixes #1 for 5.18:

Only DT fixes. They cover syntax issues as well as features:
- fix dtschema check warnings for DMA channel entries, boolean
  properties and flash names
- sam9g20ek audio clock and regulator description
- sama5d[34]_xplained SPI pinctrl
- align DT with hardware subtleties on sama7g5ek

----------------------------------------------------------------
Claudiu Beznea (2):
      ARM: dts: at91: sama5d4_xplained: fix pinctrl phandle name
      ARM: dts: at91: fix pinctrl phandles

Eugen Hristev (1):
      ARM: dts: at91: sama7g5ek: enable pull-up on flexcom3 console lines

Krzysztof Kozlowski (2):
      ARM: dts: at91: align SPI NOR node name with dtschema
      ARM: dts: at91: use generic node name for dataflash

Mark Brown (2):
      ARM: dts: at91: Map MCLK for wm8731 on at91sam9g20ek
      ARM: dts: at91: Describe regulators on at91sam9g20ek

Rob Herring (1):
      ARM: dts: at91: Fix boolean properties with values

Sergiu Moga (1):
      ARM: dts: at91: sama7g5: Swap `rx` and `tx` for `i2c` nodes

Tudor Ambarus (1):
      ARM: dts: at91: sama7g5ek: Align the impedance of the QSPI0's HSIO and PCB lines

 .../devicetree/bindings/mfd/atmel-flexcom.txt      |  2 +-
 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi          |  2 +-
 arch/arm/boot/dts/at91-kizbox3-hs.dts              |  2 +-
 arch/arm/boot/dts/at91-kizbox3_common.dtsi         |  2 +-
 arch/arm/boot/dts/at91-q5xr5.dts                   |  2 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi        |  2 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts      |  2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  2 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  8 ++--
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |  2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  6 +--
 arch/arm/boot/dts/at91-sama5d4ek.dts               |  2 +-
 arch/arm/boot/dts/at91-sama7g5ek.dts               |  4 +-
 arch/arm/boot/dts/at91-vinco.dts                   |  2 +-
 arch/arm/boot/dts/at91rm9200ek.dts                 |  4 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |  2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |  2 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |  2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        | 45 +++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |  2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |  2 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |  2 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi                |  2 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi                  |  2 +-
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi              |  2 +-
 arch/arm/boot/dts/sama7g5.dtsi                     | 18 ++++-----
 arch/arm/boot/dts/usb_a9263.dts                    |  2 +-
 27 files changed, 85 insertions(+), 42 deletions(-)

-- 
Nicolas Ferre
