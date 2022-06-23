Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21EE5572D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiFWGHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFWGH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:07:27 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923C041317;
        Wed, 22 Jun 2022 23:07:25 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 805E71E80CCC;
        Thu, 23 Jun 2022 14:07:07 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HzIKGLSmJDaE; Thu, 23 Jun 2022 14:07:04 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.33])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 173F41E80C7D;
        Thu, 23 Jun 2022 14:07:04 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     jwi@linux.ibm.com, bblock@linux.ibm.com, davem@davemloft.net,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] s390/qdio: Fix spelling mistake
Date:   Thu, 23 Jun 2022 14:05:43 +0800
Message-Id: <20220623060543.12870-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'defineable' to 'definable'.
Change 'paramater' to 'parameter'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 arch/s390/include/asm/qdio.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/qdio.h b/arch/s390/include/asm/qdio.h
index 54ae2dc65e3b..2f983e0b95e0 100644
--- a/arch/s390/include/asm/qdio.h
+++ b/arch/s390/include/asm/qdio.h
@@ -133,9 +133,9 @@ struct slibe {
  * @sb_count: number of storage blocks
  * @sba: storage block element addresses
  * @dcount: size of storage block elements
- * @user0: user defineable value
- * @res4: reserved paramater
- * @user1: user defineable value
+ * @user0: user definable value
+ * @res4: reserved parameter
+ * @user1: user definable value
  */
 struct qaob {
 	u64 res0[6];
-- 
2.25.1

