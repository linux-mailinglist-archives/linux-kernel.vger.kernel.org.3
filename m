Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F215078FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357307AbiDSSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357373AbiDSS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:03 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C53DF5F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:53 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id dw17so2263162qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1/ie4QuWSXXgB+xp4DMhBE7HLrajOsmWcuUCsf6X4I=;
        b=hdaKTXpzMgU7K+djFEqGEew0POFWTwy/yslxAuKNMD0SaPrYTGwDse6J9unjK/yYxf
         AzS+9BkBWpKwFPb4/aIKs8q7UvilGIyCwj2WD+n/jWJxeWhJalWfhaWW8hArwixxnnJ0
         eVRAcApf3qBVWKS8MaMqxYL84fMNZRMfBH8H2jGJ1y2iTyFmAJjQv23fMYDdx8sMj6Pt
         cZxwt/kcmcvqIsDghKsSDTUCoNUhm3zWRKjYGjbamswqYxwjTVzhxKJ8Qa4HwrBM0B2D
         xNWNc0zxv6VNqUMMC8nTUg5HY0jX0rR/V0nFtUlxsKed8aawq3f4S0OYyBpnWS93/WZv
         FeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1/ie4QuWSXXgB+xp4DMhBE7HLrajOsmWcuUCsf6X4I=;
        b=4baGQLMQ/Mq/a364cJpLJ2ROaP3uCRWWXgwJHu1DwiWbNCdmz8+vRrk1o/kPDsnTHT
         bLpipjvqpZlecWJiaX/KssJlz3gIL43YWj8gFUrrrQvI826wlZOcbX18zQBKp+VoNdtb
         2ViDEOk5mX1PWf6wZRFWZs1CkVvbo4D7PvKD+UklVbVAgOfgmBmkHvECVwUDPtBafgWn
         WFyTjgEE4zJZSBWFLp1udVr1a4pqQAqHyiU3zzlUh4lKQtKHLFzeAZC79iiYltiN650g
         sQJmNDRvmMOupIo0RX31hYPcUHvBTm+Py3gwXAv28gZcPGqugQJRrlp12ALiKrC1iuQe
         /hiw==
X-Gm-Message-State: AOAM532z2lbuGv6JtWjGU5GB/ddk9fnV0HhsNm3pc84kCJwOJXVKl6CP
        0/vwrYqQ2R0kQ3ZhT5DHHRZlIv2Q80OP5C6a
X-Google-Smtp-Source: ABdhPJwJtueRCrxqkAyYZLYLe58f+CxKoMRLxIKN75UObTXcycf/iTcnWI6/CrsTLzO4xhztd5vGNQ==
X-Received: by 2002:a05:6214:262c:b0:446:3464:57cd with SMTP id gv12-20020a056214262c00b00446346457cdmr12636468qvb.89.1650392392426;
        Tue, 19 Apr 2022 11:19:52 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm373334qkc.19.2022.04.19.11.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:19:51 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v3 5/7] staging: r8188eu: replace spaces with tabs
Date:   Tue, 19 Apr 2022 14:19:36 -0400
Message-Id: <48b324c1be1c26f34d793a0b5cf7933b41882a26.1650392020.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650392020.git.jhpark1013@gmail.com>
References: <cover.1650392020.git.jhpark1013@gmail.com>
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

Use tabs instead of spaces. Issue found with checkpatch.
WARNING: suspect code indent for conditional statements

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index adaf0f813a97..173754c127e3 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -704,7 +704,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			pmlmepriv->to_join = false;
 			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
 			if (s_ret == _SUCCESS) {
-			     _set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
+				_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 			} else if (s_ret == 2) { /* there is no need to wait for join */
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 				rtw_indicate_connect(adapter);
-- 
2.25.1

