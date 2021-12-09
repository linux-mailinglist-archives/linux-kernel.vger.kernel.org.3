Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA59846E68B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhLIK3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:29:21 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52782 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhLIK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639045547; x=1670581547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lAm+h0fWWothU92JbMR7pP+ZVmwfNgYi5a7dJ7whHSc=;
  b=fUZy3DL3SGzIfFEbkz/KDDzeZL1Cv5dqhNLYoXswk1fiI277wqWeRlZi
   c1HNDOAfNsKcj8s3H+f+RWDWxIqUOjc/rY8BwBzWVH36xkrLay3d+8CNw
   yFpx5ZiQWsNipLa5EJPDIYQeeHpZPhmc283p/ONqYXbVZzjGvcvRzyU6X
   BzfoGQpD4ijnKe6y+wSV5ot6/zdKuHjyTlft+5lmOxUnzajW0yxIJb0bJ
   uozuEnk11dw9YmDfcBvyaXDrS4IDDlmP8gnfHqQukJJTw3MQxixZ58/kZ
   gsClc0MtBXRro4eL13UllrzWV1XCFDQlyLfe1PcEf3dkUvWTul/UOVYRd
   A==;
IronPort-SDR: PHY/A564odty8KV/PgWlPjQww2htl3QPfsfpiqMAzCeTtmdGrX6I6ahirTCff0RzwjOKleSuxj
 aEVUUty71XWgmsT7TXEOZ00/IvKBiDIbolXzB/EYy9f92ejdJpnfRNllnp8NV5bY106zsw1tkH
 zcvXKY1opaBEx+CfDeb5M+lurZlX9MfvBJRQta73+/uEUSJWLRuZejf/S8jZv9ixOKfFoIK8id
 rJemlDUtixgbn+r+p0WqVm+CkV2Y+KNanO9P4zqauTFqHxvyADCS26Z/25P45qaCcQ7SIeF2n3
 5+aeua/x4xaWvWRloajYOw8P
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="154846800"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 03:25:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Dec 2021 03:25:46 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 03:25:44 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2: Name the qspi clock
Date:   Thu, 9 Dec 2021 12:25:42 +0200
Message-ID: <20211209102542.254153-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naming clocks is a good practice. The atmel-quadspi driver supports
an unnamed clock for the peripheral clock in order to be backward
compatible with old DTs, but it is recommended to name the clocks
on new DTs. The driver's bindings file requires the clock-names
property, so name the clock.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 801969c113d6..09c741e8ecb8 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -288,6 +288,7 @@ qspi0: spi@f0020000 {
 				reg-names = "qspi_base", "qspi_mmap";
 				interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
+				clock-names = "pclk";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -299,6 +300,7 @@ qspi1: spi@f0024000 {
 				reg-names = "qspi_base", "qspi_mmap";
 				interrupts = <53 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 53>;
+				clock-names = "pclk";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
2.25.1

