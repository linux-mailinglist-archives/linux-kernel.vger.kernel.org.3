Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A3E4C2425
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiBXGlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiBXGla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:41:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214C418A7A2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:41:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1261450pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElvpxC59AC+5EE0hm9laYqztd/rBe9KXtd2sk3NCuYA=;
        b=IZqeiiWnye2HrgzIsdHmNw0Rleg0bMGKe/vKXS+rqKaM5kU79Q7U6QvSXTCD4PI9aX
         zZXjFrvQNblcYzSbbyIGCUBRJ+YPXppnvtoDORH8HE4nhJqjUQJyTS1iMpZVUP4P0ElX
         Hoew6Ad2kXyIZNpkcf5oMA2CV3+KhX9nrFa7gmg9jBRGV8bvIIzCG/O2ZUwBMLF3bBh0
         0Aby2+ZiSyHpPPjCgxOrgp8XLSD6VBLbbHYpWxaT0sci4bKk8bOfdh3Z6VxSaOs45wj8
         odLhD5gmhsXXPvACvDyrLLawabmTBKgFx/fRGhpf4pQTgZDWxOzpCz8a4UMQ6tvcihVc
         5+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElvpxC59AC+5EE0hm9laYqztd/rBe9KXtd2sk3NCuYA=;
        b=KxLFDpM9tYYEy6xhqL0QBeYujZ6YjtDgOyPG22aaSNroXi/1AauXWriRNvLaja2hfb
         eQyKZj9RMO0fqD4guYSWdTDhOTtGF3X35Z+EtRmeZ1nWyvSXECXYLEGtTytRqj8gc3WN
         t7Itrj86a1ahn4gsm12pWgEkPUUY83SiwzDq6cH3012Ny0EiwlHrkRuJ3qb5q0F2abrZ
         vquf4YhmFxucOc9tA0iCKxfrI5kPVqsKNZCY1rMA/1CgNKso7jJ6ZBR0AITXJ0ahELOH
         DK6LvbMOdbH/FzvaBaTz6U0fYh72FadUnAbsOgX3JUNPrX9m0NVxtPKmVRFAtOkeSOFw
         S2uw==
X-Gm-Message-State: AOAM532ssrkdQp5dvNuf5fVdMUoL5BwoRzCrX66Pe4PFDP930GtmLamW
        NB20x9+cFH/NJOwaAgA8VxE=
X-Google-Smtp-Source: ABdhPJwzsITH29U7YX+Ztw1B5zJQVIHuORmzkcointo7qkrUm5hzfrx49+I9VnSprMuI7GBbF1S+cA==
X-Received: by 2002:a17:902:f681:b0:14f:d22a:d71d with SMTP id l1-20020a170902f68100b0014fd22ad71dmr1178730plg.96.1645684861583;
        Wed, 23 Feb 2022 22:41:01 -0800 (PST)
Received: from tong-desktop.local ([2600:1700:3ec7:421f:47fe:f358:be6:4577])
        by smtp.googlemail.com with ESMTPSA id j12sm1729109pfu.79.2022.02.23.22.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:41:01 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com
Subject: [PATCH v2 2/3] staging: rtl8192u: add empty debug functions
Date:   Wed, 23 Feb 2022 22:40:30 -0800
Message-Id: <20220224064033.1530924-2-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YhPI5iDRUpzYWDyY@kroah.com>
References: <YhPI5iDRUpzYWDyY@kroah.com>
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

Add two empty functions to handle the case when CONFIG_IEEE80211_DEBUG
is turned off. These two functions will be used by module init() and
and exit().

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index ab1e380688ee..68c0bf9a191a 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2315,8 +2315,13 @@ int ieee80211_wx_get_freq(struct ieee80211_device *ieee,
 			  union iwreq_data *wrqu, char *b);
 
 /* ieee80211_module.c */
+#ifdef CONFIG_IEEE80211_DEBUG
 int ieee80211_debug_init(void);
 void ieee80211_debug_exit(void);
+#else
+static inline int ieee80211_debug_init(void) { return 0; }
+static inline void ieee80211_debug_exit(void) { }
+#endif
 
 //extern void ieee80211_wx_sync_scan_wq(struct ieee80211_device *ieee);
 void ieee80211_wx_sync_scan_wq(struct work_struct *work);
-- 
2.25.1

