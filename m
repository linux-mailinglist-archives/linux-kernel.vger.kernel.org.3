Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A402556BDB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbiGHPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiGHPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:13:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA223BD4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657293236; x=1688829236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BzeOzLqO978xxyCov4it/ZgIZwyg61Vim6TdwwrQ678=;
  b=I4uDZOVxwURAHSNaQBec1/QYg1MXUuA+lEFp3jt1N2OXEQgtl+Er5dlc
   T75FY+UHXQS5Q8QCDqdeTfTvc94We8ofh1G2ZKdJ4XHf7YGMvhMT28TJF
   F6Or+6M4AbkgkZvsft63Jrm/glmH0pqQypdIQ3hks5YrrlL3nk0CqGwEX
   Tsi125FqrIuKLYjXibvdIm52YhtzukGtOAfrRh/2Z6r5oOxcVG7SoCgoZ
   HhelSsSPhfQe7dBxWR6BB03uSkoYbcT5FKRfLsdteitH1aYMEWhZtJQjM
   M1So3f07NdYIEEX5M37B6KoUwxf1ZADcb2/kmtGoIVaMS5gcycvqwfkfj
   w==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="167018455"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 08:13:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 08:13:55 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 8 Jul 2022 08:13:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <arm@kernel.org>,
        <soc@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] AT91 fixes for v5.19 #2
Date:   Fri, 8 Jul 2022 18:16:21 +0300
Message-ID: <20220708151621.860339-1-claudiu.beznea@microchip.com>
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

In case it is not too late, please pull these 2 fixes for 5.19.
They are necessary for proper working of:
- I2S1 interface on SAMA5D2
- switch available on kswitch-d10 based boards.

Thank you,
Claudiu Beznea

The following changes since commit 91d60e259c0f58c855f88f3fe5b7909aec563525:

  ARM: at91: pm: Mark at91_pm_secure_init as __init (2022-06-28 12:55:32 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-fixes-5.19-2

for you to fetch changes up to 2fdf15b50a46e366740df4cccbe2343269b4ff55:

  ARM: dts: at91: sama5d2: Fix typo in i2s1 node (2022-07-08 17:44:33 +0300)

----------------------------------------------------------------
AT91 fixes for 5.19 #2

It contains 2 DT fixes:
- one for SAMA5D2 to fix the i2s1 assigned-clock-parents property
- one for kswitch-d10 (LAN966 based) enforcing proper settings
  on GPIO pins

----------------------------------------------------------------
Michael Walle (1):
      ARM: dts: kswitch-d10: use open drain mode for coma-mode pins

Ryan Wanner (1):
      ARM: dts: at91: sama5d2: Fix typo in i2s1 node

 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi | 8 ++++----
 arch/arm/boot/dts/sama5d2.dtsi                         | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
