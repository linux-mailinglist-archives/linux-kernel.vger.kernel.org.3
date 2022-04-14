Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A892A500B60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiDNKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242388AbiDNKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:46:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C476E07
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bh17so9215543ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVFAJRqd3IbNMgTMyXPpJtbL2G7uewgHBXHJSIvHW0o=;
        b=IQXu4G7VB/lBprrrqnvy0EFMgzp4m0fuumcZSfkzmo51m7RidJsYX1OUJKR+GrS5uf
         K7Du1GJqU2Ih2fGpbIglxzxwD7OFDD429qy1+tV3HK3a/lAzidWttUvytM9h+f+IplaB
         fI4gdZ1vSE8Um+/Fqu/Ev4rISOW0FPIW/84jd0N8RIlnhXOf7N4grx7SXk/g7dmPW62r
         jWfOWzYCHkQF1TNN/B2cYJNt3evtciPBcWkXqv+JyF7OGzT6CLy4Ozx8UFArACVEza6p
         xNXzp7NqQ/Op2ar0TSICEPe5suyvULHECcF199xJNAeKG0fOzmR2kP5oN3StQuYWhhAi
         i4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVFAJRqd3IbNMgTMyXPpJtbL2G7uewgHBXHJSIvHW0o=;
        b=mw6/Cw3gd1lYtxDTRI1MN1SJSPZYpPNFIwWxmUmbZOpyhMldXr14Jn85V8Q87oqRxn
         g2ip1HpG6mDuIzl1IqaPw+mofYO1PoiOcB418B6ezupSENEINSIMoRIM/J1uItJuX8Ne
         k0dbRuHCiflZlK4Nt8McHb0KN0LdNzHQdrdYea7llg6TXsDsmgsuwKK74zyrta4cRrAb
         dDLVQIFI3mgl7EBaH3oDYHy6PCBKVsiSx75wufpbihtdiLno8GiN5Fy7z2xBFbRQy39A
         ArE0icUCKoKtfxjQ+pnHD3jGveBp1rLcpLtHOsaMVWN04xagGvqd9RAv8KrWjc/kn8Zb
         vDUQ==
X-Gm-Message-State: AOAM531Z9mQ1chZCxSexcQ+67ZhNa3zvWHpEfZz0c9by3zmAY4zNJDQK
        KxmC38QfFD2P8ezm4Be/LvE=
X-Google-Smtp-Source: ABdhPJzgdAz9F9MyKUwu5c/4hKYUqDjZghCnkVZvfpNjUV/JtPkaVUFpEG2Y2gLqeK3Cg1DbS8kcgg==
X-Received: by 2002:a17:907:2daa:b0:6da:924e:955 with SMTP id gt42-20020a1709072daa00b006da924e0955mr1755904ejc.1.1649933029113;
        Thu, 14 Apr 2022 03:43:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm821318edt.34.2022.04.14.03.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:43:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/8] staging: r8188eu: rename fields of struct rt_firmware_hdr
Date:   Thu, 14 Apr 2022 12:43:18 +0200
Message-Id: <20220414104323.6152-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414104323.6152-1-straube.linux@gmail.com>
References: <20220414104323.6152-1-straube.linux@gmail.com>
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
 drivers/staging/r8188eu/core/rtw_fw.c | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 323e0c634c4e..3da52a1ba23c 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -9,29 +9,29 @@
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
-	__le16		Signature;
-	u8		Category;
-	u8		Function;
-	__le16		Version;
-	u8		Subversion;
-	u8		Rsvd1;
-	u8		Month;
-	u8		Date;
-	u8		Hour;
-	u8		Minute;
-	__le16		RamCodeSize;
-	u8		Foundry;
-	u8		Rsvd2;
-	__le32		SvnIdx;
-	__le32		Rsvd3;
-	__le32		Rsvd4;
-	__le32		Rsvd5;
+	__le16	signature;
+	u8	category;
+	u8	function;
+	__le16	version;
+	u8	subversion;
+	u8	rsvd1;
+	u8	month;
+	u8	date;
+	u8	hour;
+	u8	minute;
+	__le16	ramcodesize;
+	u8	foundry;
+	u8	rsvd2;
+	__le32	svnidx;
+	__le32	rsvd3;
+	__le32	rsvd4;
+	__le32	rsvd5;
 };
 
 static void fw_download_enable(struct adapter *padapter, bool enable)
@@ -254,9 +254,9 @@ int rtl8188e_firmware_download(struct adapter *padapter)
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

