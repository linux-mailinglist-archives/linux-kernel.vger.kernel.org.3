Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213504BEC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiBUVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:25:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiBUVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:25:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D413CD0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:14 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a23so36362666eju.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JWjYfqXasCYEUfZcDuCmAcewGNZu47MK/PX+0VAxPLM=;
        b=Di05ReSn75HTTnV/xV+063h7YXUIJNIUfTSmixmKczxJxPu8eCzNM7Ar5HTzlO96Jp
         SHUfPWxlkV8NFxfHgfCcXNeK1D90SMct9LNxnww86f26wxK79xcRn3O7dzw+Cb9auOuh
         ITAtC9/YL8h0B8Rmm4hps6ExwAonjLs70UKGruWcvLxTI+5inrcmTFC5AVbtQQsgxrfF
         hf0GdAaT861gDX9hHQp32FoVqqoJOWwpaS21I79pT8nW3cfYylqBuA+x1ZpYg0pvg7oK
         ZqKbH6qCjMnl7zTxQ+bkiGTLN3ynNadoAGGfHrJeSkxluHQAQoZ3dLFxlxbkBlB1R/G2
         ORag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JWjYfqXasCYEUfZcDuCmAcewGNZu47MK/PX+0VAxPLM=;
        b=MRModPLiRm5BAzpKJ4XTtR/zjZRG01GpdB+sy3HUJM/XJk49yKY8brDadqj+zikq6T
         tI7IlYpIzYlXlI7eUATy/u7eMppoO8XZVvLx/yoHyH3CjsoGDJjq4LK2LIuGku/Bgt5O
         oPpul18VnivJM53baWu7AIbJ1qGb/F74U4jt5zqeqJ3jh1LuogiVZ3X8AVInlXqe1+vy
         A/8cuqEsaYrSjT7xciuxKPYSGQju1O+IITqGeno+amLR2oUImd/1JdjDwNif+QIZD6Tk
         oRaVUVOolLN3oBh3kszeyNv/6PaK7JV7j8HOuAVZ18729coLLw0TreYzEsoaKUCjhNIX
         8XhQ==
X-Gm-Message-State: AOAM533FdGLAkeHZ9pOeKlINY6GTkbEagy6Lu6mYebLZYDM0wY5leVV5
        XApF4EZorEG5x6aISU0H6Us=
X-Google-Smtp-Source: ABdhPJwngm1nPQDLcrGttoKbc3qyTiAwa5bkoKD1xHpoJtrVHFT/viemRNdvBvdj/rDEhH0nF8Iewg==
X-Received: by 2002:a17:906:a145:b0:6ae:e45d:15b6 with SMTP id bu5-20020a170906a14500b006aee45d15b6mr17107775ejb.714.1645478712790;
        Mon, 21 Feb 2022 13:25:12 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id m4sm5598757ejl.45.2022.02.21.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:25:12 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:25:10 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] staging: vt6656: Fix CamelCase warnings in macro
Message-ID: <53072a97348b08276b083ce18188b9199cbfaae6.1645477326.git.philipp.g.hortmann@gmail.com>
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
- CHECK: Avoid CamelCase: <uVar>

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Devided patch into three
---
 drivers/staging/vt6656/device.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index dda38c2a6f06..0ab2d60204e8 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -381,11 +381,11 @@ struct vnt_private {
 	struct ieee80211_low_level_stats low_stats;
 };
 
-#define ADD_ONE_WITH_WRAP_AROUND(uVar, uModulo) {	\
-	if ((uVar) >= ((uModulo) - 1))			\
-		(uVar) = 0;				\
+#define ADD_ONE_WITH_WRAP_AROUND(var, modulo) {	\
+	if ((var) >= ((modulo) - 1))			\
+		(var) = 0;				\
 	else						\
-		(uVar)++;				\
+		(var)++;				\
 }
 
 int vnt_init(struct vnt_private *priv);
-- 
2.25.1

