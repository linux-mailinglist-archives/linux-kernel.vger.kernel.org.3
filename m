Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B125A38DF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiH0Qqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiH0Qqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:46:51 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED404E628
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 09:46:49 -0700 (PDT)
X-QQ-mid: bizesmtp77t1661618800t73ozg1x
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 28 Aug 2022 00:46:32 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 7eMeDS5LHEbiHJSsAFdEgcyqheNAdPRP0MJT8SooaTM6gMOb+CVtND3PJdTfD
        j7prpqfHx9Nw3Du3rRWe06NTmwgubAEaxPX5lxE2jOVEf7YK6hXi9uUZXHU1RXPtw5D8PG/
        uBsu0OrNwUK3VLx+RTlb/SgaGZ5bFb+1U9djCzsZgBZhFmZim+bx6UkhR3YtEg8+Ilpm95A
        bjEJAbuM3r+G6UcrvqH8ZqEnQoLue/nkO23bKSoN1Klp+Z1EKSfLKRlrlZNBVkTulSzv/5E
        EC9Muc3/G31vwITFWPX+/sU1XikSqjChmvT/ryQ0Ab4Ox9L6kBlwm4ZJ+ZPcszfS11b0PyM
        AwQzXfCS65iQ5tStrAxe4Wutvz5Sg16X537ZPqOcUAOC1k/5XMw1L7aSizYlA==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] staging: r8188eu: Delete unneeded variable
Date:   Sat, 27 Aug 2022 12:46:31 -0400
Message-Id: <20220827164631.26448-1-dengshaomin@cdjrlc.com>
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

The variable "ret" is unused except return, so return "0" will be okay.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 047e9c7d38c3..5f309739b493 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2989,8 +2989,6 @@ static int rtw_p2p_set(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-
 	if (!memcmp(extra, "enable =", 7)) {
 		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
 	} else if (!memcmp(extra, "setDN =", 6)) {
@@ -3037,7 +3035,7 @@ static int rtw_p2p_set(struct net_device *dev,
 		rtw_p2p_set_persistent(dev, info, wrqu, &extra[11]);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get2(struct net_device *dev,
-- 
2.35.1

