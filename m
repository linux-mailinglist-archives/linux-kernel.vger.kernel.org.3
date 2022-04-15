Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBED50296F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353156AbiDOMNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353122AbiDOMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:13:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903AEBF011
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s25so9261278edi.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ao+2u5mN9oqQNh9Bj75ET9jSsQPun5Z4kpcJNLscrms=;
        b=cjoLOsSDj/9/qFpS2S1vuZWjEowzAEn4dR0Nh2GziZQLnl4Bn3FUrhJZjp7IfB7AS/
         6LdzKS8R4qeoBYxCkRdZjzxr4mTOY9oJcDZqA2QPH/v1BtuPL5kKlG8vOHAPwf5lKNs/
         vRfPfrVB/l7zNqMlmGmjcpMPUxSwzhsXSQqxV6OWrV2whRiGaW/al8nqo23kWqBswDO3
         Pv6lDtq8Nhcva64wzC+TwdnAf4HF2HWLSS0BwZAk0vO9NpNAhduMf96SpnsZkVdX9iCe
         AvGQq9OnuQC6jY0+XyGgLisJfmIvCdO8aPLreEP0Y9HC3YZ310e730d4NMy9xuSX5gvg
         t4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ao+2u5mN9oqQNh9Bj75ET9jSsQPun5Z4kpcJNLscrms=;
        b=fKxfp21lmMfP9N24Q0V21sq0PEjQ4mY65+RWZh3jpIBeUGAUi++xWKACz2qC6kJmr8
         BGRet7rOrJXFRwNWglKT4RpQW835s/G3EXk08zXJEovVqIwdb+xYTHRVOOOYKsk5BCA8
         cU8SKbEz4iPXhzZ6EfXV4Gb+5T5PhDoHRoFMxLobuITZKL0V+gSCdHTxaMWhYUooi/NY
         Z/6C7xV27OU7dI9L/J4wPoLEOH+kxIZKJVSdd0o7UzGRN2tQkmws09uWfTTFywId3lDJ
         xW1yoNMBKBxCoWrMDcMOZN7lFuIajjvgwCFa47xJ6n5117OWuU7LdJH/5lAm76WolLkB
         Yt+A==
X-Gm-Message-State: AOAM531PGKzO64i5S8QbJUSjsN7uJs6qzKpCiUUerjS5prZldtXR5DtF
        2djvJCJf+If88R8CKIo+l2Q=
X-Google-Smtp-Source: ABdhPJyKs7kZ6vzgwX3OHrdJ0E5c3YGCeKrhSaUtvDjb6Bz6b6BkhJdPWey9xTtiDxWqKRMwmZGI5w==
X-Received: by 2002:a50:cc9e:0:b0:41d:7123:d3ba with SMTP id q30-20020a50cc9e000000b0041d7123d3bamr8022989edi.296.1650024637162;
        Fri, 15 Apr 2022 05:10:37 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm1626114ejd.72.2022.04.15.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:10:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 3/8] staging: r8188eu: clean up comments in struct rt_firmware_hdr
Date:   Fri, 15 Apr 2022 14:10:18 +0200
Message-Id: <20220415121023.11564-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415121023.11564-1-straube.linux@gmail.com>
References: <20220415121023.11564-1-straube.linux@gmail.com>
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
v3:
- no changes

v2:
- no changes

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

