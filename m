Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5634EDA41
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiCaNLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiCaNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:11:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFEA2558E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:09:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a1so33738904wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BV/bIHTT1neiW4KaA2YJdbMk/VdfvUqsLrJa1P0rOGk=;
        b=jdZY1CShnQz+gjzfn4c5QInD9OvUvgHhBakTnvP29jkgwaq8BVcr/L0rdvOwxsNStp
         UNFT4h8GjY5/HM88JI6BJeon0UClKG/c+RnJ5KeVOb0U5+Tbw0rahFs80y2PvchgV8WE
         FMkhNonvBeOLZsfa82VkZ6pj2gLdq22olUgjPqlVnZZ7XJNEsQeAUCpM7Oq4Mt46yE3U
         uHUGe1W/aJlEgsp6KH2kG5eftsc7orLhhH1mmPojaKU2hPTQpe2GdyR5tgfjOQLdZ7Xj
         J4sWhEmyxgdbofVsJxRjJ5sXSortzu+HBVUHCVzf/Vucz3VU8GfJjp17x7HEE1ydcGFp
         WFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BV/bIHTT1neiW4KaA2YJdbMk/VdfvUqsLrJa1P0rOGk=;
        b=uTZ7hKtjoYzgfzf99P8WP+FRxw/XRANP9stH523Y8eusGsEoXQcZ4s0f/CiVdm+dKn
         K62vGtXf75GiJQL06Fu49xkZhYWTbFbdF5PBjn/tQB+nne9it0dFZysReS9zdXgSsshG
         DarTd/z5SPbDBhSLVRzxe0fHqFh8upCeHupldgAlxXGxyGeHS5f4cdRnkv79qpAXStcJ
         bQ0/MoV+2x93ZzbpVFIyHFQ2Di0CgqVpx/pro/XWgY+UoPgDOG9/RH7TKYbJyuiv9uLU
         Bcb+plJFaSURvEAet8FET7a9lG82ejuuGGBcTaNT34zGMDy+j90l5H7bwkKBoi8wiOM4
         6v0A==
X-Gm-Message-State: AOAM531YiDu7bR5CVoaNVcCzB5dmUy9V/fwA1/kZIV9fajwkwhpta4bu
        HIL1LxbNuvBxe1j89bzLf0es6KvooQM=
X-Google-Smtp-Source: ABdhPJyvjYt9wLvH682uZ+aLb5dzowvSPZC9TGQqNZGDrGWH9B/reFQrxPC0eXEDTojUf/CgGJ4gEg==
X-Received: by 2002:a5d:64ae:0:b0:205:dc46:faff with SMTP id m14-20020a5d64ae000000b00205dc46faffmr3990442wrp.195.1648732192802;
        Thu, 31 Mar 2022 06:09:52 -0700 (PDT)
Received: from alaa-emad ([41.37.132.115])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c1d8e00b0038dbb5ecc8asm6898070wms.2.2022.03.31.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 06:09:52 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] staging: rtl8723bs: Fix No space before tabs
Date:   Thu, 31 Mar 2022 15:09:48 +0200
Message-Id: <20220331130948.74835-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Fix "WARNING: please, no space before tabs"
reported by checkpatch

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 54 +++++++++++-----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 3d3c77273026..06e727ce9cc2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -100,7 +100,7 @@ u8 PwrState)
 u16
 Efuse_GetCurrentSize(
 	struct adapter *padapter,
-	u8 	efuseType,
+	u8	efuseType,
 	bool		bPseudoTest)
 {
 	return padapter->HalFunc.EfuseGetCurrentSize(padapter, efuseType,
@@ -124,29 +124,29 @@ Efuse_CalculateWordCnts(u8 word_en)
 }
 
 /*  */
-/* 	Description: */
-/* 		1. Execute E-Fuse read byte operation according as map offset and */
-/* 		    save to E-Fuse table. */
-/* 		2. Referred from SD1 Richard. */
+/* Description: */
+/*		1. Execute E-Fuse read byte operation according as map offset and */
+/*			save to E-Fuse table. */
+/*		2. Referred from SD1 Richard. */
 /*  */
-/* 	Assumption: */
-/* 		1. Boot from E-Fuse and successfully auto-load. */
-/* 		2. PASSIVE_LEVEL (USB interface) */
+/* Assumption: */
+/*		1. Boot from E-Fuse and successfully auto-load. */
+/*		2. PASSIVE_LEVEL (USB interface) */
 /*  */
-/* 	Created by Roger, 2008.10.21. */
+/* Created by Roger, 2008.10.21. */
 /*  */
-/* 	2008/12/12 MH	1. Reorganize code flow and reserve bytes. and add description. */
-/* 					2. Add efuse utilization collect. */
-/* 	2008/12/22 MH	Read Efuse must check if we write section 1 data again!!! Sec1 */
-/* 					write addr must be after sec5. */
+/* 2008/12/12 MH	1. Reorganize code flow and reserve bytes. and add description. */
+/*					2. Add efuse utilization collect. */
+/* 2008/12/22 MH	Read Efuse must check if we write section 1 data again!!! Sec1 */
+/*					write addr must be after sec5. */
 /*  */
 
 void
 efuse_ReadEFuse(
 	struct adapter *Adapter,
 	u8 efuseType,
-	u16 	_offset,
-	u16 	_size_byte,
+	u16		_offset,
+	u16		_size_byte,
 	u8 *pbuf,
 bool	bPseudoTest
 	);
@@ -154,8 +154,8 @@ void
 efuse_ReadEFuse(
 	struct adapter *Adapter,
 	u8 efuseType,
-	u16 	_offset,
-	u16 	_size_byte,
+	u16		_offset,
+	u16		_size_byte,
 	u8 *pbuf,
 bool	bPseudoTest
 	)
@@ -168,7 +168,7 @@ EFUSE_GetEfuseDefinition(
 	struct adapter *padapter,
 	u8 efuseType,
 	u8 type,
-	void 	*pOut,
+	void	*pOut,
 	bool		bPseudoTest
 	)
 {
@@ -194,7 +194,7 @@ EFUSE_GetEfuseDefinition(
 u8
 EFUSE_Read1Byte(
 struct adapter *Adapter,
-u16 	Address)
+u16		Address)
 {
 	u8 Bytetemp = {0x00};
 	u8 temp = {0x00};
@@ -235,8 +235,8 @@ u16 	Address)
 u8
 efuse_OneByteRead(
 struct adapter *padapter,
-u16 		addr,
-u8 	*data,
+u16	addr,
+u8	*data,
 bool		bPseudoTest)
 {
 	u32 tmpidx = 0;
@@ -324,8 +324,8 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 
 int
 Efuse_PgPacketRead(struct adapter *padapter,
-				u8 	offset,
-				u8 	*data,
+				u8	offset,
+				u8	*data,
 				bool		bPseudoTest)
 {
 	return padapter->HalFunc.Efuse_PgPacketRead(padapter, offset, data,
@@ -334,9 +334,9 @@ Efuse_PgPacketRead(struct adapter *padapter,
 
 int
 Efuse_PgPacketWrite(struct adapter *padapter,
-				u8 	offset,
-				u8 	word_en,
-				u8 	*data,
+				u8	offset,
+				u8	word_en,
+				u8	*data,
 				bool		bPseudoTest)
 {
 	return padapter->HalFunc.Efuse_PgPacketWrite(padapter, offset, word_en,
@@ -386,7 +386,7 @@ efuse_WordEnableDataRead(u8 word_en,
 
 u8
 Efuse_WordEnableDataWrite(struct adapter *padapter,
-						u16 	efuse_addr,
+						u16		efuse_addr,
 						u8 word_en,
 						u8 *data,
 						bool		bPseudoTest)
-- 
2.35.1

