Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F278590AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiHLDY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiHLDXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:23:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE6A3D7D;
        Thu, 11 Aug 2022 20:23:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27C3NbGd076876;
        Thu, 11 Aug 2022 22:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660274617;
        bh=Jj6n3h/aXvvo2nkr+eTMi1f20oQKf1OldZ2XmgcaBM8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pHER2XPJNh+glFZuiXPLJ6VshsYHPXi/6mT7OyMC4jxqBN616trneo0Wcerjs9ONl
         mwQD/FAEkeiLAR0q8fl1yvWhYrQ3jsSdTfjx/3AIS9PViQEtvp9W/9WSkRTz8uTwgt
         vLx1bU6Rv1wtomgpa1BiA/nvl/yxw3gw2Qm/B0a8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27C3NbnK119665
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Aug 2022 22:23:37 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 11
 Aug 2022 22:23:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 11 Aug 2022 22:23:37 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27C3MkOv096105;
        Thu, 11 Aug 2022 22:23:30 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <j-keerthy@ti.com>, <lee@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 5/6] arm64: dts: ti: k3-j721e-common-proc-board: Add TPS6594x PMIC node
Date:   Thu, 11 Aug 2022 20:22:41 -0700
Message-ID: <20220812032242.564026-6-mranostay@ti.com>
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

Add TPS6594x PMIC + RTC definition for j721e common processor board
device tree.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 .../boot/dts/ti/k3-j721e-common-proc-board.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index b1691ac3442d..f7b8b40993bd 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -995,3 +995,19 @@ &main_mcan12 {
 &main_mcan13 {
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

