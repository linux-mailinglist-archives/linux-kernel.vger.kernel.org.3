Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA86C56B876
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbiGHL2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbiGHL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:28:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0F3904E6;
        Fri,  8 Jul 2022 04:28:10 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 268BRwWT068516;
        Fri, 8 Jul 2022 06:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657279678;
        bh=UinwLqd6zWhyZIOTuXz8QUpJHoWQPFqGR0Yqkfs0HPs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=synLA/sX2BRTAdUu13IEFmCvoeKbbi+m8BMm/lwz5Ej9cJxUhYX/tljzCTQLSLza5
         mngkWIhwmghdZUyRow+m59lxkg4WMeMWRdlkBJfeSa6/scrnjxC8zpOZ+bTeZeSpoR
         l+WAqIHy51Yk1MHMWHh1QUFefRgC1wwdPa8cKpEo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 268BRwZP019616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jul 2022 06:27:58 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Jul 2022 06:27:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Jul 2022 06:27:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 268BRvdm105813;
        Fri, 8 Jul 2022 06:27:57 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am64: Add SA2UL address space to Main CBASS ranges
Date:   Fri, 8 Jul 2022 16:57:54 +0530
Message-ID: <20220708112755.105642-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220708112755.105642-1-j-choudhary@ti.com>
References: <20220708112755.105642-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Add the address space for the SA2UL in MAIN domain to the ranges property
of the cbass_main interconnect node so that the addresses within the
corresponding sram nodes and its children can be translated properly by
the relevant OF address API.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 016dd8511ca6..c858725133af 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -82,6 +82,7 @@
 			 <0x00 0x3b000000 0x00 0x3b000000 0x00 0x00000400>, /* GPMC0_CFG */
 			 <0x00 0x3cd00000 0x00 0x3cd00000 0x00 0x00000200>, /* TIMERMGR0_CONFIG */
 			 <0x00 0x3f004000 0x00 0x3f004000 0x00 0x00000400>, /* GICSS0_REGS */
+			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA2_UL0 */
 			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>, /* CTRL_MMR0 */
 			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
 			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMASS */
-- 
2.17.1

