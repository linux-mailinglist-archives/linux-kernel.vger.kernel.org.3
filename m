Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8A5B1DB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiIHMyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiIHMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:54:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A375AAE7D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:54:30 -0700 (PDT)
X-QQ-mid: bizesmtp64t1662641649t44k0i9f
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:54:08 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: r/cTxDoDoiHliKBVqzahqQwTuWEw4jkUvkoE1hZA9hVA55E2Y/u/rhbfz2Y1y
        50YU4Mt6Rx4y78xBL6uGhtWUBlL1ZVaO8FbvWIYrDYxxKw4U1WFkTqaCUPxCdiPxfsK/S27
        gj1ze3WXdTcej2HHCTQhIPsNdIf4asrxFuj4BntZvXJQRY1No88BFVuYfu/zZM3cnZ0FVDh
        gXW/PTrYqk7vt8zpRTm7UuwjeKeW71zH9b5FONDF+zrzYBckJKZ+Nx7wpQ+hu2JHHJ26O5/
        vXD6FUlxzUMcIIzcjnhdWqT/jyOZOxxxzi0OpTXJ6mGaEv8+W3qsVICp+LuSXsG3zwasdDR
        gr9JJBBQd+n6jUIas87UeSikjsI9FI/32yqmbtT0Vs0LWrDKR73j0XgafZkNg==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] um/kernel: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:54:01 +0800
Message-Id: <20220908125401.28130-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/um/kernel/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index e7c7b53a1435..91485119ae67 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -169,7 +169,7 @@ __uml_setup("iomem=", parse_iomem,
 );
 
 /*
- * This list is constructed in parse_iomem and addresses filled in in
+ * This list is constructed in parse_iomem and addresses filled in
  * setup_iomem, both of which run during early boot.  Afterwards, it's
  * unchanged.
  */
-- 
2.36.1

