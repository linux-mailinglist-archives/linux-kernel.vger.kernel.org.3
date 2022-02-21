Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3464BEC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiBUVZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:25:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiBUVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:25:40 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907F12AF2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:09 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qx21so36362759ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oauo1b7HT73p7Gr1WROI5Ol6cUloVjrlNqIzfwLAH/Y=;
        b=qtDA+iJMSbeae+4uVqNcUJeGpB0jUbHeP+Z/CRB55izmjZBEeHLuRBuE7pxkTR8piY
         LmNUU9sysUfzKHzgLUYQ1BCvuw34D8vMmhkq2sTJhLZAiM4cz9PdG3h3VGOgn32aGGLi
         Dhm0uYXhKRl7f9hlF3OuUClNj3vFLBUkrEKlpB1Sjqb9HApqr2bG+dOzLoaXYAyrzW3C
         9k5Sht3x5lqVh04VlKNP1ic1Gunbv/oPpxnUTuWYPgnoPHuz3WLPZISfW+grsngacH6y
         Nma/d0rQ5DeM5P3ceyXJZlgJVdaJc9kIc5fYxvoNlqcJqJgZEMnuFhF0o7BB9yZRVGwp
         8vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oauo1b7HT73p7Gr1WROI5Ol6cUloVjrlNqIzfwLAH/Y=;
        b=0S7J7KKtNQ/1J/rWi5NYlg1WqVcsA7+BiwfTruGvUfnI1LDAjSQhIpBVOnC9alqi30
         y5MVTbpikIMhtbxKd3UYECPUszN5kjE4rP1jYdQbLg5jiBa0eZf5QmkwAogyDAD3vQRo
         RTYxCjJg9i+IyT3+eC1kFtsP2vCiRkJpzfzRKDSIvaeiLqbsRMTTcnSpFiQ43qn4vwgf
         yqFlhRDwSjzRkM2W09teXiNFP0eI+RgVSa7KoccXRTPmVmclDGnhsnt3fx2E6cLS8iKk
         GOEihoQI7vJtrlEetINIIxip2z3fIkXBGc60f3C+tyqouW0ZBPbhMkGdTXSJ7Wogzf46
         TX0g==
X-Gm-Message-State: AOAM530H+WFoujxKHkbKoxukTpnlZk4gmE7eavJDH0DcuN0C002CZIDb
        uTkUpaUWJ5WiBE7LzmlvqRY=
X-Google-Smtp-Source: ABdhPJyKDULWkIgC0AqNbiYLCH6Pf/SIodgvrqrgbYRagMi4siuwq0/bpO5ZkNczpb4tMCU2nDEcPg==
X-Received: by 2002:a17:906:6693:b0:6cf:3cb:89c9 with SMTP id z19-20020a170906669300b006cf03cb89c9mr17455135ejo.23.1645478707569;
        Mon, 21 Feb 2022 13:25:07 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id vs2sm5421682ejb.64.2022.02.21.13.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:25:07 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:25:05 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] staging: vt6656: Add comment for locks
Message-ID: <c6a5ef8e7704b488c54145b09ac44bd4880c13b4.1645477326.git.philipp.g.hortmann@gmail.com>
References: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warnings like:
- CHECK: spinlock_t definition without comment

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Devided patch into three patches
---
 drivers/staging/vt6656/device.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 8b6623a751f0..dda38c2a6f06 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -268,8 +268,8 @@ struct vnt_private {
 	u32 rx_buf_sz;
 	int mc_list_count;
 
-	spinlock_t lock;
-	struct mutex usb_lock;
+	spinlock_t lock;		/* prepare tx USB URB */
+	struct mutex usb_lock;		/* USB control messages */
 
 	unsigned long flags;
 
-- 
2.25.1

