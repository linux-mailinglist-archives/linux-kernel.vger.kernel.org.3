Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58929511418
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiD0JNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiD0JMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:12:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A382465E1;
        Wed, 27 Apr 2022 02:09:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R98sCq080290;
        Wed, 27 Apr 2022 04:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651050534;
        bh=wIxGGCo5O/g8khTW2d3qSojKziqOByGDACwtY7V4+yI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UoBT6+EoTKfdESh8DQZWN6E+fNNlzWR8+7CWkc0tQGTZuTLgxFn0tiHi92w+xSKoE
         ssA5bXuSg7eBLBz+xqN36HHa1Aw8h2zSUiihjA+cKee2NsFTjTPSy9LJCQHtVh2DHz
         BsZUMkYM2LcQ9SHrcXPBRAPGhfyHVb9zolvd0UTM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R98soF085129
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 04:08:54 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 04:08:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 04:08:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R98r81008651;
        Wed, 27 Apr 2022 04:08:53 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-am62-main: Add node for Display SubSystem
Date:   Wed, 27 Apr 2022 14:38:47 +0530
Message-ID: <20220427090850.32280-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427090850.32280-1-a-bhatia1@ti.com>
References: <20220427090850.32280-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for the Display SubSystem on the am62x soc in cbass_main.
The DSS IP on this soc is compatible with the one on the am65x soc.

The DSS supports one each of video pipeline (vid) and video-lite
pipeline (vidl1). It outputs OLDI signals on one video port (vp1) and
DPI signals on another (vp2). The video ports are connected to the
pipelines via 2 identical overlay managers (ovr1 and ovr2).

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index eec8dae65e7c..ff21efa4ffad 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -515,6 +515,36 @@ cpts@3d000 {
 		};
 	};
 
+	dss: dss@30200000 {
+		compatible = "ti,am65x-dss";
+
+		reg = <0x00 0x30200000 0x00 0x1000>, /* common */
+		      <0x00 0x30202000 0x00 0x1000>, /* vidl1 */
+		      <0x00 0x30206000 0x00 0x1000>, /* vid */
+		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
+		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
+		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
+		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
+
+		reg-names = "common", "vidl1", "vid",
+			"ovr1", "ovr2", "vp1", "vp2";
+
+		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
+
+		clocks = <&k3_clks 186 4>,
+			 <&k3_clks 186 0>,
+			 <&k3_clks 186 2>;
+
+		clock-names = "fck", "vp1", "vp2";
+
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+
+		dss_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	hwspinlock: spinlock@2a000000 {
 		compatible = "ti,am64-hwspinlock";
 		reg = <0x00 0x2a000000 0x00 0x1000>;
-- 
2.36.0

