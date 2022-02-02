Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47B4A6C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbiBBHvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbiBBHvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:51:00 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709FC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 23:50:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ah7so62370143ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 23:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CgyjgB4L9zvBx61NtaEHH+XoDxcJaqF6DRtq7Ip9h4Q=;
        b=R75EEj2nxwyPKSloD7O5XcU7ZaZHe35FB3tehqwhB5A+eaqfCZckFSjV+9m3n16BcL
         u/A43WBUpnTPj7L0bgZp8Mtxw6Q+y4dM8x42AQFqEcde6jYZ+PH9qmMElxZHDLz0ckAX
         93k+HyUvNpRe1Pg3lMhYWDv1wUbZ0Oz3gdxbSiuvMBj9mqyCfvGo1bf8XQkHBSCPsaqF
         cqrtTBDCHOuNztM1GwTKhJ1ub7W0rWtbe5JxBNM62CZV8of3nkHLExY7qUBdC2N2hI38
         MNLPNPeVvhSN833RaeSkYpHgATxLfEbVKM103TQnrwSil+/lfjkboTueKkyNhxOiHJSg
         ZRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CgyjgB4L9zvBx61NtaEHH+XoDxcJaqF6DRtq7Ip9h4Q=;
        b=X9NiXcSPM1hXKDRRv/w9Lw0kGhU1sVOalBgJshTCOFWO4BrPMTlvPR12ISa2iuD6Eb
         ctukr+qJi/0/zlUZXvW5n0A5pupQe9Kjp9s/Afr3ewKqyTf/Iqz+4EukxMU7l0eGW81t
         IXNHFjHlIE2i3A90wvR0YM7+lzGFtg0J7IRK0gtaN8DpvPY7+9mjfgIfrJKkmgnnkd/a
         8soYq0OJz9jMWfzg0SgFbQvj/IpjkqcUx4mK4jdO5vr+t7+xNc+FhQL9T1wetshR+Mfj
         9nVb3RKoh7ULA/Sdu3Mi4DFaEzaHtgR3A6GHwtPohxFfmUApfzCnTolxfyFxKBi1Zpey
         0V/g==
X-Gm-Message-State: AOAM530SoRgS5uDLZShU7JoyzxZ+r35CXV6gPaYdBrmeS81+B9DfpyNd
        DCBO5wchsmxP3gXXNicOyXcyWZK9cJQ=
X-Google-Smtp-Source: ABdhPJwqijHBykICxgf1RRVXDD4VV+z5w9QEVP6th+gogLNBO6C9aIT/cmLUU5Y90GlrPUQB4lL/8A==
X-Received: by 2002:a17:907:2d11:: with SMTP id gs17mr24662788ejc.189.1643788258331;
        Tue, 01 Feb 2022 23:50:58 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id w6sm6694673edd.50.2022.02.01.23.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:50:58 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: move struct rt_firmware_hdr to rtw_fw.h
Date:   Wed,  2 Feb 2022 08:50:51 +0100
Message-Id: <20220202075051.21266-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure rt_firmware_hdr is firmware related. Move it to the
rtw_fw.h header.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/rtl8188e_hal.h    | 35 -------------------
 drivers/staging/r8188eu/include/rtw_fw.h      | 35 +++++++++++++++++++
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index e3c028ff20c7..c323476f5936 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -34,41 +34,6 @@
 #define DRVINFO_SZ	4 /*  unit is 8bytes */
 #define PageNum_128(_Len)	(u32)(((_Len)>>7) + ((_Len) & 0x7F ? 1 : 0))
 
-/*  This structure must be careful with byte-ordering */
-
-struct rt_firmware_hdr {
-	/*  8-byte alinment required */
-	/*  LONG WORD 0 ---- */
-	__le16		Signature;	/* 92C0: test chip; 92C,
-					 * 88C0: test chip; 88C1: MP A-cut;
-					 * 92C1: MP A-cut */
-	u8		Category;	/*  AP/NIC and USB/PCI */
-	u8		Function;	/*  Reserved for different FW function
-					 *  indcation, for further use when
-					 *  driver needs to download different
-					 *  FW for different conditions */
-	__le16		Version;	/*  FW Version */
-	u8		Subversion;	/*  FW Subversion, default 0x00 */
-	u16		Rsvd1;
-
-	/*  LONG WORD 1 ---- */
-	u8		Month;	/*  Release time Month field */
-	u8		Date;	/*  Release time Date field */
-	u8		Hour;	/*  Release time Hour field */
-	u8		Minute;	/*  Release time Minute field */
-	__le16		RamCodeSize;	/*  The size of RAM code */
-	u8		Foundry;
-	u8		Rsvd2;
-
-	/*  LONG WORD 2 ---- */
-	__le32		SvnIdx;	/*  The SVN entry index */
-	u32		Rsvd3;
-
-	/*  LONG WORD 3 ---- */
-	u32		Rsvd4;
-	u32		Rsvd5;
-};
-
 #define DRIVER_EARLY_INT_TIME		0x05
 #define BCN_DMA_ATIME_INT_TIME		0x02
 
diff --git a/drivers/staging/r8188eu/include/rtw_fw.h b/drivers/staging/r8188eu/include/rtw_fw.h
index 9b7492ef0199..2ee9ae70a468 100644
--- a/drivers/staging/r8188eu/include/rtw_fw.h
+++ b/drivers/staging/r8188eu/include/rtw_fw.h
@@ -16,6 +16,41 @@
 	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
 	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
 
+/*  This structure must be careful with byte-ordering */
+
+struct rt_firmware_hdr {
+	/*  8-byte alinment required */
+	/*  LONG WORD 0 ---- */
+	__le16		Signature;	/* 92C0: test chip; 92C,
+					 * 88C0: test chip; 88C1: MP A-cut;
+					 * 92C1: MP A-cut */
+	u8		Category;	/*  AP/NIC and USB/PCI */
+	u8		Function;	/*  Reserved for different FW function
+					 *  indcation, for further use when
+					 *  driver needs to download different
+					 *  FW for different conditions */
+	__le16		Version;	/*  FW Version */
+	u8		Subversion;	/*  FW Subversion, default 0x00 */
+	u16		Rsvd1;
+
+	/*  LONG WORD 1 ---- */
+	u8		Month;	/*  Release time Month field */
+	u8		Date;	/*  Release time Date field */
+	u8		Hour;	/*  Release time Hour field */
+	u8		Minute;	/*  Release time Minute field */
+	__le16		RamCodeSize;	/*  The size of RAM code */
+	u8		Foundry;
+	u8		Rsvd2;
+
+	/*  LONG WORD 2 ---- */
+	__le32		SvnIdx;	/*  The SVN entry index */
+	u32		Rsvd3;
+
+	/*  LONG WORD 3 ---- */
+	u32		Rsvd4;
+	u32		Rsvd5;
+};
+
 int rtl8188e_firmware_download(struct adapter *padapter);
 void rtw_reset_8051(struct adapter *padapter);
 
-- 
2.34.1

