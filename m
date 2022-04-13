Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5556B4FFFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiDMUO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbiDMUOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:14:11 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289727EA33
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z16so2196842qtq.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ul9FGVJ1sqTdARK0mUZLH5+vAqXgfv1Osb8Y+BayvnA=;
        b=g3gjqqtdqKQE5IGicT5Wjd9h3ncG7DVCNTkMIk04qmTIFPfSPARDB83o4ujZ/aj4BW
         1Ziuz0voyvAICrIB0yVPtQMS5aEEyJsViQkfhCuBv2rFF2P6KAlcUpGIfSQuwOjSAg9+
         PoyxmZghi/DZFjwjf7KINxaxqWt02zgrnI4bz5GtcJTQ2iAz7Z/lAgVks8UJPzzGp0vR
         O6YdTukXugvGAKbCAJHdei/PAAX9L0dr+/v6acnR6iuk3/kdXqHLFmvmZ9yE1Uc4KKgE
         wO4qkmrufxD+mJhNQenzel3OKXg57IvUXg536Dgbh6dnNlQDSPstmwjlENL4fSy59SlU
         UO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ul9FGVJ1sqTdARK0mUZLH5+vAqXgfv1Osb8Y+BayvnA=;
        b=iXwgx+GNrqaRnjb0kDBKnOpnb3Fz9P+Ke5IM451pWa/wyzssff/7v/PtskaCGVgOAQ
         7xQ9ukEhaPmJX4q2uMFJcoEPhVDi/pB8IlXit9ox/pn1u5zkWbxNnicXwgs0P1Oj5nxF
         aKkvc6NDpJEY2gKO2FGDUr7W8BcUpNv8FmJQbbcKF3GkhrGw5ok6pzQra60pqXSSuZZa
         J2uTnSusrXienqeLrLqdcH9cGrXX5tNOTZh5oDSiq0HSHTCR+fTnhwX1CzIvUCWzWeAh
         tfwR3BuZJI6/QPSW3jXNVtOvayBSQMFOIJJpNECHXFCL+g3+Q/0RXPWocAidVdh9inu6
         Lyhw==
X-Gm-Message-State: AOAM532CirMeNnLJEFyIOuKnhxrpE9UpFvlF0iaUTa0N4uFR0aKV6bI8
        W7H4VV6wGTje6X+1B4v4Ay8=
X-Google-Smtp-Source: ABdhPJzfi6bbVPouWPiwjX4RCv+GQvPEnn27rrOjadz/T8qn0tC/JtVXXDXSE2vWCCCbYKdHSZ36SA==
X-Received: by 2002:a05:622a:408f:b0:2ed:12b7:2e9c with SMTP id cg15-20020a05622a408f00b002ed12b72e9cmr8351994qtb.309.1649880708326;
        Wed, 13 Apr 2022 13:11:48 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id 7-20020a370907000000b0069c5598584esm1469827qkj.105.2022.04.13.13.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:11:47 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH 5/6] staging: r8188eu: replace spaces with tabs
Date:   Wed, 13 Apr 2022 16:11:33 -0400
Message-Id: <c2d719eba2a374be573034022218a098e4db9e77.1649880454.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649880454.git.jhpark1013@gmail.com>
References: <cover.1649880454.git.jhpark1013@gmail.com>
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

