Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C00E4F0173
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbiDBMa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbiDBMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:30:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7A2E7A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 05:28:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h4so7673747wrc.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+wUVfcP1Kq4anpR9aDlXlD62iSVYYqFHg1dfGPcvyE=;
        b=SuqBZt9WHRSlMmoDljfZ2o6v2iqbSxryE8SmG7HI0zvApvlnAay0YbN9uRijWGsMlQ
         iaLz9+Op0PJFTD6Dl/2RkkC9E0afHnKBFecJi6QwgJm7SGK8bbfrNK7GWjbj1FZepICX
         uKQLS8v77mLfroFmp/MpCHXZeL0RKrTCAO5RO7zXalGMXifVhBbq+0OUiKf0Nn+toN5f
         jM12uokZDPGW6jFzaU9AiGxdOCqW31i7ytMfv1hwVR+eAX5NL6+UVBxCBkh1M6y/3IpJ
         fJBuVtYZ5mF3PjKa/sUaXMxek6J3/Bv+f95BvNnPEtfmXBsfaw8EaC06aI53hmwOefUq
         hblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+wUVfcP1Kq4anpR9aDlXlD62iSVYYqFHg1dfGPcvyE=;
        b=IOCPKWE8kLYxNFEuWxr+nCxMc96LHqqdF7ZdMqcoCiGeIQj4uoK8EecuHt22N3qNYo
         Gt6lt92ZP77JIxgGObyxqpoe5YY526DYbpDsANwB3yb1vRaA3nGhZeXDTmP2S9ZdfUwT
         Ar+cMBqACLmkSOGtyao0BkJRJdqPQeXulPoWrL4WUks4Mr8loWUjELc5aMHicQl4b7zn
         gZbwhqEWIIdiV2ScmOdvXt1h7vAHrSy+1Djgd9KySWts+Hqwa8Dm+VMrJ99TmRS3m8cJ
         6I0CBBGsFDZWqDSZGmj2UaLFNmcm+7on301wb2o2YVuKsvsSWD6yFEEoRwXJ9Iu3zgGa
         S2xg==
X-Gm-Message-State: AOAM530KsxmezkY1pXqP+ViebuvgEh5JlfPlAwGiV00GvJPg7JK8nD/o
        D6F+XbN7CXvIarSS9DctZmqttnbFmws=
X-Google-Smtp-Source: ABdhPJwHB1o3gLPTaHMN2eGdujHQRk9YnbPhNyCqzdRLhiYg7/HNsdgt+L6kRLixDM02UIT7e396hA==
X-Received: by 2002:a05:6000:1d8b:b0:203:df82:ff8d with SMTP id bk11-20020a0560001d8b00b00203df82ff8dmr11039502wrb.623.1648902505436;
        Sat, 02 Apr 2022 05:28:25 -0700 (PDT)
Received: from alaa-emad ([197.57.138.121])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm4563681wrf.80.2022.04.02.05.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 05:28:24 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH 1/2] staging: rtl8712: remove blank line after brace {
Date:   Sat,  2 Apr 2022 14:28:16 +0200
Message-Id: <8c88829f625f9847a1db18fe467399594dacb064.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
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

Fix " CHECK: Blank lines aren't necessary after an open brace '{' "
Reported by checkpatch

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index 84a22eba7ebf..05ba0ca7d627 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -147,7 +147,7 @@ static u32 get_ff_hwaddr(struct xmit_frame *pxmitframe)
 }
 
 static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
-					 struct hw_xmit *phwxmit,
+						struct hw_xmit *phwxmit,
 					 struct tx_servq *ptxservq,
 					 struct  __queue *pframe_queue)
 {
@@ -167,7 +167,7 @@ static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
 }
 
 static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
-				     struct hw_xmit *phwxmit_i, sint entry)
+					    struct hw_xmit *phwxmit_i, sint entry)
 {
 	unsigned long irqL0;
 	struct list_head *sta_plist, *sta_phead;
@@ -201,7 +201,7 @@ static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
 						tx_pending);
 			pframe_queue = &ptxservq->sta_pending;
 			pxmitframe = dequeue_one_xmitframe(pxmitpriv, phwxmit,
-				     ptxservq, pframe_queue);
+							   ptxservq, pframe_queue);
 			if (pxmitframe) {
 				phwxmit->accnt--;
 				goto exit_dequeue_xframe_ex;
@@ -292,14 +292,14 @@ void r8712_append_mpdu_unit(struct xmit_buf *pxmitbuf,
 	r8712_xmit_complete(padapter, pxmitframe);
 	if (pxmitframe->attrib.ether_type != 0x0806) {
 		if ((pxmitframe->attrib.ether_type != 0x888e) &&
-			(pxmitframe->attrib.dhcp_pkt != 1)) {
+		    (pxmitframe->attrib.dhcp_pkt != 1)) {
 			r8712_issue_addbareq_cmd(padapter,
-					pxmitframe->attrib.priority);
+						 pxmitframe->attrib.priority);
 		}
 	}
 	pxmitframe->last[0] = 1;
 	update_txdesc(pxmitframe, (uint *)(pxmitframe->buf_addr),
-		pxmitframe->attrib.last_txcmdsz);
+		      pxmitframe->attrib.last_txcmdsz);
 	/*padding zero */
 	last_txcmdsz = pxmitframe->attrib.last_txcmdsz;
 	padding_sz = (8 - (last_txcmdsz % 8));
@@ -334,7 +334,7 @@ void r8712_xmitframe_aggr_1st(struct xmit_buf *pxmitbuf,
 }
 
 u16 r8712_xmitframe_aggr_next(struct xmit_buf *pxmitbuf,
-			struct xmit_frame *pxmitframe)
+			      struct xmit_frame *pxmitframe)
 {
 	pxmitframe->pxmitbuf = pxmitbuf;
 	pxmitbuf->priv_data = pxmitframe;
@@ -388,7 +388,7 @@ void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
 		/*default = 32 bytes for TX Desc*/
 	}
 	r8712_write_port(pxmitframe->padapter, RTL8712_DMA_H2CCMD,
-			total_length + TXDESC_SIZE, (u8 *)pxmitframe);
+			 total_length + TXDESC_SIZE, (u8 *)pxmitframe);
 }
 
 #endif
@@ -618,14 +618,13 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 	pxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
 	/* need to remember the 1st frame */
 	if (pxmitframe) {
-
 #ifdef CONFIG_R8712_TX_AGGR
 		/* 1. dequeue 2nd frame
 		 * 2. aggr if 2nd xframe is dequeued, else dump directly
 		 */
 		if (AGGR_NR_HIGH_BOUND > 1)
 			p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits,
-							hwentry);
+							  hwentry);
 		if (pxmitframe->frame_tag != DATA_FRAMETAG) {
 			r8712_free_xmitbuf(pxmitpriv, pxmitbuf);
 			return false;
@@ -663,7 +662,7 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 		if (pxmitframe->frame_tag == DATA_FRAMETAG) {
 			if (pxmitframe->attrib.priority <= 15)
 				res = r8712_xmitframe_coalesce(padapter,
-					pxmitframe->pkt, pxmitframe);
+							       pxmitframe->pkt, pxmitframe);
 			/* always return ndis_packet after
 			 * r8712_xmitframe_coalesce
 			 */
@@ -715,10 +714,10 @@ static void dump_xframe(struct _adapter *padapter,
 		ff_hwaddr = get_ff_hwaddr(pxmitframe);
 #ifdef CONFIG_R8712_TX_AGGR
 		r8712_write_port(padapter, RTL8712_DMA_H2CCMD, w_sz,
-				(unsigned char *)pxmitframe);
+				 (unsigned char *)pxmitframe);
 #else
 		r8712_write_port(padapter, ff_hwaddr, w_sz,
-			   (unsigned char *)pxmitframe);
+				 (unsigned char *)pxmitframe);
 #endif
 		mem_addr += w_sz;
 		mem_addr = (u8 *)RND4(((addr_t)(mem_addr)));
-- 
2.35.1

