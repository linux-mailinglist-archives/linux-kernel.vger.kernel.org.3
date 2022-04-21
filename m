Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B323750A90C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391911AbiDUTXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391869AbiDUTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:23:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76AD4D249
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b68so4319763qkc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8hL0jBT5xZ4aSX/GQ3ksV9bgLPofPyPWC/LZsNauFo=;
        b=XG8SJK33BDwMiVJqw1QQx/+w1u+bNOgMSY0Tm61NDdxthwyeJVFDjL2trbkS26WY7p
         jZL5SP/LnQPZ5kJd5XLSgnkgsncZhKVC409Hef4jfDFnY7IvAbw0Z6Jcw5ly8OpeIWvQ
         UGM+j2W6WexEmdSC3Ank/7x641c5dvG07g0kMxV7X1pkEbmYdgybn5q+Q26uI8tDQWVQ
         nmn/qpPE4yC3Ze4PkH0PVABDy0yahSoMSStaJFAjC060xRGBneViu6lkGSIScGSvoj1c
         tkpOvlSUT8q2dgbTtjyc3YTrif4+V03SHSnA70t3curI6Qdf3RU+8XqLy4XWfRjB984w
         Pjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8hL0jBT5xZ4aSX/GQ3ksV9bgLPofPyPWC/LZsNauFo=;
        b=lMfMOAsHyl3EuuKHOJDs7qBKDbIfzM4Gn9hq7j0nuT19qcgrt6QIh1Yc3jtKUzoBke
         KgD7NZpU8C2zreHzBRhNIjMQaNjiRHAmj4a/0OvZgfy1rQWxnruQ2+3CmHv7+UMq+/hk
         r+J/lH0AA9q1nx7iHYhZKYFVM3jotye9JJN6DGQSpxx464w7jR/2/LEAKAfF4iajP7dD
         VQMSUdl5lGzbjy99WzwMbVs7HZ73AEHyEleqozErdN+ga+gZHAZUQ8lKqXTENFlwGOWz
         y290IKpWxNYDaAOYpz/yeM1JX7z4tCyY+kF0nFA2Nz5yFbpyLa+aRGPb4rfb0Pmf0CSz
         FDYQ==
X-Gm-Message-State: AOAM530LijcbCc3vYBiOYQ/xqVt9WtYdePm82sJSPHl6uvySoIWsuol6
        k0sMUTH/eTd7spg0LbwhBRg=
X-Google-Smtp-Source: ABdhPJz06GNbdRt8kpmS3Y9/FKz328cWWogMe2wv1AFvX0xYG0jQK8O4EbxTpjClD3KlnqRuCQpBHw==
X-Received: by 2002:a05:620a:2681:b0:67e:933e:54b6 with SMTP id c1-20020a05620a268100b0067e933e54b6mr647276qkp.428.1650568840022;
        Thu, 21 Apr 2022 12:20:40 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id l9-20020a05622a174900b002f34421b01csm2567736qtk.23.2022.04.21.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:20:39 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v4 1/7] staging: r8188eu: remove unnecessary braces in single statement block
Date:   Thu, 21 Apr 2022 15:20:26 -0400
Message-Id: <b96ae957e2ddc519e56813a1c56e770168f67a2d.1650568579.git.jhpark1013@gmail.com>
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

Remove braces for single statement block to minimize the number of
empty lines, without loss of readability. Issue found with checkpatch.
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 3e9882f89f76..d3f4d7cdfa08 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -112,9 +112,8 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
 
-	if (pmlmepriv) {
+	if (pmlmepriv)
 		vfree(pmlmepriv->free_bss_buf);
-	}
 
 }
 
-- 
2.25.1

