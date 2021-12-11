Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37B447131B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhLKJPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 04:15:16 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:16281 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhLKJPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 04:15:16 -0500
X-QQ-mid: bizesmtp39t1639214080tw1e00jy
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 11 Dec 2021 17:14:39 +0800 (CST)
X-QQ-SSF: 01000000008000D0H000B00A0000000
X-QQ-FEAT: Lg5IqoGaTUgN7XQ3N7S7FwNtz5DDynVfo7MHXh6ZEglsDDRHhNkoI6vuS8HML
        HivY8m9Phq/uREtD3XIrcLUMim/igcB6MHHsiGKaQ3Wg6iAEwRnYiVcIxXmYgabomUo6XKr
        ri8AiODTzCg85916Jf/+PJFcNWiFrtiw/PSOASTzffyBg93z7Du8LZBRKPlGHxYkL39Kpz+
        BXlzbUTNTesb0h1crcPOez21DjBv7J7+C9Sp/JorQZd8k3mV2vxIxaWeTXc2Jui2YXshH8O
        3ysC0SATK8F7vnFoThCpMS6XrJyPX986Vnuruo9BBaxXtzCweWev4VuIfaY+UdzEbMgxsA4
        ku9c0GBZLkPMqm4MCqADMTO8VaelWhRwmRBEkPj1ydijfV6+Ug=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     lee.jones@linaro.org, wangborong@cdjrlc.com, coldcity@gmail.com,
        len.baker@gmx.com, dev.dragon@bk.ru, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: remove some repeated words in some comments
Date:   Sat, 11 Dec 2021 17:14:22 +0800
Message-Id: <20211211091422.260442-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `new' in the comment in line 1349 and `to' in the comment in
line 2030 are repeated. Remove the repeated words from these comments.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 1a193f900779..1a43979939a8 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1346,7 +1346,7 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 
 	short apset, ssidset, ssidbroad, apmatch, ssidmatch;
 
-	/* we are interested in new new only if we are not associated
+	/* we are interested in new only if we are not associated
 	 * and we are not associating / authenticating
 	 */
 	if (ieee->state != IEEE80211_NOLINK)
@@ -2027,7 +2027,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
  * N = MAX_PACKET_SIZE / MIN_FRAG_THRESHOLD.
  * In this way you need just one and the 802.11 stack
  * will take care of buffering fragments and pass them to
- * to the driver later, when it wakes the queue.
+ * the driver later, when it wakes the queue.
  */
 void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *ieee)
 {
-- 
2.34.1

