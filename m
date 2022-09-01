Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C445A8A91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiIABXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiIABXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:23:14 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED58214FC82;
        Wed, 31 Aug 2022 18:23:08 -0700 (PDT)
X-QQ-mid: bizesmtp86t1661995383tf6b7xma
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 09:23:01 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: 9E3Ddn8eo0LQgNSXZVdgud8z0yQ0Cn35g1PJs2XVEc34sQusOu8mptrcaab57
        r2TgtwvWyDLddhRh7bsRDIAyCRME8N0tkXEVREDX0053GLdLw5mszFVjj5knZkFY/PmppyA
        u10RMrXxaXaOY9NdUUEmliGdY/Md1X07ZxGAoRO/8DNNw6Sza5x9Ywj/K7X+9PZTMjBM2fa
        6F6kvP72AgJpVQHd/irmSzPSc36K8KUN9nYJ5vVRc6CPMRQkcg7e65plJw6aRivdAl/gd82
        jY6uepBGCYmZXK5usF6nwCudXwZRk4C/cOqLara48DJvOrd9fCp6jjQXynehq/BEmsbxcJB
        qfidrLyi6qDkiuU+uTQWifLB7Noqlt+WofNyRFoViQtbvwB90uiLTax4EcK/w==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media: videobuf2: Use 'unsigned int' instead of just 'unsigned'.
Date:   Thu,  1 Sep 2022 09:22:55 +0800
Message-Id: <20220901012255.26586-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' should be clearer than 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b203c1e26353..abfd84173df6 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1590,7 +1590,7 @@ static int vb2_start_streaming(struct vb2_queue *q)
 	 * should be returned to vb2 in start_streaming().
 	 */
 	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
-		unsigned i;
+		unsigned int i;
 
 		/*
 		 * Forcefully reclaim buffers if the driver did not
@@ -2738,7 +2738,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
 	 * else is able to provide this information with the write() operation.
 	 */
 	bool copy_timestamp = !read && q->copy_timestamp;
-	unsigned index;
+	unsigned int index;
 	int ret;
 
 	dprintk(q, 3, "mode %s, offset %ld, count %zd, %sblocking\n",
@@ -2914,8 +2914,8 @@ static int vb2_thread(void *data)
 	struct vb2_queue *q = data;
 	struct vb2_threadio_data *threadio = q->threadio;
 	bool copy_timestamp = false;
-	unsigned prequeue = 0;
-	unsigned index = 0;
+	unsigned int prequeue = 0;
+	unsigned int index = 0;
 	int ret = 0;
 
 	if (q->is_output) {
-- 
2.36.1

