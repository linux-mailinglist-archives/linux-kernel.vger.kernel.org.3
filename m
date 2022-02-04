Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF64A9CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376436AbiBDQST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:18:19 -0500
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:55197 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238920AbiBDQSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:18:18 -0500
Received: from pro2.mail.ovh.net (unknown [10.108.1.178])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 7C09CE1D4880;
        Fri,  4 Feb 2022 17:18:16 +0100 (CET)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 17:18:15 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <geert+renesas@glider.be>, <linux-kernel@vger.kernel.org>
CC:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 2/6] dt-bindings: clock: r9a06g032: Add the definition of the watchdog clock
Date:   Fri, 4 Feb 2022 17:18:00 +0100
Message-ID: <20220204161806.3126321-3-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204161806.3126321-1-jjhiblot@traphandler.com>
References: <20220204161806.3126321-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 5893241588116830497
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrgeelgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeefueeggfeiuedthfdvgeevtedvueevgfevgeelieelveevheefjeejfffguddukeenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock is actually the REF_SYNC_D8 clock.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 include/dt-bindings/clock/r9a06g032-sysctrl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/r9a06g032-sysctrl.h b/include/dt-bindings/clock/r9a06g032-sysctrl.h
index 90c0f3dc1ba1..d9d7b8b4f426 100644
--- a/include/dt-bindings/clock/r9a06g032-sysctrl.h
+++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h
@@ -74,6 +74,7 @@
 #define R9A06G032_CLK_DDRPHY_PCLK	81	/* AKA CLK_REF_SYNC_D4 */
 #define R9A06G032_CLK_FW		81	/* AKA CLK_REF_SYNC_D4 */
 #define R9A06G032_CLK_CRYPTO		81	/* AKA CLK_REF_SYNC_D4 */
+#define R9A06G032_CLK_WATCHDOG		82	/* AKA CLK_REF_SYNC_D8 */
 #define R9A06G032_CLK_A7MP		84	/* AKA DIV_CA7 */
 #define R9A06G032_HCLK_CAN0		85
 #define R9A06G032_HCLK_CAN1		86
-- 
2.25.1

