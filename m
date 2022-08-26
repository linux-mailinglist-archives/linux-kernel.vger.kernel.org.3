Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A25A2325
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245254AbiHZIhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245724AbiHZIhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:37:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1087E802;
        Fri, 26 Aug 2022 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661503028; x=1693039028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3AOsxGTtrlPJreKgOH7rFOJHmY6DpAE/RWsW5da4KDU=;
  b=IqawFW2v18e2OmNkKcmbK81C200WSayjBBTXtkvaGBDzsqw1Z18UR6rt
   FrIqvbGbYWZhjJElI4+Q7ITt6Hj64PumwfrhZEJNXwJ8HjJ1XDryl3QvR
   /WS3Gseh0EKi/V14QPvYhqDFfLXh6Ta5hp5iXrWnoO5I1OrTUmSGPX0hA
   YuMXsS+hux1QUupOGW8kwGvOk1SvGojn3GYMbYAaOf2U6Xm8Te09jzSos
   Ovh6DmtxvKdDcUI6bm8GDJV1Udm8pw5SRgVcP6xiweDU6+yLGh4hJSF16
   XbY6uIz2gUFl0ji8o7AeZ9lsZA9hxulSNRGxvdqbvAPrfxsTQmxe3jJx9
   w==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="174284207"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 01:37:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 01:37:07 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 01:37:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>
CC:     <cristian.birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/9] ARM: at91: some fixes and one cleanup
Date:   Fri, 26 Aug 2022 11:39:18 +0300
Message-ID: <20220826083927.3107272-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series adds some fixes on PM and device trees and a
cleanup on sam9x60ek device tree.

Thank you,
Claudiu Beznea

Claudiu Beznea (9):
  ARM: configs: at91: remove CONFIG_MICROCHIP_PIT64B
  ARM: at91: pm: fix self-refresh for sama7g5
  ARM: at91: pm: fix DDR recalibration when resuming from backup and
    self-refresh
  ARM: dts: at91: sama5d27_wlsom1: specify proper regulator output
    ranges
  ARM: dts: at91: sama5d2_icp: specify proper regulator output ranges
  ARM: dts: at91: sama7g5ek: specify proper regulator output ranges
  ARM: dts: at91: sama5d27_wlsom1: don't keep ldo2 enabled all the time
  ARM: dts: at91: sama5d2_icp: don't keep vdd_other enabled all the time
  ARM: dts: at91: sam9x60ek: remove simple-bus for regulators

 arch/arm/boot/dts/at91-sam9x60ek.dts        | 78 ++++++++++-----------
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 21 +++---
 arch/arm/boot/dts/at91-sama5d2_icp.dts      | 21 +++---
 arch/arm/boot/dts/at91-sama7g5ek.dts        | 18 ++---
 arch/arm/configs/at91_dt_defconfig          |  1 -
 arch/arm/configs/sama7_defconfig            |  1 -
 arch/arm/mach-at91/pm.c                     | 36 ++++++++--
 arch/arm/mach-at91/pm_suspend.S             | 24 +++++--
 include/soc/at91/sama7-ddr.h                |  8 +++
 9 files changed, 122 insertions(+), 86 deletions(-)

-- 
2.34.1

