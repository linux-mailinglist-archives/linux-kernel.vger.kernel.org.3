Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E55D5925BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbiHNREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiHNREM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:04:12 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61BDBA4;
        Sun, 14 Aug 2022 10:04:11 -0700 (PDT)
Received: from ipservice-092-217-070-211.092.217.pools.vodafone-ip.de ([92.217.70.211] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oNH1v-0000XS-MR; Sun, 14 Aug 2022 19:04:03 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] hwrng: imx-rngc - use KBUILD_MODNAME as driver name
Date:   Sun, 14 Aug 2022 19:03:59 +0200
Message-Id: <20220814170359.480062-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use KBUILD_MODNAME instead of hard coding the driver name.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 8373e34df4b9..4345df012d8f 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -355,7 +355,7 @@ MODULE_DEVICE_TABLE(of, imx_rngc_dt_ids);
 
 static struct platform_driver imx_rngc_driver = {
 	.driver = {
-		.name = "imx_rngc",
+		.name = KBUILD_MODNAME,
 		.pm = &imx_rngc_pm_ops,
 		.of_match_table = imx_rngc_dt_ids,
 	},
-- 
2.30.2

