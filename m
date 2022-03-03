Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00184CC1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiCCPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiCCPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:53:57 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD71F532D8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:53:11 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id d19so6293862ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=At9rhZ9bP/5wc2tfjZxF99ePrD8o4MbbQ/4vArkM+1I=;
        b=e9uqh6T4ArQ+bzZlwa2ohBxHuuRe71nusE323J/YWoHDuCADM/aHAkh0xEJLkrek8C
         PSkf9YX7uVWg5ZnQj0lJ2z+R9nqJnVUzsjwgGlgZSzpV12I1W9Plf2EU+cDf5E80eij0
         ZshFrT4+rmtczn4i4Z6WztivKv0uxUUujaafodB4zRNkSgnEIJ12xZqAhnk/+rNniq/k
         wGvriWwtJLkNWYNZ46WSz4e5sChIGX0Sau3DmpujSHqiLuMRJJlby8lZ6LDpsa8Pa987
         dYe5iwnDy8JsFh6zQBQ14Vr9HrRzFkmL0xJwMUwm0tS5yTDfaag+bL/BGi8fU48rOCO2
         o8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=At9rhZ9bP/5wc2tfjZxF99ePrD8o4MbbQ/4vArkM+1I=;
        b=ju6TplP9fHb40ZiZOeY0pTrwpPRpFltMFwq68ncG1AKQbE0DhiRx87gGMNL/mfp9y4
         0ziaizoiazK563C5wAIK8g1sYyh+dud1ISVQej1BHBe2KnskfckzY6c7X78c7Da9Hpsh
         djLwRNMKK1g7gTmXxz1UF362PWMHXhiS+s7Gn/TdLpZAqjx9feheCRqVVqMOp6vY763t
         YJIiiznApoJ5/yT7KkKCMMgdz5y6mCZPDjY/rmrBUpaDz54YjhWtnGUda85yiS/uje4T
         LcD5Uyy9uy04q7xz1CNmZ5pS41IjvhU/Dc1wKJ81jb2Qd8EpO2qkdAJCCsxXMZV8YNPT
         PpAA==
X-Gm-Message-State: AOAM533y5zxm1CjQavn/xgj4Z2NwdLTntwQbaixXExvUrEYy6gHRs172
        1eJBl5ycSSHNuXwhvJwooT4=
X-Google-Smtp-Source: ABdhPJzfbvK5rst7gmndvthlXCWaSCB8X5msFLQbemjDSPvsB3BX2zo087oUvLQdubAebPVmaJythg==
X-Received: by 2002:a02:3f13:0:b0:314:4a83:ac2c with SMTP id d19-20020a023f13000000b003144a83ac2cmr30604613jaa.3.1646322790603;
        Thu, 03 Mar 2022 07:53:10 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id a6-20020a92d346000000b002c1a6040691sm2506599ilh.70.2022.03.03.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:53:10 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, paskripkin@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] staging: r8188eu: remove unused field recvbuf_lock
Date:   Thu,  3 Mar 2022 21:21:04 +0530
Message-Id: <24597a0cc19fa59139bf0a77ccd11a8229d7201f.1646321515.git.abdun.nihaal@gmail.com>
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

The spinlock field recvbuf_lock in struct recv_buf is initialized but
not used. Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 1 -
 drivers/staging/r8188eu/include/rtw_recv.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 341605c67216..19d22db56e7d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -54,7 +54,6 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		spin_lock_init(&precvbuf->recvbuf_lock);
 		precvbuf->alloc_sz = MAX_RECVBUF_SZ;
 		res = rtw_os_recvbuf_resource_alloc(padapter, precvbuf);
 		if (res == _FAIL)
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 90482cdd2236..7347ec162632 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -207,7 +207,6 @@ struct sta_recv_priv {
 };
 
 struct recv_buf {
-	spinlock_t recvbuf_lock;
 	u32	ref_cnt;
 	struct adapter *adapter;
 	u8	*pbuf;
-- 
2.35.1

