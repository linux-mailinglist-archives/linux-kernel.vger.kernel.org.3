Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5A4F5B80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbiDFJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351892AbiDFJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:48:12 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D027FDE07
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649217351;
        bh=mwJyGvDfqq8uz4P7M9BPqtkY2gmLd8B4s+4UJ8k46Po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VLIsPgaBJS2Q9MPV1XRhJO96s4iNSZz8n059YkaslVEiMKv0kG0qsH41S5Yd2f5jL
         QbnBF9H37d231AcVWURqfQhcT7ptzczvHSTQcP4haEJRysD+mcjv6BtbYRnFU9OeCm
         SgwB0Gji501M7/rV2VoX/wvRLBivU3KAdk8fS8+k=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id DF0B5296; Wed, 06 Apr 2022 11:55:48 +0800
X-QQ-mid: xmsmtpt1649217348t5lxnp1rd
Message-ID: <tencent_833C53E9E95F05049BD9297781E387622005@qq.com>
X-QQ-XMAILINFO: OakVxA/3u/8RDSac4O7zy62FMOR3lSEOvmucN4D2cPuQzKt5rqAaNqpPE6Noad
         fn/jWG2MdLT7Me1MnSo71Em3/Z9T20ZjsG6m37esCCDGV1TLT/EsrwSh4R69H1J9CzR7BrZyIgd9
         7PJxqi3vGN4e/Uh7sjOfjMlqnv3dFn41h/jaL3PAl4mXDZq7lPmQ8B9zRuVCDSEVm62X39rbv4br
         My79ylFsg0NByYii9a0FXUx22jNjCl70HSzFG01pwR62rhw+Bq0PyIBgnXKxSgC9sYOKKvLTth5P
         eDQce9do1iPFJgYO5tGOvtpSY7MFgQQQ1emn6CttC9lFaQpmS/f+34MYnxZLd4/rlPg1GDzWKFV/
         LZP9tYo2n6KJ1PHzahwKh/+lzdxKSJCQHrJpN2tWFUogB+dTpAHmGSZ3kijnj28Z05XCue8RBTva
         2hi6A40p4PW6GfcA3/5WNdCEizK/6CRfsafcj7CUeCNqC7NQS89IW+KTSnRHZmXsuW+l5Spf1myP
         c9AkYfzkloTUs7TVnysDJluZHYOmMg8UYaeWc4GzroODWrpMb2bGA/LXxEe5M8YV6vxBxKmC5mdd
         HtegzntO1d1obtEtX9p7TutsWZx4bCsqwhwXKXToz3xpeLd1IeUlfdh6i+qhdp2T24oWynrrt1y/
         8yfrxaLqvkS8X86WuCsyIULFvibDh0BGfXL08aM/mm0B8HjEaTI4E9CQM33CJeIpAysf/w2tYBYO
         W0Vp3CikRz0H0GJRR1m2BN69lNTZNwdZRbjWtYZJgQKWUHVinLSOwzQouGl2YPFwG/HBki8ELeN+
         TDzybsZHsPSKG+PQtGAhf8azaYQEUIPZGhVDtKXtcstpK36V41rM61dndM8yStBqE4vv3W9dSJMd
         EYMbe0Kyb8G6hOqEYbZBqB0m5EU3P0sRanb+EtbDl3qJtKx0J4AEJAco2xdOR1OTVYhl1zGCEphx
         GuNd9GsrpEE47eJYptCRZmGc7q928EVii4dPb7J5Q=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3 2/3] staging: rtl8712: change the type of _r8712_init_recv_priv()
Date:   Wed,  6 Apr 2022 11:55:37 +0800
X-OQ-MSGID: <20220406035537.12913-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_8289F062A5E3FF2C104466AF5C5A0E1B0A07@qq.com>
References: <tencent_8289F062A5E3FF2C104466AF5C5A0E1B0A07@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

There is a memory allocation in _r8712_init_recv_priv().  
However, since the original type of this function is `void`, its error 
status can not be feedbacked to its caller.
Therefore, to make the error of allocation failures propagate to its 
caller easily, this patch changes the type of this function to `int`.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 remove kmemleak_not_leak().
v2->v3 update the description.
 drivers/staging/rtl8712/recv_osdep.h   | 2 +-
 drivers/staging/rtl8712/rtl871x_recv.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/recv_osdep.h b/drivers/staging/rtl8712/recv_osdep.h
index d8c1fa7..f5b97c5 100644
--- a/drivers/staging/rtl8712/recv_osdep.h
+++ b/drivers/staging/rtl8712/recv_osdep.h
@@ -18,7 +18,7 @@
 #include "drv_types.h"
 #include <linux/skbuff.h>
 
-void _r8712_init_recv_priv(struct recv_priv *precvpriv,
+int _r8712_init_recv_priv(struct recv_priv *precvpriv,
 			   struct _adapter *padapter);
 void _r8712_free_recv_priv(struct recv_priv *precvpriv);
 void r8712_recv_entry(union recv_frame *precv_frame);
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index c23f6b3..3464ee2 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -44,7 +44,7 @@ void _r8712_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 	_init_queue(&psta_recvpriv->defrag_q);
 }
 
-void _r8712_init_recv_priv(struct recv_priv *precvpriv,
+int _r8712_init_recv_priv(struct recv_priv *precvpriv,
 			   struct _adapter *padapter)
 {
 	sint i;
@@ -60,8 +60,7 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 				sizeof(union recv_frame) + RXFRAME_ALIGN_SZ,
 				GFP_ATOMIC);
 	if (!precvpriv->pallocated_frame_buf)
-		return;
-	kmemleak_not_leak(precvpriv->pallocated_frame_buf);
+		return -ENOMEM;
 	precvpriv->precv_frame_buf = precvpriv->pallocated_frame_buf +
 				    RXFRAME_ALIGN_SZ -
 				    ((addr_t)(precvpriv->pallocated_frame_buf) &
@@ -77,6 +76,7 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 	}
 	precvpriv->rx_pending_cnt = 1;
 	r8712_init_recv_priv(precvpriv, padapter);
+	return 0;
 }
 
 void _r8712_free_recv_priv(struct recv_priv *precvpriv)
-- 
