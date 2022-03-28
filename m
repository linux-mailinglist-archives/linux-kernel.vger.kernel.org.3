Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215804E95B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbiC1Lwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243217AbiC1Loi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:44:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9B83207D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x34so16532916ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BBT6nEYzLBNKJa5StA4l20Ep/xLb2s98P4A955hkWk=;
        b=ApcDM2P3ZXeAufbLvqkC/ab+Np12Rcl9lbLtcxNMC5ZN9KcP9ehRjKitH7G8DZRgdp
         qEtQuIRNuwmYu3PDKxRUC5uwV6Y5LxJ4PVjDJSKdJPF87PbvhCt107h5uFfZBhPW7MNp
         izHT+qeUM1anm8q1K7eh6TcoLy6bTgt0Lun6MVe12zLtDlv/apzS3GAjRTEaxvp4Iv6V
         6kG1rXCGj5+Ze4UqXjx6ke48NOXYDMg0Hl6CvrgefeQHsPKR8dbzQS7aX4NHKEvZVeXS
         K/tilVHSvVAYjHdPwmlCdwwAMsNwLoF0FwxCDdUfgot33q0n0MqfmyUwUAYE1mUz2VzJ
         RDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BBT6nEYzLBNKJa5StA4l20Ep/xLb2s98P4A955hkWk=;
        b=kSmIjwf/+JIQEKPuV7hR8HJqJrZI4PWGTLFBCIPDkjUIykX/X5GAXDA9e0gqRSyMWN
         /Ar4rJK9IBpbP93yh0+Dhf3GbiOVxrAivRoBgHlqwMrITfdThtskxK6F87pRNXpvHpo/
         6Ubqpvxrh0gy12+o3gOzFEpc66g2RkKI0L3gNN0bBBG84gIrhllEJjkoqvy7uYWpmtIq
         RF566BCNq13EHcTuyGoQlH9lpfYjQhHb5hwGbFakt+8FFNt09c27LAZA+INz3nSY0plm
         0SDiY/CZfeSA9JeKseq3eExsdJV1Y4HEWLqHvaRNIIdp6Z8K28GHlX0sQmlFZR+cUdUD
         QOUg==
X-Gm-Message-State: AOAM531omaSpiiEX2kAhz+29mfrDqVM9R3smMDEl5GSBURJI+Pa1HxXF
        bkggjyhJxnWvQR0k3H9UIIE=
X-Google-Smtp-Source: ABdhPJwio4iQdmg5hTn4ICgwa/6A6/OAfMwLhxhVHZl+K2bgUwFU+NuoMMKJPODt8fHEfwNqaY32pg==
X-Received: by 2002:a05:6402:5cd:b0:419:7753:acfb with SMTP id n13-20020a05640205cd00b004197753acfbmr15442329edx.131.1648467593052;
        Mon, 28 Mar 2022 04:39:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm5938556ejc.73.2022.03.28.04.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:39:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/9] staging: r8188eu: rename some macros to upper case
Date:   Mon, 28 Mar 2022 13:39:34 +0200
Message-Id: <20220328113940.6396-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328113940.6396-1-straube.linux@gmail.com>
References: <20220328113940.6396-1-straube.linux@gmail.com>
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
 drivers/staging/r8188eu/hal/usb_halinit.c       | 12 ++++++------
 drivers/staging/r8188eu/include/rtl8188e_spec.h | 10 +++-------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index cf1e4bbfd6a9..26a86b891aa1 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1152,19 +1152,19 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
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

