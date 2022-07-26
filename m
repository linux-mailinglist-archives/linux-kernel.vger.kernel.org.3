Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE63E5809CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiGZDHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiGZDGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:06:54 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530382A243;
        Mon, 25 Jul 2022 20:06:53 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [113.118.189.34])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 3F99E800058;
        Tue, 26 Jul 2022 11:06:51 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 3/3] arm: dts: mt7623: update scpsys device nodes
Date:   Tue, 26 Jul 2022 11:06:21 +0800
Message-Id: <20220726030621.7555-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726030621.7555-1-amadeus@jmu.edu.cn>
References: <20220726030621.7555-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGhlPVkJNT0lDSBhDGEpKHVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSFVKSkNVSkNCVUhPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oio6Ehw*UT0rKE44GUgLNx4q
        LBgKCUxVSlVKTU5DQ0tPQ0pKQktPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        SFVKSkNVSkNCVUhPWVdZCAFZQUlLSU43Bg++
X-HM-Tid: 0a823878b704b03akuuu3f99e800058
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the power domain data of mt7623a changed,
device tree should also be changed accordingly.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm/boot/dts/mt7623a.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
index d304b62d24b5..fb2670875a66 100644
--- a/arch/arm/boot/dts/mt7623a.dtsi
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -31,8 +31,9 @@ &pcie {
 
 &scpsys {
 	compatible = "mediatek,mt7623a-scpsys";
-	clocks = <&topckgen CLK_TOP_ETHIF_SEL>;
-	clock-names = "ethif";
+	clocks = <&topckgen CLK_TOP_MM_SEL>,
+		 <&topckgen CLK_TOP_ETHIF_SEL>;
+	clock-names = "mm", "ethif";
 };
 
 &usb0 {
-- 
2.25.1

