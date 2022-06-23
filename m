Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7221A5573B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiFWHRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFWHRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:17:09 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A745AC3;
        Thu, 23 Jun 2022 00:17:03 -0700 (PDT)
X-QQ-mid: bizesmtp70t1655968582tfcjxrq7
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 15:16:18 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000D00A0000000
X-QQ-FEAT: JU4ydNK5SjsZXtnwJm4MVof9Qc1LlzZZENjDXhUJwa/Toj4YC2n3U1xKEFAc1
        L1j9osPFXf0AQEnJSmceP+6mtj8eRtVqTfzwUoUfV+q0JFXPrTckd/72XR95W95Rcpl0J8h
        WJZUgGd/xBZRO1JvS6fYuRHm2suae69yQSjxq4KFrbOX7SDVWD9t3HEkjWCCmLQJySMFgZR
        l86ygq6gTUQofAsS8pnk+ZF2E+taa9uIvKjoaIW+me3SCHVatCJ5zy5U9yJVVGtkIE5wcmx
        WDVyUkjjYjf+A0rporpD1cEFM+gOQdQRYfvCmCG1vdEn6KcARdYMVcnHclJo2EeA9PuejSN
        3YnNBNwDrKGb2iYPLf/0NleMVYYcg==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] mmc: sdhci: drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 15:16:16 +0800
Message-Id: <20220623071616.13873-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word 'a' from comments

file - drivers/mmc/host/sdhci.h
line - 348

/* Allow for a a command request and a data request at the same time */

changed to:

/* Allow for a command request and a data request at the same time */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/mmc/host/sdhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 95a08f09df30..0abe4b428ed5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -345,7 +345,7 @@ struct sdhci_adma2_64_desc {
  */
 #define SDHCI_MAX_SEGS		128
 
-/* Allow for a a command request and a data request at the same time */
+/* Allow for a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
 
 /*
-- 
2.17.1

