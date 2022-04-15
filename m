Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B2E5020C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349032AbiDOCv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348975AbiDOCvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:51:19 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C61BB646A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j6so5879149qkp.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uW8HDovjcYWMlVuqX7cK2tEDuwELYOJWlsZgLOTezY=;
        b=T9pY4aJr/Tpd8Txacuo9ZZRry1/sEf67pUNRbc9AgSvFHBDXD9KgEqMqwl+/FTbSRC
         Hy6xLkqluMcBP9tB4nwS35Ztr6NKZ2fK8iWm80EBvtrIWirwHuJDeLar30ggQzlHlXOl
         4ycHils44jiXtdhQ25ZT8M8u/XCpHhXBXxn/9k/33xuhYmvGE2CbfypC6/wUvpdhoeVy
         qta80dlGApRL085+rfDV/VxmHAiAthkesg/RmYLGyLwibK0g6A4l2GJ+biooHJL5I9Dd
         Nt8wn6V74bJMdKBvk0GevW1fFpZMErgg1gkW5tWOwkrPn4fSV7fkakUPbzAphdtUuvAf
         yp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uW8HDovjcYWMlVuqX7cK2tEDuwELYOJWlsZgLOTezY=;
        b=FjkqR1pemFYe27A91D7mC6SXsWploif/yos3NzTUHEMALBNDm48UVdeh9uM0AfJ/xL
         4dC+daq1cwegNCZYlAXFZOidXl+5hqhER7qJIuVM/cvz8ucd9A4VrqUC1lhisINFDD3a
         JQXZ9LiLbbOVmS18Xlxc7v/fLFtXR9wJPdk9QrhlwaICjPcaYK+ZKt9GJJWaQQPkJSan
         32Xiawio/1o9sQrQnAGDrebVEuwYlccuQQRfuySbsSlWD4epbXE+Tw2OsgeLawPHTVDm
         60wvroQurPkOoEqPNxWQJEQcUlgmDruE6oS0SwYJvwEz0jeuHkjQx+pegzULGDMEVFw0
         +VaA==
X-Gm-Message-State: AOAM530DFPhU93g/ErV23I6PFXyNqV6gc0a00xwqajr/gvxHnTsCtozz
        9qKPRseglBXvurINRJhkT+g=
X-Google-Smtp-Source: ABdhPJxBOZ/V3SpJWAh6t0TYcIQfFR8yObffl/ZuJG7zbcCFMc6wg0JEa6zEUgOsI2TfP+uJYVH7dg==
X-Received: by 2002:a05:620a:2889:b0:699:bbc5:9b4b with SMTP id j9-20020a05620a288900b00699bbc59b4bmr4202038qkp.712.1649990931638;
        Thu, 14 Apr 2022 19:48:51 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:1b7a:2349:50b1:5db4:a2d5:7054])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a22a700b0069c37e2c473sm1800085qkh.94.2022.04.14.19.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 19:48:50 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v2 5/6] staging: r8188eu: replace spaces with tabs
Date:   Thu, 14 Apr 2022 22:48:36 -0400
Message-Id: <b65ac8696e994e44c0d7dda5b6afa14cf7b8db74.1649990500.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649990500.git.jhpark1013@gmail.com>
References: <cover.1649990500.git.jhpark1013@gmail.com>
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
index d57f2ffa069e..38ae8be675c4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -716,7 +716,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
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

