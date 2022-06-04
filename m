Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F52753D532
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350434AbiFDERj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFDERf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:17:35 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59422E6AE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:17:30 -0700 (PDT)
X-QQ-mid: bizesmtp66t1654316173td47vxll
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Jun 2022 12:16:04 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: qpGeUh0uYB+A4CqLiygihqm5X4tJCpkfoijZT7y7faQKSQao1ktH/4Pf1kKM7
        WTh830hNLpDU6Q0z5HA5BJhYjVDXgPvT9Wdw8/uCXosQPuG8cuIU85+6XEQ1F+R8MfKOC26
        m5f8SqIjgbdySI39ZkcLr616kJCAdK9oJzW8QF4qovfjSSncawG6S5opx0Q9i0H86K/hak6
        6MlI60nb4O0Nx7CTDEcl8YwSB9RNvJAc4M+xLqD9UC5zybOTViYQrnm8JhDAvbygjjRMLL6
        sZnGNSvvT4lb8997am39PL8Vbf+FdlLbBL7HtfmzaJjWCt8CZWfiJGIZrXJYU/NUeNEgLro
        YvRDupMzS8PO1+NQ4g=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] regmap: cache: Fix syntax errors in comments
Date:   Sat,  4 Jun 2022 12:16:03 +0800
Message-Id: <20220604041603.9697-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/base/regmap/regcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index d0f5bc827978..2eaffd3224c9 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -531,7 +531,7 @@ EXPORT_SYMBOL_GPL(regcache_mark_dirty);
  * @enable: flag if changes should not be written to the cache
  *
  * When a register map is marked with the cache bypass option, writes
- * to the register map API will only update the hardware and not the
+ * to the register map API will only update the hardware and not
  * the cache directly.  This is useful when syncing the cache back to
  * the hardware.
  */
-- 
2.36.1

