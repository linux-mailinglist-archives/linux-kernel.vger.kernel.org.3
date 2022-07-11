Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7992F56F96C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiGKI6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiGKI6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:58:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC31A042;
        Mon, 11 Jul 2022 01:58:00 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26B8vknN040990;
        Mon, 11 Jul 2022 03:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657529866;
        bh=UinwLqd6zWhyZIOTuXz8QUpJHoWQPFqGR0Yqkfs0HPs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V32UnphGTTcGrTPDHwB6OP/1yXkqODwH5efMld2ZeTgHkTQA6w/455V7Car26XV5M
         WvAIfn+jgmKCBWFm9skHLslyi6HX2yWVcO6q25OfPamO+PZqzqO3cdQ2la62gMTCmQ
         KzZOaMhCHBrn1rg0tszWZ9XezbLBLt/l7T340cIA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26B8vkPR077587
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jul 2022 03:57:46 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Jul 2022 03:57:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Jul 2022 03:57:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26B8vj2f008185;
        Mon, 11 Jul 2022 03:57:46 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am64: Add SA2UL address space to Main CBASS ranges
Date:   Mon, 11 Jul 2022 14:27:42 +0530
Message-ID: <20220711085743.10128-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220711085743.10128-1-j-choudhary@ti.com>
References: <20220711085743.10128-1-j-choudhary@ti.com>
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

