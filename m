Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFF04CD86A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiCDQBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiCDQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:01:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52291B0BCE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646409643; x=1677945643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m1ChR7M0tuClOXVONifHVOA2VcoI0G6cdp50B0K6wFI=;
  b=f6RevXHBt1i7JzGdGKLnSp6sFjXV/VlpYiNqQwHXmL01d+YOe6ukqt2i
   ZxILCd8nY7JCMWt11yJCD3mFnpvgAU3S6NEtfBtVAeVaJaikDiTcGy2av
   01malZJOW/uzkFAw0S4Cd4lexwstGInKCq9ZjvRvkGOFuEFsmzJoXPn8Y
   yhEtnulmftN3JxVhCpwq/1sRVh4lmvcdpV6cZVCqJxcZJRnck9yfCcdLS
   iIIpnthUIXJ+w9ej1zLu0vIrbT8XwALM/Bg2OwlFmqFR9MAVwc2Axopyl
   8tx2+HYqnh3j0G82E/+sBwp90xxo4MAqa3B8VQR7TnyKwJNhd7oKWY0XT
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="164553996"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 09:00:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 09:00:42 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 09:00:40 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [GIT PULL] ARM: at91: dt for 5.18 #2
Date:   Fri, 4 Mar 2022 17:00:36 +0100
Message-ID: <20220304160036.27392-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Some more dt changes for 5.18.
I had to modify one patch to remove a dependency with the clock tree because of
a modification of the header file in [1] which is already in linux-next.
I tought it would be the simplest solution as I didn't manage to get an
inmutable branch (which could be an overkill solution for such a small change).

I verified that there is no conflict when merging this content with linux-next.
Anyway, tell me if you prefer to not proceed like this.

Thanks, best regards,
  Nicolas

[1]: https://lore.kernel.org/linux-clk/20220111125310.902856-1-tudor.ambarus@microchip.com/T/#u

The following changes since commit 3c8a9c2e2daf51bd3dcaedd321ecc79f10227c41:

  ARM: dts: at91: sama7g5: add opps (2022-02-25 11:32:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.18-2

for you to fetch changes up to 92499dec3aa9c251e605b42e1024e805bbaa50ad:

  ARM: dts: at91: sama7g5: Add NAND support (2022-03-04 15:03:53 +0100)

----------------------------------------------------------------
AT91 DT #2 for 5.18:

- Align one sam9x60ek regulator with reality at vdd_1v15
- Clean sama7g5 i2c nodes
- Add EIC and NAND nodes to sama7g5

----------------------------------------------------------------
Claudiu Beznea (1):
      ARM: dts: at91: sama7g5: add eic node

Mihai Sain (1):
      ARM: dts: at91: sam9x60ek: modify vdd_1v5 regulator to vdd_1v15

Tudor Ambarus (2):
      ARM: dts: at91: sama7g5: Remove unused properties in i2c nodes
      ARM: dts: at91: sama7g5: Add NAND support

 arch/arm/boot/dts/at91-sam9x60ek.dts |  8 ++--
 arch/arm/boot/dts/sama7g5.dtsi       | 74 ++++++++++++++++++++++++++++++++---
 include/dt-bindings/clock/at91.h     |  1 +
 3 files changed, 73 insertions(+), 10 deletions(-)

-- 
Nicolas Ferre
