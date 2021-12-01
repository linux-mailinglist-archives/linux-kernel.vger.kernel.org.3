Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4204651BE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351010AbhLAPfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350252AbhLAPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:35:45 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C172C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:32:24 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 71so23991967pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrT+feO4jnWB4qX0RGpa/8Soov2WZ3IzNfAVkfbdgTI=;
        b=ma7EZbMwQXE247j/JhwHgzIWPyKJ5oPomd1r/MLnckKAUijBHl1U47v3UuecutrHMt
         W0nwyvF/bJ6a4EFgA5UPV46nwRCdpjGp9tGL6AxZ7ZkxyqRzu57/Aye0GpbR1LfzUr1S
         HHQr8ztVmTDrmA1fzNl//7Wc0YUDgKYU8kwKqN3H2Aj7DqqupLcUXCAH2ijFQ8FzRsmE
         ERSy7WA43Y+FjEVWvA7IuuWtY+mSE7MoXmZnPB9SL4+dYvvli0WWzBkwUWLNfmoVyKiR
         nyHuae0zz+fEGjvM7pqdM3zHSMSfltjq9i42beCRbfP+BFaPM+OZEd5J1kCgutpy0LS/
         znSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrT+feO4jnWB4qX0RGpa/8Soov2WZ3IzNfAVkfbdgTI=;
        b=8QtVp+LMiViYGscYRCHYOGbiDe+gO1vFMJeCaegqudPeA8fnMyKx02OescGapoHVxd
         wdggRgPuQAQMms+mi8IKJhnuDz7a1UWW4C5Fqy3ZjZuCvKfvsYuUQlaaFMr90HLuSi7P
         KFB+QzmoL/E5K+98gHD0WMTzf2PxhQR9AFiLDgu0xyB7cNT8KE8YgddMzqsNuJ2yeChi
         +MxpOTlZB4VwXrOjVpBv2nYKujghyIrozDYbB5aQILoNlL0LBwec5Edw4HfQkwy0KqYJ
         QtaFYBl5IYEszo63AZviyh+LR0AFG2NxXRB5JPh17/agtOQIBJ9zzvs25TOWfjYy7mhd
         U+RQ==
X-Gm-Message-State: AOAM530YJ6SN4gICm0Ob8DTYSjWiKcM9q1zWH4V3gE4wYMVxHlAANThU
        uD8SA96qjgN4UspdsZzkd84=
X-Google-Smtp-Source: ABdhPJw8c9dtJdcGzrZVMkPW265/TG0sEQX8PPXRYeFZXXK7s3uwXJjnPIV+4kEqAzn6KFTBpRQnUA==
X-Received: by 2002:a62:7a54:0:b0:494:6e78:994b with SMTP id v81-20020a627a54000000b004946e78994bmr6745750pfc.5.1638372744031;
        Wed, 01 Dec 2021 07:32:24 -0800 (PST)
Received: from nlap2.localdomain ([106.198.84.234])
        by smtp.googlemail.com with ESMTPSA id 7sm91772pgk.55.2021.12.01.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 07:32:23 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH] staging: r8188eu: Fix coding style error
Date:   Wed,  1 Dec 2021 21:00:39 +0530
Message-Id: <20211201153039.305245-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move opening brace to next line to conform to kernel coding style.

Fixes the following checkpatch error:
ERROR: open brace '{' following function definitions go on the next line

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index b4820ad2cee7..627ecd45beca 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -252,7 +252,8 @@ static void init_mlme_ext_priv_value(struct adapter *padapter)
 
 static int has_channel(struct rt_channel_info *channel_set,
 					   u8 chanset_size,
-					   u8 chan) {
+					   u8 chan)
+{
 	int i;
 
 	for (i = 0; i < chanset_size; i++) {
@@ -264,7 +265,8 @@ static int has_channel(struct rt_channel_info *channel_set,
 
 static void init_channel_list(struct adapter *padapter, struct rt_channel_info *channel_set,
 							  u8 chanset_size,
-							  struct p2p_channels *channel_list) {
+							  struct p2p_channels *channel_list)
+{
 	struct p2p_oper_class_map op_class[] = {
 		{ IEEE80211G,  81,   1,  13,  1, BW20 },
 		{ IEEE80211G,  82,  14,  14,  1, BW20 },
-- 
2.33.1

