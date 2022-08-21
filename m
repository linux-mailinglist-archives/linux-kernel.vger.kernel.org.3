Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D68959B4EE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiHUPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiHUPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:16:07 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D38822BE2;
        Sun, 21 Aug 2022 08:16:05 -0700 (PDT)
X-QQ-mid: bizesmtp81t1661094960tuyj8oye
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:15:59 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: uGhnJwy6xZJX01K/LbZyqMYpBBnOjubtMfasGJ5PC2oBqcDuF54HwwQotXyyf
        Y0KVlIOubZQvZfCfgqDj7Vjc1RUn9GgjnPPH56br6y5WIIk/zn3pke+/oc7XnOmEt6yQurX
        PYoBtGSxDn1NNyTvm49zhpVwIFZytV1qlDLLQA5YJkgtGxvnjQNFzxIGUR1SJoPacncVcmZ
        ANiXecLvQv2vyUsnlMp/Uey8rz3WtwBTSzl+77wn3xWqO+8T8Nkh6JZg7uUYzOKKyMsINSS
        WRsjX7fbsxYzMw7ctBCvJq0LVrzEcoIdjsHNWArW9DHWWrHXS40QccBQWsSX+HU8b5t+awY
        gKQyA8/6ZYI0Dur2kOYAJwkUozcNSG4hQlBedVBnvQlphGo1x4=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] i2c/cx25840: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:15:52 +0800
Message-Id: <20220821151552.58514-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'of'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/i2c/cx25840/cx25840-ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/cx25840/cx25840-ir.c b/drivers/media/i2c/cx25840/cx25840-ir.c
index 9d7d1d149f1a..8cef9656c612 100644
--- a/drivers/media/i2c/cx25840/cx25840-ir.c
+++ b/drivers/media/i2c/cx25840/cx25840-ir.c
@@ -196,7 +196,7 @@ static u32 clock_divider_to_resolution(u16 divider)
 {
 	/*
 	 * Resolution is the duration of 1 tick of the readable portion of
-	 * of the pulse width counter as read from the FIFO.  The two lsb's are
+	 * the pulse width counter as read from the FIFO.  The two lsb's are
 	 * not readable, hence the << 2.  This function returns ns.
 	 */
 	return DIV_ROUND_CLOSEST((1 << 2)  * ((u32) divider + 1) * 1000,
-- 
2.36.1

