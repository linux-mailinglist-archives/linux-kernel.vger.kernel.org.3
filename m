Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F034CC1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiCCPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiCCPyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:54:05 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC3E5F8C6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:53:15 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y5so4321708ill.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIpI3npq5phDRjrFvP94Jr7V5vgXrH/mDklakdcvMfE=;
        b=lHOrIlfddL76oMIFw5LvA+rDj5YYjRVo/0Awqk7pDKX8pyADNJAFeXOUTQF4iFopfW
         IbxK/RYtiqPMi0uqN123tYJpuCvkgoBMRocs7uw42e0dHACwPByYiB/L0Ph6NXwg8OwE
         7p7OtpI8l7CKZZqe9CM0gmW7Tp9SdhVIljtFUfKTXyZK5eQC8bSPGNPcL3q4Up5mdGi4
         z/MrN58yc9xRFT26cwvalJbpiRESwdr0F7dGex1so1bAxdmX8NCCWztS/bAZM1mliEEX
         RYAxiWb4/uG3GCoJWwyS05H7AVseulrCK52JaJgqwzdq42kKGHN5r7etKrzQCey2Mh+B
         IGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIpI3npq5phDRjrFvP94Jr7V5vgXrH/mDklakdcvMfE=;
        b=r9WWq0NLMcqs+SbqdWoMOGKvVzU/gKV9VzD5ecitgvBi+t71+L7o2sLut9t/fdMJWL
         fXw5NSzO3zcWpEDKkgmwGEmvfwDAzbxwHdNeE9lLaxz6dHrH9NCSx3Xeeiwy1blVuuoD
         cPIh7isPMLi4KU8Yn03AYnnNfSTZ9smv8DVcY3sHMR9CO1TL65VDlQMNjW3JCVyLsxLA
         g1AhYw+BEggRsYo0rR29TIz2kLrBpdwKIA2Xsvhj86l8K4RFgfuQh1uOxFXgoLqO4kWN
         Qm5jhMM1ckKRVMuoXXYzlFOIQwb3zantGVHW8rq4h5/25EjGz66nRTmJ4JveWTJ7vbo6
         PorQ==
X-Gm-Message-State: AOAM532X5/X7lSEn2fsM0h78HkPKsev0xM7w1nwrWoDHuRjQIrDVgAdh
        1QWExYrDqfG+QGg7PUV7eak=
X-Google-Smtp-Source: ABdhPJyJunYkAQ7b+7txtuE78EgMbKxNjPCwQs7b+H7Z/5982NqwLQCkNExknLf7KPdO5u7XuGo0DA==
X-Received: by 2002:a05:6e02:1c83:b0:2c1:ed61:9241 with SMTP id w3-20020a056e021c8300b002c1ed619241mr30126412ill.202.1646322794911;
        Thu, 03 Mar 2022 07:53:14 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id a6-20020a92d346000000b002c1a6040691sm2506599ilh.70.2022.03.03.07.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:53:14 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, paskripkin@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] staging: r8188eu: remove unused fields in struct recv_buf
Date:   Thu,  3 Mar 2022 21:21:05 +0530
Message-Id: <fe5565c02a01babf64469333dae73cbdd841d393.1646321515.git.abdun.nihaal@gmail.com>
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

The fields len, ref_cnt and transfer_len in struct recv_buf are set
but not used. Remove them.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 7 -------
 drivers/staging/r8188eu/hal/usb_ops_linux.c  | 1 -
 drivers/staging/r8188eu/include/rtw_recv.h   | 3 ---
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 2 --
 4 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 19d22db56e7d..76bf57c52a7e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -14,12 +14,6 @@
 
 void rtl8188eu_init_recvbuf(struct recv_buf *precvbuf)
 {
-	precvbuf->transfer_len = 0;
-
-	precvbuf->len = 0;
-
-	precvbuf->ref_cnt = 0;
-
 	if (precvbuf->pbuf) {
 		precvbuf->pdata = precvbuf->pbuf;
 		precvbuf->phead = precvbuf->pbuf;
@@ -58,7 +52,6 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 		res = rtw_os_recvbuf_resource_alloc(padapter, precvbuf);
 		if (res == _FAIL)
 			break;
-		precvbuf->ref_cnt = 0;
 		precvbuf->adapter = padapter;
 		precvbuf++;
 	}
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 6bd2164ce1fa..4953a431ffd7 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -364,7 +364,6 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 		} else {
 			rtw_reset_continual_urb_error(adapter_to_dvobj(adapt));
 
-			precvbuf->transfer_len = purb->actual_length;
 			skb_put(precvbuf->pskb, purb->actual_length);
 			skb_queue_tail(&precvpriv->rx_skb_queue, precvbuf->pskb);
 
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 7347ec162632..bafc10905bed 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -207,11 +207,9 @@ struct sta_recv_priv {
 };
 
 struct recv_buf {
-	u32	ref_cnt;
 	struct adapter *adapter;
 	u8	*pbuf;
 	u8	*pallocated_buf;
-	u32	len;
 	u8	*phead;
 	u8	*pdata;
 	u8	*ptail;
@@ -220,7 +218,6 @@ struct recv_buf {
 	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
 	u32 alloc_sz;
 	u8  irp_pending;
-	int  transfer_len;
 	struct sk_buff *pskb;
 	u8	reuse;
 };
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index b205c50e9d75..d3b5fd83f926 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -30,8 +30,6 @@ int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 	precvbuf->phead = NULL;
 	precvbuf->ptail = NULL;
 	precvbuf->pend = NULL;
-	precvbuf->transfer_len = 0;
-	precvbuf->len = 0;
 	return res;
 }
 
-- 
2.35.1

