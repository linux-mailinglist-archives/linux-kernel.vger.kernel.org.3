Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AFF58CDA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbiHHSct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbiHHScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:32:47 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD70DE82;
        Mon,  8 Aug 2022 11:32:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 278IWZi0041258;
        Mon, 8 Aug 2022 13:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659983555;
        bh=n7vPDHyrFMWd1Tk/SIYGUkZbr/pCF5fAtWj2szmUsJ0=;
        h=From:To:CC:Subject:Date;
        b=PEjOCQgON3YQQjHnCyAPr6YZebKLBQXPZtGwpmtd10oDGc1/RiyRbhRrhik4bJpqD
         TgCr7VSM3gtghiZyYPIvu8QP96j/JzDp4BNkjHrDWDZwCjVQU3EZsPisF2ta9GK56u
         D+1RhH9ikk/rjDnhH6MeBWZ/ChSptH4O4FL/JlTA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 278IWZdI126832
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Aug 2022 13:32:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 8
 Aug 2022 13:32:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 8 Aug 2022 13:32:35 -0500
Received: from uda0500628.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 278IWZcl126680;
        Mon, 8 Aug 2022 13:32:35 -0500
From:   Daniel Parks <danielrparks@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721e-main: fix RNG node clock id
Date:   Mon, 8 Aug 2022 13:32:00 -0500
Message-ID: <f29e2c65dc7310a926af8a676651592afac04b03.1659981162.git.danielrparks@ti.com>
X-Mailer: git-send-email 2.17.1
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

The RNG node for this platform claims pka_in_clk. Change it to claim the
correct clock x1_clk. [1]

[1]: https://downloads.ti.com/tisci/esd/latest/5_soc_doc/j721e/clocks.html#clocks-for-sa2-ul0-device

Signed-off-by: Daniel Parks <danielrparks@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 43b6cf5791ee..917c9dc99efa 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -343,7 +343,7 @@
 			compatible = "inside-secure,safexcel-eip76";
 			reg = <0x0 0x4e10000 0x0 0x7d>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&k3_clks 264 1>;
+			clocks = <&k3_clks 264 2>;
 		};
 	};
 
-- 
2.17.1

