Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCA4EB4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiC2UXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiC2UXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A6012221F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c62so22005691edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXzC7B+G1Vq7z1Rm7bBrok4K1ZSPCYyPSAJ9Zp074Sw=;
        b=q3vf2bCmZ1ZNNDsHVj7VTUOZLT75ckZ+jzRTjxI79ZK+r+8N7HyjTOv8g1xVew7qrp
         yv3aQOyyx4HhhSbJsA4UnbTAVgeeQxw8zQMKDSy3h4ZNu2XJhoPnpfuh/fbxd43IUFGT
         Y/3Rbf6KrXPtt18ROsuEXWlwIqbeiQWg8hxICPLyKUS0Cfk5YC8Y8rWk52nTgOqnw5HR
         smIsJNAVpgssK5M1Q0nQeM9U/f5+ZoiQBSesQW767NVM11xiMbxKv5s7KBG2WzQvZKb3
         tJGl2/f7dI/hLUEgK4mnvAdwJkUk089iZpPFeskba3V0FxPDNxOhSOOZoW1Qe8kF5NSL
         DswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXzC7B+G1Vq7z1Rm7bBrok4K1ZSPCYyPSAJ9Zp074Sw=;
        b=IHbOPfc6wB1kU1xypiQEvtKTgWuG2+rV5PU9yt0KV/cn+pHOmiPzAthJxkeON4HAdt
         HIGm3H8kpmIyzAJkMKoFZLVcnEortL3m7zJF89U0AvomLtlqEk+wpLGqN9+VqlDtUR2t
         rkFYgA4JYuBzwTpYUNn6fI4kYy9j705ClqcMgIN0oO95r0ZsmZ5dIf2X/wsRfaOD4i0G
         08w8+aXqvXRkrSQNdSQ5a93TmFJPmdWMd/YMl4Xb0hYp689hn8Gx78x4QSXC1nRD8OR9
         9PZcEJUA4kuRL4l/M4lovlzdzvXlH9PAYz9Jy6trmDs3bjpymMi3Q1pmVsGCzmOt1XMC
         kk5A==
X-Gm-Message-State: AOAM532eGMMBaFEBLoHHMTATbaEpX445QVLryIGgsplrztzI+niR+NKr
        ZXj6w6E1/PI+lxK7ktt01jk=
X-Google-Smtp-Source: ABdhPJwjjdL5AxQOccoKR3owW99Y8879dAR8FYcnUW7XGN1zAHBGFL2zRoplCkFqRzGWCsFRR+nvxw==
X-Received: by 2002:a05:6402:3689:b0:419:d380:ddbc with SMTP id ej9-20020a056402368900b00419d380ddbcmr6819875edb.230.1648585311330;
        Tue, 29 Mar 2022 13:21:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id ss12-20020a170907038c00b006e0ec9e806dsm3938111ejb.136.2022.03.29.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:21:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/8] staging: r8188eu: rename some macros to upper case
Date:   Tue, 29 Mar 2022 22:21:36 +0200
Message-Id: <20220329202141.7028-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329202141.7028-1-straube.linux@gmail.com>
References: <20220329202141.7028-1-straube.linux@gmail.com>
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

Rename some macros to upper case to avoid camel case and improve
readability. While at it, remove some unused macros.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 drivers/staging/r8188eu/hal/usb_halinit.c       | 12 ++++++------
 drivers/staging/r8188eu/include/rtl8188e_spec.h | 10 +++-------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 8e4b84f51a3c..8dc90f9636b5 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1148,19 +1148,19 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				AcmCtrl = AcmCtrl | 0x1;
 
 			if (acm_ctrl & BIT(3))
-				AcmCtrl |= AcmHw_VoqEn;
+				AcmCtrl |= ACMHW_VOQEN;
 			else
-				AcmCtrl &= (~AcmHw_VoqEn);
+				AcmCtrl &= (~ACMHW_VOQEN);
 
 			if (acm_ctrl & BIT(2))
-				AcmCtrl |= AcmHw_ViqEn;
+				AcmCtrl |= ACMHW_VIQEN;
 			else
-				AcmCtrl &= (~AcmHw_ViqEn);
+				AcmCtrl &= (~ACMHW_VIQEN);
 
 			if (acm_ctrl & BIT(1))
-				AcmCtrl |= AcmHw_BeqEn;
+				AcmCtrl |= ACMHW_BEQEN;
 			else
-				AcmCtrl &= (~AcmHw_BeqEn);
+				AcmCtrl &= (~ACMHW_BEQEN);
 
 			rtw_write8(Adapter, REG_ACMHWCTRL, AcmCtrl);
 		}
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index edae053e350e..ef42c4b2f20c 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -998,13 +998,9 @@ Current IOREG MAP
 #define STOP_BCNQ		BIT(6)
 
 /* 2 ACMHWCTRL */
-#define	AcmHw_HwEn		BIT(0)
-#define	AcmHw_BeqEn		BIT(1)
-#define	AcmHw_ViqEn		BIT(2)
-#define	AcmHw_VoqEn		BIT(3)
-#define	AcmHw_BeqStatus		BIT(4)
-#define	AcmHw_ViqStatus		BIT(5)
-#define	AcmHw_VoqStatus		BIT(6)
+#define ACMHW_BEQEN		BIT(1)
+#define ACMHW_VIQEN		BIT(2)
+#define ACMHW_VOQEN		BIT(3)
 
 /* 	0x0600h ~ 0x07FFh	WMAC Configuration */
 /* 2APSD_CTRL */
-- 
2.35.1

