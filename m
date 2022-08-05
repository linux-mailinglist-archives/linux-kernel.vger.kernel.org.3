Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CCD58A60E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiHEGou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiHEGoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:44:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0ED7434C;
        Thu,  4 Aug 2022 23:44:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2756idxm007872;
        Fri, 5 Aug 2022 01:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659681879;
        bh=6rPE/bXMV/XtZVzrkJNNtd/XO2H6ocUbL1oqvByw9Vw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UjkrB1RWx7GcWYfuwFNH8CTQ/+orVxGEVC/vQkuxkywUGRl/C1GsVA3Lxjj+XEppT
         Iakkax0oVGEvBiZg3RVdF9DAaP5nyw/G/D67V4sqtQXweQrnp6QXCE0YkF9GH0JS+J
         XSof1r/MDvsFRiFKDwdXlUAoIry85UW1ZBY/g7ns=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2756idl2026653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Aug 2022 01:44:39 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 5
 Aug 2022 01:44:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 5 Aug 2022 01:44:39 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2756hvNH086657;
        Fri, 5 Aug 2022 01:44:32 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <lee@kernel.org>, <nm@ti.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-j7200-common-proc-board: Add TPS6594x PMIC node
Date:   Thu, 4 Aug 2022 23:43:52 -0700
Message-ID: <20220805064352.793918-5-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220805064352.793918-1-mranostay@ti.com>
References: <20220805064352.793918-1-mranostay@ti.com>
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

From: Keerthy <j-keerthy@ti.com>

Add TPS6594x PMIC + RTC definition for J7200 common processor board
device tree.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 121975dc8239..6deab4f9a04b 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -353,3 +353,19 @@ &pcie1_ep {
 	num-lanes = <2>;
 	status = "disabled";
 };
+
+&wkup_i2c0 {
+	status = "okay";
+};
+
+&wkup_i2c0 {
+	tps6594x: tps6594x@48 {
+		compatible = "ti,tps6594x";
+		reg = <0x48>;
+		ti,system-power-controller;
+
+		rtc {
+			compatible = "ti,tps6594x-rtc";
+		};
+	};
+};
-- 
2.36.1

