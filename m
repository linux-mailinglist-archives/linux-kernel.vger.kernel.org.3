Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C125541E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357021AbiFVEx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356979AbiFVExP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:53:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BADE62C8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id z14so15093602pgh.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJjZkSNiCRUyDH8c9+KjX8Rp6orUrFEEu//TCWlvtVw=;
        b=EfAakUfvTvHPwmYtL/U0emYHaoaYi4U1zj6JFpfvCt1DK0rBhB8+VIii/TYJVSTHIt
         wS+iqsC1S5kfCgx7Y/729oPRp3bi4sMSm5WYhlEQCJJaSal9dHiXHt0SigdNvrP3q9pO
         sNLyG7gPp2hWNy96rUoz62ajN+whP3P/B9lh9LCKk9KRpy1t8Ube6mkwKraJGn8kF0HB
         we8YOhzQTsWahhkCp/+zAtUPaSONRT6OmXo03YktF5kCSrsCXd9sFeXXNAFDqFFlYw9v
         KMXE2RlF0x1tYr/Z46ltmBRTkkPPlk4yvLT+nBTmTPw2ESoV/uUNDVZ9qX8TI6pozllq
         dMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJjZkSNiCRUyDH8c9+KjX8Rp6orUrFEEu//TCWlvtVw=;
        b=PQvYtBX0JOUYcSc9GTTi/zwfnCp9MxYTFUrPCcJqedprmnaMBfGIS3tIVf015fWG0N
         Pba52B3W+HrNUlWAqDUCNACMUpVnz4Zw2Yf9upoiUX+Xk1qqS4zi5MWH9WQOd+mwYWZF
         t/8lrSrQR7ltc7K8M8nGvVBHnRABIqaHQ0fhyPIg/j9QQ2g/dQ5bi5dXfaR/F/hJLIla
         96Se6iY3rNffseA/XjPKuwqknq3S9g/USRzljOAe1izS4OwzpgugUQP8S5DkfPOlZS8O
         btxi2QTLYld9meIrD3aSIMJ7koeXBF31db1WsMjkNJ3l18laqKtIM3w+f2ZTa+247HIN
         Q+0g==
X-Gm-Message-State: AJIora+PDnvmq6mev2F57gYgjcHEroql8X/FKNIPP5lKyh+uu5siCXlm
        FXloIScfx8a0vKzJcp8Cmos=
X-Google-Smtp-Source: AGRyM1u79SZByc9RiPlW8G1ORiWRgJ5CCetm87jXTERa2WEMJzRDpxgIR+IXo8NQ8FQ1/VMa9mYF7A==
X-Received: by 2002:a05:6a00:cce:b0:525:3bd3:b62c with SMTP id b14-20020a056a000cce00b005253bd3b62cmr5127731pfv.67.1655873593775;
        Tue, 21 Jun 2022 21:53:13 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b00163bfaf0b17sm11660222plf.233.2022.06.21.21.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:53:13 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: Fixed comment style
Date:   Tue, 21 Jun 2022 21:52:33 -0700
Message-Id: <fe45dd24a6ffcb4902a5efacaae63028f7c7a68f.1655872968.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655872968.git.marcus.yu.56@gmail.com>
References: <cover.1655872968.git.marcus.yu.56@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed block comments style as per checkpatch.pl and kernel coding style
guide.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index d42ff210ee81..14dd2344fa4b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -204,12 +204,12 @@ int rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue)
 }
 
 /*
-caller : defrag ; recvframe_chk_defrag in recv_thread  (passive)
-pframequeue: defrag_queue : will be accessed in recv_thread  (passive)
-
-using spinlock to protect
-
-*/
+ * caller : defrag ; recvframe_chk_defrag in recv_thread  (passive)
+ * pframequeue: defrag_queue : will be accessed in recv_thread  (passive)
+ *
+ * using spinlock to protect
+ *
+ */
 
 void rtw_free_recvframe_queue(struct __queue *pframequeue,  struct __queue *pfree_recv_queue)
 {
@@ -1745,9 +1745,11 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 		     !psecuritypriv->busetkipkey) {
 			rtw_enqueue_recvframe(rframe, &padapter->recvpriv.uc_swdec_pending_queue);
 			if (recvpriv->free_recvframe_cnt < NR_RECVFRAME / 4) {
-				/* to prevent from recvframe starvation,
+				/*
+				 * to prevent from recvframe starvation,
 				 * get recvframe from uc_swdec_pending_queue to
-				 * free_recvframe_cnt  */
+				 * free_recvframe_cnt
+				 */
 				rframe = rtw_alloc_recvframe(&padapter->recvpriv.uc_swdec_pending_queue);
 				if (rframe)
 					goto do_posthandle;
-- 
2.36.1

