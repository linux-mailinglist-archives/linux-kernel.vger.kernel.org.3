Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5294BA7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244081AbiBQSK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:10:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbiBQSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:10:54 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48312194153;
        Thu, 17 Feb 2022 10:10:40 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21HIAXvl071017;
        Thu, 17 Feb 2022 12:10:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645121433;
        bh=OUDS3/YzCieZB1OgiNyQ5kmPcpgryJ+lRXlzpHYl/jY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BZlO0fWRm6ljU6pMWfQSbbCs5QcWsXmSc4LrH4rNIXnhb1NQ9IFOH5mEQT694xv9E
         V5YiZalPa+O9+Fb1gd3mN6SKp4BCk/PwBPuf//S/nfd5nXuLS2sUvUCgxIBXKeiTsm
         Kr+qMaz9jFmfTm68CBPV2iaKiDo09zaTddvt16yg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21HIAXbM119067
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Feb 2022 12:10:33 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 17
 Feb 2022 12:10:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 17 Feb 2022 12:10:32 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21HIAQJW001378;
        Thu, 17 Feb 2022 12:10:30 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] arm64: dts: ti: k3-*: Drop address and size cells from flash nodes
Date:   Thu, 17 Feb 2022 23:40:25 +0530
Message-ID: <20220217181025.1815118-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217181025.1815118-1-p.yadav@ti.com>
References: <20220217181025.1815118-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifying partitions directly under the flash nodes is deprecated. A
partitions node should used instead. The address and size cells are not
needed. Remove them.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

Only compile-tested.

 arch/arm64/boot/dts/ti/k3-am642-evm.dts               | 2 --
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                | 2 --
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi           | 2 --
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 --
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                | 2 --
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi           | 2 --
 6 files changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index edf80e277267..8e7893e58b03 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -509,8 +509,6 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 30b956276060..1d7db8bf3a5c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -380,8 +380,6 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index 7d819f0db8df..2d615c3e9fa1 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -267,7 +267,5 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 2ecc4541f6d8..f5ca8e26ed99 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -493,8 +493,6 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <2>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index b726310d867c..f25d85169e0d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -475,8 +475,6 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index 990dfcd61018..e36335232cf8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -182,8 +182,6 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };

--
2.34.1

