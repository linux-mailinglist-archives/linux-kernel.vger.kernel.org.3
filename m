Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A491C5A8A83
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiIABUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiIABUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:20:16 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8F2DAA4;
        Wed, 31 Aug 2022 18:20:10 -0700 (PDT)
X-QQ-mid: bizesmtp71t1661995206t3v7x6o2
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 09:20:05 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: 4rCmCcmdMHfaY1WQWesDmjP4jvXA66jlw2+1CTnfx5ssoXmG6o5kmyrWaDmto
        Ny6qgLaw2s0aaRdK0m3f5m0LWgRsZVZ5+4YhyfgtANlk+ES9p0ksz54jPtL0vvTbu6JJ8Zk
        zJDYB1VlP0edJLEXlOwl4nxfS/DGAdZC4ArbkEW9oKcA1mkPSErvBuYpURv0NyfdPDg96G7
        JtrIluaoYqtYGUdVZR0XfCcAIw/Gx5GsFA8F4laZ8VGG5Jc4YUSvAcsAQe2t94DqATD61tw
        T70QBMs+nHmWQLwiI5MGQIF27DKnRnaJHfX/SIKUz8T77ujtWCowbHBqw+j8z4du4f4kvqY
        pbezeCOQRDW4xbf6nLNmCRghNjcY1sPe96HJbfWo8Qnb7LMYlGqSS+/vhHPIg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media: videobuf2: Use 'unsigned int' instead of just 'unsigned'.
Date:   Thu,  1 Sep 2022 09:19:58 +0800
Message-Id: <20220901011958.26027-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 T_SPF_HELO_TEMPERROR SPF: test of HELO record failed
        *      (temperror)
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' should be clearer than 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index f26cb8586bd4..2e1adf88aa55 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -754,11 +754,11 @@ EXPORT_SYMBOL_GPL(vb2_prepare_buf);
 
 int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
 {
-	unsigned requested_planes = 1;
-	unsigned requested_sizes[VIDEO_MAX_PLANES];
+	unsigned int requested_planes = 1;
+	unsigned int requested_sizes[VIDEO_MAX_PLANES];
 	struct v4l2_format *f = &create->format;
 	int ret = vb2_verify_memory_type(q, create->memory, f->type);
-	unsigned i;
+	unsigned int i;
 
 	fill_buf_caps(q, &create->capabilities);
 	validate_memory_flags(q, create->memory, &create->flags);
-- 
2.36.1

