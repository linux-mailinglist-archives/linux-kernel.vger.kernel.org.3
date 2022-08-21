Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CABD59B504
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiHUPWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHUPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:22:44 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD4515718;
        Sun, 21 Aug 2022 08:22:42 -0700 (PDT)
X-QQ-mid: bizesmtp73t1661095306tw0cv023
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:21:45 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: UtElvlgZTbqDjLnskBt0cSb9R0kgsPM3qW5fjUpVdS2DshLqgqf9GGFWQTRIV
        n8maPYF8atI80Kq+1ktWtoZfybQmQQz5GeiQyinZIAzcQRY4smRBTTeOwBB12rCa0UasJZJ
        BQNYTha2x/oB5Ah3kfTxNhYi7UPOF+ypWIXR0kR6Bh6puACYgbaBxIQctwN0BmaCFUllihM
        nv0wRwa4qsVx+eVuu1c90vFl8tI2n6VkZiQWxnGhUMkBf3pxX7t7rYSkW5twwbTPdeJPsWC
        Oxr+ZWwMlUHoWFi374XFkIJ1tIJ9MD0r6fp278osDg6ONKp0V/1T6E/PFFevjSvwsaPeKMZ
        8PK+mlflaN0yNhfCRYo0IePR4JxV31SUCnhaM99XGuMloZVNp0=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] pci/cx18: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:21:38 +0800
Message-Id: <20220821152138.62100-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
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
 drivers/media/pci/cx18/cx18-av-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-av-audio.c b/drivers/media/pci/cx18/cx18-av-audio.c
index 833baa934448..78e05df9a7ba 100644
--- a/drivers/media/pci/cx18/cx18-av-audio.c
+++ b/drivers/media/pci/cx18/cx18-av-audio.c
@@ -50,7 +50,7 @@ static int set_audclk_freq(struct cx18 *cx, u32 freq)
 	 *
 	 * Many thanks to Jeff Campbell and Mike Bradley for their extensive
 	 * investigation, experimentation, testing, and suggested solutions of
-	 * of audio/video sync problems with SVideo and CVBS captures.
+	 * audio/video sync problems with SVideo and CVBS captures.
 	 */
 
 	if (state->aud_input > CX18_AV_AUDIO_SERIAL2) {
-- 
2.36.1

