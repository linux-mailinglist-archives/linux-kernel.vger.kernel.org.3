Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B35350A9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbiEZObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiEZObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:31:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333F1145F;
        Thu, 26 May 2022 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653575472; x=1685111472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ed2yd8aNhL4cQz8uqrkE0QxcuOYwBtlwGyXKgcop6bw=;
  b=fUYN29T4XEFoWu5aGIoY6iAyDfpD3cMpHsIB7cdkAG+fDAbEvBy4PaFb
   2flCTbSxyINpPX7WbWrRYFAT9Oqg0U0BAJCHqKkif+XQtzMBg3Tim7Yww
   sQXxPrgZuvlHAWadQk2kRntAQ3vKTdW+kahrpFLGOTXOqC5VW9naZEraX
   3TaDQ21cj50RBIRpQ/Oahsfr6PWOEbWc68Fim44X2vEPjWEEKHjhzdiCw
   31hhbCYn8lHKzMTGXi0MAJL0QzHXYgfd7ilTBuMxO72GYDLfgS/gTwKFr
   cuelbZg5AzZKnqa+V1+8PwVOfxelRJIIorwmtYgkJe74ljyfpLrUnIMno
   A==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="160739016"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2022 07:31:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 26 May 2022 07:31:12 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 26 May 2022 07:31:09 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: [PATCH] riscv: dts: microchip: remove spi-max-frequency property
Date:   Thu, 26 May 2022 15:29:07 +0100
Message-ID: <20220526142906.2285607-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
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

spi-max-frequency property is supposed to be a per SPI peripheral device
property, not a SPI controller property, so drop it.

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/lkml/20220526014141.2872567-1-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index c5c9d1360de0..40b11b530bca 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -274,7 +274,6 @@ spi0: spi@20108000 {
 			interrupt-parent = <&plic>;
 			interrupts = <54>;
 			clocks = <&clkcfg CLK_SPI0>;
-			spi-max-frequency = <25000000>;
 			status = "disabled";
 		};
 
@@ -286,7 +285,6 @@ spi1: spi@20109000 {
 			interrupt-parent = <&plic>;
 			interrupts = <55>;
 			clocks = <&clkcfg CLK_SPI1>;
-			spi-max-frequency = <25000000>;
 			status = "disabled";
 		};
 
-- 
2.36.1

