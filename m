Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A966C4CC1FC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiCCPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiCCPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:54:27 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AD1E868F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:53:38 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id r7so6303308iot.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwLxIaXOaK21ohAinUqvqYAddO4Vte0e4AM7N4ZJWiY=;
        b=T1r6nxQ1vdmFI6/LYEjWcY7i/AS6a6+7EPTzYx6ssumRZvE96gCpmJPqFvNGhiX7Ql
         G4pzgBoHzgBKX7EJa4MDOeGxkx+JGAP8xKO4qfJb3JoK0Ie79hde9JBcufER2SkHNCAh
         f2mRiOpGsVERSxSSBVmyI4nDLX5L8a3nKhjfPTIszu8iYUJdtK99IdDeBONWPa6Y1zPp
         vh5mCCZ6yoBi8embwJlU1cbvx2WZuTp97y+b1GJHwq4rE5SXcKkIMhGUCw7c8pftGzQy
         H7Oh0SpIc1XejEBW0sqWfJbA+3X75Yt4FY8awV+RQc+u3GoxkGu+rZ0zNV2EtzWOcm7B
         HuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwLxIaXOaK21ohAinUqvqYAddO4Vte0e4AM7N4ZJWiY=;
        b=nrY47q5EclFti+INv3xJyPyFo3cvqnXgs9NIhDzUCn7VQyOCsxyMUGcziavUX1vQK8
         SuFQ6bP12hSaLDdauYGvcTpdNqC7QreKH4TZot5IZVhlUS61sdX7XVmwCS8CqSlZNPUT
         /k1kfwjxbGxvTs2gbRYNUeV38N+CLsMyf5dHectvVqwkTuJEBWoErIVDijmCC/qb9ME9
         UQKCZXvWryAyICCX0VuXz/T5XjMszE3Z8LsGkZNVy7HfUfErMeEv9iO57W3tDJcZodOT
         +rOfObY5pu8KjSdq0E2sOgWiYYLTDLW1FI6HFUjftzm0cKZpyvlw+vEYMe2TxFM5Sn6I
         TOqA==
X-Gm-Message-State: AOAM532THMYVXC00ekdQOGvESQamLgNPUHpxgOAL1NIBaaEtcgJTGx5V
        TWFCq3r/W1HTqjiZwLCfzfo=
X-Google-Smtp-Source: ABdhPJyBhdxWQUFPxW714ZQZIEW6NkypKRkY/ttmZ/bbrIwRQxsedtRkYe8m94mqkzI8jRv3D2IrTQ==
X-Received: by 2002:a05:6638:502:b0:30e:4b0c:55cf with SMTP id i2-20020a056638050200b0030e4b0c55cfmr29462445jar.11.1646322818145;
        Thu, 03 Mar 2022 07:53:38 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id a6-20020a92d346000000b002c1a6040691sm2506599ilh.70.2022.03.03.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:53:37 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, paskripkin@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] staging: r8188eu: remove unneeded field pbuf
Date:   Thu,  3 Mar 2022 21:21:10 +0530
Message-Id: <080a9269b9381089e4dc9117f35d0a2d1d0c0259.1646321515.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646321515.git.abdun.nihaal@gmail.com>
References: <cover.1646321515.git.abdun.nihaal@gmail.com>
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

The field pbuf in struct recv_buf can be removed as it can be replaced
with pskb->data. Remove pbuf field.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 6 +-----
 drivers/staging/r8188eu/include/rtw_recv.h  | 1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 063bec94fd7e..673c30ed3cce 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -437,11 +437,7 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 		tmpaddr = (size_t)precvbuf->pskb->data;
 		alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
 		skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
-
-		precvbuf->pbuf = precvbuf->pskb->data;
 	} else { /* reuse skb */
-		precvbuf->pbuf = precvbuf->pskb->data;
-
 		precvbuf->reuse = false;
 	}
 
@@ -453,7 +449,7 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 	pipe = usb_rcvbulkpipe(pusbd, pdvobj->RtInPipe);
 
 	usb_fill_bulk_urb(purb, pusbd, pipe,
-			  precvbuf->pbuf,
+			  precvbuf->pskb->data,
 			  MAX_RECVBUF_SZ,
 			  usb_read_port_complete,
 			  precvbuf);/* context is precvbuf */
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 55b1bb7840c8..e62cda94bc90 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -208,7 +208,6 @@ struct sta_recv_priv {
 
 struct recv_buf {
 	struct adapter *adapter;
-	u8	*pbuf;
 	u8	*pallocated_buf;
 	struct urb *purb;
 	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index a35c78f9ae44..898ae944bd7d 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -25,7 +25,6 @@ int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 	precvbuf->pskb = NULL;
 	precvbuf->reuse = false;
 	precvbuf->pallocated_buf = NULL;
-	precvbuf->pbuf = NULL;
 	return res;
 }
 
-- 
2.35.1

