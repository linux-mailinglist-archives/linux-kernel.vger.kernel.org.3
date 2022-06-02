Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA5353B573
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiFBIzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiFBIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:54:55 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59C188E94
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:54:50 -0700 (PDT)
X-QQ-mid: bizesmtp89t1654160052t1zf8w5m
Received: from localhost.localdomain ( [117.176.187.31])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 02 Jun 2022 16:53:52 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000000A0000000
X-QQ-FEAT: luOaNWLUXql+90tq29tHlaNee6MTAc5jjfOS9XKjMNS+OyiwiwUYqgaGNscJ9
        8tJj84zGyFElEZsdG/8fvCTBcU4NetPRF4vmIw1PNdhFyDYvNKU49/7p1PVjU/yp6IeO7kR
        qNy2bnnnwIBkcB5hXAzb9cWGiy0HU4ZiSfydTM/OArb2LWbQAUMf86QN29iw3JVIkSFCoPG
        A4Jj27zN7MMrQIWB9WobNrxuJrgLvmGW3rH7Vo8sHrqKTzdmVMPssTn+XD/PGEmiuN8Kw5s
        i6F5XN5drdhwQm8yncRYYeYpVNphFNWXr4rR8yt1fhyNXRX/lkrHSSpYJ7UAccuxbCipBsv
        6e2aJJ+YINtwKtZlLI=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jonas@southpole.se
Cc:     stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] openrisc: Fix syntax errors in comments
Date:   Thu,  2 Jun 2022 16:53:50 +0800
Message-Id: <20220602085350.12741-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/openrisc/kernel/unwinder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/unwinder.c b/arch/openrisc/kernel/unwinder.c
index 8ae15c2c1845..c6ad6f867a6a 100644
--- a/arch/openrisc/kernel/unwinder.c
+++ b/arch/openrisc/kernel/unwinder.c
@@ -25,7 +25,7 @@ struct or1k_frameinfo {
 /*
  * Verify a frameinfo structure.  The return address should be a valid text
  * address.  The frame pointer may be null if its the last frame, otherwise
- * the frame pointer should point to a location in the stack after the the
+ * the frame pointer should point to a location in the stack after the
  * top of the next frame up.
  */
 static inline int or1k_frameinfo_valid(struct or1k_frameinfo *frameinfo)
-- 
2.36.1

