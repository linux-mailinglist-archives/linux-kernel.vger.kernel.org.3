Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990495A8A97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiIABZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiIABZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:25:07 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6961A23159;
        Wed, 31 Aug 2022 18:24:58 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661995465t9y4saum
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 09:24:23 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: ALw5QuVtm4WA3GanO4tjQw9jLexe55QkUyjbHpzNaXEASRvOyHgFLGWyh+t9h
        CZY/Z5rw/ljIfYWLl+tD33gG5pfsfcufK2nxM/6PqqEaP8ca2MZtEjF/OPAvy9ibUmJGrLM
        HNP5eRYpTLJE1kRTgdloUFP9kqHWfwhcjjHE2/R+jo5b0sejB9aUfFuHlTF9ZA7Iy/lR1cr
        r2nF+XgNJRLTyBTnvguHI5vAsVqigky+fvWSARlaT8rv5JkeO2AmIMcsE+wGD6XZApCcM/A
        YpClbrQWAuRVWoRUTFLwcZ96II9SrMJw5vk/605jATYUdAGZE65gtkXHRe8WtaQARiC/P2u
        eECeQ1pZ+CLOH5iZEZFd5+A7y6Y/1HGtEScQgYAMZi0aAEfdCjYq8bsWTCvzw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org, s.nawrocki@samsung.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media: platform: Use 'unsigned int' instead of just 'unsigned'.
Date:   Thu,  1 Sep 2022 09:24:17 +0800
Message-Id: <20220901012417.28681-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' should be clearer than 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/platform/samsung/exynos4-is/fimc-is.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is.h b/drivers/media/platform/samsung/exynos4-is/fimc-is.h
index 06586e455b1d..89bb1bc15c81 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is.h
@@ -292,7 +292,7 @@ struct fimc_is {
 	struct is_fd_result_header	fd_header;
 
 	struct chain_config		config[IS_SC_MAX];
-	unsigned			config_index;
+	unsigned int			config_index;
 
 	struct is_region		*is_p_region;
 	dma_addr_t			is_dma_p_region;
-- 
2.36.1

