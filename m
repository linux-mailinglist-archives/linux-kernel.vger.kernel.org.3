Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA158CE6E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiHHTOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244293AbiHHTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:13:54 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E851704D;
        Mon,  8 Aug 2022 12:13:52 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 278JDbsN099708;
        Mon, 8 Aug 2022 14:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659986017;
        bh=jscsQ/IoQZ26mYB0MEJPoCO2OWweuz3qaoA4kkyHKYQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bOsC0HX7ZkhjHRo3Q5TAd7VYPUsnVVFye0o6fKfnrEkUmLRm4wOqGM9OalrHhCPDW
         llwuFAIPhb/njVAzyj7WDA+WwDHtO+S7lycECm6nYhcvEw/TWFr/CRADJO2tnPgeWq
         TXaSmUEyMtrjdTCXUsCHYSnl1qyxXdQE+Viqq3Mw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 278JDb5C018473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Aug 2022 14:13:37 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 8
 Aug 2022 14:13:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 8 Aug 2022 14:13:37 -0500
Received: from uda0500628.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 278JDaYR054740;
        Mon, 8 Aug 2022 14:13:37 -0500
From:   Daniel Parks <danielrparks@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 4/6] arm64: dts: ti: k3-j721e-main: add SA2UL public key accelerator subdevice
Date:   Mon, 8 Aug 2022 14:12:53 -0500
Message-ID: <33daf58739bc55bbcdc516a81e7d94f82dbdaa7f.1659985696.git.danielrparks@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1659985696.git.danielrparks@ti.com>
References: <cover.1659985696.git.danielrparks@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

j721e contains two SA2ULs, and the PKA in the main domain is accessible,
so add it as a subdevice alongside the RNG module.

Signed-off-by: Daniel Parks <danielrparks@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 917c9dc99efa..56e4ae0ab61f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -344,8 +344,15 @@
 			reg = <0x0 0x4e10000 0x0 0x7d>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&k3_clks 264 2>;
 		};
+
+		pka: pka@4e20000 {
+			compatible = "inside-secure,safexcel-eip29t2";
+			reg = <0x00 0x4e20000 0x00 0x2000>,
+			      <0x00 0x4e24000 0x00 0x8000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
-- 
2.17.1

