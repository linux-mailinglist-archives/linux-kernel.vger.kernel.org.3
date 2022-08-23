Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ABE59E7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbiHWQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245169AbiHWQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:39:55 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E6B115C;
        Tue, 23 Aug 2022 07:41:25 -0700 (PDT)
X-QQ-mid: bizesmtp63t1661265681tj79in0v
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:41:20 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: jbaoaN/hLKLzyiwpz6X66a4WYpeCEb0/P3xe+DnxWmKGfGVhb2h8juu2G3MWL
        YjIxC9Ran96iqgPGKmS5EKWv425WOAd0ruXMi22wOqKnxBIn1RTbD4Vy84MQczrlaZZI9CQ
        zsWzdcpvR1lxnWW2yDEJgL+P0p2xxuXEiwS7zeyV84ZIrNkVraNY0sVgWJbXC1/m2J9Co7g
        c9VXHHNjbHr4IEQaJLeT85d6mzdPt3KcqOZFfQDCGiIxFdyhwBvEdXrdMmZkMxeMa22IRRh
        XHJetB4GhfRea9bF/X+pGYk0oGicEs3D95a+x0KVPzVtyYtg4P2ZJd4UqexxoFsTF+1FvpZ
        9Mx7FswRxpg1vcJt8qWS0KAQdMSWpPs7P+XUwQoiH7FXlre9QYme1QmECL1CA==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     prabhakar.csengg@gmail.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] ti/davinci: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:41:03 +0800
Message-Id: <20220823144103.31566-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
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
2.36.1

