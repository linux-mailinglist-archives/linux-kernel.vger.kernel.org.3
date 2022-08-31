Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D315A75C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiHaFg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiHaFgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:36:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35051A894F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:36:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb36so5324580ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=iq7MNHMLWmoXJu8LSGb5KsjsJLnznH4nitQ6n3bLOfY=;
        b=cD0eE0gMPJv6AFsCkaSAtRjcgPv2FR6ypXADkQQKhnu27aYKO3ZBX0Ct17ci3/voBV
         GIrbnH4Datq2VKuyi2ykWQZN7yDHX7qNkS3Tjt9kaPBxPyQimzyQXW+LDcOh78498Zlz
         0CDJrccF6OD8snGITZAIJXSko4ec274ZbqvsXUdANjpbUEiKWy609QrE3F8On6jdnABW
         xWu98ysZwwFFMd0ivK1MTz4Bm0PE+x1FQSpeyc+5CrgQo6crRmHgCspqWwtdEk89JgQ0
         IbuwDkz8xA/LOLRlXmql83RQB0R/h0vSjm7UdhkAclbBXLWcrbelkrKpuLE1YxkDUUlb
         R3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=iq7MNHMLWmoXJu8LSGb5KsjsJLnznH4nitQ6n3bLOfY=;
        b=TK1pZDV8UXih3yvOFZcyO4m6eankYw5nJy8MSnOxjLGCDU+gqj0VrzlZSoNeQMzoLy
         kZof4TFEhrWpQdXjYAgwTWD70WQFaJvRPb/IfCYH+IuAXPhsYxLgDq2rWwU9VWcgVdYL
         ixXRWQcn4Dyl30NhtZdazBEUjD/XKxSm+GMD9sAwD0Wn9dDnMzF0+5YxJtLe79/jHqrg
         pNDLZTmhfJ4OV8KGW58rczd6V326yqJ5JE9DJgUcC2+SzPgUn/rH+uQCxQp23q/d6uxR
         fAH5tkkdMb+IZYVLnFQey/rriC28MFO6CS7ZZeokt+INtdeVVi12A2Z4efDAtm3OHTGA
         mqig==
X-Gm-Message-State: ACgBeo3I3rQlPtIwaKbCm36f/ICZwPzsQpotqJhRmwcMyW0EmkPrGyVE
        ELYUGc4CKGrnWP7a1jHpQuo=
X-Google-Smtp-Source: AA6agR4/jNoZrVh8xVKkfGrl7+YhbIpStB2JYJbHDsN89h+kY62UO+m17JSt/ryTwVUSBUQNBfw00A==
X-Received: by 2002:a17:906:cc5d:b0:741:38a8:a50a with SMTP id mm29-20020a170906cc5d00b0074138a8a50amr14208343ejb.650.1661924211818;
        Tue, 30 Aug 2022 22:36:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb89.dynamic.kabel-deutschland.de. [95.90.187.137])
        by smtp.gmail.com with ESMTPSA id gh21-20020a1709073c1500b0073a644ef803sm6610135ejc.101.2022.08.30.22.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 22:36:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: make two functions static
Date:   Wed, 31 Aug 2022 07:36:38 +0200
Message-Id: <20220831053639.8559-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831053639.8559-1-straube.linux@gmail.com>
References: <20220831053639.8559-1-straube.linux@gmail.com>
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

The functions rtw_join_timeout_handler() and
_rtw_scan_timeout_handler() are only used in os_dep/mlme_linux.c.
Make them static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_mlme.h  | 2 --
 drivers/staging/r8188eu/os_dep/mlme_linux.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index e8168e36fac2..d827ea7d841b 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -433,8 +433,6 @@ void indicate_wx_scan_complete_event(struct adapter *padapter);
 void rtw_indicate_wx_assoc_event(struct adapter *padapter);
 void rtw_indicate_wx_disassoc_event(struct adapter *padapter);
 int event_thread(void *context);
-void rtw_join_timeout_handler (struct timer_list *t);
-void _rtw_scan_timeout_handler (struct timer_list *t);
 void rtw_free_network_queue(struct adapter *adapter, u8 isfreeall);
 int rtw_init_mlme_priv(struct adapter *adapter);
 void rtw_free_mlme_priv (struct mlme_priv *pmlmepriv);
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index 5bd2b2c31342..2f8f866d5362 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -7,14 +7,14 @@
 #include "../include/drv_types.h"
 #include "../include/mlme_osdep.h"
 
-void rtw_join_timeout_handler (struct timer_list *t)
+static void rtw_join_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = from_timer(adapter, t, mlmepriv.assoc_timer);
 
 	_rtw_join_timeout_handler(adapter);
 }
 
-void _rtw_scan_timeout_handler (struct timer_list *t)
+static void _rtw_scan_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = from_timer(adapter, t, mlmepriv.scan_to_timer);
 
-- 
2.37.2

