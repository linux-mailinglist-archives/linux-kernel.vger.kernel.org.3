Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599C24CC1F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiCCPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiCCPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:54:16 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A96D6AA44
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:53:25 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h28so4359774ila.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNgXJDzyLTX7z4K2H7RhMUewadRDf0i8VGlFa5Rjq3k=;
        b=LEZHzWuZAdsDi4M3CxiPIRlMB3YQ6zdNJvIHLiAeEcPHClUI5cYdiBEyjfy3Q1J+ta
         vvOwd270f2ISLT/KV4XdvFPVIFMv6fPEIZp6Rb1lo8CvSeXiQbB6tGSMXEpY9UgARaNJ
         SXMsr0z8Uh+8ww2ckEyuTb60w5rdv0fej8uT0ffAJgJ2dRGgBEv2t7S3QAcQQ+vBJDOU
         5gDKX1v2gn1pc17c6EH5zHu30ZqsO4ulSWy6R1YXaXreep9GxKWsyVXxDJu/FjgbS/a3
         co29LOBL6XPSRW7CJLhr3dEcaoXDMWQHy5/3xOoKf/XSfXj7oLJBTdwmJ1nAeQA0jD/k
         LAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNgXJDzyLTX7z4K2H7RhMUewadRDf0i8VGlFa5Rjq3k=;
        b=Rt8I/BFbnI4Lzii6BN6fcNQISHKC/QpgkgkGn9CbqWzjhVKlD7cXkYU4dSTY8EFbDn
         RGXuFemt0y+mvFAyUDi6qwyZavGSEK+APLZOGwKROVDauTSMTsNxRcRK9OSHmuDAnlFk
         Cnz+KZMHefw1lXPGgu1vbAHOniH/IgcjrRgOldsMiaHHRWMZ36XZR8tAxNADyWn5y9Gw
         Xbo96h18BqhDeB7/iQDFI64GXn1AtzGNGMSAD9YcVCGYV4PGaN5RuvRLqryrhS1KbcSf
         Wz1xuQoaOC7O8r+ynWNBqGvlWK99whbWeKSTEgb9+g1CmxblXDfvIgRGMzraWknJt+OT
         008g==
X-Gm-Message-State: AOAM5315q7DC+RWnZgOJfu37viEarLjdLJIQzDSknFDGp+1NRkU8MAn+
        S1wcW+HbM0ZS9BcKwfU+9lo=
X-Google-Smtp-Source: ABdhPJz8VxCU0wsFanT3oxeXX9nknEMA18wdol6UkgdYKbxyPCvU/iW6wViywfKBxk2zi4t7cxAwKg==
X-Received: by 2002:a92:d80c:0:b0:2c2:c40c:7bd4 with SMTP id y12-20020a92d80c000000b002c2c40c7bd4mr23780866ilm.310.1646322804419;
        Thu, 03 Mar 2022 07:53:24 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id a6-20020a92d346000000b002c1a6040691sm2506599ilh.70.2022.03.03.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:53:23 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, paskripkin@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] staging: r8188eu: remove unused field ptail
Date:   Thu,  3 Mar 2022 21:21:07 +0530
Message-Id: <9574ad2dfba0cc444ce1dea1268661ed32b84799.1646321515.git.abdun.nihaal@gmail.com>
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

The field ptail in struct recv_buf is set but not used.
Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 1 -
 drivers/staging/r8188eu/hal/usb_ops_linux.c  | 2 --
 drivers/staging/r8188eu/include/rtw_recv.h   | 1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 1 -
 4 files changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 7db5cfaa251f..7a787944064f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -16,7 +16,6 @@ void rtl8188eu_init_recvbuf(struct recv_buf *precvbuf)
 {
 	if (precvbuf->pbuf) {
 		precvbuf->pdata = precvbuf->pbuf;
-		precvbuf->ptail = precvbuf->pbuf;
 		precvbuf->pend = precvbuf->pdata + MAX_RECVBUF_SZ;
 	}
 }
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 8f4c059e09c9..74a221db1c3d 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -441,12 +441,10 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 		skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 
 		precvbuf->pdata = precvbuf->pskb->data;
-		precvbuf->ptail = skb_tail_pointer(precvbuf->pskb);
 		precvbuf->pend = skb_end_pointer(precvbuf->pskb);
 		precvbuf->pbuf = precvbuf->pskb->data;
 	} else { /* reuse skb */
 		precvbuf->pdata = precvbuf->pskb->data;
-		precvbuf->ptail = skb_tail_pointer(precvbuf->pskb);
 		precvbuf->pend = skb_end_pointer(precvbuf->pskb);
 		precvbuf->pbuf = precvbuf->pskb->data;
 
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index e4f844507d17..c97ec9d0feed 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -211,7 +211,6 @@ struct recv_buf {
 	u8	*pbuf;
 	u8	*pallocated_buf;
 	u8	*pdata;
-	u8	*ptail;
 	u8	*pend;
 	struct urb *purb;
 	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 8832199b10ee..fd29f06b375a 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -27,7 +27,6 @@ int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
 	precvbuf->pallocated_buf = NULL;
 	precvbuf->pbuf = NULL;
 	precvbuf->pdata = NULL;
-	precvbuf->ptail = NULL;
 	precvbuf->pend = NULL;
 	return res;
 }
-- 
2.35.1

