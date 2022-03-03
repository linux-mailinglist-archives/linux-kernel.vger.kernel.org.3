Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A344CC1FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiCCPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiCCPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:54:17 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD77BF970
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:53:29 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id f14so6315086ioz.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YihgJUJcKUepElU6ZGSDtmFFyQk1sWFC8hH6Pg8liNU=;
        b=fADTev/VBuZIkxTgMAAcFysd6mPMYFTZNXYLcHb+GE0KUeHD5I8MFKVpujuhp5iGA1
         diclXF6fhvXuwUivl3jjJDrTAbL18WO1GijShBsDlypsT2edvEnl1/LD1Faly2Ct1ZNE
         zah4EtYX8paQ1LL9/0nlZFL1/x5k7dBcYBXoYCpUF9vxryUsuGRLYyAaCDfkvpEK48Lp
         eW+8VYphGRopSi8I6WRm3RiyTWMQvRyL6zhN/ZPdCQg5eMh7QI/UFRxb4pypN4urEFlz
         9aBLCoUTOIGqI2X0mSs+EYw1An4vwgYoyo116RGEFBQ2jtUMU/0wuHeCXXX4GuyPNYiN
         58kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YihgJUJcKUepElU6ZGSDtmFFyQk1sWFC8hH6Pg8liNU=;
        b=1Z/UHUUQwhxrXDideTxd4HFhsYkxbx5fKv4YXDbIGku1BCZ9ekoXoDjHCGpRuxRR4r
         X82E/T8h/7rIHhhVxr27J5ABgny0Fs0kSIrl1YFvl6iaT9cc9s/BXu+mDqzrT6eQeOX5
         pbkhhCKzMeothLlLO/SHNCWk8oDocmCg2FDeARGFaCl3BiT9FKh8NJu0hSmehYTE9zoB
         ULyQTizVS4/9sllEQQk6TTewHuO3KVfCHeOnA3Qb2iI6RIsKH0gtiGnMVxsMcTejIbpC
         izNGTFfkWw8psQolxkLPmoLjMPi2wReSuKsJTY51XFLug6h99PqTnEHdt+KybRYjsD7i
         1QJQ==
X-Gm-Message-State: AOAM530xtP4InidQC81j0QS5vfVP8Th6L2SFdN/6ePTksHIIxiHm6spF
        XjxYMKdPQvW2cOL7kTRO+qDdrgCavN4=
X-Google-Smtp-Source: ABdhPJzXsA6ckuejxDUGB0IHIIN7T6tWsz71XsI4jTdRl3o20IZXjgKCbN6l+KGl4FWm6BWoAGNAdg==
X-Received: by 2002:a05:6602:3c5:b0:613:8644:591c with SMTP id g5-20020a05660203c500b006138644591cmr28148980iov.161.1646322809228;
        Thu, 03 Mar 2022 07:53:29 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id a6-20020a92d346000000b002c1a6040691sm2506599ilh.70.2022.03.03.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:53:28 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, paskripkin@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] staging: r8188eu: remove unused field pend
Date:   Thu,  3 Mar 2022 21:21:08 +0530
Message-Id: <2ccf7067c411716a05bb6fa0acc04d5a612b5f12.1646321515.git.abdun.nihaal@gmail.com>
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

The field pend in struct recv_buf is set but not used.
Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 1 -
 drivers/staging/r8188eu/hal/usb_ops_linux.c  | 2 --
 drivers/staging/r8188eu/include/rtw_recv.h   | 1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 1 -
 4 files changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 7a787944064f..9f772fc7d6c1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -16,7 +16,6 @@ void rtl8188eu_init_recvbuf(struct recv_buf *precvbuf)
 {
 	if (precvbuf->pbuf) {
 		precvbuf->pdata = precvbuf->pbuf;
-		precvbuf->pend = precvbuf->pdata + MAX_RECVBUF_SZ;
 	}
 }
 
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 74a221db1c3d..f16a6bb21ab4 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -441,11 +441,9 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 		skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 
 		precvbuf->pdata = precvbuf->pskb->data;
-		precvbuf->pend = skb_end_pointer(precvbuf->pskb);
 		precvbuf->pbuf = precvbuf->pskb->data;
 	} else { /* reuse skb */
 		precvbuf->pdata = precvbuf->pskb->data;
-		precvbuf->pend = skb_end_pointer(precvbuf->pskb);
 		precvbuf->pbuf = precvbuf->pskb->data;
 
 		precvbuf->reuse = false;
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index c97ec9d0feed..f7bc1c9579fc 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -211,7 +211,6 @@ struct recv_buf {
 	u8	*pbuf;
 	u8	*pallocated_buf;
 	u8	*pdata;
-	u8	*pend;
 	struct urb *purb;
 	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
 	u32 alloc_sz;
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index fd29f06b375a..c8a0ac80df69 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -27,7 +27,6 @@ int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 	precvbuf->pallocated_buf = NULL;
 	precvbuf->pbuf = NULL;
 	precvbuf->pdata = NULL;
-	precvbuf->pend = NULL;
 	return res;
 }
 
-- 
2.35.1

