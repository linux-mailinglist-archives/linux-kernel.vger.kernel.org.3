Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36124AE0FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385066AbiBHSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiBHSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:39:00 -0500
X-Greylist: delayed 1053 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 10:38:58 PST
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E69EC061579;
        Tue,  8 Feb 2022 10:38:58 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 218ILMhw124429;
        Tue, 8 Feb 2022 12:21:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644344482;
        bh=1nkGGCWScu2aD1m/BHp/eL9jSeS7UsELkjz8CZraFUc=;
        h=From:To:CC:Subject:Date;
        b=NhWuEc0KIz2LBcVl968jVOIZF9e8fMyyxTgeeBm6UVU/1dg7t6JfT6dkUzRZVK5U7
         2mZjWsLaGAz9wwN77QyxF+uvOgJnrbb+eS/Ewd3GXdlIjR1AD2vtPgGEcOtlsvUWjD
         Jft0SunS5xd8hF6R7EfCAXZbVAtJvF37QuO43fSw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 218ILMat004125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Feb 2022 12:21:22 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 8
 Feb 2022 12:21:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 8 Feb 2022 12:21:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 218ILMfn029185;
        Tue, 8 Feb 2022 12:21:22 -0600
From:   Hari Nagalla <hnagalla@ti.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <robh+dt@kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am64: Add ESM0 to device memory map
Date:   Tue, 8 Feb 2022 12:21:19 -0600
Message-ID: <20220208182119.24707-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64x SoCs have two ESM modules, with one in MAIN voltage domain and the
other in MCU voltage domain. The error output from Main ESM module can
be routed to the MCU ESM module. The error output of MCU ESM can be
configured to reset the device.

For ESM details please refer technical reference manual at
https://www.ti.com/lit/pdf/spruim2

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 120974726be8..0622a93ec136 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -66,6 +66,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x000f4000 0x00 0x000f4000 0x00 0x000002d0>, /* PINCTRL */
+			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
-- 
2.17.1

