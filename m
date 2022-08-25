Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BDD5A152A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbiHYPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242703AbiHYPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:04:00 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C14B81D7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:03:48 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661439786t2i9nrb6
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 23:03:00 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: ILHsT53NKPgo6CVByiP5FDaChDOa8bpPjPIfuK+PgRDGKENnLp3+8x/uhteUs
        c/zlmGytvAMjN4k/U9DQC7lCLZXFjh6svzcWOv+uLYi+RhvRFIMNXKH5V24eBmcrpddkCdm
        t0F31XrrKabFvEOTPbUWMVdPPizrz3dbVJMJ8kr4DHeKB4OfRroRoXcaRVcvQ7XSHTILVBu
        jS5fJX9JWoVjk77RCUFVNli08ne2d7jXlPuRJPjceWYnYpscpZjDxvKpnz+JOFbOjJU3XdG
        R8pQMRtrM4Ly4mHEsjFyPgeEtyB8/A17Zb/4pZ2jrReRZSedQfhhbkTlErNm1TlvIZOrQjO
        fO4U3+S2TheaG6BYHFYT/T52ZYpzMEzpq6l3Gx4mko6nK8BPBr7RorEECxWZ6cslgkyjwGE
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     baihaowen@meizu.com, dan.carpenter@oracle.com,
        paskripkin@gmail.com, dave@stgolabs.net, edumazet@google.com,
        dengshaomin@cdjrlc.com
Subject: [PATCH] staging: rtl8192e: Fix comments typo
Date:   Thu, 25 Aug 2022 11:02:58 -0400
Message-Id: <20220825150258.8967-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix double word "new" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b5f4d35954a9..9e6d7c5716ff 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1611,7 +1611,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 
 	short apset, ssidset, ssidbroad, apmatch, ssidmatch;
 
-	/* we are interested in new new only if we are not associated
+	/* we are interested in new only if we are not associated
 	 * and we are not associating / authenticating
 	 */
 	if (ieee->state != RTLLIB_NOLINK)
-- 
2.35.1

