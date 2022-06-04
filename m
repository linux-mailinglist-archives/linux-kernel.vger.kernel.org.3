Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C2453D734
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiFDOSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiFDOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:18:48 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B68B33E2E;
        Sat,  4 Jun 2022 07:18:40 -0700 (PDT)
X-QQ-mid: bizesmtp75t1654352314tmfkru4m
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Jun 2022 22:18:12 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: DHpJGCbtM4kIY9nwcT20Q/K9Wh+hsT2RYwlebOMto+kzSjHyloBtsaDGiFUVq
        IAT5hJtYvTTvW2iDvebLmrYtr9EU61gNulAEePAqVFjUFSnNBeiDuTtgiDUZsLxaTfKJDXh
        PSxWyqfSnqgW5TAJVvCpV8d6xJA/ha2HKV3Xx8LqGW04ZcnAWn3nLiidvn+UUKWvROwLhar
        ldY616YK83c/+yNLd1TZsf3I1NO6qBFECFP4hoVA+chUacbiufZUwuc3X180dbvK6ACBxgj
        LqBsNDsC42QbYEoqbFT9lZ62upUkLIRYvaAEdRE07htpS4F8wxjFlsXlbHVkzm8LCQzbbAI
        aJ3cqHjUQNJpeFOjb0=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] power: supply: bq24257: Fix syntax errors in comments
Date:   Sat,  4 Jun 2022 22:18:11 +0800
Message-Id: <20220604141811.14276-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'is'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/power/supply/bq24257_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 96cb3290bcaa..ecba9ab86faf 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -287,7 +287,7 @@ static int bq24257_set_input_current_limit(struct bq24257_device *bq,
 {
 	/*
 	 * Address the case where the user manually sets an input current limit
-	 * while the charger auto-detection mechanism is is active. In this
+	 * while the charger auto-detection mechanism is active. In this
 	 * case we want to abort and go straight to the user-specified value.
 	 */
 	if (bq->iilimit_autoset_enable)
-- 
2.36.1

