Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17C4F50D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843513AbiDFBlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452385AbiDEPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:54:51 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514010BA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:54:29 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c4so11426192qtx.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=GiOCB0LEnVJnuUDKgIp7T1dC76Lv7y/CQVx5+uI2YZc=;
        b=M4hADWEp021dn2H8CsRC3C99oEW6F8vJHJoOMLrMCUtoe85gORP+719UDYi2PioJJ3
         GAsgSFwUvRgL8dnof/nCYGHgPIa1D9XSoPsoIXWanp2KBItOXOVI2x5vt0aYpRQfdiZB
         HHKE/qkU+hyMsvzIK6CkqHKMgoxN97q8Z4ea4nnIyD/gUD17zGKWZIafrQHusA3jX10q
         BJf6b1JG5zF174+wAgF5T1WJ8R9h4qVTE22/B9YkTgcl1C4jAyXI50FDli44jMrzaNIQ
         vCzcayMxf5CKvgNqsYxf6Mj6swmrVLwPvB11MJUtx/UVVPyWFX9kKiWXc7vUDesLtrlo
         lVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=GiOCB0LEnVJnuUDKgIp7T1dC76Lv7y/CQVx5+uI2YZc=;
        b=g09kPDWAN+3TiYeGgjIWfqYv00sO8eLvJ4Sgv1NqSkmdupu8PUUd9o41rCe7lydEyd
         qBvTmwXAnwpDZxPN+xujBWc6sHUyNlXOEHqXnannVUSgcPLyZkQhwwKs8Y4/n6w8yXEB
         tf57W65FxX/xgRD5wCGeWLlYn+MJHyEt7XJ8J9yZKXdwAd8adk6TQL6X0O4z161aSfvO
         m0Y2pw7LvFsOfo+ANcpLfx+2P3bYw/2XRTu7DDdubb0u5a0yGIF0sZxsqaKYNXM6v/8q
         Se101ih24p1jgnZQxbya9qBNlIxafeJJs2Azsv2U2ckmCQRMdEj92iAKLopC/ItOO+Is
         H+tw==
X-Gm-Message-State: AOAM531lON/BkYf4KGQGdx38nqCUXZjyD+IZnwrN2PmWmedQJiPTfjy/
        vyvzprp7lRuCIkpooVPJR1LQa8xMkqfYQw==
X-Google-Smtp-Source: ABdhPJxWyKR68v2HR7slViur6n1YhBWHCXKEZdM79ZxGegD3hmcTEcx9ZnCjsvnh4vH3eih2OrSbyg==
X-Received: by 2002:ac8:5dcd:0:b0:2eb:9458:4985 with SMTP id e13-20020ac85dcd000000b002eb94584985mr3329851qtx.85.1649170468792;
        Tue, 05 Apr 2022 07:54:28 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id u62-20020a379241000000b0067ed2b0994dsm8201646qkd.54.2022.04.05.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 07:54:28 -0700 (PDT)
Date:   Tue, 5 Apr 2022 10:54:24 -0400
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8723bs: fix indentation
Message-ID: <20220405145424.GA623343@euclid>
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

