Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DC255233A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244621AbiFTRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244442AbiFTRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:55:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44A15A29;
        Mon, 20 Jun 2022 10:55:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso8132086wms.3;
        Mon, 20 Jun 2022 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rO76farMqYrPQC4ew78x4uRO3kIuRntTwzkVO3g3BmE=;
        b=IXKYt1GNB0skST+g+G4WX5y6frV6Y4HqH2GhmT+UmjHsf9n/eI/8mQ/1U9DblJ6nA+
         EuQQBR7A64ljTuDVW0sTn1xiDxxQCPWO8F5rfuzYDMXiCFM+o5ZCoJHN9uhhUWbNC/ma
         Cy12wOo2F6wvVmCZc8uA73rbiBazH+msWsg66pnnXJhV3hyoRqDw8eVrI/KkeWDFyNoj
         JUHYPoUJjygpC98Hd13+KqHXDnQEkd5ywSFlDtsbDwPzT5Tciop659ZSJ3q2yNV3IP+7
         KaaYG2DOOU60fAyt7bmRps3R+IZzONdJS5MaxDw4ryX58jj8QbNzXmXO+wmzKVLghsqc
         dyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rO76farMqYrPQC4ew78x4uRO3kIuRntTwzkVO3g3BmE=;
        b=Q8dapEcXeDZz/XPtLxF9JSaaYLWYdvDgc2WXdWYKgE+8TECsB/MwkwiZoCfOmz8RXe
         Mpt4sCAEic2twwtWxMMRtdjeCSMjGZLAgNdonLQToRs7EIMtRmP7Qgt3GZBHgVy5On8j
         Nq1s2iePR3XS6RG/cCDyzUKYsfAUqEH9uHdgqEcoxrHhSbEa02LEa7k3SVzk7Tzzo5tx
         3MYrGyGoFPflFjJ9f8V58MNbUhKWrj2T7Sb7f/zrDnpG7FJrYE8gaYl7rttpMzCA4OIj
         IIMzX5VuawHo/C9DffAzE+/Jb031W0S/0KgrxmWxWRLjZ+3QdFnuojstaSu0aSiOm2eG
         4Lcg==
X-Gm-Message-State: AJIora8dSZ/4lwwjPwvKtJ3tzrN/OQIYctakPdWAuMBVybw2GIuYQCpT
        dh/1oSkBIOy7uFRVxxq54E7VPLXZZiM=
X-Google-Smtp-Source: AGRyM1u30Dw+JFAP13t7yhgHTvIDNuEJxA8aQ+DfNlPldZrFipM6Pgrn21E14dvHe/90gjXmt5wvtA==
X-Received: by 2002:a1c:4e15:0:b0:3a0:1990:afeb with SMTP id g21-20020a1c4e15000000b003a01990afebmr4215164wmh.137.1655747736907;
        Mon, 20 Jun 2022 10:55:36 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 184-20020a1c02c1000000b0039db31f6372sm19620752wmc.2.2022.06.20.10.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:55:36 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 6/7] media: cedrus: Add helper for determining number of elements
Date:   Mon, 20 Jun 2022 19:55:16 +0200
Message-Id: <20220620175517.648767-7-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620175517.648767-1-jernej.skrabec@gmail.com>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com>
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

Now that controls can be dynamic arrays, we need to know how many
elements are in such array. Add a helper for that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 11 +++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 99c87319d2b4..b855e608885c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -232,6 +232,17 @@ void *cedrus_find_control_data(struct cedrus_ctx *ctx, u32 id)
 	return NULL;
 }
 
+u32 cedrus_get_num_of_controls(struct cedrus_ctx *ctx, u32 id)
+{
+	unsigned int i;
+
+	for (i = 0; ctx->ctrls[i]; i++)
+		if (ctx->ctrls[i]->id == id)
+			return ctx->ctrls[i]->elems;
+
+	return 0;
+}
+
 static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 {
 	struct v4l2_ctrl_handler *hdl = &ctx->hdl;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index d2b697a9ded2..15a1bdbf6a1f 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -261,5 +261,6 @@ vb2_to_cedrus_buffer(const struct vb2_buffer *p)
 }
 
 void *cedrus_find_control_data(struct cedrus_ctx *ctx, u32 id);
+u32 cedrus_get_num_of_controls(struct cedrus_ctx *ctx, u32 id);
 
 #endif
-- 
2.36.1

