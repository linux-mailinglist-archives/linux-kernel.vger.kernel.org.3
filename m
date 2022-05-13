Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5573525C95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377922AbiEMHvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377915AbiEMHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:51:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78CB2655E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:51:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso7122681pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=QrqaDOovabmDJIWbQp5jwa4H/wrRF/tDldOr21QOUG4=;
        b=JZDuLkdBTFDQ7KWBfaXar4nccamEVRPV8aYGT+jAlBqgUy7xAE50b6PfTPWkSpBSUJ
         RfFaWL13Ii0HXejxG2THMOhsk9sCuc+TPRKm8lT7Eq2TNzG6iLB6b2PdXtWhZ4i0vPm/
         FxVPUhzwel0M2NDefl0HXRj6j3TjEPQ7WydboFnFx7mTbhYLuzjLrt6dLnFYonvS6i95
         hciohckIA9Xho+Z63+dFvOYwOdFz4q2aRdcnfbOJgdEEvjwBxk3apgJ801Ps03VkbtZP
         TyKAi20gCp1duBtVxmFmw9lP0GoUsN/xNgpzECLb91m/k7apWSG+dBS8wHADLmnAOwla
         Tl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QrqaDOovabmDJIWbQp5jwa4H/wrRF/tDldOr21QOUG4=;
        b=PDA2OIz0X31iK5V37waXNUgQVaK5Tr0Q6YOyQECzDS3UnJs4+4i5stpzchhE0F0mk0
         EalgMaXJEywWXnrdw9vPDzYjBnp8IA82+f3B+y3ci1ofdPkQEfndKYe+48qG6hK+1292
         a8AuzJP3pboVI2JqspagUR+TlEqGrd4cCW2wpwYTxQJJnUV/m/UJYL18x2hcW5wDOJqK
         IYeAQuchQjN1VhZHDEjGLj/FoJ6MFgxmAbTuZZDRKtMjLTVgJ7/cUr6TOhK7wlzlxwuc
         yxm4YNWW2IWiCRvW+EWnX3ODfn7B44MYplm09PLxt8HiaAfV0NQg6x5jZYL+BGwpXbW+
         RwGA==
X-Gm-Message-State: AOAM531uZMZsKCF9UodpEKrdC3uvowtvW4q+Qhp7y2QCGp0lfHQv9td8
        4AuijiO3jso85FgOlKm/lgVjyFyykfeJmw==
X-Google-Smtp-Source: ABdhPJyWmgoWTR40oS2xAUiT/lGyMb4AB8dUzXDLfA22y1IuOAspj8AvdRVmVI6ODS+SgiFp0oniyw==
X-Received: by 2002:a17:903:1252:b0:154:ca85:59a0 with SMTP id u18-20020a170903125200b00154ca8559a0mr3689431plh.169.1652428299951;
        Fri, 13 May 2022 00:51:39 -0700 (PDT)
Received: from Negi ([207.151.52.3])
        by smtp.gmail.com with ESMTPSA id w18-20020a62c712000000b0050dc7628166sm1099898pfg.64.2022.05.13.00.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 00:51:39 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Fix block comment format
Date:   Fri, 13 May 2022 00:51:07 -0700
Message-Id: <20220513075107.23285-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux coding style. Fix the below checkpatch warning:
 WARNING: Block comments should align the * on each line

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 60 ++++++++++++-------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index d086812f8c0e..806e24743ecc 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -52,8 +52,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	sema_init(&pxmitpriv->terminate_xmitthread_sema, 0);
 
 	/*
-	Please insert all the queue initializaiton using rtw_init_queue below
-	*/
+	 * Please insert all the queue initializaiton using rtw_init_queue below
+	 */
 
 	pxmitpriv->adapter = padapter;
 
@@ -66,10 +66,10 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	rtw_init_queue(&pxmitpriv->free_xmit_queue);
 
 	/*
-	Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
-	and initialize free_xmit_frame below.
-	Please also apply  free_txobj to link_up all the xmit_frames...
-	*/
+	 * Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
+	 * and initialize free_xmit_frame below.
+	 * Please also apply  free_txobj to link_up all the xmit_frames...
+	 */
 
 	pxmitpriv->pallocated_frame_buf = vzalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
 
@@ -853,17 +853,15 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter, struct pkt_attrib *pat
 }
 
 /*
-
-This sub-routine will perform all the following:
-
-1. remove 802.3 header.
-2. create wlan_header, based on the info in pxmitframe
-3. append sta's iv/ext-iv
-4. append LLC
-5. move frag chunk from pframe to pxmitframe->mem
-6. apply sw-encrypt, if necessary.
-
-*/
+ * This sub-routine will perform all the following:
+ *
+ * 1. remove 802.3 header.
+ * 2. create wlan_header, based on the info in pxmitframe
+ * 3. append sta's iv/ext-iv
+ * 4. append LLC
+ * 5. move frag chunk from pframe to pxmitframe->mem
+ * 6. apply sw-encrypt, if necessary.
+ */
 s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct xmit_frame *pxmitframe)
 {
 	struct pkt_file pktfile;
@@ -1207,24 +1205,22 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 }
 
 /*
-Calling context:
-1. OS_TXENTRY
-2. RXENTRY (rx_thread or RX_ISR/RX_CallBack)
-
-If we turn on USE_RXTHREAD, then, no need for critical section.
-Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
-
-Must be very very cautious...
-
-*/
-
+ * Calling context:
+ * 1. OS_TXENTRY
+ * 2. RXENTRY (rx_thread or RX_ISR/RX_CallBack)
+ *
+ * If we turn on USE_RXTHREAD, then, no need for critical section.
+ * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
+ *
+ * Must be very very cautious...
+ */
 struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pfree_xmit_queue) */
 {
 	/*
-		Please remember to use all the osdep_service api,
-		and lock/unlock or _enter/_exit critical to protect
-		pfree_xmit_queue
-	*/
+	 * Please remember to use all the osdep_service api,
+	 * and lock/unlock or _enter/_exit critical to protect
+	 * pfree_xmit_queue
+	 */
 
 	struct xmit_frame *pxframe = NULL;
 	struct list_head *plist, *phead;
-- 
2.17.1

