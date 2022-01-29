Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427FC4A306D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbiA2QFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351673AbiA2QFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:05:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CBDC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:05:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r59so9417436pjg.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xa9/uQimRO4U5DdZfy5OHCYx6e+VSAPR4ymHWAiOiFc=;
        b=nitZL45Jd8jjpmzytmvzZg4RNy1iCWk6koqbhkdU1VvecYhAnNMJIExE7JcVSBVnkU
         khBVIo/39rVRwuAUJAHUdiuvYXA4DoqN9hIb4W56m34+quB80y8obNhshlBxcBwwb188
         T+e+kie/Geu4QFabfsT40lKBOyY26ijKOpL+rxEyn0hSk86kkNXdmwYcLDKsG2/AE+Mc
         2Y0zv7OkmR8j2Qb4KdENcjqEn+rM8X1f7whpg4Q8eSlEWjBpxDIn+rTwyyL5ICZaTlrJ
         5UmWwAWdg7GpPQ+3CXsJtbzvejV+5LipP+U+chLXcwBrf3to+Cxfxk1aoWgydyga/ItY
         j4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xa9/uQimRO4U5DdZfy5OHCYx6e+VSAPR4ymHWAiOiFc=;
        b=QlRX0KmmoUuEnzC32e6sxs4yE9Xor4NxK5Pj+6Jj4Ejc+N1sMoGOZfPhYZ8LNWEBPi
         Yp3vHMgn/Z3J99IMP74OPJ9n/MfPJWJeszORV/mGCo6lP69JmQ5yQA69evJbmke4vfhH
         0+sc5gcd4ITG7cJqxkw3zh5bICWv3qb0Xcbn0sNf6NM4ObZBiVDdrIlo743pcXSpSvCX
         tDm7j1bd26B/iPASONcODlTPKrEAf23q9EatohEsAbMCMGtUttrlwtVC8H6KlxQKLpGM
         qbgWmoSjVJ9rFIQ6iKPZrVbMhu3SpMGrMJhp/AKflASaHK5ZK8SSfwNEvmReVwJR2V7t
         7C8A==
X-Gm-Message-State: AOAM530aXGbg7gS378HmIh2dBV2Zxf41njzNzjDY2WpqfAvXhczxYDWm
        gZssGCLohMHvcxje3Wggq0s=
X-Google-Smtp-Source: ABdhPJyiCGW59QHIl7TaXuJn+iXBBjkYu4OgfUAwdBNc3X9SDa9676AKvhMF8dkYwjmEhbT8AzGJTw==
X-Received: by 2002:a17:902:e746:: with SMTP id p6mr13199995plf.78.1643472345817;
        Sat, 29 Jan 2022 08:05:45 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id t9sm5672868pjg.44.2022.01.29.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 08:05:45 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/23] staging: r8188eu: remove unneeded variable in rtw_wx_get_enc
Date:   Sat, 29 Jan 2022 21:34:08 +0530
Message-Id: <e31a2b15673497cbd70bf62b0093f46952cc7596.1643466748.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643466748.git.abdun.nihaal@gmail.com>
References: <cover.1643466748.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded return variable that is initialized to 0 and not
assigned after.

Found using Coccinelle
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 3a60e1f81592..f99942417a71 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1717,7 +1717,7 @@ static int rtw_wx_get_enc(struct net_device *dev,
 			    struct iw_request_info *info,
 			    union iwreq_data *wrqu, char *keybuf)
 {
-	uint key, ret = 0;
+	uint key;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct iw_point *erq = &wrqu->encoding;
 	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
@@ -1778,7 +1778,7 @@ static int rtw_wx_get_enc(struct net_device *dev,
 	}
 
 
-	return ret;
+	return 0;
 }
 
 static int rtw_wx_get_power(struct net_device *dev,
-- 
2.34.1

