Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064514BE328
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354370AbiBUKan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:30:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354687AbiBUKa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:30:28 -0500
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BE16418;
        Mon, 21 Feb 2022 01:51:40 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.1.33])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 91E4B23F147;
        Mon, 21 Feb 2022 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 10:51:09 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <linux-renesas-soc@vger.kernel.org>, <geert+renesas@glider.be>,
        <linux-kernel@vger.kernel.org>
CC:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: clock: r9a06g032: Add the definition of the watchdog clock
Date:   Mon, 21 Feb 2022 10:50:27 +0100
Message-ID: <20220221095032.95054-2-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221095032.95054-1-jjhiblot@traphandler.com>
References: <20220221095032.95054-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: CAS3.emp2.local (172.16.1.3) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 6957498477018429729
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepfeeugefgieeutdfhvdegveetvdeuvefgveegleeileevveehfeejjeffgfduudeknecukfhppedtrddtrddtrddtpdekkedruddvhedrudefvddrjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock is actually the REF_SYNC_D8 clock.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Acked-by: Rob Herring <robh@kernel.org>
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

