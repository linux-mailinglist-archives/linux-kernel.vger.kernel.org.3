Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F625511D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiD0PfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiD0PfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:35:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C0F35248
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:32:08 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z126so1556195qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=cyrolNltUUpbs4yZr4ZZ4cVcFuuThjMYIy0lsDeAp/M=;
        b=ga7PA3xJYU6LHhoM5kPggCpCEGKJ5eM6EcSGUEXJtH4FpksmzO2XBrq+/HeMYvYFj8
         X3BoK8dWB5ySh81Nftik79G1npYH1rdTU87BqwpYU6iRheaSm46R4tt+Tyd+S7WusV5m
         2280iBykRrNhWzK5CQQqzsqBE/sjQVg88IMabVMIz8rGHyKZjNplv8KS0P/oNK9cshYI
         niTk4ChR7fCfNGXiD6KVwZYcQSyWReXYe/PRoRKVM0L9GU1dw/z72QxGlS4nLHJKFs+N
         hKrAM2Rbj+1XmZpHMKsXQ1w0NaOZP7eMRS118X7QN0OoxCIKzTkWLU260dQfAn0CI70o
         7PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=cyrolNltUUpbs4yZr4ZZ4cVcFuuThjMYIy0lsDeAp/M=;
        b=lsUXTnybmZ8QXoLgdr5MJ/yJ9l16k7nBWTyEvkaOt6Znmb7DPuqVXwo9TR47xzPZhW
         sPIL1X3C+4Y8CImA/9WkgigNRvH0tnNxQG7pM/vERNkIbP0Mq3rm+09qJYz+WX6wQTkD
         wDIP1y2W/RLtX9Kbs51QAFe9MFxj96UomohWDDH+bs2tJHGhTKA+9NTI4TaltS3kmmfz
         7s06pCujIn6Wcf8jCHkzsGLZROji21BlscTkiFtI9kRhgfvmHO3/fCbvVPfqlUqbM+u7
         6kolqmtKVbkTjs4ayzrRaIXMVj6uZcKLwbCAsU/H8E4ovHc/83z5xFpqOBM/q0ROl0g4
         5GKA==
X-Gm-Message-State: AOAM530JXD6xbiZxxt1fdk+nXiZlTkuCg45QAQjUjVes9ZIP0l7FJUcm
        fiBxMhjFW6KbSDwfGKiprdo=
X-Google-Smtp-Source: ABdhPJzKwLjFN7Ly4bvVQUi+eZxIcuebllqbHq6gOW3POQq235Srnx5TCcRCVB9tKQ65UO6DO/3ZwQ==
X-Received: by 2002:a37:a853:0:b0:69f:7f28:d90f with SMTP id r80-20020a37a853000000b0069f7f28d90fmr4672410qke.385.1651073527688;
        Wed, 27 Apr 2022 08:32:07 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id x9-20020a05622a000900b002f37b3537eesm3085759qtw.1.2022.04.27.08.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:32:07 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:32:03 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jhpark1013@gmail.com
Subject: [PATCH v2] staging: r8188eu: remove unused else condition
Message-ID: <20220427153203.GA503502@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_select_and_join_from_scanned_queue() cannot return '2' so this
else condition is unused. Remove this unnecessary else statement.

Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
patch v2:
- fixed the patch message 

 drivers/staging/r8188eu/core/rtw_mlme.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d422ce87ba7c..29b8b101180b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -723,9 +723,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
 			if (s_ret == _SUCCESS) {
 				_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
-			} else if (s_ret == 2) { /* there is no need to wait for join */
-				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
-				rtw_indicate_connect(adapter);
 			} else {
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
-- 
2.25.1

