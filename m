Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FDB589B37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiHDLvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDLvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:51:50 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229FD3A495;
        Thu,  4 Aug 2022 04:51:47 -0700 (PDT)
X-QQ-mid: bizesmtp73t1659613902tr8iibs5
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 19:51:41 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: zT6n3Y95oi3QnsI+KB1b3gOsSd/OwBhg+NIW0w3VPkMU/9UU/jac1/XNsRCqE
        6meyz9FBif5CoQ3dG3EHxIIeatNTljn7txE/jSGRQIzxX/LAmaC5Na/7Y+cHv8HceH26nyx
        jgI8g3C7y0uZk4rXaucOX4JGFebARRdWo1MJ9zugLO9EIjp7P95Z34t5jFjf8wgakWv6yna
        YoxzHrjERJwEdVDJ186iuKo5L/PYg8XaFTVDMM4zSmhFyLTwC6lu9DsQBfAQ+roSUKzF3sN
        b/IQXtTtWk9q5SVTnZuE0vBXMx0+3SbmoGF7zofw6+l30tYGD3QpBgcg8mKSm38cdKTPZ5A
        KB/j07fbxn94LGg8VgO6lyEG9IY2uBZp7bH8Zkh9g08uFDUzTb+3iwWsG6j6JzftQnfNeWM
        R6hnixn2cuw=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: drxk: Fix comment typo
Date:   Thu,  4 Aug 2022 19:51:38 +0800
Message-Id: <20220804115138.49419-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `for' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/dvb-frontends/drxk_hard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 9430295a8175..47d83e0a470c 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -3516,7 +3516,7 @@ static int set_dvbt_standard(struct drxk_state *state,
 	status = write16(state, IQM_AF_CLP_LEN__A, 0);
 	if (status < 0)
 		goto error;
-	/* window size for for sense pre-SAW detection */
+	/* window size for sense pre-SAW detection */
 	status = write16(state, IQM_AF_SNS_LEN__A, 0);
 	if (status < 0)
 		goto error;
-- 
2.35.1

