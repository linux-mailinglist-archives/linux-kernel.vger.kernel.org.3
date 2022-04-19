Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C388450654E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349177AbiDSHGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbiDSHGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:06:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E582AE00;
        Tue, 19 Apr 2022 00:04:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23J73ich090970;
        Tue, 19 Apr 2022 02:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650351824;
        bh=rQb5x+seCA/gRyaHh8ycHp7w1ZagLiW2Ocbe4cn0WE8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FNu3cIpmQP2T3j6CKBtdoi23GtPDA+QFvlWI5fDl7zWaCEITM4XZG4r/kERHKh21h
         aEB3jwf9YRd5GVnGck4eOgO8sNYk/IVp/Lasx3m+dk5iDOq2ZvstCciXTs+Wo0nfqa
         8Ja3MWfPnb5xEejkmUJqcZ8OfNDhg4wLBUJsTWgs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23J73iUC031438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Apr 2022 02:03:44 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Apr 2022 02:03:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Apr 2022 02:03:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23J73hAJ105340;
        Tue, 19 Apr 2022 02:03:43 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomba@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     DRI Development <dri-devel@lists.freedesktop.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am65: Add missing register & interrupt in DSS node
Date:   Tue, 19 Apr 2022 12:33:02 +0530
Message-ID: <20220419070302.16502-3-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220419070302.16502-1-a-bhatia1@ti.com>
References: <20220419070302.16502-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The DSS IP on the ti-am65x soc supports an additional register space
named "common1". Further, it services a maximum of 2 interrupts.

Add the missing register space "common1" and the additional interrupt in
the dss DT node .

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index e749343acced..1bafa3a98e71 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -830,13 +830,14 @@ csi2_0: port@0 {
 	dss: dss@4a00000 {
 		compatible = "ti,am65x-dss";
 		reg =	<0x0 0x04a00000 0x0 0x1000>, /* common */
+			<0x0 0x04a01000 0x0 0x1000>, /* common1 */
 			<0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
 			<0x0 0x04a06000 0x0 0x1000>, /* vid */
 			<0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
 			<0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
 			<0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
 			<0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
-		reg-names = "common", "vidl1", "vid",
+		reg-names = "common", "common1", "vidl1", "vid",
 			"ovr1", "ovr2", "vp1", "vp2";
 
 		ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
@@ -856,7 +857,8 @@ dss: dss@4a00000 {
 		assigned-clocks = <&k3_clks 67 2>;
 		assigned-clock-parents = <&k3_clks 67 5>;
 
-		interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
 
 		dma-coherent;
 
-- 
2.35.3

