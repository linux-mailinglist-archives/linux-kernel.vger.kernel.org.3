Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79707500B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiDNKqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242387AbiDNKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:46:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04916EC77
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 11so783977edw.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjWebb0xz2JlPboqiHF18jFOy9xu4u7Sl1Xjhzt8LEw=;
        b=fQu9zVhyLfSvkDTiVKK35W3kogpJHHy8JcRjdvY7yUh85D1JHhkyeWvqrBnKjAVAwR
         hXERnHr8RPNFs2iKyRJ9cO+jGHB67q6bNMfUOU5sYYI5r3Rre8eC9cp1p6L/wGKMcIDN
         FSlB3P/RIRODBtayPyIqYDT1IqKwlFjHuvYAUOFBsZHDJ3Z3xye+wLsf+Vlsgoa2+QV7
         siw3OFi7YgGzHONajSRxSz4K+fhJIelu8i6pxNwQTRG0IXfIUTBkTRYCQyLlhvkAZh1d
         iyUwvDtlB0Ox6Zt1kCz4hBtadcabdsTCvt3j1eL1mmjWvSqi01Ehp+RJIegNvYXbJZN2
         wE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjWebb0xz2JlPboqiHF18jFOy9xu4u7Sl1Xjhzt8LEw=;
        b=AuaRYceKX/ZtL/uR4NAemUIhSPOziqiBwwC4++iAb41E8P1T+JIFVJZIa2eOqljmYQ
         6DohQy7Jy2Iqh2xVqUf7ATJIc8tObIZI9o7/IE6cwO3EYgk9zVQFuVVZxGcPjrkG74fA
         YUPYlbXOYOQSjC+hQJTfAj9C0w0c6bn/gk5TjVL9g8DJABKTgQm+K8YMOovSc6/PWYXw
         DeG2i7owWKWuqNEK3ZNS2MdeAzRMPAG7cgQaKBYvGkTmQqynxo5cKRRrFpLZZWzzjC2P
         dUJ1udQw5D4Vz1adAY6JXpPF6S5z91qKxlUEHxUkKh9P18X2oSu6X3KoWdVQFeHKgP72
         Hgdw==
X-Gm-Message-State: AOAM532IrvMYWqFX8XuG7cgHnnkfFaQf9UfDHtD2V9aCWUB9BbFHzlUb
        1P+TTwQbITXRK5kAPlx5lZ4=
X-Google-Smtp-Source: ABdhPJwdyJBKaw+6ezo0DN2iI5ToAsHEhtUcQb+bNDgAmdGF+YPAyeOrPuGaSFxaoJ/SA/673FxfRA==
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id z22-20020a50e696000000b00419998d5febmr2294868edm.122.1649933028339;
        Thu, 14 Apr 2022 03:43:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm821318edt.34.2022.04.14.03.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:43:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/8] staging: r8188eu: clean up comments in struct rt_firmware_hdr
Date:   Thu, 14 Apr 2022 12:43:17 +0200
Message-Id: <20220414104323.6152-3-straube.linux@gmail.com>
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

The comments in struct rt_firmware_hdr are not needed.
Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 37 ++++++++-------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 7cd08268f3b9..323e0c634c4e 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -14,37 +14,22 @@
 	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
 	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
 
-/*  This structure must be careful with byte-ordering */
-
 struct rt_firmware_hdr {
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
+	__le16		Signature;
+	u8		Category;
+	u8		Function;
+	__le16		Version;
+	u8		Subversion;
 	u8		Rsvd1;
-
-	/*  LONG WORD 1 ---- */
-	u8		Month;	/*  Release time Month field */
-	u8		Date;	/*  Release time Date field */
-	u8		Hour;	/*  Release time Hour field */
-	u8		Minute;	/*  Release time Minute field */
-	__le16		RamCodeSize;	/*  The size of RAM code */
+	u8		Month;
+	u8		Date;
+	u8		Hour;
+	u8		Minute;
+	__le16		RamCodeSize;
 	u8		Foundry;
 	u8		Rsvd2;
-
-	/*  LONG WORD 2 ---- */
-	__le32		SvnIdx;	/*  The SVN entry index */
+	__le32		SvnIdx;
 	__le32		Rsvd3;
-
-	/*  LONG WORD 3 ---- */
 	__le32		Rsvd4;
 	__le32		Rsvd5;
 };
-- 
2.35.1

