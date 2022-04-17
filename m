Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A15048AC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiDQR5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiDQR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:57:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB4BE1F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v4so15343985edl.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHM9PFFwx6hClGPcuoJgSs1Sb6xb089x4uMzIqzHgxE=;
        b=Yp56c+ZB8HEv1qF30A4KlgnajiNfkp/end5U3doacovPJEmHPgB5M6jLXBAj6iHqYp
         9R3CjqP3XpBeMvY0D1uc4/D1k9NcvvT/5P/SB18egXGckfj+qK4SIuldWJftfnXDetPP
         oixZVm9mHe0rEIgR4YkuTxhJ5SwWJM3vOwqLNJXkihF3CQKhO2IwGHj2AIOJjnJBCvvc
         XCvs40JMYYhGizciLG+mwnPww5IYMX/0bJWrF+c31+UlY4IO+4CsLNAI6bTu9le4JEBf
         NtSAcjkyQyPB2TCehsBPWANsEfo9C7Qjpxh3uDHTPYc88z3opIRcxISWAXtprEXNZzEa
         kNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHM9PFFwx6hClGPcuoJgSs1Sb6xb089x4uMzIqzHgxE=;
        b=mZuR5dHeI5C2Z/1LbHujZoNutuYqXKYuFmuTZQ3+JdeFxrHkm5qnbo86j27EicIqhB
         itgyoTGR+BhaAfVaoWQdAGzvD+CqHoc2aU8hvQnoBvFCz3F6RSLLd/J6HkjkgViN9SAe
         sGK7tQYjby7WHnEP0ZP5kIZe2nob7WjKKfPa6O9/Vr5P5vhJ/Lhw9AU+WOrZg+olMSGM
         Aum2jyTOPpFNo5NnpPEL19ZzS75aLnYPTTwhhWNWh0Y71RAeamZnlP18D/Qba0irVuJw
         8RizKrpTqjV84C+QivM3WZHJm5msqhjdMF6bK/D1d2j/9Ckn7B7AIsNVNviNLJjw8R/J
         W9DQ==
X-Gm-Message-State: AOAM532L+bTnRqq9pO2VQn2zQFoyDQDCrba82ZI9urw1z+7kerlohqhc
        MnGdWpNuN9+kx9YZK094QEA=
X-Google-Smtp-Source: ABdhPJzpsqelcEFavErmiQTZY9Yba+1II7W/RaX2sY5D0MrTifQjwSVy8Q2XdtxzQbs85AIktc1GBw==
X-Received: by 2002:aa7:dcd3:0:b0:41d:70e4:bf4d with SMTP id w19-20020aa7dcd3000000b0041d70e4bf4dmr8649818edu.223.1650218089830;
        Sun, 17 Apr 2022 10:54:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm3719409ejc.150.2022.04.17.10.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:54:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 3/8] staging: r8188eu: clean up comments in struct rt_firmware_hdr
Date:   Sun, 17 Apr 2022 19:54:36 +0200
Message-Id: <20220417175441.13830-4-straube.linux@gmail.com>
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

Remove unnecessary comments from struct rt_firmware_hdr. While at it
align the in-line comments.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v4:
- keep the in-line comments

v3:
- no changes

v2:
- no changes

 drivers/staging/r8188eu/core/rtw_fw.c | 36 ++++++++++-----------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 7cd08268f3b9..0fa27b36bb8e 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -14,37 +14,27 @@
 	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
 	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
 
-/*  This structure must be careful with byte-ordering */
-
 struct rt_firmware_hdr {
-	/*  8-byte alinment required */
-	/*  LONG WORD 0 ---- */
 	__le16		Signature;	/* 92C0: test chip; 92C,
 					 * 88C0: test chip; 88C1: MP A-cut;
 					 * 92C1: MP A-cut */
-	u8		Category;	/*  AP/NIC and USB/PCI */
-	u8		Function;	/*  Reserved for different FW function
-					 *  indcation, for further use when
-					 *  driver needs to download different
-					 *  FW for different conditions */
-	__le16		Version;	/*  FW Version */
-	u8		Subversion;	/*  FW Subversion, default 0x00 */
+	u8		Category;	/* AP/NIC and USB/PCI */
+	u8		Function;	/* Reserved for different FW function
+					 * indcation, for further use when
+					 * driver needs to download different
+					 * FW for different conditions */
+	__le16		Version;	/* FW Version */
+	u8		Subversion;	/* FW Subversion, default 0x00 */
 	u8		Rsvd1;
-
-	/*  LONG WORD 1 ---- */
-	u8		Month;	/*  Release time Month field */
-	u8		Date;	/*  Release time Date field */
-	u8		Hour;	/*  Release time Hour field */
-	u8		Minute;	/*  Release time Minute field */
-	__le16		RamCodeSize;	/*  The size of RAM code */
+	u8		Month;		/* Release time Month field */
+	u8		Date;		/* Release time Date field */
+	u8		Hour;		/* Release time Hour field */
+	u8		Minute;		/* Release time Minute field */
+	__le16		RamCodeSize;	/* The size of RAM code */
 	u8		Foundry;
 	u8		Rsvd2;
-
-	/*  LONG WORD 2 ---- */
-	__le32		SvnIdx;	/*  The SVN entry index */
+	__le32		SvnIdx;		/* The SVN entry index */
 	__le32		Rsvd3;
-
-	/*  LONG WORD 3 ---- */
 	__le32		Rsvd4;
 	__le32		Rsvd5;
 };
-- 
2.35.1

