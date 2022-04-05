Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0243C4F47FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351609AbiDEVYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455062AbiDEP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:34 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B4D3723
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:09:19 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id v2so11506261qtc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=YZkbL+GyCYshGd2SxK7PvgiiaFokGhdvBjFhAiL3mJE=;
        b=ZJO9yRZp6P90RZT3XEvaUufFTHnVskvsXvvmkYd9SwzpPfgQ/EG7qq7XxWlnwiAWZo
         P87Oj4KT6pQfjRrCT+DpXN5an1xn0JKcq13+wFXorFDrN7JcfMlNb5TWDfnUUdJj1+am
         u/COgwXV/FL5IXcjkoE6ZJu8OXTt34vQyZjsGz7DWRMSrtnX1PJo/os3xrYpXg42KcBN
         rnZO8Lts3yrMffecZZBrIk1/RZKUlrubFkJjuldbUXB5gB1TdX70eAdcZucVRfiMem6K
         NbNXuSftzcBcc6NzXtkTRUFZo31VAtvKDKOAFFPu01z1GS0yn8EcAeqkhmn3robIPMwE
         rSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=YZkbL+GyCYshGd2SxK7PvgiiaFokGhdvBjFhAiL3mJE=;
        b=PDqR27+pVAZ6t3vtA1B6iZCoVOyeeESivPVKFtWiVJfxv/1KdlQolDiKRf0hvUVTOr
         9siuhdr1PRAa0bWSFDXu2YyUptYuuZ7UGTKWFSwK5GvTaoZTOHoJTmEU5DBhBa+/F/B0
         UIasBEs35RZTJz62H6w5w9o+MKcvxmiFL4gkVteioOCY0n8sxQBq/QTKMvBFxGAthyzG
         Mc9dxHafP1iXiQoRcxMEdczLIO0aNeSYheGBvRh+2i306tZdnckC7XVzgkGewZtMGomu
         aM9p8Jns9PWTiC3a4fEGcmcIzE3owd1NyxEz4WNuWra71f7ubo0H6iQn1UuunFfuonS+
         tw/g==
X-Gm-Message-State: AOAM531ywncEFsoq63FUf+41SH/WZ0FvYUU4kIeuGb9OY1UtEo+dqUuG
        l1qMf4kifs6d37RxtjdJnQzXh5FImv5ITw==
X-Google-Smtp-Source: ABdhPJzBcKEnmfMxzO4pTwXmDLNbb647BPIfA5UOISMSbZI4aCTntBXAPD1cj/qU/bDGmO4X+wqKOQ==
X-Received: by 2002:a05:620a:4612:b0:67e:be08:b079 with SMTP id br18-20020a05620a461200b0067ebe08b079mr2633660qkb.422.1649171358837;
        Tue, 05 Apr 2022 08:09:18 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002e06aa02021sm11266239qta.49.2022.04.05.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:09:18 -0700 (PDT)
Date:   Tue, 5 Apr 2022 11:09:12 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rtl8723bs: fix indentation
Message-ID: <20220405150912.GA625670@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

WARNING: suspect code indent for conditional statements

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---

v1 -> v2: Remove the comments that became irrelevant with proper indentation.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 04e29e228c1e..1bdbd0971f73 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5143,17 +5143,9 @@ void link_timer_hdl(struct timer_list *t)
 	} else if (pmlmeinfo->state & WIFI_FW_AUTH_STATE) {
 		/* re-auth timer */
 		if (++pmlmeinfo->reauth_count > REAUTH_LIMIT) {
-			/* if (pmlmeinfo->auth_algo != dot11AuthAlgrthm_Auto) */
-			/*  */
-				pmlmeinfo->state = 0;
-				report_join_res(padapter, -1);
-				return;
-			/*  */
-			/* else */
-			/*  */
-			/* 	pmlmeinfo->auth_algo = dot11AuthAlgrthm_Shared; */
-			/* 	pmlmeinfo->reauth_count = 0; */
-			/*  */
+			pmlmeinfo->state = 0;
+			report_join_res(padapter, -1);
+			return;
 		}
 
 		pmlmeinfo->auth_seq = 1;
-- 
2.25.1

