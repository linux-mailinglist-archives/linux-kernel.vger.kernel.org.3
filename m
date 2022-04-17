Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7645048B0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiDQR5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiDQR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:57:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2486C1115
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g18so23490410ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkM9doiA/i7FmCkoWkaNp3fDJvZEfu53FAG4JMLkpr4=;
        b=RtG8TW745DqgPExo3dLdT274i4DPwhvzS6YADILJsm7uTpZLHqKUoKfyCBArXBD9Tk
         ZTM/U4QTwmQa6Fw+KTYKGLB8uEC41qoS4ZmY8mKXmmOGDO9Zw/s+z2RVAmI7QtVCwTiA
         Ra5O+ASfyv10lkvKOEMtoT5mj4TuSi0mfX3vOdnco50gf6bhQpGKoFZjIQZQ+RFE5LtX
         1YpYMM/r8JPNiCrRhvDv2GGtQwHCDM1XbhJ+bHrlPLqgrb4+GA/MrWG9wHJ8r8X6k/Vt
         TgkjNPf7deXW1c49vxFXbcETDdz3Zu+p9vXZmqakrJNFd6iiUciyU5McCiNsdWgNixNt
         KCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkM9doiA/i7FmCkoWkaNp3fDJvZEfu53FAG4JMLkpr4=;
        b=NTbILxIfHDafLu6ZMnYuNw6xi9mx8YMVIev9ygIOqJenlmHrON3KN5daoi0tPPiE5/
         574pTQ/XOHoSfAORHFe4oCX7NbHAEf/oglfE4UFW50lAoRpZVCk//8iFwMZWrZyVU03j
         7v/mXcueUVYYVDq9iMNpqdtwhiWgRvoc57xcvJNcaIMF1ZDBb7ELI0Iz6YjXydB5Bk6V
         W4jgjWxzegIJRVegc3wnrG5p43DUqFL/p0cUipcMINEhnGeaN908Tl9ITA8hjmdor94d
         DsMbtLSaTf0QkDSzCBOMmP0KJ6GQP0OZoAZJV6SWFLTCKAiDcQBj1uCYjPr67mkjXXXs
         sq/g==
X-Gm-Message-State: AOAM530jN7uyJO1dObAaQLYPj4F4tv8SlY/dvu8858ccFnIWOraGt/hB
        7qy9yz6s6CELtwDp36/tzlM=
X-Google-Smtp-Source: ABdhPJzB8V3WpMAzb62sj1vfrrDR4r0Prc0w9mfdMeUWGpI6008RYHpAgn1+pXQoM3Fu0fdY3kEl0w==
X-Received: by 2002:a17:906:3c10:b0:6e8:9e25:5156 with SMTP id h16-20020a1709063c1000b006e89e255156mr6473926ejg.703.1650218090694;
        Sun, 17 Apr 2022 10:54:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm3719409ejc.150.2022.04.17.10.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:54:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 4/8] staging: r8188eu: rename fields of struct rt_firmware_hdr
Date:   Sun, 17 Apr 2022 19:54:37 +0200
Message-Id: <20220417175441.13830-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417175441.13830-1-straube.linux@gmail.com>
References: <20220417175441.13830-1-straube.linux@gmail.com>
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

Rename the fields of struct rt_firmware_hdr to avoid camel case.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v4:
- no changes

v3:
- no changes

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 58 +++++++++++++--------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 0fa27b36bb8e..a80cc7fa3a53 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -9,34 +9,34 @@
 #define MAX_PAGE_SIZE		4096
 
 #define IS_FW_HEADER_EXIST(_fwhdr)				\
-	((le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x92C0 ||	\
-	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88C0 ||	\
-	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
-	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
+	((le16_to_cpu(_fwhdr->signature) & 0xFFF0) == 0x92C0 ||	\
+	(le16_to_cpu(_fwhdr->signature) & 0xFFF0) == 0x88C0 ||	\
+	(le16_to_cpu(_fwhdr->signature) & 0xFFF0) == 0x2300 ||	\
+	(le16_to_cpu(_fwhdr->signature) & 0xFFF0) == 0x88E0)
 
 struct rt_firmware_hdr {
-	__le16		Signature;	/* 92C0: test chip; 92C,
-					 * 88C0: test chip; 88C1: MP A-cut;
-					 * 92C1: MP A-cut */
-	u8		Category;	/* AP/NIC and USB/PCI */
-	u8		Function;	/* Reserved for different FW function
-					 * indcation, for further use when
-					 * driver needs to download different
-					 * FW for different conditions */
-	__le16		Version;	/* FW Version */
-	u8		Subversion;	/* FW Subversion, default 0x00 */
-	u8		Rsvd1;
-	u8		Month;		/* Release time Month field */
-	u8		Date;		/* Release time Date field */
-	u8		Hour;		/* Release time Hour field */
-	u8		Minute;		/* Release time Minute field */
-	__le16		RamCodeSize;	/* The size of RAM code */
-	u8		Foundry;
-	u8		Rsvd2;
-	__le32		SvnIdx;		/* The SVN entry index */
-	__le32		Rsvd3;
-	__le32		Rsvd4;
-	__le32		Rsvd5;
+	__le16	signature;	/* 92C0: test chip; 92C,
+				 * 88C0: test chip; 88C1: MP A-cut;
+				 * 92C1: MP A-cut */
+	u8	category;	/* AP/NIC and USB/PCI */
+	u8	function;	/* Reserved for different FW function
+				 * indcation, for further use when
+				 * driver needs to download different
+				 * FW for different conditions */
+	__le16	version;	/* FW Version */
+	u8	subversion;	/* FW Subversion, default 0x00 */
+	u8	rsvd1;
+	u8	month;		/* Release time Month field */
+	u8	date;		/* Release time Date field */
+	u8	hour;		/* Release time Hour field */
+	u8	minute;		/* Release time Minute field */
+	__le16	ramcodesize;	/* The size of RAM code */
+	u8	foundry;
+	u8	rsvd2;
+	__le32	svnidx;		/* The SVN entry index */
+	__le32	rsvd3;
+	__le32	rsvd4;
+	__le32	rsvd5;
 };
 
 static void fw_download_enable(struct adapter *padapter, bool enable)
@@ -259,9 +259,9 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	/*  To Check Fw header. Added by tynli. 2009.12.04. */
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
-	fw_version = le16_to_cpu(fwhdr->Version);
-	fw_subversion = fwhdr->Subversion;
-	fw_signature = le16_to_cpu(fwhdr->Signature);
+	fw_version = le16_to_cpu(fwhdr->version);
+	fw_subversion = fwhdr->subversion;
+	fw_signature = le16_to_cpu(fwhdr->signature);
 
 	if (!log_version++)
 		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-- 
2.35.1

