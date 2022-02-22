Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF64BF758
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiBVLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiBVLkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:40:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF4137599;
        Tue, 22 Feb 2022 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645529989; x=1677065989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vTBBdEJPDTv9Jo14PTFuc9Ho0MLN95dGKxtfaf1LydE=;
  b=EvqOWGU6zLUYeBn085flALinkCKigV9weiLS740uv476WvJM/FPaQVT8
   n66n9I9tHwLmQnDDsi9vijD5lAOAkzvNhOfI9ZHwbFLZMilYklNGpKq15
   pY1mMAXnzRIC1owdHaknVTdnwpAtDB0640GHv7pySfLLJu4/c5s3rrTc9
   iUrv0hkuDrdYi13pwCsG1um3q2oOp5j9eUe6hFP2xmAQ7cARnxSxk5lak
   qgDYXE7Q/UNzsff9t6+8GwHyytFoLIYwGLLp8QVNqKGKlSLo6s8QwfUEU
   KxxOLlh/zYEf/s8/RytZfGX+DcA5hZG78dmSewOJlEiLlhyaOsJSo7DCC
   w==;
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="149554587"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2022 04:39:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 22 Feb 2022 04:39:48 -0700
Received: from hari-laptop.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 22 Feb 2022 04:39:42 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [PATCH] 3/3] ARM: dts: at91: sama7g5: Enable can0 and can1 support in sama7g5-ek
Date:   Tue, 22 Feb 2022 17:09:24 +0530
Message-ID: <20220222113924.25799-3-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222113924.25799-1-Hari.PrasathGE@microchip.com>
References: <20220222113924.25799-1-Hari.PrasathGE@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the can0 and can1 controllers in sama7g5-ek board along with
its pin mux settings.

Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index ccf9e224da78..5211a8c9a19c 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -131,6 +131,18 @@
 	status = "okay";
 };
 
+&can0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can0_default>;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_default>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vddcpu>;
 };
@@ -454,6 +466,19 @@
 };
 
 &pioA {
+
+	pinctrl_can0_default: can0_default {
+		pinmux = <PIN_PD12__CANTX0>,
+			 <PIN_PD13__CANRX0 >;
+		bias-disable;
+	};
+
+	pinctrl_can1_default: can1_default {
+		pinmux = <PIN_PD14__CANTX1>,
+			 <PIN_PD15__CANRX1 >;
+		bias-disable;
+	};
+
 	pinctrl_flx0_default: flx0_default {
 		pinmux = <PIN_PE3__FLEXCOM0_IO0>,
 			 <PIN_PE4__FLEXCOM0_IO1>,
-- 
2.17.1

