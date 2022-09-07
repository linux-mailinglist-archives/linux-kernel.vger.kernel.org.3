Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B65B0037
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIGJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIGJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:21:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D171AD89;
        Wed,  7 Sep 2022 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662542466; x=1694078466;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=R6uswTVjlmBlaPkaiULFtZiRx5hWhYCfyzgtpFUZqfI=;
  b=dnVlGJMii5EqV4W8B5RUnzYbFDQSjU02JOlS1uVXL9Oi/a9/VOAIvxVG
   4ujslwd1AaA+8kmJSHpRSOg6u6gcORAv4q7OZ5hHfjvuGoI2Y2kchNh1u
   K2x4BwhGXNCw5Tk+n+r3Irw8Bwd01Fyu61v9ObeG7WqGdADXY0zRtCQSx
   YX5y/RL/S2kvDUMSM/q6FGfmFA4DeNlam5lOCMdj8Ud5rc5MYHm0lpvN9
   GnuUBjZSjG96CiWi2/eymvrVuPORtrx8MbS/9t5Fu/W67jilCLz4Fnopq
   /vX4aBIo8GIDKkeFRhvJdFXRtdePOxmWcIV2zSTXMHyMDF2ZxOWvee44+
   w==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="179494515"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 02:21:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 02:21:03 -0700
Received: from che-lt-i63539lx.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 02:20:57 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <manikandan.m@microchip.com>, <michael@walle.cc>,
        <horatiu.vultur@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <durai.manickamkr@microchip.com>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [linux][PATCH 0/6] Add support for sam9x60 curiosity board
Date:   Wed, 7 Sep 2022 14:50:48 +0530
Message-ID: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This patch series addresses the following:
	- Moving of flexcom definitions from board file to SoC file plus
	  some minor changes to its properties.
	- Add support for the new sam9x60 curiosity board based on the
	  existing sam9x60 SoC.

Durai Manickam KR (1):
  ARM: dts: at91: sam9x60: Add missing flexcom definitions

Hari Prasath (2):
  ARM: dts: at91: sam9x60: Move flexcom definitions to the SoC dtsi
  ARM: dts: at91: sam9x60: Add DMA bindigs for the flexcom nodes

Manikandan M (3):
  ARM: dts: at91: sam9x60: Fix the label numbering for the flexcom
    functions
  ARM: dts: at91: sam9x60: Specify the FIFO size for the Flexcom UART
  ARM: dts: at91: sam9x60_curiosity: Add device tree for
    sam9x60_curiosity board

 .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/at91-sam9x60_curiosity.dts  | 532 +++++++++++++++
 arch/arm/boot/dts/at91-sam9x60ek.dts          |  49 +-
 arch/arm/boot/dts/sam9x60.dtsi                | 623 ++++++++++++++++++
 5 files changed, 1172 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sam9x60_curiosity.dts

-- 
2.17.1

