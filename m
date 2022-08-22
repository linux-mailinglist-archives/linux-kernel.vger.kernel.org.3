Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727BA59BF34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiHVMCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHVMCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:02:47 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8182DA83
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:02:45 -0700 (PDT)
X-QQ-mid: bizesmtp85t1661169750ti33d5a5
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 20:02:28 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: etr5rHAfTVnm+Lzc98pE/65CqMV5oeFwGG6B90zCbVhh86o5K4nP2H9zBUqco
        jnEotxpE8wpgvhE4pkk/9MXQ1ozpiKAnCgTjK11JuKs2AUOi09w1dhgaJOn86JSwFH2H+Jk
        NlBWdduX/jlVTcGXzpDJZygAUhkep4Tj46ezuT6sAUNyqrd+1eDEB2sAiIHr77kzuHt7xwN
        9zykikXFYT5tEumx29yObDEfo5iECMOfOpqNcslTUrAG/TFKTsSmtYfTfVCVYFeQXUO/9Nd
        0CCZ2CyYsozNQhvdeuHbdIn2XkGENMi0kecsZWvRv2wSdralcSR8KXWdrqGx2ilzmbsV243
        XOcBV9S+WDLc0C6m39hC4UOcB6pQkH1weTB5/JmtDSBGAZ/juuLnaeV5XA3+EanE8YwUZkh
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/tty: fix repeated words in comments
Date:   Mon, 22 Aug 2022 20:02:22 +0800
Message-Id: <20220822120222.14281-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?43.154.54.12>]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.
 Delete the redundant word 'should'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/tty/amiserial.c | 2 +-
 drivers/tty/n_gsm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index afb2d373dd47..e18415ba374f 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -12,7 +12,7 @@
  * (non hardware specific) changes to serial.c.
  *
  * The port is registered with the tty driver as minor device 64, and
- * therefore other ports should should only use 65 upwards.
+ * therefore other ports should only use 65 upwards.
  *
  * Richard Lucock 28/12/99
  *
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 137eebdcfda9..1335ec4e092d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -796,7 +796,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
  *
  *	Add data to the transmit queue and try and get stuff moving
  *	out of the mux tty if not already doing so. Take the
- *	the gsm tx lock and dlci lock.
+ *	gsm tx lock and dlci lock.
  */
 
 static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
-- 
2.36.1

