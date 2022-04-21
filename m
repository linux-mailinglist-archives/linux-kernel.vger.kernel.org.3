Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5724A50A911
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391926AbiDUTYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391899AbiDUTXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:23:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2034C7A6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d14so4013703qtw.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ul9FGVJ1sqTdARK0mUZLH5+vAqXgfv1Osb8Y+BayvnA=;
        b=PboPQS2k7qvXDrE1qoUSXr2+VaPYMTv45/YlkkbxdwUA9owtd9aItiTqTE4Wi5GvNq
         ZrzMhUzwkihHH0iR99HRnJOBjRQECZvU01YsruDLsSV6VVimkgIKpm5W/HB64MkeScMn
         CHpY7/80p2iqBHHRyKMrt8OfL4vwyCD83efJWF1+XlngJLKRFaY1zbfGTMsZnzDRaeq4
         8k7Jktm+/DyQqfUO9sa+x0Ncn0GTU4gOdWtqDlGxci0MgRBDRHf913iCRLhkwD+X0I2p
         s3YxqejLxsNu2FiRHe09Xy/N/tByUvRd2K6SkV+GIgb9VH6ZRuBp8raJgw1vSJc32qsy
         WzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ul9FGVJ1sqTdARK0mUZLH5+vAqXgfv1Osb8Y+BayvnA=;
        b=q0f+mStL5EiqOGlgxsfRF8XHzwAcYXqGJ6zC4ex1BHJXHl3RlkqEvnOsLh4rIvg3oJ
         PMrRZGERxW/t7cy2JwdGXVa3jvn3tAS7zZD+7JtEQirT3WcQvX3HxWCG2JLsZ4G9gipi
         Oh3wFAfJOYcnXi2pY+wY6/95a3fCrC7ogXCQrLSafW+rp9mz8P1T26Q3lxzgXmA5W9G1
         bI9VO0oLSzYSFluQ2LaTMCXz3nIb82qwwtb17yhC0ChKwZk4C5gJIF/mhKxlu3+elf3Y
         scmi8SRmgHb+ICnP6tx/NtsthsyYg5zcOY66xGuGIsatg4MrpEdcsIJefK5Kcv81EzqT
         9l4w==
X-Gm-Message-State: AOAM53133t5z2qgcZZpH5c9iCI5myPck/CyfsSsGrKXnQLxNX22IiKcI
        zNqCFQ2rH2XYGBJVlMaWm1M=
X-Google-Smtp-Source: ABdhPJydGXJP9BFb1WSRFH7cUBdCTIZqsh5XL7qhdz3craqFPk3UEPjmG7JCVH0Qt25hbQzNFkc5lA==
X-Received: by 2002:a05:622a:446:b0:2e1:b95e:3b48 with SMTP id o6-20020a05622a044600b002e1b95e3b48mr758043qtx.310.1650568844562;
        Thu, 21 Apr 2022 12:20:44 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id l9-20020a05622a174900b002f34421b01csm2567736qtk.23.2022.04.21.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:20:44 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v4 5/7] staging: r8188eu: replace spaces with tabs
Date:   Thu, 21 Apr 2022 15:20:30 -0400
Message-Id: <fd4a66013be081bc5adb491c6dc7774362d1ac82.1650568579.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650568579.git.jhpark1013@gmail.com>
References: <cover.1650568579.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index b943fb190e4c..7a90fe826d1d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -722,7 +722,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
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

