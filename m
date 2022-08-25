Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2A45A1062
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbiHYM1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiHYM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:27:06 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B8AB2871
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:04 -0700 (PDT)
X-QQ-mid: bizesmtp62t1661430412t51laxfj
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 20:26:51 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: ILHsT53NKPijEBeKhvrs7x4kNBMF8sdjP+lC1OBtQpIPBHG5kct3gEo0GsiFm
        DBh2b1t5/0j76TGgiyJj9qGMDi49LEaB4HIOhRRoJnAEY2J9Lu3WmkEbE2MLdoKTHg+LOLq
        D66Rp/iMPjXD8GKEx/xDyJQNyd3rUIO8LbyCIFHqmNICpYt6ITXIV9WJ+/fkvaPWaJQQO/r
        +3IbMzdgT0c9wXAwPIqRn5n7+D51wsOxN5KduS3qJjYzRLFJf6xa+x9VPlXfj6kSe8Svxbq
        6jpY31UWJqwNbPCXVxysHlJ1Otu/E4F0e276SNEV7oZl9ebnt7S0gQWOiJuy+Z3RFDjm2y3
        L41jQYFrpVt4FTlVwT3lMLNEYtX8jA2qMxB98xl95sY9APAz6JnnWUkaaFi2A==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, duoming@zju.edu.cn, dave@stgolabs.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] staging/rtl8192e: fix repeated words in comments
Date:   Thu, 25 Aug 2022 20:26:45 +0800
Message-Id: <20220825122645.27588-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
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

 Delete the redundant word 'new'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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
2.36.1

