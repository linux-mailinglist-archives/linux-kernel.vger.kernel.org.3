Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4194F881B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiDGTbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiDGTar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:30:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE144299F0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:28:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so7569757edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0bJLwilh7WH2dJze8SpTafU8NcKHXjFenPKKfg6dz0=;
        b=dnl4yaFuJmzRJC1dsaooha0LilBinNwtGkCoaNEJhxbia6EkFOwbDMQLmz053BoCZM
         8mk/PkRWyc25WSQYa/2LGIPgHq+ANdc3PNw9ywtwNp3puDiAle5l9Ti19+NSHNS6h+9s
         I2OXARH9wZrMHvzQFCSKKd2YnJByv9LE7wafacsQQXZMHfgCCj6LNEJ4sOkfuVXE73q/
         DsLE5Ose7jz0ClePmdd1EJyycSgby8ALw6GCRRwfqGTMlIc7P1XCqSssNBrn4W6s9u5W
         BomzNtPs/LKVp0NUCNExJRe10BAf4Mfu7QUAX2X5/oy/VE282vfMLF+NGRBD3mhEYZkd
         Kg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0bJLwilh7WH2dJze8SpTafU8NcKHXjFenPKKfg6dz0=;
        b=KA2M6JsIwA7RKiA2q/gQ34lcKqARn+WkOcSBt11YPszUjEYmXVdcsBwEog96iK0l7d
         feAQXp9T8vdj+A8+XEzWCSJLfLUPEZ5mpFnip6b4S/dhs6ZHLDDyJX6zHyjLppcJHDGi
         xepjxb6YAivfs7B3prkiYLUl14a7QfPJ4d/9oVhl77c9acg1pMfCmb4sAu1QpOGH0X9u
         ULdzBkzlK9U3OPl8y7Mjt88NF/D1uqonAwKpzagZ2+PEbKQFJIjViH2lozrTJak6dbqr
         959wOPszPN2mDMTULy7flOJQhgfa8iIKvQ9SkG87LMM7zvNETLcmTaAIX3jQi93hms9A
         OsLg==
X-Gm-Message-State: AOAM530y4rklHn4XK7wgo+ifqMEwQDjnBmt+Flun+vrM6BXiX55i1Pw0
        5BXGipEaDYOqGoyjYjBtfoM=
X-Google-Smtp-Source: ABdhPJyyQYuQXxG644w9SUnoQFO/aKp53IZJZzJXHr158yoRDweK+HSZIsQB7ggegFWEDrPbpl1BBw==
X-Received: by 2002:a05:6402:d0a:b0:418:ec3b:2242 with SMTP id eb10-20020a0564020d0a00b00418ec3b2242mr16149692edb.229.1649359706885;
        Thu, 07 Apr 2022 12:28:26 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm9652798edl.22.2022.04.07.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:28:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: r8188eu: remove unused enums from odm.h
Date:   Thu,  7 Apr 2022 21:28:16 +0200
Message-Id: <20220407192819.10661-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407192819.10661-1-straube.linux@gmail.com>
References: <20220407192819.10661-1-straube.linux@gmail.com>
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

Remove unused enums from odm.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 29 ---------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 1902aa48a255..f131e17167bf 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -98,22 +98,6 @@ struct odm_per_pkt_info {
 	bool	bPacketBeacon;
 };
 
-enum odm_ability {
-	/*  BB Team */
-	ODM_DIG			= 0x00000001,
-	ODM_HIGH_POWER		= 0x00000002,
-	ODM_CCK_CCA_TH		= 0x00000004,
-	ODM_FA_STATISTICS	= 0x00000008,
-	ODM_RAMASK		= 0x00000010,
-	ODM_RSSI_MONITOR	= 0x00000020,
-	ODM_SW_ANTDIV		= 0x00000040,
-	ODM_HW_ANTDIV		= 0x00000080,
-	ODM_BB_PWRSV		= 0x00000100,
-	ODM_2TPATHDIV		= 0x00000200,
-	ODM_1TPATHDIV		= 0x00000400,
-	ODM_PSD2AFH		= 0x00000800
-};
-
 /*  2011/10/20 MH Define Common info enum for all team. */
 
 enum odm_common_info_def {
@@ -137,19 +121,6 @@ enum odm_ability_def {
 
 # define ODM_ITRF_USB 0x2
 
-/*  ODM_CMNINFO_OP_MODE */
-enum odm_operation_mode {
-	ODM_NO_LINK		= BIT(0),
-	ODM_LINK		= BIT(1),
-	ODM_SCAN		= BIT(2),
-	ODM_POWERSAVE		= BIT(3),
-	ODM_AP_MODE		= BIT(4),
-	ODM_CLIENT_MODE		= BIT(5),
-	ODM_AD_HOC		= BIT(6),
-	ODM_WIFI_DIRECT		= BIT(7),
-	ODM_WIFI_DISPLAY	= BIT(8),
-};
-
 /*  ODM_CMNINFO_WM_MODE */
 enum odm_wireless_mode {
 	ODM_WM_UNKNOW	= 0x0,
-- 
2.35.1

