Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBADD4B3CB0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiBMR75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:59:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiBMR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:59:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E85AEE1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:59:47 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y18so8824581plb.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIubIh4Wyz3tsOI6MEDUxASpEp1n/qqp0RW8fAkp5Is=;
        b=chKJoCnSwiXQNcGxobfzewsPGvPFqJUpAT2ZrYWsolWYBwA+6W62D22Y8Qlu24bZHX
         X0GZHtgvFuX70WlB6W00XcMg2/naTQ5YfyJh+MguS0Gy69ehw7GO2xes/BzxRQoW/KnI
         /t2z4uazgmAR1VWgRCdLTpaZhFcksnFW1T6yfWfWcGKCYgAeUKxQ+n3pAO5PpL6KidKj
         BxqlFpZ66CJzklIjEFyGZ+Z2b3VKx1sz/Mvg5k6rqkwS5P5yxYpMqxI2+gglsykXcEfd
         GRIYekN5GnniOLY31Oebx59qgR5s9x7hykD6keUccMXY6/IyskYkxJv+d1ufqOpvH2ZZ
         SKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIubIh4Wyz3tsOI6MEDUxASpEp1n/qqp0RW8fAkp5Is=;
        b=orQLp1wJxn/Y56vjoPzWwAZq5LGk3VftWDtuZ7b5y8TQi8yTEZwAJtKkvwyBLxSNOY
         vGtphy7nTBxBD+CciqeT5++mUVISv2DA5/cmkVQX41vpa/nkCbN1l8wVRiUoKycDboWk
         KkQEySyLGEI9Xe/EWu6jqKmOcoYA9j9jjnuUeEeyApz3RIiugybid9Elj4Lni7KKzAs2
         maMKx1bsJhtjO56wBPxfWqVwYr/+kodR3+VbjzX40Amki7GB6crpssF4hN4mrZgepc2q
         N1DQT2nkvqPw3EuV404au8XgCwA56lONnPsXsNZt+D45k1pI7pMSuAqJRetwCMwbF1/6
         /0XQ==
X-Gm-Message-State: AOAM531RFATDT5ZFx8waBW0+XrsAibQn9xONt5+g68wQ5hpIsWL4IzBW
        ktjI8j+LSFSUAdEFV9520owGZJdyM33IHA==
X-Google-Smtp-Source: ABdhPJyOObH9yXI4jZ3v/ZC0hv+bvvh9z8jtq9XqPQ8W6mQH9O0JMQWaoSvRIkaKjflfd/ycLnchmg==
X-Received: by 2002:a17:902:ce81:: with SMTP id f1mr10614856plg.35.1644775187074;
        Sun, 13 Feb 2022 09:59:47 -0800 (PST)
Received: from localhost.localdomain ([103.85.9.185])
        by smtp.gmail.com with ESMTPSA id me18sm8446066pjb.39.2022.02.13.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 09:59:46 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH] staging: r8188eu: mark _rtw_free_sta_priv as void
Date:   Sun, 13 Feb 2022 23:04:26 +0530
Message-Id: <20220213173424.39935-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
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

_rtw_free_sta_priv() always returns _SUCCESS and it's return value
isn't checked either.
So it makes sense to mark it as void instead of u32.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 4 +---
 drivers/staging/r8188eu/include/sta_info.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index de5406a58..79b49a13f 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -117,7 +117,7 @@ inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
-u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
+void _rtw_free_sta_priv(struct	sta_priv *pstapriv)
 {
 	struct list_head *phead, *plist;
 	struct sta_info *psta = NULL;
@@ -147,8 +147,6 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 
 		vfree(pstapriv->pallocated_stainfo_buf);
 	}
-
-	return _SUCCESS;
 }
 
 struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
diff --git a/drivers/staging/r8188eu/include/sta_info.h b/drivers/staging/r8188eu/include/sta_info.h
index 24b125431..23f6a85bf 100644
--- a/drivers/staging/r8188eu/include/sta_info.h
+++ b/drivers/staging/r8188eu/include/sta_info.h
@@ -344,7 +344,7 @@ static inline u32 wifi_mac_hash(u8 *mac)
 }
 
 extern u32	_rtw_init_sta_priv(struct sta_priv *pstapriv);
-extern u32	_rtw_free_sta_priv(struct sta_priv *pstapriv);
+extern void _rtw_free_sta_priv(struct sta_priv *pstapriv);
 
 #define stainfo_offset_valid(offset) (offset < NUM_STA && offset >= 0)
 int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta);
-- 
2.30.2

