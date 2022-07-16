Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4951A576E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiGPOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGPOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:06:00 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E21B781;
        Sat, 16 Jul 2022 07:05:55 -0700 (PDT)
X-QQ-mid: bizesmtp88t1657980351tldjk98c
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 22:05:48 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: RmQi6iQXyoN26/cwQq3uZowOdDEi6rAJSp/WeAJbi4cM8c9mgfZiP0YyEPny3
        Ye/WD5OQYyuxbJKO7eW9QusDXcOpeqGOmmONNpBEzQs72Gf1vvtaRx67aImzD1UzbScV0yQ
        bzT4NFsu9ow3sQcJ+mfCnqMOpg2HHTJNths3OHMWmQgECVow/RXVzcet13mhPOxRTgrjHcq
        wjjaxUIJtusyPTojkNqsIhTWIEokJXfzMGAsBxjOiBpaU+rPCQT/oOR19Ix+lXo23WNov/G
        LCSpk6leouBU3ztWqlRfFyq2OjOb9mwRm+rnOaoOuoxqCJ/VcW9ySBcbeXFJVYy4hTOl1u+
        1JD8RPlubuO71Icdmr5Ecacr/SNelXnQlgmzRMp1TBR3hU/9+JtkI2le9OD1YlXEGyCeI47
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mmc/core: fix repeated words in comments
Date:   Sat, 16 Jul 2022 22:05:27 +0800
Message-Id: <20220716140527.56086-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 2ed2b4d5e5a5..01f291e3b266 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -269,7 +269,7 @@ EXPORT_SYMBOL(mmc_of_parse_clk_phase);
  * @host: host whose properties should be parsed.
  *
  * To keep the rest of the MMC subsystem unaware of whether DT has been
- * used to to instantiate and configure this host instance or not, we
+ * used to instantiate and configure this host instance or not, we
  * parse the properties and set respective generic mmc-host flags and
  * parameters.
  */
-- 
2.36.1

