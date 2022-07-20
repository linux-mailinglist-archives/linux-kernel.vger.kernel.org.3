Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2457BED8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiGTTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGTTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:45:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641A821251;
        Wed, 20 Jul 2022 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658346352; x=1689882352;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wDZqMEBM/M5rGvDCUK9488p4euVbH3cPHh0S9+ycDDY=;
  b=rfJ2RRgvIWwRLsIsbPa/ztccrNIhkNDxM+yetxV3kksS0DXyfFakPHqz
   rM23MoGBdHodMHmk35UWW2CxMMaoCmpPQO2Dmdllzjt2rXtH0rst7WfbJ
   qV3tcR1Nk2VaFcG/kHgAalImuJHLxvOJkRB/h1l9glz44nQyQlSSMV0UR
   IOtoLdrfq1ddCZQFq+NTMVVS0Q+in8YVaUPVSeGLqRPFb9nZeWM/gE13H
   eztV03w3vZHLeVJX+ud9njSLzidXFCju5w1lt1nBp+3cjUEIyL31HgPGz
   tzsmm1Z76ElKPlsj3QKqXRi83gq276joH/a9Q2fQn7W6cg91YOnZm7XzZ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="172966558"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 12:45:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 12:45:50 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 12:45:47 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 0/2] ARM: add support for pcb8309
Date:   Wed, 20 Jul 2022 21:49:02 +0200
Message-ID: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation and add the pcb8309.
It features a LAN9662 SoC with 2 internal copport ports and two SFP cages.

Horatiu Vultur (2):
  dt-bindings: arm: at91: add lan966 pcb8309 board
  ARM: dts: lan966x: add support for pcb8309

 .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/lan966x-pcb8309.dts         | 189 ++++++++++++++++++
 3 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/lan966x-pcb8309.dts

-- 
2.33.0

