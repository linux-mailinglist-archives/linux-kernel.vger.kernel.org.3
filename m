Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0B57F39E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiGXHRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiGXHRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:17:08 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E1117E09
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:17:02 -0700 (PDT)
X-QQ-mid: bizesmtp88t1658647012tvsenpzu
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:16:51 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: CR3LFp2JE4l+x/aUAW/kH4Yeux/esqp51VUCsV6tLvhKa3E7TgFtxZcf+smTw
        MzS5YYLVq4JmNLwgpPuH4xI82M1cx52rhWRfZBadf+Wafilj+3/Y79TbFz1Tt34m8YLtRtx
        /ycVL1gX2rkC0ia75Zdv/maN8b9I5mbfDdQh3noUnQwhBeos4mrtPQvN2KScW+2izZr+BrS
        40AtWAh6lxP/oylxX+4CkKxY4Dl0SPDtlB1pyLKf5AhOiKaudfzlBWfbhNeVQzob7byjzaj
        QNftpWiPOxKFxH+9uhtBSAh1cxbK0X1ARIqT4zi9PdtS8pQybN21rqGGOGEPoLGR88u6Lgj
        bL8yUZlcphd4jZy8XLKDDutku05KiePOa04/FWPyKYuIkABOLI=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] usb/6fire: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:16:44 +0800
Message-Id: <20220724071644.10630-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 sound/usb/6fire/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index 7168f1c6a37a..32c39d8bd2e5 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -175,7 +175,7 @@ static int usb6fire_pcm_stream_start(struct pcm_runtime *rt)
 			}
 		}
 
-		/* wait for first out urb to return (sent in in urb handler) */
+		/* wait for first out urb to return (sent in urb handler) */
 		wait_event_timeout(rt->stream_wait_queue, rt->stream_wait_cond,
 				HZ);
 		if (rt->stream_wait_cond)
-- 
2.36.1

