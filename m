Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4E54F2152
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiDEDSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiDEDSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:18:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE321E20
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:16:30 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s11so9473487qtc.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 20:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRi6mg+Ezu0oiDDIceXrLTZ+9OfQbKuOLQbA8q9YTdk=;
        b=oiZ5OOkmx5jtptFYs/x7G6URXWmZbRLK6/MwcYOIKV82KH94lio3pXKayG88cIjZIc
         N/cgEQS96Xse/wBSWCyuxwT9KhAJhC3gedNQgi8DfVSdFCveWsRNmwbxVttso1Ec0gIi
         r4qC6jrFJM2M8mthtL/WPC3NX99B6I10aPhKO/TgF8s+9iIbwpIcOZoV6CB5pdwlSGos
         zbwDOGzOy1kInjOwr24evMuD0wxRAkRhmdH1emzjeLfplpIIH15pQu7PCIRGvYu92LSz
         MNWNS8bvRRGFCc0A0SQA8RU1amLHz7AV4rzmHeHolo+P/VQ8NBQhoXCb7KVR33Eke0jL
         PJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRi6mg+Ezu0oiDDIceXrLTZ+9OfQbKuOLQbA8q9YTdk=;
        b=u5ylxLD2BGnXlHLqLBD4202WrQ/qbF29L9iw7+tSGDP1HMUjhOm05R+Es8ges0tlfT
         J55Kk9+5466/HcV9lecjeeWjaCghkRMSRFpuJRd4Wv5OLEJy6R6yrncjQYUWycWUrYoj
         dO0vbCXOSwuZO/WMsblORNSd9n2XOVthl+wMy/zdT1i7DVO0ZSGKTeO3/LZb6CMkE1XG
         QRrOfg96zhkSvYM7LpOaXxaw8C1ZUfku1o4UhwzzAUOnsQrclM2SsGUDwwa+staVa3wG
         Fw0/3NLU1GJ1i8iM1Ky56Df7TmYP3cXBnZrzXi7vlNgASRhquA7Xs40ZBC7ufGZXQGhM
         mHyg==
X-Gm-Message-State: AOAM531wLFGKtdhtIjbmBMYccjx91dfadYJvz3dWgDAWmTuSZlBIrWnd
        XYrfCU7xqamNkBSzbRRe0vxeMnWT1svmSw==
X-Google-Smtp-Source: ABdhPJw9XnDGw80Q8wrV7MypqxyBgsxIY1MUHc7umgqBr+tTK/zgae+0/dBMH9BLvRGOrHFR/Z6wpw==
X-Received: by 2002:ac8:5702:0:b0:2e1:ec8a:917a with SMTP id 2-20020ac85702000000b002e1ec8a917amr1263525qtw.682.1649128589221;
        Mon, 04 Apr 2022 20:16:29 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id bi36-20020a05620a31a400b00680fffef5b2sm7512101qkb.48.2022.04.04.20.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 20:16:28 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 3/5] staging: rtl8723bs: remove return from a function returning void
Date:   Mon,  4 Apr 2022 23:16:10 -0400
Message-Id: <d1aa09f34cd192e284048999ba8e20d26a224483.1649128267.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
References: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
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

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: void function return statements are not generally useful

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 8c3b1448270a..c06be65b45cf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5112,22 +5112,17 @@ void survey_timer_hdl(struct timer_list *t)
 
 		ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
 		if (!ph2c)
-			goto exit_survey_timer_hdl;
+			return;
 
 		psurveyPara = rtw_zmalloc(sizeof(struct sitesurvey_parm));
 		if (!psurveyPara) {
 			kfree(ph2c);
-			goto exit_survey_timer_hdl;
+			return;
 		}
 
 		init_h2fwcmd_w_parm_no_rsp(ph2c, psurveyPara, GEN_CMD_CODE(_SiteSurvey));
 		rtw_enqueue_cmd(pcmdpriv, ph2c);
 	}
-
-
-exit_survey_timer_hdl:
-
-	return;
 }
 
 void link_timer_hdl(struct timer_list *t)
-- 
2.25.1

