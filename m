Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6050296A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353164AbiDOMNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbiDOMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:13:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD9BF02E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ks6so15110257ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJi+tLxXamIuDAtEfjvcqCgFDEYBl2Om677cUuE/bbA=;
        b=qhgCzLkd+bA8r6SGZR0qHhG5JQ7asfZzybk24U9sGCt3ey4X5LXDDQ4i/mlbDP4rfC
         HQyjoXVEHNgVlog7GS3/ZkEoWAT9MA2/dKy01Qu0TZK3xs+AeeDm7D5b4ulNomEFab1L
         ufKiKzSbgF75EGlXqf8oL+gIQq9tZJW//fGWY7ODb/W+5DXMjUTAMU5CnnlKW2aGrK+y
         wOzEY7hkcGV0XqH8zG6Y4bnxJgudVvv3IA9QnlSMxkMrKVOx46qV081CN3aKrIHbzdY3
         wTI5shBrGrPiyYr47zLdXtEcaozQTXAN8e7yoAuepiyN8gtoVl/RchVaGyFEhr8VtH4S
         VLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJi+tLxXamIuDAtEfjvcqCgFDEYBl2Om677cUuE/bbA=;
        b=LuCZkX9Hnm6bAgnmLt4gM2jWxsyfc2p/Vz0BZuRz8CgrgcibsPYeWuQPCWOgGnSMOp
         aYovedCg5IXOJCgyppUgSG0Zrj6cwd7mkMOZh3jItMMFNAoDymmL85c3EUZ88gc34LN7
         gNHsxYLsyNcDkrSF78CDRnvigb5TpSkA39v/ABPIjjV9jh/6KgbYJoRc8WuNe/GbFUUs
         FOqqjk7A7rwogjSODlGFzaFR79vbLpjjOj6+iJaBrXr12A54cdCu5U9i549+xehJRKF4
         DTl54wAQr0kkzScW1+JaxqCYJxPnIyt375QpRD9Az5njazi9LlsS+HNzi5DkPPuXEHDr
         lNdw==
X-Gm-Message-State: AOAM530NN38Nc9NE0JY3UK/r5nAbDmgH4rUtmmS9i7k7fYi6wdVyNWju
        O+hKUvLDina2aIk0BCW0bnY=
X-Google-Smtp-Source: ABdhPJx5rDcal83LHDyWtmxL13N9eb58SYGqi/MCghxYdcwXxrcc4lbxqNt0s5f9P18SdzlnJLh7DQ==
X-Received: by 2002:a17:906:4fcb:b0:6e8:74db:6b04 with SMTP id i11-20020a1709064fcb00b006e874db6b04mr6064220ejw.676.1650024637867;
        Fri, 15 Apr 2022 05:10:37 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm1626114ejd.72.2022.04.15.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:10:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 4/8] staging: r8188eu: rename fields of struct rt_firmware_hdr
Date:   Fri, 15 Apr 2022 14:10:19 +0200
Message-Id: <20220415121023.11564-5-straube.linux@gmail.com>
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

Rename the fields of struct rt_firmware_hdr to avoid camel case.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3:
- no changes

v2:
- no changes

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

