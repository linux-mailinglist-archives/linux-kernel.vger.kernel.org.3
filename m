Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD059FB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiHXNR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbiHXNP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:15:29 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29812AA3;
        Wed, 24 Aug 2022 06:15:25 -0700 (PDT)
X-QQ-mid: bizesmtp65t1661346917t5e5vbjn
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:15:16 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: YHTLUubWl26tp8Z1kHwyK8GiWRigRpaD+E6roL+Jtd8kwrkzL97IzqQ4t+ik2
        qIciubcTOBwQvzoFSvlazQWCWexZ5+2zXpDJXMQh+CKPpQIv9xtlelH24LMN+N7dS4g7iNU
        QukydE7dsrE8spMYsB/VHIuvMNCdqbJja0EH3rcjQG1X9/k/by9jgGj798ZRhKXCL2IhGfG
        SMOzPBgca2kNLwXa2/+3meS+uNQyUrwHlBoCTacJ/JchpX9BwgD3EuAdBR+wsP1CvSaAbbG
        x7D2lJGdRuxC+eVsrXkXsBVEX5RsyKM7YlnBXs3RZNoGZEOZhUx62VDddZ0IQZ4ecmNWcsm
        aB/wjo+SHb9rFhUGciCPjLXfnviptdVSWePdxPk0KqYQCqfPqCze5duX3R0ybpcSVMv8fD/
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     jacopo@jmondi.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media/i2c: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:14:59 +0800
Message-Id: <20220824131459.52485-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/i2c/mt9v111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
index 2dc4a0f24ce8..7beca0b70b72 100644
--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -633,7 +633,7 @@ static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
 
 	/*
 	 * Set pixel integration time to the whole frame time.
-	 * This value controls the the shutter delay when running with AE
+	 * This value controls the shutter delay when running with AE
 	 * disabled. If longer than frame time, it affects the output
 	 * frame rate.
 	 */
-- 
2.36.1

