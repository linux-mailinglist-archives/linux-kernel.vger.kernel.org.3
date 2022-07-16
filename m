Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75999579F67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiGSNSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243282AbiGSNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:17:54 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CF752E51;
        Tue, 19 Jul 2022 05:34:49 -0700 (PDT)
X-QQ-mid: bizesmtp76t1658234085tuv7s1h1
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:34:43 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000020
X-QQ-FEAT: ALw5QuVtm4WL2HYUo8Y6tXN82bRstdSlfUB8w+iUcdBDMyYc4gvesvZ4NNVYg
        2dCpnBK3CsosZIQv4B9svBxK8YvUcNI2VfM8xZpGSC3i4uJAvlB6hWMrd1cSwbRAPrc0Wwd
        Jhr7MYtp4Pl2OovDLRcKROh9zwXf11HhCkMnkMNuGUR72cm2bvEt+0pNs79GDV9SUgb7yck
        tRXa+OH9/mTN9eJIWStsNn4wj/fN3jqUchgIiziTymze/EMeBNHQuStxsIGV3Ekt18gnI15
        sDdwAQn+yQNkQoOZuhEf8U3p1582DXv6T/EHJbQh0RDHTKd4ijUjHUlmIEE+gsjBolgBUch
        lvIvEvcM3Y5a8vSXpPbVUE6bn9Yq7CwQkB2LT04zu4Sz924QzOhxaum3MA1syVIZUki+7+U
        0ji8mGwDs3g=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     prabhakar.csengg@gmail.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: platform: Fix comment typo
Date:   Sat, 16 Jul 2022 12:32:47 +0800
Message-Id: <20220716043247.41183-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/platform/ti/davinci/vpbe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/davinci/vpbe.c b/drivers/media/platform/ti/davinci/vpbe.c
index 5f0aeb744e81..509ecc84624e 100644
--- a/drivers/media/platform/ti/davinci/vpbe.c
+++ b/drivers/media/platform/ti/davinci/vpbe.c
@@ -280,7 +280,7 @@ static int vpbe_set_default_output(struct vpbe_device *vpbe_dev)
  * vpbe_get_output - Get output
  * @vpbe_dev: vpbe device ptr
  *
- * return current vpbe output to the the index
+ * return current vpbe output to the index
  */
 static unsigned int vpbe_get_output(struct vpbe_device *vpbe_dev)
 {
-- 
2.35.1

