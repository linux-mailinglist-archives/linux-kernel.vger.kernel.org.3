Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE2D58FC13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiHKMUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiHKMUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:20:31 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5985C35B;
        Thu, 11 Aug 2022 05:20:29 -0700 (PDT)
X-QQ-mid: bizesmtp90t1660220390thv83bi2
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:19:48 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: XBN7tc9DADKii/8PDFUJVQ+mJJzfSU+dPMUTo1BHiQWJQ2Ij5m71XrAyDK8Mx
        /THCMShe27BOS4hT6icvF+lyrVlhqdCIVm9bElWhozoHUIo48EWJ5p5Vg+sasB/BAGJWH3P
        LD3FHYtfOHKCpkBANOdFKSWttUqoT36+12LoO4I0am9JLnHE+bTVUvO8JJHcQT7pJ4lTa7E
        7QdfYsWZVUQO5d0MBRkMDbVAIa0qqRPn5IrFivRnxnkYqWmP7k4r+ngEjnM5cd1wEXw07Ub
        z5HRmNb4pMROneLl7/T6P760XGwPYtAluSbXdI1XYaTvS2Zx6vYkHJqQa/FvyEmE5DJZe9h
        mCZ4EWf99qtkqZ85sJtrsivRHFbCAb5pG91cM3WXJM2mECCakHuUEbxTNhaV7wCf8cDW0lz
        g929lZSeyGo=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     arnd@arndb.de, ebiederm@xmission.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] sparc64: Fix comment typo
Date:   Thu, 11 Aug 2022 20:19:39 +0800
Message-Id: <20220811121939.27881-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `new' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/sparc/kernel/traps_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 5b4de4a89dec..511756cc7aaa 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -911,7 +911,7 @@ void __init cheetah_ecache_flush_init(void)
 	memset(cheetah_error_log, 0, PAGE_SIZE << order);
 
 	/* Mark all AFSRs as invalid so that the trap handler will
-	 * log new new information there.
+	 * log new information there.
 	 */
 	for (i = 0; i < 2 * NR_CPUS; i++)
 		cheetah_error_log[i].afsr = CHAFSR_INVALID;
-- 
2.36.1

