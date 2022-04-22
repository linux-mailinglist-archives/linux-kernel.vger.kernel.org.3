Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2126250C3F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiDVWOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiDVWMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:12:00 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A4F18C287
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:58:47 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d3so5775207ilr.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUpSqOzVYiFBHHL5wyZniliWxqmPr3GRK8w6NgSpN5Y=;
        b=XcmVK7JwNu54yeoZvUVgRE4ycDDruCjbj+O5/cIqn5LV67XjhrDem/poh9j9WGzYTq
         LnUDaJvHfOKnKPlTahgjH/qcg22qtd5Ff1o4h3AgL+7IUtNgRfd71+gL6T35uZxuSGE/
         0cl58yjKwbyagr1pWsEYjmcGKECgKksbTZEzCqO1gUMr8ksXXPPnbQNTSIM3eRUCdtfN
         /Qb8DAB56KwthFkmyNNza4ZsncLT3Xlal8f6W70u74xt5+hlKR3zpY9dT+FBJOi9/3Oc
         QvMOpyk26Nc9Q+j17urh7MTZvzuJAbyRiftOILa9thZn7wEV4+ua/tcuTjW+BZYloL5v
         mKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUpSqOzVYiFBHHL5wyZniliWxqmPr3GRK8w6NgSpN5Y=;
        b=2b+ksWnklLhZgwBpN4k4GfPyXC8zhWjULHH9t0atDbY5civ2swMzb4LoCDsAZk//dM
         cZoZvu7mLolIbjEXxdI16a9kC4KkExb/PfhWEa1p+4ImnPN9ZToq+u+Cl7bVKj1SYE5k
         49hP0Je3eFkWEuE4p4ewCUEs8K0AN2ZjOoxybZ8uX/euJlfR4IzCJhISEmV0/qhta0PP
         QnIbPJzO4DcV1R3JpS/5cdRGVgpq0ZhQ33mtG5Bb5lg2M8I2CTDP5mAy+kWUgPXbFsfh
         eJX7+jHd+H/Ub6qfNM5jo4wi4Cf5jcJzE6Cocw0P48742ynamxoglT2TEgTJMSYJp2YU
         lObA==
X-Gm-Message-State: AOAM533Nx7pkXGKxtMJTvuVjO7Z8Dt9g/REJpOpT4dhpKuV9SQtaTsFR
        VFjMEPf08/V4mguctr4/yUvIjXTaw4M0Tw==
X-Google-Smtp-Source: ABdhPJzUh4luMNplztXSuP6L7uMw2SWA7GRGbpG/TNQKBppwZ6TtQARW2I6z2+myuIpakDIbUiI0Xw==
X-Received: by 2002:a63:2c4c:0:b0:398:997d:b5b8 with SMTP id s73-20020a632c4c000000b00398997db5b8mr5303391pgs.86.1650655964090;
        Fri, 22 Apr 2022 12:32:44 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:bfe0:e8c0:bea6:ee63])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3518932pfh.83.2022.04.22.12.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:32:43 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v3 3/7] staging: r8188eu: drop unnecessary wrapper _rtw_init_evt_priv
Date:   Sat, 23 Apr 2022 01:02:19 +0530
Message-Id: <20220422193223.11948-4-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422193223.11948-1-makvihas@gmail.com>
References: <20220422193223.11948-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary wrapper _rtw_init_evt_priv and move its logic to
rtw_init_evt_priv.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 27 +++++++++-----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index fc955fce2..512896b86 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -17,22 +17,6 @@
 
 static void c2h_wk_callback(struct work_struct *work);
 
-static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
-{
-	int res = _SUCCESS;
-
-	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
-	atomic_set(&pevtpriv->event_seq, 0);
-
-	INIT_WORK(&pevtpriv->c2h_wk, c2h_wk_callback);
-	pevtpriv->c2h_wk_alive = false;
-	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
-	if (!pevtpriv->c2h_queue)
-		res = _FAIL;
-
-	return res;
-}
-
 void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 {
 	cancel_work_sync(&pevtpriv->c2h_wk);
@@ -133,9 +117,16 @@ u32	rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 
 u32 rtw_init_evt_priv(struct evt_priv *pevtpriv)
 {
-	int	res;
+	u32 res = _SUCCESS;
+
+	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
+	atomic_set(&pevtpriv->event_seq, 0);
 
-	res = _rtw_init_evt_priv(pevtpriv);
+	INIT_WORK(&pevtpriv->c2h_wk, c2h_wk_callback);
+	pevtpriv->c2h_wk_alive = false;
+	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
+	if (!pevtpriv->c2h_queue)
+		res = _FAIL;
 
 	return res;
 }
-- 
2.30.2

