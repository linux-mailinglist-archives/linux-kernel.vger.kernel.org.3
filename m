Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF879500884
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbiDNIlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiDNIlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:41:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD764706
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u15so8619875ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjWebb0xz2JlPboqiHF18jFOy9xu4u7Sl1Xjhzt8LEw=;
        b=gP4/hSeWQuS/g+Q7CqB/kF5+oipUEMvVVqp8MLHg1J9F9iKPwR2vS6Xda2MWovTVA9
         nyov1stL3UHsRhvCGJTTh3/1zAqQtHMd45Z3pRLHR2jTEDqXX1WQKr94+bbrKLmVAdO2
         DmTDZl/TMIdWNd0MumK5IAZHB2ArAQZmwDwxhfDVPzzWpFggSD9ky7fDcTpueHeY3B5A
         b+lYtLDS1XXLEVON8pAPL+7XS5ZtJimTD0wMKJL+fNUNwPA9F2ZK/rIy4S1kA6vbA5OE
         6dpGBZ3Kzbx8vitV669+USDbw9W1CNMbw5gm4rjAr2VhNX9tfhRRxt+hpdRzVjFogH+m
         djoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjWebb0xz2JlPboqiHF18jFOy9xu4u7Sl1Xjhzt8LEw=;
        b=23XzxtlGpOTjLNngwz/ATSsFjBVKdf3gEhLKbSYOxKYEBLrPx1pC2bKTwg14JJQwjY
         nlVG2KVQx5iJxJ7ZKmUZxMMoKxB2T9wIVVFNL/usjCZyvpkt1yVQweSt2lHSOzF5Rxu5
         1AiTdmLXI46Z9gi+SQ2j3Oc4XMkezRrAr3fyvcwy/OgaDTQpUNDvGxHeW2gq/g/firlF
         0nVd6dRZr8YK6iRaia36aZPSWIG0lne2GNhZ9j8ut7aW+DtcekRgLp1Yc1XaX/j9wfoE
         ZPwnYDyuv+2G9naIUbuVEBFxvhkofzap/Uh2yT+l8uG8JJXMy+UKEDJhZXivxEP8Izh0
         GD7A==
X-Gm-Message-State: AOAM530+h678e0SF7Rc0qQ+WdJpjQDJThA8lDn6E67TJud0mP9ZbJgxr
        QAuPL0lzJmykt7hlVGdzYns=
X-Google-Smtp-Source: ABdhPJxAErEv6I5kwWbRoynQtPMycoHXJfZsxujVKDmp2ouG2mnaosUahQhIU+lmF+W/N036r7s/GQ==
X-Received: by 2002:a17:907:9702:b0:6e8:be82:f43d with SMTP id jg2-20020a170907970200b006e8be82f43dmr1388679ejc.67.1649925549935;
        Thu, 14 Apr 2022 01:39:09 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm418138ejc.110.2022.04.14.01.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:39:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/7] staging: r8188eu: clean up comments in struct rt_firmware_hdr
Date:   Thu, 14 Apr 2022 10:38:48 +0200
Message-Id: <20220414083853.3422-3-straube.linux@gmail.com>
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

