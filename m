Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904694B55D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356300AbiBNQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:11:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356181AbiBNQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:10:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA69560D90
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o24so25024449wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Umt8mADdTzTAerDjq8HFB3usyBYQbeaKKGd2pCtpBM=;
        b=MNEmXPLm3MmB4Alzm6tcgkQHCmWZsodALgDTx87ArlT3mHPyHzQ+W5diMgmWLoNeZM
         OGF34ahi4RPlhz1RsnErExVdgB1G1FlvSlLWhUKNd6M1xQWlepP4Z2+xubL6qIXP0eDv
         G2ELl3s5d3PbzuG89MC9h+gapPycrSo/yu+SW+oFt7QWi967U3+6NJOJtyja5KnPvbTB
         FkX44YDq3BpBNrfVIQsDKWwMwbPgpsVTuMK8rvAw4VxxdY35E08Jc0/wZJna4+KKMpYS
         3eXaHfAa4DAjPsDUEdr+n7CiL+hn+KSFtjW/pch+CUI5G8C6Q4IzXO6nsqk+nv9pyRBR
         8gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Umt8mADdTzTAerDjq8HFB3usyBYQbeaKKGd2pCtpBM=;
        b=B/Ysvg6+uflWCquHsXEfJ+mys8SgAI1f9fmemIb6oiZW9PsA6ubjZo8mI5GgEBobfj
         q7TNwncSjX2U0n3oUkCyRFLlOje4/zLgkRVR1myQJWxXFvxsNgRvr22tjvLcMhem7Ffr
         DkOlqVdXx51+MH+79nbbVdylmOus81kjVYTIZz6hqJxsEHYQy+gpgwZ08wkwvMiKA3WL
         EXIHmmJgeu8onCpsvtvpKhmfx3ifq4kzdELROZ8rMfBsiFAGkMVUbXUh468GghFdxyww
         oGUFjByOLWrSa09i55emw6YR+oqp0wt3ZjCodmua7Q7YS3yKJWE9/YlNoOG9XkmqApAA
         Yj7w==
X-Gm-Message-State: AOAM532H7t9JLd2YKKlFTegmC/p6T49CYqd3squmR7at/U4bvP9paybd
        FHsC2dzykLFLfi4Yy3nlE2As2A==
X-Google-Smtp-Source: ABdhPJyXBCJuYo8GvxLKdZTLa9HJIqd9ZCs4n19vkKWllC0oHrPY1pNYPuUYwSzGrtUkYT5oRhuAew==
X-Received: by 2002:adf:ed8e:: with SMTP id c14mr271622wro.688.1644855021386;
        Mon, 14 Feb 2022 08:10:21 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id k28sm13677022wms.23.2022.02.14.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:10:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        srini@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 11/12] misc: fastrpc: Add dma handle implementation
Date:   Mon, 14 Feb 2022 16:10:01 +0000
Message-Id: <20220214161002.6831-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
References: <20220214161002.6831-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>

The remote arguments carry both remote buffers and dma handles. Add proper
dma handle instructions to make it compatible with DSP implementation.

Signed-off-by: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 52 +++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5015b4e7ec09..ad9148d8644f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -101,9 +101,20 @@ struct fastrpc_invoke_buf {
 	u32 pgidx;		/* index to start of contiguous region */
 };
 
-struct fastrpc_remote_arg {
-	u64 pv;
-	u64 len;
+struct fastrpc_remote_dmahandle {
+	s32 fd;		/* dma handle fd */
+	u32 offset;	/* dma handle offset */
+	u32 len;	/* dma handle length */
+};
+
+struct fastrpc_remote_buf {
+	u64 pv;		/* buffer pointer */
+	u64 len;	/* length of buffer */
+};
+
+union fastrpc_remote_arg {
+	struct fastrpc_remote_buf buf;
+	struct fastrpc_remote_dmahandle dma;
 };
 
 struct fastrpc_mmap_rsp_msg {
@@ -217,7 +228,7 @@ struct fastrpc_invoke_ctx {
 	struct work_struct put_work;
 	struct fastrpc_msg msg;
 	struct fastrpc_user *fl;
-	struct fastrpc_remote_arg *rpra;
+	union fastrpc_remote_arg *rpra;
 	struct fastrpc_map **maps;
 	struct fastrpc_buf *buf;
 	struct fastrpc_invoke_args *args;
@@ -767,7 +778,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
  * >>>>>>  START of METADATA <<<<<<<<<
  * +---------------------------------+
  * |           Arguments             |
- * | type:(struct fastrpc_remote_arg)|
+ * | type:(union fastrpc_remote_arg)|
  * |             (0 - N)             |
  * +---------------------------------+
  * |         Invoke Buffer list      |
@@ -792,7 +803,7 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 {
 	int size = 0;
 
-	size = (sizeof(struct fastrpc_remote_arg) +
+	size = (sizeof(struct fastrpc_remote_buf) +
 		sizeof(struct fastrpc_invoke_buf) +
 		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
 		sizeof(u64) * FASTRPC_MAX_FDLIST +
@@ -857,7 +868,7 @@ static struct fastrpc_phy_page *fastrpc_phy_page_start(struct fastrpc_invoke_buf
 static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 {
 	struct device *dev = ctx->fl->sctx->dev;
-	struct fastrpc_remote_arg *rpra;
+	union fastrpc_remote_arg *rpra;
 	struct fastrpc_invoke_buf *list;
 	struct fastrpc_phy_page *pages;
 	int inbufs, i, oix, err = 0;
@@ -893,8 +904,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		i = ctx->olaps[oix].raix;
 		len = ctx->args[i].length;
 
-		rpra[i].pv = 0;
-		rpra[i].len = len;
+		rpra[i].buf.pv = 0;
+		rpra[i].buf.len = len;
 		list[i].num = len ? 1 : 0;
 		list[i].pgidx = i;
 
@@ -904,7 +915,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		if (ctx->maps[i]) {
 			struct vm_area_struct *vma = NULL;
 
-			rpra[i].pv = (u64) ctx->args[i].ptr;
+			rpra[i].buf.pv = (u64) ctx->args[i].ptr;
 			pages[i].addr = ctx->maps[i]->phys;
 
 			mmap_read_lock(current->mm);
@@ -931,7 +942,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			if (rlen < mlen)
 				goto bail;
 
-			rpra[i].pv = args - ctx->olaps[oix].offset;
+			rpra[i].buf.pv = args - ctx->olaps[oix].offset;
 			pages[i].addr = ctx->buf->phys -
 					ctx->olaps[oix].offset +
 					(pkt_size - rlen);
@@ -945,7 +956,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		}
 
 		if (i < inbufs && !ctx->maps[i]) {
-			void *dst = (void *)(uintptr_t)rpra[i].pv;
+			void *dst = (void *)(uintptr_t)rpra[i].buf.pv;
 			void *src = (void *)(uintptr_t)ctx->args[i].ptr;
 
 			if (!kernel) {
@@ -961,12 +972,15 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	}
 
 	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
-		rpra[i].pv = (u64) ctx->args[i].ptr;
-		rpra[i].len = ctx->args[i].length;
 		list[i].num = ctx->args[i].length ? 1 : 0;
 		list[i].pgidx = i;
-		pages[i].addr = ctx->maps[i]->phys;
-		pages[i].size = ctx->maps[i]->size;
+		if (ctx->maps[i]) {
+			pages[i].addr = ctx->maps[i]->phys;
+			pages[i].size = ctx->maps[i]->size;
+		}
+		rpra[i].dma.fd = ctx->args[i].fd;
+		rpra[i].dma.len = ctx->args[i].length;
+		rpra[i].dma.offset = (u64) ctx->args[i].ptr;
 	}
 
 bail:
@@ -979,7 +993,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			    u32 kernel)
 {
-	struct fastrpc_remote_arg *rpra = ctx->rpra;
+	union fastrpc_remote_arg *rpra = ctx->rpra;
 	struct fastrpc_user *fl = ctx->fl;
 	struct fastrpc_map *mmap = NULL;
 	struct fastrpc_invoke_buf *list;
@@ -996,9 +1010,9 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
-			void *src = (void *)(uintptr_t)rpra[i].pv;
+			void *src = (void *)(uintptr_t)rpra[i].buf.pv;
 			void *dst = (void *)(uintptr_t)ctx->args[i].ptr;
-			u64 len = rpra[i].len;
+			u64 len = rpra[i].buf.len;
 
 			if (!kernel) {
 				if (copy_to_user((void __user *)dst, src, len))
-- 
2.21.0

