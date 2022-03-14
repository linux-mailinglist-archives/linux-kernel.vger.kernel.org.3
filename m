Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDF94D854F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiCNMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbiCNMr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:47:57 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978233917E;
        Mon, 14 Mar 2022 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hkSvYg+QhqgFZs/M00yfIFpfr0WP6sk4OF7YMdOXfzM=;
  b=cAIVo/VSoFJ93ordGoT7KpoGY4itLt7GuKTgBDMzcvn0vvhHNiXO85XV
   NKck4K9KZuU/STC8Z4bOBtD9EQ93cvGlW+vLZ+lyBlTaAv8HJznQqu8Zo
   SXP2YNagNcNJMD4treHXZzuintqxmGcTq9yGWrB7/SCXoT5Tm/iEkZmXz
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997348"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:54:00 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Andy Gross <agross@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/30] clk: qcom: sm6125-gcc: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:39 +0100
Message-Id: <20220314115354.144023-16-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/clk/qcom/gcc-sm6125.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sm6125.c b/drivers/clk/qcom/gcc-sm6125.c
index 431b55bb0d2f..cf3af88d4021 100644
--- a/drivers/clk/qcom/gcc-sm6125.c
+++ b/drivers/clk/qcom/gcc-sm6125.c
@@ -4151,7 +4151,7 @@ static int gcc_sm6125_probe(struct platform_device *pdev)
 
 	/*
 	 * Enable DUAL_EDGE mode for MCLK RCGs
-	 * This is requierd to enable MND divider mode
+	 * This is required to enable MND divider mode
 	 */
 	regmap_update_bits(regmap, 0x51004, 0x3000, 0x2000);
 	regmap_update_bits(regmap, 0x51020, 0x3000, 0x2000);

