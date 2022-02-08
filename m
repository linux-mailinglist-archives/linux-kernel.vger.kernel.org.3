Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7AE4AE0DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384925AbiBHSfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353486AbiBHSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:35:31 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB7DC061579;
        Tue,  8 Feb 2022 10:35:30 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.156.120])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id B4F97E36D6CC;
        Tue,  8 Feb 2022 19:35:28 +0100 (CET)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 19:35:28 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <linux-renesas-soc@vger.kernel.org>, <geert+renesas@glider.be>,
        <linux-kernel@vger.kernel.org>
CC:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: clock: r9a06g032: Add the definition of the the watchdog clock
Date:   Tue, 8 Feb 2022 19:35:05 +0100
Message-ID: <20220208183511.2925304-2-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208183511.2925304-1-jjhiblot@traphandler.com>
References: <20220208183511.2925304-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 13254093704866642209
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepfeeugefgieeutdfhvdegveetvdeuvefgveegleeileevveehfeejjeffgfduudeknecukfhppedtrddtrddtrddtpdekkedruddvhedrudefvddrjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

