Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60661482B5B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiABNMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiABNL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:11:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1911C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:11:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso17068873wmk.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eU+Qesw8IpwjYFtIpr41tQi/97DSTP46RqXidzHcV88=;
        b=ekjsSS7NQCeZLJ2xPs+LebADC6e65J3pZXMZnNLsHdd7EVWfeNkokhXrEkDzAQyY4R
         z+x1KOTKYMWOzgYaaoJs29N2KSRUD9bfuabK8DKDBD/e+SU4fqBZKcdjjgL97Vs8Gg9o
         nTPpiR3JjMCr/FFNUyppLSib2qWhkpe8jl5CvAFiU3LKAYB0rETsmD82HxIGB2AUnAj0
         prWSEMywNEJXbQptRZVBRx81u/T+wPxbR8LcwRrEiu/d6X/8fjil4vzJQ7P4HPu1Hiba
         ysEfQRg+wHqP0CZIK319Ns7MzHGhEVTA7etL+iItih+O0C9Ksx0P348YdQnC+xrkV5gL
         0mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eU+Qesw8IpwjYFtIpr41tQi/97DSTP46RqXidzHcV88=;
        b=qkXeSfakPoXsPdiD10TcU7fP3jKMVwHsa3n5+boZ8EZk8i4owjZDXZfi5SIDrnzajf
         8U8yc6kojaIADs5/tswt8vCjJuUmZKLprXRSbj8+OeRnGpPeoSE+9TmhzKCiBKnh16Ca
         boD2oOORrnmAbHStySx/Lh0ZnES7qQmL0iEQ9lbxzs727Toi2mtdw9TGZSllEmggD7Fi
         lqowjDAq/wVpnNgc+JohvGeWQ3UcItqnr5ajgnRPEbRmu2dbtPQFr5IEVbEE8YAAs4r+
         vmeB9Z9g4isU91n5SsqfWQCPgamnmQ2wkUKtuTB4hTpvIIkzJ91mt4BuGI5/2NT/3LBm
         rokw==
X-Gm-Message-State: AOAM531j7KUTqcfrr2t78zW9+5Fz7NoD2UpNB2sEajH7pBjGdH2ElOji
        XOfUMHlfjOoWZ6q4kUuLMjs=
X-Google-Smtp-Source: ABdhPJxawAh2BsSmgRP2n2U6iDlRylBwUPXQ3DCl4oB6JBA4vmWtNuzZtaWx8WRn+VEuu/mKlOe/Sg==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr24026975wmj.168.1641129115938;
        Sun, 02 Jan 2022 05:11:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:11:55 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/11] staging: r8188eu: remove unused enum and defines
Date:   Sun,  2 Jan 2022 14:11:33 +0100
Message-Id: <20220102131141.12310-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102131141.12310-1-straube.linux@gmail.com>
References: <20220102131141.12310-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused enum rf90_radio_path and some unused defines.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_eeprom.h |  5 -----
 drivers/staging/r8188eu/include/rtw_rf.h     | 19 -------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index e517239bd75e..22c2eddd5e75 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -21,11 +21,6 @@
 #define EEPROM_EWEN_OPCODE		19      /*  Erase/write enable */
 #define EEPROM_EWDS_OPCODE		16      /*  Erase/write disable */
 
-/* Country codes */
-#define USA				0x555320
-#define EUROPE				0x1 /* temp, should be provided later */
-#define JAPAN				0x2 /* temp, should be provided later */
-
 #define	EEPROM_CID_DEFAULT		0x0
 #define	EEPROM_CID_ALPHA		0x1
 #define	EEPROM_CID_Senao		0x3
diff --git a/drivers/staging/r8188eu/include/rtw_rf.h b/drivers/staging/r8188eu/include/rtw_rf.h
index 2308a00b5dec..b7267e75346c 100644
--- a/drivers/staging/r8188eu/include/rtw_rf.h
+++ b/drivers/staging/r8188eu/include/rtw_rf.h
@@ -6,28 +6,16 @@
 
 #include "rtw_cmd.h"
 
-#define OFDM_PHY		1
-#define MIXED_PHY		2
-#define CCK_PHY		3
-
 #define NumRates	(13)
 
 /*  slot time for 11g */
 #define SHORT_SLOT_TIME			9
 #define NON_SHORT_SLOT_TIME		20
 
-#define RTL8711_RF_MAX_SENS		6
-#define RTL8711_RF_DEF_SENS		4
-
 #define	MAX_CHANNEL_NUM			14	/* 2.4 GHz only */
 
 #define NUM_REGULATORYS	1
 
-/* Country codes */
-#define USA				0x555320
-#define EUROPE				0x1 /* temp, should be provided later */
-#define JAPAN				0x2 /* temp, should be provided later */
-
 struct	regulatory_class {
 	u32	starting_freq;				/* MHz, */
 	u8	channel_set[MAX_CHANNEL_NUM];
@@ -64,13 +52,6 @@ enum	_REG_PREAMBLE_MODE {
 	PREAMBLE_SHORT	= 3,
 };
 
-enum rf90_radio_path {
-	RF90_PATH_A = 0,		/* Radio Path A */
-	RF90_PATH_B = 1,		/* Radio Path B */
-	RF90_PATH_C = 2,		/* Radio Path C */
-	RF90_PATH_D = 3			/* Radio Path D */
-};
-
 /*  Bandwidth Offset */
 #define HAL_PRIME_CHNL_OFFSET_DONT_CARE	0
 #define HAL_PRIME_CHNL_OFFSET_LOWER	1
-- 
2.34.1

