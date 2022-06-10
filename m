Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1554620E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbiFJJ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349157AbiFJJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:25:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDBA14CDC9;
        Fri, 10 Jun 2022 02:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654852980; x=1686388980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGEZaqDGs6qwciUKiG3sAcu+ojJ/Own5Cy2mCDAYuis=;
  b=rBAt6XVlzyjuLyCXmbL4YvEgszdsvA23sVxV4OVy4PZP0znP+zBxkqfr
   +GqXD98KLCxq91sQdKllriYlrQ99qbUiv3G/a2uv7jVYH26V6LlAPkAfL
   CupLdiRJizbkumjYmWsZib2QTHlwMOLEKHYgJjVSxyGy11TX2iHh0sBO2
   QalJ2n0nH8HkZRhLiwmWA1YfyWvaXbZPesMQ7AxSPrGPEOK4gTo79d89R
   9LjvLqEpKrzqV30JRfVD8U0WyzYS0OXYASOKLjJQxAnbvJiRGzaPIgXrr
   hrUst72bY0SIOsXurw29sotUFwNg8eaOde6RSLPrWaarukPn2YYdEov9b
   A==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="167569646"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 02:22:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 02:22:58 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 10 Jun 2022 02:22:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 9/9] ARM: dts: at91: sama7g5: add reset-controller node
Date:   Fri, 10 Jun 2022 12:24:14 +0300
Message-ID: <20220610092414.1816571-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
References: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller node.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index a37e3a80392d..bb6d71e6dfeb 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -198,6 +198,13 @@ pmc: pmc@e0018000 {
 			clock-names = "td_slck", "md_slck", "main_xtal";
 		};
 
+		reset_controller: reset-controller@e001d000 {
+			compatible = "microchip,sama7g5-rstc";
+			reg = <0xe001d000 0xc>, <0xe001d0e4 0x4>;
+			#reset-cells = <1>;
+			clocks = <&clk32k 0>;
+		};
+
 		shdwc: shdwc@e001d010 {
 			compatible = "microchip,sama7g5-shdwc", "syscon";
 			reg = <0xe001d010 0x10>;
-- 
2.34.1

