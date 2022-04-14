Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7106150088A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiDNIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240991AbiDNIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:41:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA7764BDE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lc2so8617380ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVFAJRqd3IbNMgTMyXPpJtbL2G7uewgHBXHJSIvHW0o=;
        b=VE8YjlWUKgkchXEYuJVz5rbZ07MGhtaOwGwA7HmAK6bA4qU3xj3YGDjn5/smmYiB8k
         Ww6zgK7ju9y67TXHRHkeP4WmDgrVXT6+wOGLMkxecOTp67SPIRE912TGf+houWsc5UUs
         WSLE4Imqjecg+cA/1ijEc4pcjlnZ6kTeRtBRbb0Oi3NxQntbt4y8CkQysj5KfGq+9C6K
         u5IHgpOIO+rheL/+MLVVbLJtxcrpoCUS+18MPYbJ4tuQzCqfty/3sJqC1G8BNBeLYTVr
         kJf6tAgwYi6gmr2ZU1R5bRbYfPsdQ0RwCMhdIyn8vUlzNqyhv6x/0v0o0upbB/dJtUd0
         0nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVFAJRqd3IbNMgTMyXPpJtbL2G7uewgHBXHJSIvHW0o=;
        b=KA2mLMq8p5mXIAejzYy2kB1sqKiH/PFnjACuX/YhlZe9N2k3tqM3PpCY9d+RfXxZgq
         owCuHkAoKAtnIkcWWQl2S/Lm8lvana2jnwRiLalnPALHIfqLYWxQXx/bw7g10yh8U+3z
         synY90Ci48MSe4SPlgK0WxtTbG31GI5xx0H7CG0Krsr/Yo0rbK08We80e2PlOtfcElm2
         NJCwUOag8V4IwkM+gYr3YH3HDwi2MRf0nVls+vTpintYX9Z2quf6bO5ih11FWq0d5BZD
         /QuHGahZnSv0XOlnYMwgosnd7FazRKm3u/E8aYJb/x04hy1Wk5pxD9TpKcjQT8A/y+LV
         maig==
X-Gm-Message-State: AOAM530nlN+ODiXp+zOm5tFFZgCPspCjsC2Ae1B1xI6E91IhRODBFDOC
        +1V0ipvWAIH9Z48mW5JagF0=
X-Google-Smtp-Source: ABdhPJwE+55knosR+8ffRZiPRdSADpNTwIDEQtqd4XoJx0T/1fPU6tA7ZE86xbhsWXT7Ga3knjR1zA==
X-Received: by 2002:a17:907:2cc7:b0:6df:b76d:940d with SMTP id hg7-20020a1709072cc700b006dfb76d940dmr1407774ejc.742.1649925550815;
        Thu, 14 Apr 2022 01:39:10 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm418138ejc.110.2022.04.14.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:39:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/7] staging: r8188eu: rename fields of struct rt_firmware_hdr
Date:   Thu, 14 Apr 2022 10:38:49 +0200
Message-Id: <20220414083853.3422-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414083853.3422-1-straube.linux@gmail.com>
References: <20220414083853.3422-1-straube.linux@gmail.com>
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

