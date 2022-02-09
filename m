Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40564AF6E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiBIQhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbiBIQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:37:47 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABE3C05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:37:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id r19so5218191pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7SfWIYcMKFCx5mR3sW9x5b00I6aXavnSx2tCKm9abk=;
        b=nQKoxqasnjZrN00QaFeMliXHfvnZcy+tTEFc7C7RUnzM9Se5ggSjPr77OEFn1QeXad
         wKtutXnXHMQxNmQHOSdfYOT3dHRlseIvup5D7jMbxQZ3UuK28+AuvUOET57dgoLrp5qs
         gdiGoXlPg4YzaUmaM3seCzbJMnKQ7Sqy4aGdRp1Z/smh1HTVrlYH18nS8zIrnPfw+w6F
         s9Q4eDU977sVCszrOol9N5ge+ZYJrWR00vAIMkdqrIIEZ1MRGrRNcrnjJPElyXZ5h32v
         +Kuwxww0eb5pyXcu7uFzCPjpgup1wMpXPHTomX91ibbCuXMnKeBM7gP6Z0CjxT08UaVX
         er1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7SfWIYcMKFCx5mR3sW9x5b00I6aXavnSx2tCKm9abk=;
        b=ad/UCxPNjmN0jjo/kbXAmkANG46FgiAk7hjpd8QrnfDiVXmXEWE5FlrQQ2OpxMSppd
         9MZL/lzP2+jCVKyaHtdMBr10MycJaNfhipvr4tSDIHaeBQKUOpFgYI6m5ILMeWrKlJ+w
         WR0NjFvi095LP6+gpRleLUI06GHKIZMoMksWIFAa7wmgtHjkAE/VR6JcLOocLgt3/S55
         Z02OiyXgyIOuVRBW1JxgxaKQsdBoncu/zuixIOa5KQ3LS48fT61jJJ9hhDyNYMngmRUU
         NetTV1flk0Cha8s0xl1ObYVS3hvtIMSM4bfvZ4H9f581uxIV1Yj1pOmn/yDBexnFJ3h4
         LxAg==
X-Gm-Message-State: AOAM531uVEtgy45QVCNbcYB0QqMjmNidZ52uf2xmBAB/17GwW/UK+upr
        4VS549RRRVw0UhJHDrJI9rE=
X-Google-Smtp-Source: ABdhPJybq5FBQ8lAAs34GkEFcjdMxEWedEpVGe/LtAQ4W5ca34VdnBYoMROqz/BXp1m1e6piMlCftw==
X-Received: by 2002:a63:67c2:: with SMTP id b185mr2580013pgc.38.1644424670155;
        Wed, 09 Feb 2022 08:37:50 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id kb18sm7840199pjb.30.2022.02.09.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:37:49 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 7/9] staging: r8188eu: remove unused argument in on_action_public_default
Date:   Wed,  9 Feb 2022 22:06:05 +0530
Message-Id: <01c8fd82c21ae96773c9099a2cee3c3fd29c1054.1644422181.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644422181.git.abdun.nihaal@gmail.com>
References: <cover.1644422181.git.abdun.nihaal@gmail.com>
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

The function argument action is not used in on_action_public_default.
Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 7fabb5b11aac..27bfb43f306e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -4044,7 +4044,7 @@ static unsigned int on_action_public_vendor(struct recv_frame *precv_frame)
 	return ret;
 }
 
-static unsigned int on_action_public_default(struct recv_frame *precv_frame, u8 action)
+static unsigned int on_action_public_default(struct recv_frame *precv_frame)
 {
 	unsigned int ret = _FAIL;
 	u8 *pframe = precv_frame->rx_data;
@@ -4083,7 +4083,7 @@ unsigned int on_action_public(struct adapter *padapter, struct recv_frame *precv
 		ret = on_action_public_vendor(precv_frame);
 		break;
 	default:
-		ret = on_action_public_default(precv_frame, action);
+		ret = on_action_public_default(precv_frame);
 		break;
 	}
 
-- 
2.34.1

