Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637F9550CCB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiFSTnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiFSTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:42:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD66343
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso8437617pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjFKNxuzMVouA/d7fakclf85AnSbfILJPYcTGegW5qw=;
        b=UwCbSawCcCT1UcHKQ3M2FG2+4vDf7xUy5BppVWuP8zcEKMltcHzlCAU9goZZhKkMuK
         GfjHBPV8O9uLFM2m9jImf+0vJfn4Sl07FyTaDimQwH7vHiqg87j+tfXRYOCOYFPYyUWt
         608BGhM6JUS1iTw7GI1JxTlUYSwTlphnMW9L461Fo25xd3kZf8LUCfAL5WC/I50THChc
         b9iQQenIDMvMqRnqmHhFDWwh/AvdAS/BeE1jkF1Z1DFJmctUDJmcHs/tXr5dbNLWELMY
         iCoXmQyZROu8bUcW0fHaKdKf+saodmPhJvQUied7GtTgkM3pJ0feN5cBPwNpyAwYZwgu
         Brhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjFKNxuzMVouA/d7fakclf85AnSbfILJPYcTGegW5qw=;
        b=rtIRzqlrneQHL8v8WSrBOReJZjE6Z9zZTkxFRkq5vWgHJHpb1SHfLwix5QNMyFtsmq
         cDpElj71UFlJNZKrxSa/jILxfD9CP++tfUhuLoLZQoyYAu85pLOn4FbtR6wepT8Ff+iC
         XrPVSxMK/9ilbbTH1/PhmbRxGnWTxp1GyfUtsfWpvNF+dlJgecQBDbIAJmf1qwDwY0Fx
         X94Rye0zdoyjULyc/Wm167dJZvBzsLJq8O1gODiyFxd4FtqJyF0Q53L7U0PmEvst+SsT
         G8ONlTZo7fbs746pW18MhV1L3pS+w4u/4j8fNP3BRRU9KEwtnhOaaI5lTF96Xn/n/ddo
         O+jg==
X-Gm-Message-State: AJIora9AwggmFia8OhGYjHEIMHImB9en/setWn6s53ZQJveo9qSvOCwl
        +XPoNzaiJbcldsLALPAMmcM=
X-Google-Smtp-Source: AGRyM1sB6AxmQpzfGNf7BsMzM2Ds5TDND0OugBJof33s1XvvM2leHIW8TPCsJ7tM0vdaZnhc0TKb0Q==
X-Received: by 2002:a17:902:bc84:b0:167:80c6:aedd with SMTP id bb4-20020a170902bc8400b0016780c6aeddmr20759705plb.97.1655667776376;
        Sun, 19 Jun 2022 12:42:56 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902edc300b0016370e1af6bsm7129923plk.128.2022.06.19.12.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 12:42:55 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v2 3/5] Staging: r8188eu: core: rtw_xmit: Fixed some spelling errors in the comments
Date:   Sun, 19 Jun 2022 12:42:29 -0700
Message-Id: <8d2f49631551b53ad970c9165cceb845c4d60b75.1655666628.git.marcus.yu.56@gmail.com>
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

Fixed the spelling of "broadcast" and "update" in the comments.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 2bc059808a71..73eb2f01c176 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -957,7 +957,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		}
 
 		if (bmcst) {
-			/*  don't do fragment to broadcat/multicast packets */
+			/*  don't do fragment to broadcast/multicast packets */
 			mem_sz = _rtw_pktfile_read(&pktfile, pframe, pattrib->pktlen);
 		} else {
 			mem_sz = _rtw_pktfile_read(&pktfile, pframe, mpdu_len);
@@ -1765,8 +1765,8 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 
 			pstapriv->tim_bitmap |= BIT(0);/*  */
 			pstapriv->sta_dz_bitmap |= BIT(0);
-
-			update_beacon(padapter, _TIM_IE_, NULL, false);/* tx bc/mc packets after upate bcn */
+			/* tx bc/mc packets after update bcn */
+			update_beacon(padapter, _TIM_IE_, NULL, false);
 
 			ret = true;
 		}
@@ -1816,7 +1816,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 				pstapriv->tim_bitmap |= BIT(psta->aid);
 
 				if (psta->sleepq_len == 1) {
-					/* upate BCN for TIM IE */
+					/* update BCN for TIM IE */
 					update_beacon(padapter, _TIM_IE_, NULL, false);
 				}
 			}
@@ -2085,7 +2085,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
 			pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
-			/* upate BCN for TIM IE */
+			/* update BCN for TIM IE */
 			update_beacon(padapter, _TIM_IE_, NULL, false);
 		}
 	}
-- 
2.36.1

