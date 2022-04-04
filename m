Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB99B4F1EA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382761AbiDDWKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381130AbiDDVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:22:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323727FC0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:20:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n38-20020a05600c502600b0038e4a0fc5easo363209wmr.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bFlDiB7Yl+vEk/1oUNkeFuM8bNkIWz6zYHUTpxecM0=;
        b=jqBvCJw3e9Zy0AXxEU4UbP/3TXTppzsBxqSvjlzePS9sPBZfoVNut7dgKFSTHqfKAo
         ohLFl4S6XUZjvlqZYTb4SuIL4PrLMQhKKh9pgp6Rt1ClFd8J/gbnag3J5IY6BXcqs0DT
         59BfddhoMjej4Mow31ayuT7L42clo/9iQGAFlqWuT6XJqN1KXbJ9aU1OFXFW/Hvd+2sl
         Y9IDp11lyhXRm2dF2KwoHN424Miga/YyYvkr7nvBGE+RlrQXtJlWvU1UVbeVkMitgh4g
         afl8mBeYDl8Glx7DxJt6jyx/zT796Yyfc50tTbkfclY2/btnH2OsCRd0R4LBK1aPbLv0
         l7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bFlDiB7Yl+vEk/1oUNkeFuM8bNkIWz6zYHUTpxecM0=;
        b=wJlUzBStsDKsPg6ayhMeDx9aqk4ODhC4YbiIf/HFWTcIRbRGdLwURIA0dOV+KT+Yba
         lZhTy4R+X/ou7HwUcvzMmlRm8ql2Pvmtzh8t0ZjD51y43Wn7gf+xBk3WON+zjJJr9AOa
         NPQy+gh0S+nefWWEtwcdnTAw30JSO7lw9gbDwSvQwHMY6AsOtvrLYKyPw13uLQYG7t4e
         sxFJDkGGoA1Hr376oc9bXbvKMjUGMi9kNFQX0DRYgteLdAgi0jp1ztdjfRzS5LdOohks
         SpgnyLJiv+kga7HA5VdvL5QdHCKvpPAHiShd0mhaby1IjqX4+TqfuvJwA+0qugDFAS/F
         Ylrw==
X-Gm-Message-State: AOAM531sX5+faL5AplsSWDqSuKUd01xaqWxhvLywb4TXGp79HXbtNkIX
        LyjBBIDkuP7mv7hfvjCuUbwYj/rvajE=
X-Google-Smtp-Source: ABdhPJxJKPlittVZwsDwfkFErdZ0YsY8p76eVcZFYWXY1FmFqERPcdwilZFXMypEdeumrxgbdlJgpg==
X-Received: by 2002:a1c:f719:0:b0:381:ba:5247 with SMTP id v25-20020a1cf719000000b0038100ba5247mr23415wmh.183.1649107185757;
        Mon, 04 Apr 2022 14:19:45 -0700 (PDT)
Received: from alaa-emad ([41.42.174.117])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b0038e44e316c1sm132294wmq.6.2022.04.04.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:19:44 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] staging: rtl8712: remove Unnecessary parentheses
Date:   Mon,  4 Apr 2022 23:19:42 +0200
Message-Id: <20220404211942.11446-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by checkpatch:

CHECK: Unnecessary parentheses

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 0ffb30f1af7e..7f1fdd058551 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -56,7 +56,7 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
 		precvbuf->ref_cnt = 0;
 		precvbuf->adapter = padapter;
 		list_add_tail(&precvbuf->list,
-			      &(precvpriv->free_recv_buf_queue.queue));
+			      &precvpriv->free_recv_buf_queue.queue);
 		precvbuf++;
 	}
 	precvpriv->free_recv_buf_queue_cnt = NR_RECVBUFF;
@@ -123,8 +123,8 @@ void r8712_free_recvframe(union recv_frame *precvframe,
 		precvframe->u.hdr.pkt = NULL;
 	}
 	spin_lock_irqsave(&pfree_recv_queue->lock, irqL);
-	list_del_init(&(precvframe->u.hdr.list));
-	list_add_tail(&(precvframe->u.hdr.list), &pfree_recv_queue->queue);
+	list_del_init(&precvframe->u.hdr.list);
+	list_add_tail(&precvframe->u.hdr.list, &pfree_recv_queue->queue);
 	if (padapter) {
 		if (pfree_recv_queue == &precvpriv->free_recv_queue)
 			precvpriv->free_recvframe_cnt++;
@@ -319,7 +319,7 @@ static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *prframe)
 	struct rx_pkt_attrib *pattrib;
 	_pkt *sub_skb, *subframes[MAX_SUBFRAME_COUNT];
 	struct recv_priv *precvpriv = &padapter->recvpriv;
-	struct  __queue *pfree_recv_queue = &(precvpriv->free_recv_queue);
+	struct  __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
 
 	nr_subframes = 0;
 	pattrib = &prframe->u.hdr.attrib;
@@ -485,8 +485,8 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
 		else
 			break;
 	}
-	list_del_init(&(prframe->u.hdr.list));
-	list_add_tail(&(prframe->u.hdr.list), plist);
+	list_del_init(&prframe->u.hdr.list);
+	list_add_tail(&prframe->u.hdr.list, plist);
 	return true;
 }
 
@@ -520,7 +520,7 @@ int r8712_recv_indicatepkts_in_order(struct _adapter *padapter,
 		pattrib = &prframe->u.hdr.attrib;
 		if (!SN_LESS(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
 			plist = plist->next;
-			list_del_init(&(prframe->u.hdr.list));
+			list_del_init(&prframe->u.hdr.list);
 			if (SN_EQUAL(preorder_ctrl->indicate_seq,
 				     pattrib->seq_num))
 				preorder_ctrl->indicate_seq =
@@ -980,7 +980,7 @@ static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff *pskb)
 	union recv_frame *precvframe = NULL;
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 
-	pfree_recv_queue = &(precvpriv->free_recv_queue);
+	pfree_recv_queue = &precvpriv->free_recv_queue;
 	pbuf = pskb->data;
 	prxstat = (struct recv_stat *)pbuf;
 	pkt_cnt = (le32_to_cpu(prxstat->rxdw2) >> 16) & 0xff;
-- 
2.35.1

