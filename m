Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A3550CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiFSTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiFSTmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:42:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A045586
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m2so753606plx.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yhbMYbX4HtRbzfEZJFo8LMvIa5s7zM2myB/V/KkweM=;
        b=Yy/mGjXKRM7R5k3PY1YFCGE0du4sujyFxeyANLLNCMTtbH+D1CVDSswsskmtK+2a/p
         CSXJAYS+qcRgqAkaJJQzi5RhFrbmGgmJgyvpIKzpT0b3CyFId/bpE2aKxRY0kzoP60ht
         PVbiE9Uq17Q40A3LJOFPb+PlphuYJkVXMjfQUDwKxkOOjpzyaeP/jyJ2LnlkIc5OmAGW
         gqegbLrPTZxaGRf4mxCKcWv+14YVoLqkZDQhexsuX6UM6ayn9Y2i/QzRINuMhP24x0bH
         VjptmHic8Vin1k4LoyHZpDwYakw44xBlJuEFM+TsXXHBgtpV2gh+K+pN/HTNH0xDEJHa
         hbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yhbMYbX4HtRbzfEZJFo8LMvIa5s7zM2myB/V/KkweM=;
        b=1VJWmVhJd4Zhs8gjGEAb/fDJBOWtMtSwjdp4cS0P8WlRNLllCf83LyFj7aPhADrHMa
         kQAufe5ADdwZWLR1O+EYS+NoXsdhmvfFaFbFZS3/1cY2/1XOIJha2Oa7eXiRg8donDfe
         48wHJggB9bOlrEbUSgXdn23SzgNOTqWUyPaGRmIo8CXhCDonef5v9txKFlGdPbDidcUP
         sFo5lGV4z9lUWwDahR9F6Enx3i3X7hIhAGyi06AZqKFUCBoLw9EvmZ1NU65oYPcYAc8K
         mMK5Y257sLwsTpE54AfcCCw9/QEj/B5uXUOooa+hbXK88FtkPk5Uev+hal5NhkE3vhXg
         VjUg==
X-Gm-Message-State: AJIora8/jZNuVVmDB+bazZ/OUpLjyHBckbhE9MgUu6PaOAkyY+YJzaAC
        wqyQjJE3weDWX67ucHsjBjQ=
X-Google-Smtp-Source: AGRyM1vQ72ZXZU1v51U4BZ0gIX1RMl7fcXKPbeGXpZBkq5C5G/h3PY58XOL60Q4LLgg5AKHC6zEMAg==
X-Received: by 2002:a17:90b:4c07:b0:1e8:2961:e318 with SMTP id na7-20020a17090b4c0700b001e82961e318mr22787751pjb.151.1655667774538;
        Sun, 19 Jun 2022 12:42:54 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id p12-20020a637f4c000000b003fc4001fd5fsm7483584pgn.10.2022.06.19.12.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 12:42:54 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v2 2/5] Staging: r8188eu: core: rtw_xmit: Fixed two indentation coding style issues.
Date:   Sun, 19 Jun 2022 12:42:28 -0700
Message-Id: <6b0e3efe83bf06ea60cdbe27f31f6f3aa1058f01.1655666628.git.marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655666628.git.marcus.yu.56@gmail.com>
References: <cover.1655666628.git.marcus.yu.56@gmail.com>
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

Fixed two indentation issues.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 1aa284453ab2..2bc059808a71 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -626,7 +626,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 				if (pframe[1] & 2)  /* From Ds == 1 */
 					rtw_secmicappend(&micdata, &pframe[24], 6);
 				else
-				rtw_secmicappend(&micdata, &pframe[10], 6);
+					rtw_secmicappend(&micdata, &pframe[10], 6);
 			} else {	/* ToDS == 0 */
 				rtw_secmicappend(&micdata, &pframe[4], 6);   /* DA */
 				if (pframe[1] & 2)  /* From Ds == 1 */
@@ -1737,7 +1737,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 	bool bmcst = is_multicast_ether_addr(pattrib->ra);
 
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
-	    return ret;
+		return ret;
 
 	if (pattrib->psta)
 		psta = pattrib->psta;
-- 
2.36.1

