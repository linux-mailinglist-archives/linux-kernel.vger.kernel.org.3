Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212CC4AE0E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385020AbiBHSfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376884AbiBHSfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:35:32 -0500
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5029C06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:35:31 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.156.54])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id A02432473FB;
        Tue,  8 Feb 2022 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 19:35:29 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <linux-renesas-soc@vger.kernel.org>, <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] ARM: dts: r9a06g032: Add the watchdog nodes
Date:   Tue, 8 Feb 2022 19:35:07 +0100
Message-ID: <20220208183511.2925304-4-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208183511.2925304-1-jjhiblot@traphandler.com>
References: <20220208183511.2925304-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 13254656654614739419
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeefueeggfeiuedthfdvgeevtedvueevgfevgeelieelveevheefjeejfffguddukeenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SOC includes 2 watchdog controllers (one per A7 core).

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index c47896e4ab58..c5659db1581b 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -66,6 +66,22 @@ soc {
 		interrupt-parent = <&gic>;
 		ranges;
 
+		wdt0: watchdog@40008000 {
+			compatible = "renesas,r9a06g032-wdt";
+			reg = <0x40008000 0x1000>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
+			status = "disabled";
+		};
+
+		wdt1: watchdog@40009000 {
+			compatible = "renesas,r9a06g032-wdt";
+			reg = <0x40009000 0x1000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
+			status = "disabled";
+		};
+
 		sysctrl: system-controller@4000c000 {
 			compatible = "renesas,r9a06g032-sysctrl";
 			reg = <0x4000c000 0x1000>;
-- 
2.25.1

