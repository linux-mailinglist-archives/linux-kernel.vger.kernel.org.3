Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B7590AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiHLDYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiHLDYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:24:15 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EEBA4072;
        Thu, 11 Aug 2022 20:23:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27C3Nkdd073789;
        Thu, 11 Aug 2022 22:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660274626;
        bh=HnC7he2GVetXqMlW5ITNKLWHNTlIWm5BgOftHuYkAXg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pZKJtKfqXkdNMO/USlyBauP/+6flSpazBJRxE0hUuG7bD1/F4KPEEB/izujYrc0+i
         vkfpHPoyEmPk4sxmHGtSLelGGXpU04j7/wlbk1HDQfuUNg+2PeQ5lqtZr5Q66oyoX8
         MoEpBWcYvWaK1rl9Gjc5CPHWemL1P0fGOjQTFp8w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27C3Nkme125207
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Aug 2022 22:23:46 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 11
 Aug 2022 22:23:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 11 Aug 2022 22:23:45 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27C3MkOw096105;
        Thu, 11 Aug 2022 22:23:38 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <j-keerthy@ti.com>, <lee@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 6/6] arm64: dts: ti: k3-j721s2-common-proc-board: Add TPS6594x PMIC node
Date:   Thu, 11 Aug 2022 20:22:42 -0700
Message-ID: <20220812032242.564026-7-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220812032242.564026-1-mranostay@ti.com>
References: <20220812032242.564026-1-mranostay@ti.com>
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

Add TPS6594x PMIC + RTC definition for j721s2 common processor board
device tree.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index b210cc07c539..0156a700f5df 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -429,3 +429,19 @@ &main_mcan15 {
 &main_mcan17 {
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

