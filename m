Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A15A8A74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiIABRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiIABRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:17:05 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE0BD4DD;
        Wed, 31 Aug 2022 18:17:00 -0700 (PDT)
X-QQ-mid: bizesmtp75t1661995016tpiku81u
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 09:16:55 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: 18nvhbmG5XeWVm+HKnuWucdz+Dtp2jSZZ5LkBbUVzeMQg0+ItgOBsr3xykviq
        E8h3KMFHMuh/0yLlC+pKrZ+iKd2DcGZ/2JDHqtl/VY24+fEpYvbGFm9vA93mJQOjSCBhRDu
        be3oGbCMt2gytz2epH5cmTFOPXpoh3TgFrB7XONAFvMnVEPzP6ttCngqqYehUOGgc0VqsSn
        9rpnYnvCLGpBmlnwRFm+9FCPQylDSfCfWWB/OxRhSETRQ2EKnYcvLOfEn6Qto0/U4eGRrUU
        vy8HTOfXXB2Hj1jnwovrIuQ18ethd+u1+CMz3Knk7UcKn4CdZ2IcvxlB/A4VizRp9jHFks+
        tBpP/EZUr2EuyV53bTKKMB1u77UPNhnMOihrTQap//c6k9vE+TvXYS94UtckQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media: siano: Use 'unsigned int' instead of just 'unsigned'.
Date:   Thu,  1 Sep 2022 09:16:49 +0800
Message-Id: <20220901011649.24393-1-yuanjilin@cdjrlc.com>
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
 drivers/media/common/siano/smsdvb-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/smsdvb-debugfs.c b/drivers/media/common/siano/smsdvb-debugfs.c
index 8916bb644756..a07d3c335d02 100644
--- a/drivers/media/common/siano/smsdvb-debugfs.c
+++ b/drivers/media/common/siano/smsdvb-debugfs.c
@@ -25,7 +25,7 @@ struct smsdvb_debugfs {
 	spinlock_t		lock;
 
 	char			stats_data[PAGE_SIZE];
-	unsigned		stats_count;
+	unsigned int	stats_count;
 	bool			stats_was_read;
 
 	wait_queue_head_t	stats_queue;
-- 
2.36.1

