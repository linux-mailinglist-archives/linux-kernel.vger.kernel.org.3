Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD21952FBA8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355153AbiEULQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353621AbiEULMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:20 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB3633A3E;
        Sat, 21 May 2022 04:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aU5tlRSC14cMrGEbcpMrzzo5gZ5+HICJ96yqY3jYY20=;
  b=CC9+gz2aPYtWxNYlwEYMGhZ7J9Pn2n160KUdhvh6D7nH2NrGqreGCxUl
   COSxil176o9VY1+cByJAVt0QEYtGBjiT+qxM7OY8CUL/v6xabEYR7V941
   ZUXer4h1098ERyMxvyteK0h02/3wjO/hmjrBlnjG8cLvVF+oNmL5Y2KvR
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727938"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:59 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: exynos4-is: fix typos in comments
Date:   Sat, 21 May 2022 13:10:51 +0200
Message-Id: <20220521111145.81697-41-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h |    2 +-
 drivers/media/platform/samsung/exynos4-is/mipi-csis.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
index da36b48b8f9f..9dcbb9853ac0 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
@@ -116,7 +116,7 @@ enum fimc_is_error {
 	ERROR_COMMON_PARAMETER		= 2,	/* Invalid parameter */
 	/* setfile is not loaded before adjusting */
 	ERROR_COMMON_SETFILE_LOAD	= 3,
-	/* setfile is not Adjusted before runnng. */
+	/* setfile is not Adjusted before running. */
 	ERROR_COMMON_SETFILE_ADJUST	= 4,
 	/* Index of setfile is not valid (0~MAX_SETFILE_NUM-1) */
 	ERROR_COMMON_SETFILE_INDEX	= 5,
diff --git a/drivers/media/platform/samsung/exynos4-is/mipi-csis.c b/drivers/media/platform/samsung/exynos4-is/mipi-csis.c
index 27a214936cb0..6a0d35f33e8c 100644
--- a/drivers/media/platform/samsung/exynos4-is/mipi-csis.c
+++ b/drivers/media/platform/samsung/exynos4-is/mipi-csis.c
@@ -124,7 +124,7 @@ static char *csi_clock_name[] = {
 #define DEFAULT_SCLK_CSIS_FREQ	166000000UL
 
 static const char * const csis_supply_name[] = {
-	"vddcore",  /* CSIS Core (1.0V, 1.1V or 1.2V) suppply */
+	"vddcore",  /* CSIS Core (1.0V, 1.1V or 1.2V) supply */
 	"vddio",    /* CSIS I/O and PLL (1.8V) supply */
 };
 #define CSIS_NUM_SUPPLIES ARRAY_SIZE(csis_supply_name)

