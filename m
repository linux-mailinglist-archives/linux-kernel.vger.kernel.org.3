Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4340D4CC1F3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiCCPx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiCCPxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:53:52 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9AD496AC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:53:06 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c14so6179941ioa.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9wCC6ma+G0ROf2L8fTWOMDInn2EXx12HmoAUJb0VTI=;
        b=amzbu5kMPiTGrdFI/f9rqPr0FExXQ8QlMrRHMq7gHgN4Ma8NrghzJVsENJaH8ya2MK
         WwoG/15bQAAs4VRYn+rGqyLUQ5x7kEqiNEpRToGZpazXHf5MQO46V/1kf1CtbVoJ8QvO
         iQoCZ6kPGtApHygrlO3yHejHGUZLtLgkVDqLJbcA4lkH9TE/tuUj8OF0tN1NXs5hB6ut
         tzg+BhIBKbJGlzvFcyG/EwlPubLR2IsX0HcGBQZow08IC/PXaFjRB+8r2SMzWG1MvZRA
         FbAv2bHEtZfbpgF2jmfuCaXvoOYWsJC8luXYufZ3vkTwTbTvGs5YmmgOxabsWijVK6iO
         0KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9wCC6ma+G0ROf2L8fTWOMDInn2EXx12HmoAUJb0VTI=;
        b=7IckC01LxVVY1bJUlxJ6qeoZy9zZEszFbFQjAkcLtm5DerFCFBrHr3PLLvGz37zPlN
         wPGXteTiCbmFwAmWnWa1ukA/5BFKdHtEsedWVPcbvR9wb7sYuZw3IFbjHDNS7yOvOOvW
         5XqBQV8ZpUnpQKV48e3FpJ/cB0WTiUpvacW0l4STJ6sIHucH5n66jHEAxvQfZTA/YB3I
         pDGCIFdar7HEJLuYzVeIABXPwpZApYd690MPQSqgdDIvMneYaKCFyE9UgtBjDQDgXurI
         vv97xfQ8SF9KmdaPqhuK/KdiPtRW8KFua6R3AZII2S5BTLwv9DGotMkgIjdXdgue1nc5
         7ydA==
X-Gm-Message-State: AOAM531Vewhq6czltUEEj6CE0stE9V5SkT35upXLKToehK7RltkiZ2L9
        aZYZ3y3etYpU73lJbQg/aoQ=
X-Google-Smtp-Source: ABdhPJyz3Apwg1nEMKBftYBiOJFs65vl0PkY+0lnY4bk8rt4EZ8bfaFGPCO9T+zLx4izQQfVu5nAyQ==
X-Received: by 2002:a02:604f:0:b0:30f:e6f1:3883 with SMTP id d15-20020a02604f000000b0030fe6f13883mr29779549jaf.266.1646322786397;
        Thu, 03 Mar 2022 07:53:06 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id a6-20020a92d346000000b002c1a6040691sm2506599ilh.70.2022.03.03.07.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:53:05 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, paskripkin@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] staging: r8188eu: remove unused field list
Date:   Thu,  3 Mar 2022 21:21:03 +0530
Message-Id: <558177d9165792a99f6efb439f6f537e13da705b.1646321515.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646321515.git.abdun.nihaal@gmail.com>
References: <cover.1646321515.git.abdun.nihaal@gmail.com>
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

The field list in struct recv_buf is initialized but not used.
Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 1 -
 drivers/staging/r8188eu/include/rtw_recv.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 6af72b3e7a7d..341605c67216 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -54,7 +54,6 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		INIT_LIST_HEAD(&precvbuf->list);
 		spin_lock_init(&precvbuf->recvbuf_lock);
 		precvbuf->alloc_sz = MAX_RECVBUF_SZ;
 		res = rtw_os_recvbuf_resource_alloc(padapter, precvbuf);
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index d2f1c71f2262..90482cdd2236 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -207,7 +207,6 @@ struct sta_recv_priv {
 };
 
 struct recv_buf {
-	struct list_head list;
 	spinlock_t recvbuf_lock;
 	u32	ref_cnt;
 	struct adapter *adapter;
-- 
2.35.1

