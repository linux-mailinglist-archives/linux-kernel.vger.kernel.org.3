Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF05593CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiFXG4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFXG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:56:24 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DF467E7B;
        Thu, 23 Jun 2022 23:56:14 -0700 (PDT)
X-QQ-mid: bizesmtp78t1656053768tajouao1
Received: from localhost.localdomain ( [106.117.98.174])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 24 Jun 2022 14:55:57 +0800 (CST)
X-QQ-SSF: 01000000008000D0J000B00A0000000
X-QQ-FEAT: XsF3eVhiq7U8XfmM4kWbg2/cZ+sfPRY04bOfzSdlPFjczFxgqbfNIbe0gbMxq
        YuYh+tIxnrswYTsmpqbV3e72+kiCOCSfsrGJgMnDP68bByr1Vd6sPzoQ7P+qixpq5EaD7e7
        YTefdnQ9T4rm7L57IfcfS0Hjdzzm57OhpUYBnxi/vFcddKLDXPvkV4xWWYMaPrOMoLCO6Je
        eAPJSC5h2o2Z6RnttgKgq44gTcU2U4Yp84mj+9jdoqWrWy/7XDUWQsx3JZzi90wtsK749wV
        1wo9INUzEWeyREjk7i1bYcvp8yxgUOsDUmWY9aPISP/KueWQjHNmpoJNsU9xOPR/xl1e5so
        8JEwC2o
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     trenn@suse.com
Cc:     shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] cpupower: Fix typo in comment
Date:   Fri, 24 Jun 2022 14:55:55 +0800
Message-Id: <20220624065555.33345-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'cpu'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 tools/power/cpupower/bench/system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
index 40f3679e70b5..eb79dd9ac670 100644
--- a/tools/power/cpupower/bench/system.c
+++ b/tools/power/cpupower/bench/system.c
@@ -37,7 +37,7 @@ long long int get_time()
  * sets the cpufreq governor
  *
  * @param governor cpufreq governor name
- * @param cpu cpu for which the governor should be set
+ * @param cpu for which the governor should be set
  *
  * @retval 0 on success
  * @retval -1 when failed
-- 
2.36.1

