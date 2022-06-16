Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5783A54DAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359053AbiFPGn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiFPGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:43:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFFC4DF77;
        Wed, 15 Jun 2022 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655361804; x=1686897804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qjNRaKtVF9yCz0DwkTUlTSkU7fN8dVYg780X+fwpa0g=;
  b=GvHkHe3kBETScSgcx1jXZZHjE9iNELQsogaLOZGm6LDJipdX81poLih9
   MRWMBQKKkzwtlhN6S7GLEkmw8vMAquqC1JKQiRtYJqvYfB3cBADUogXoM
   KoiMwLaioDMcF6NHLN8PG0Jycf/tpxUZGnZBjIYiepaJi1cprqL3NIzqf
   ZIURhy6OxpVUuB68/NEcKFjEwCkmi933iKQBKBixth6YLlLqfrfOmRB+B
   eMgPSReq6PjRkSBT3SUGGSvuD2VzRh90JPkJOGBneelwHJf1x/mrvfI7I
   EVuJUhjzZzlTLqESRd0zZMhwSXyItzNWw9s+1lY2FcAcxchPTXasuBg9f
   A==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="160580445"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 23:43:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 23:43:17 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Jun 2022 23:43:13 -0700
From:   Nagasuresh Relli <nagasuresh.relli@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <palmer@dabbelt.com>
CC:     <nagasuresh.relli@microchip.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Rob Herring" <robh@kernel.org>
Subject: [PATCH] riscv: dts: microchip: remove spi-max-frequency property
Date:   Thu, 16 Jun 2022 12:12:51 +0530
Message-ID: <20220616064251.586263-1-nagasuresh.relli@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the spi-max-frequency property from the spi0 controller
node as it is supposed to be a per SPI peripheral device property.

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/lkml/20220526014141.2872567-1-robh@kernel.org/
Signed-off-by: Nagasuresh Relli <nagasuresh.relli@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index fb963559ba96..1a5aa8836099 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -278,7 +278,6 @@ spi0: spi@20108000 {
 			interrupt-parent = <&plic>;
 			interrupts = <54>;
 			clocks = <&clkcfg CLK_SPI0>;
-			spi-max-frequency = <25000000>;
 			status = "disabled";
 		};
 
-- 
2.25.1

