Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ABC4AEB34
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiBIHgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiBIHgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:36:23 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43665C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:36:27 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id y3so4824950ejf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 23:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3bEk3Ka9vuptIFAps3HWkZM4gzLyBfOMR/Q71qvDpw=;
        b=etrOHlXUrACkEBWxtFjoha0JTVlXmxF1mPXOFAzRQEZzhjqAi3TtbaUYAdUbCSjDEt
         tP8kenKI8c+IYdecNiGy3GgJvhlUQuqMYGjWrFXlH+s6OaWQHXjaEqpKCvwDusCCFrZH
         HERUuOlDsnmH4TKfScjb7PSSlyHh2f7fZDqbP5w3ySM+ORNNZXny/YhpuVnpj3PCVwpP
         yUt4AZrO7icJDaF1Ij9T7lDbzCR3IYzSYmahY8imINEfhK1achGkJaVkjI7+YffewXPR
         xu3KcEwtCX4Lv7Cz7/0sIzzAcwWLpMq+ShRAzdu0YnN6CY6hlzx9Tj/mHYtprh5bAJ1w
         lqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3bEk3Ka9vuptIFAps3HWkZM4gzLyBfOMR/Q71qvDpw=;
        b=izYVKV2LMksJ1PnDD+p3fOyPfz1suy/KDLV/N9AVCFAFyS8KLN6sjZobOtkI49la7d
         RuVpCGugTOfj1NxMTwqKrEKomLNMiiw+2w5Vl71/Fa/aQDM6KlzSllkJF5LSxqLexiiu
         Gpf/Ht2IL0tbpnXlKBpRU380LU1fwxBIvtg576hCkynJbN2e3DgBDpf1Op5IWbo7JQkP
         nlPdN5wAaLDVlepKNJ4sp/SI5wYWa55QVHQR7hUituLdu3YvLogkQqZsADek1m4Rl/IV
         wtm7AqqS6pCtUMoD6A10S4NfFUOPafkyDlYRe7IBA2/kpmerruqf9B5ccw6qLZ3abSge
         ewag==
X-Gm-Message-State: AOAM530Amtb993S3+ILc5To09PV5gVRUwRydrnZqiCRWCMIZvKSnlgsS
        9ZUXLKN/dPxGy8X3J2P2lZA=
X-Google-Smtp-Source: ABdhPJw4kZ1WgbXO2tRZgL4OmSgZOHwdah7cApDCpPd2V+FH98Gn8oOHnr1qDXTIl/Ju7JhsgMAjsQ==
X-Received: by 2002:a17:906:5d10:: with SMTP id g16mr798914ejt.642.1644392185877;
        Tue, 08 Feb 2022 23:36:25 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id y27sm3731813ejd.19.2022.02.08.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:36:25 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove unused enum
Date:   Wed,  9 Feb 2022 08:36:17 +0100
Message-Id: <20220209073618.29725-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209073618.29725-1-straube.linux@gmail.com>
References: <20220209073618.29725-1-straube.linux@gmail.com>
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

Remove an unused enum from rtl8188e_hal_init.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index b3ae358d1143..8fe74e21992e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -336,14 +336,6 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_frame *xmit
 	return ret;
 }
 
-/*  */
-/*			Efuse related code */
-/*  */
-enum{
-		VOLTAGE_V25						= 0x03,
-		LDOE25_SHIFT						= 28,
-	};
-
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState)
 {
 	u16	tmpV16;
-- 
2.35.1

