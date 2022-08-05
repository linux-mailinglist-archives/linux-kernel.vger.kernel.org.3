Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965EE58A847
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiHEIpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiHEIpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:45:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C510E1
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:45:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id uj29so3928803ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qH2LYPCNZYmgIRU5T6AQyufS+ddcNinO3+CC6bKu/Is=;
        b=WZcDiQ7B+fg8SeqJSjgxGi4FS8JqnZqv2i2F7SbbE05mxAA64N3y6lMtynNKCdz3VU
         SqBhfQZf5YtqgnIgbu0IFQ1XH+dDuhMQLNdbKrjHVRgH9kPDcuW3Uik0jWyDbgjR7c5G
         RrFGDDVEwnxPg0VNILyVEZ6w6NT3Y9dGeIUDFufIOpcbKklmxMEXAtC0FcOog3PYGPlr
         CI2MK7wQ90OjZ63GdxEi4V1RqHy6fe8qRmCHzyU5VaJfk26oGVOMRdH08W7nF2+QGzG3
         /Ld7X+IYhfbK88P7HT/357j42G52ntNA9gb+I24Ud1xDmGkMkbj810K87vdzwn6nh7Y6
         8ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qH2LYPCNZYmgIRU5T6AQyufS+ddcNinO3+CC6bKu/Is=;
        b=E/TmOtaZYMBJyycgmAA0XRWjsj9FhtyQLTUeROCgE4+OPqsO4KPAgCFF5AvSv05WIf
         CCkOwFrIT398M5hb3xB8exIpOhLApMIwfaCmaLUuSvImIFvBwiQlE1ggdGoTRviTwljB
         FbZ4P2AfukdaqHnIqWYUtuom4+HscMFa6gyDGZ+msgF8UGLwFQHqQ54adTvg/RKJ4NST
         dBFm0uLJ+9NzW+kfgtiXG12w/IWHJP0WOfET3zXh2Je9XItVhidHalDwBZZYTL5noaW3
         jq4w0aeCF80m58CBUajhqxl32JrQeKoih3ncYgrn9PemmPFjnBIlCTZn4MjJMGvmYBJR
         2Wrw==
X-Gm-Message-State: ACgBeo3fXj1ThpBCel5bFulVDtonlcrX+xYxzirUI4STa+wUaoupfx+t
        e1C0Vemz/LyYmhzWHT54Dgs=
X-Google-Smtp-Source: AA6agR4p6Tb3nF/0/10/nRzHNH4ot9xVXSyRFzblvx/r2SOJbCOcH0CQb1E53+R0yahW44VLxxYiLQ==
X-Received: by 2002:a17:907:97d2:b0:730:657f:bef5 with SMTP id js18-20020a17090797d200b00730657fbef5mr4691544ejc.757.1659689114485;
        Fri, 05 Aug 2022 01:45:14 -0700 (PDT)
Received: from localhost.localdomain ([88.208.127.92])
        by smtp.gmail.com with ESMTPSA id g2-20020a170906538200b0072b592ee073sm1343654ejo.147.2022.08.05.01.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 01:45:14 -0700 (PDT)
From:   Simone Serra <serrazimone@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        soumya.negi97@gmail.com, hdegoede@redhat.com,
        straube.linux@gmail.com
Cc:     Simone Serra <serrazimone@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixes checkpatch checks
Date:   Fri,  5 Aug 2022 10:45:08 +0200
Message-Id: <20220805084508.246882-1-serrazimone@gmail.com>
X-Mailer: git-send-email 2.25.1
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

fixes checkpatch checks

Signed-off-by: Simone Serra <serrazimone@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 172 ++++++++++-----------
 1 file changed, 81 insertions(+), 91 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index d2d69321d47a..2ec77d7fa296 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -9,7 +9,6 @@
 #include <hal_data.h>
 #include <linux/jiffies.h>
 
-
 /* Define global variables */
 u8 fakeEfuseBank;
 u32 fakeEfuseUsedBytes;
@@ -38,7 +37,7 @@ Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
 	if (fakeEfuseBank == 0)
 		*Value = fakeEfuseContent[Offset];
 	else
-		*Value = fakeBTEfuseContent[fakeEfuseBank-1][Offset];
+		*Value = fakeBTEfuseContent[fakeEfuseBank - 1][Offset];
 	return true;
 }
 
@@ -50,7 +49,7 @@ Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
 	if (fakeEfuseBank == 0)
 		fakeEfuseContent[Offset] = Value;
 	else
-		fakeBTEfuseContent[fakeEfuseBank-1][Offset] = Value;
+		fakeBTEfuseContent[fakeEfuseBank - 1][Offset] = Value;
 	return true;
 }
 
@@ -74,10 +73,9 @@ Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
  *---------------------------------------------------------------------------
  */
 void
-Efuse_PowerSwitch(
-struct adapter *padapter,
-u8 bWrite,
-u8 PwrState)
+Efuse_PowerSwitch(struct adapter *padapter,
+		  u8 bWrite,
+		  u8 PwrState)
 {
 	padapter->HalFunc.EfusePowerSwitch(padapter, bWrite, PwrState);
 }
@@ -100,10 +98,9 @@ u8 PwrState)
  *---------------------------------------------------------------------------
  */
 u16
-Efuse_GetCurrentSize(
-	struct adapter *padapter,
-	u8	efuseType,
-	bool		bPseudoTest)
+Efuse_GetCurrentSize(struct adapter *padapter,
+		     u8	efuseType,
+		     bool		bPseudoTest)
 {
 	return padapter->HalFunc.EfuseGetCurrentSize(padapter, efuseType,
 						     bPseudoTest);
@@ -145,34 +142,31 @@ Efuse_CalculateWordCnts(u8 word_en)
 /*  */
 
 void
-efuse_ReadEFuse(
-	struct adapter *Adapter,
-	u8 efuseType,
-	u16		_offset,
-	u16		_size_byte,
-	u8 *pbuf,
-bool	bPseudoTest
+efuse_ReadEFuse(struct adapter *Adapter,
+		u8 efuseType,
+		u16		_offset,
+		u16		_size_byte,
+		u8 *pbuf,
+		bool	 bPseudoTest
 	);
 void
-efuse_ReadEFuse(
-	struct adapter *Adapter,
-	u8 efuseType,
-	u16		_offset,
-	u16		_size_byte,
-	u8 *pbuf,
-bool	bPseudoTest
+efuse_ReadEFuse(struct adapter *Adapter,
+		u8 efuseType,
+		u16		_offset,
+		u16		_size_byte,
+		u8 *pbuf,
+		bool	bPseudoTest
 	)
 {
 	Adapter->HalFunc.ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
 }
 
 void
-EFUSE_GetEfuseDefinition(
-	struct adapter *padapter,
-	u8 efuseType,
-	u8 type,
-	void	*pOut,
-	bool		bPseudoTest
+EFUSE_GetEfuseDefinition(struct adapter *padapter,
+			 u8 efuseType,
+			 u8 type,
+			 void	*pOut,
+			 bool		bPseudoTest
 	)
 {
 	padapter->HalFunc.EFUSEGetEfuseDefinition(padapter, efuseType, type, pOut, bPseudoTest);
@@ -196,52 +190,52 @@ EFUSE_GetEfuseDefinition(
  *---------------------------------------------------------------------------
  */
 u8
-EFUSE_Read1Byte(
-struct adapter *Adapter,
-u16		Address)
+EFUSE_Read1Byte(struct adapter *Adapter,
+		u16		Address)
 {
 	u8 Bytetemp = {0x00};
 	u8 temp = {0x00};
 	u32 k = 0;
 	u16 contentLen = 0;
 
-	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
+	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN,
+				 (void *)&contentLen, false);
 
 	if (Address < contentLen) {/* E-fuse 512Byte */
 		/* Write E-fuse Register address bit0~7 */
 		temp = Address & 0xFF;
-		rtw_write8(Adapter, EFUSE_CTRL+1, temp);
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+2);
+		rtw_write8(Adapter, EFUSE_CTRL + 1, temp);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 2);
 		/* Write E-fuse Register address bit8~9 */
 		temp = ((Address >> 8) & 0x03) | (Bytetemp & 0xFC);
-		rtw_write8(Adapter, EFUSE_CTRL+2, temp);
+		rtw_write8(Adapter, EFUSE_CTRL + 2, temp);
 
 		/* Write 0x30[31]= 0 */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
 		temp = Bytetemp & 0x7F;
-		rtw_write8(Adapter, EFUSE_CTRL+3, temp);
+		rtw_write8(Adapter, EFUSE_CTRL + 3, temp);
 
 		/* Wait Write-ready (0x30[31]= 1) */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
 		while (!(Bytetemp & 0x80)) {
-			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
 			k++;
 			if (k == 1000)
 				break;
 		}
 		return rtw_read8(Adapter, EFUSE_CTRL);
-	} else
+	} else {
 		return 0xFF;
+	}
 
 } /* EFUSE_Read1Byte */
 
 /*  11/16/2008 MH Read one byte from real Efuse. */
 u8
-efuse_OneByteRead(
-struct adapter *padapter,
-u16	addr,
-u8	*data,
-bool		bPseudoTest)
+efuse_OneByteRead(struct adapter *padapter,
+		  u16	addr,
+		  u8	*data,
+		  bool		bPseudoTest)
 {
 	u32 tmpidx = 0;
 	u8 bResult;
@@ -257,16 +251,16 @@ bool		bPseudoTest)
 
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
 	/* address */
-	rtw_write8(padapter, EFUSE_CTRL+1, (u8)(addr&0xff));
-	rtw_write8(padapter, EFUSE_CTRL+2, ((u8)((addr>>8) & 0x03)) |
-	(rtw_read8(padapter, EFUSE_CTRL+2)&0xFC));
+	rtw_write8(padapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
+	rtw_write8(padapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
+	(rtw_read8(padapter, EFUSE_CTRL + 2) & 0xFC));
 
 	/* rtw_write8(padapter, EFUSE_CTRL+3,  0x72); read cmd */
 	/* Write bit 32 0 */
-	readbyte = rtw_read8(padapter, EFUSE_CTRL+3);
-	rtw_write8(padapter, EFUSE_CTRL+3, (readbyte & 0x7f));
+	readbyte = rtw_read8(padapter, EFUSE_CTRL + 3);
+	rtw_write8(padapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
 
-	while (!(0x80 & rtw_read8(padapter, EFUSE_CTRL+3)) && (tmpidx < 1000)) {
+	while (!(0x80 & rtw_read8(padapter, EFUSE_CTRL + 3)) && (tmpidx < 1000)) {
 		mdelay(1);
 		tmpidx++;
 	}
@@ -291,16 +285,13 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 	if (bPseudoTest)
 		return Efuse_Write1ByteToFakeContent(addr, data);
 
-
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
 	/* address */
 
-
 	efuseValue = rtw_read32(padapter, EFUSE_CTRL);
-	efuseValue |= (BIT21|BIT31);
+	efuseValue |= (BIT21 | BIT31);
 	efuseValue &= ~(0x3FFFF);
-	efuseValue |= ((addr<<8 | data) & 0x3FFFF);
-
+	efuseValue |= ((addr << 8 | data) & 0x3FFFF);
 
 	/*  <20130227, Kordan> 8192E MP chip A-cut had better not set 0x34[11] until B-Cut. */
 
@@ -308,9 +299,9 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 	/* 0x34[11]: SW force PGMEN input of efuse to high. (for the bank selected by 0x34[9:8]) */
 	/* PHY_SetMacReg(padapter, 0x34, BIT11, 1); */
 	rtw_write16(padapter, 0x34, rtw_read16(padapter, 0x34) | (BIT11));
-	rtw_write32(padapter, EFUSE_CTRL, 0x90600000|((addr<<8 | data)));
+	rtw_write32(padapter, EFUSE_CTRL, 0x90600000 | ((addr << 8 | data)));
 
-	while ((0x80 &  rtw_read8(padapter, EFUSE_CTRL+3)) && (tmpidx < 100)) {
+	while ((0x80 &  rtw_read8(padapter, EFUSE_CTRL + 3)) && (tmpidx < 100)) {
 		mdelay(1);
 		tmpidx++;
 	}
@@ -328,9 +319,9 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 
 int
 Efuse_PgPacketRead(struct adapter *padapter,
-				u8	offset,
-				u8	*data,
-				bool		bPseudoTest)
+		   u8	offset,
+		   u8	*data,
+		   bool		bPseudoTest)
 {
 	return padapter->HalFunc.Efuse_PgPacketRead(padapter, offset, data,
 						    bPseudoTest);
@@ -338,10 +329,10 @@ Efuse_PgPacketRead(struct adapter *padapter,
 
 int
 Efuse_PgPacketWrite(struct adapter *padapter,
-				u8	offset,
-				u8	word_en,
-				u8	*data,
-				bool		bPseudoTest)
+		    u8	offset,
+		    u8	word_en,
+		    u8	*data,
+		    bool		bPseudoTest)
 {
 	return padapter->HalFunc.Efuse_PgPacketWrite(padapter, offset, word_en,
 						     data, bPseudoTest);
@@ -367,34 +358,33 @@ Efuse_PgPacketWrite(struct adapter *padapter,
  */
 void
 efuse_WordEnableDataRead(u8 word_en,
-						u8 *sourdata,
-						u8 *targetdata)
+			 u8 *sourdata,
+			 u8 *targetdata)
 {
-	if (!(word_en&BIT(0))) {
+	if (!(word_en & BIT(0))) {
 		targetdata[0] = sourdata[0];
 		targetdata[1] = sourdata[1];
 	}
-	if (!(word_en&BIT(1))) {
+	if (!(word_en & BIT(1))) {
 		targetdata[2] = sourdata[2];
 		targetdata[3] = sourdata[3];
 	}
-	if (!(word_en&BIT(2))) {
+	if (!(word_en & BIT(2))) {
 		targetdata[4] = sourdata[4];
 		targetdata[5] = sourdata[5];
 	}
-	if (!(word_en&BIT(3))) {
+	if (!(word_en & BIT(3))) {
 		targetdata[6] = sourdata[6];
 		targetdata[7] = sourdata[7];
 	}
 }
 
-
 u8
 Efuse_WordEnableDataWrite(struct adapter *padapter,
-						u16		efuse_addr,
-						u8 word_en,
-						u8 *data,
-						bool		bPseudoTest)
+			  u16		efuse_addr,
+			  u8 word_en,
+			  u8 *data,
+			  bool		bPseudoTest)
 {
 	return padapter->HalFunc.Efuse_WordEnableDataWrite(padapter, efuse_addr,
 							   word_en, data,
@@ -419,18 +409,18 @@ Efuse_WordEnableDataWrite(struct adapter *padapter,
  *---------------------------------------------------------------------------
  */
 void
-Efuse_ReadAllMap(
-	struct adapter *padapter,
-	u8 efuseType,
-	u8 *Efuse,
-	bool		bPseudoTest);
+Efuse_ReadAllMap(struct adapter *padapter,
+		 u8 efuseType,
+		 u8 *Efuse,
+		 bool		bPseudoTest);
 void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse, bool bPseudoTest)
 {
 	u16 mapLen = 0;
 
 	Efuse_PowerSwitch(padapter, false, true);
 
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, bPseudoTest);
+	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN,
+				 (void *)&mapLen, bPseudoTest);
 
 	efuse_ReadEFuse(padapter, efuseType, 0, mapLen, Efuse, bPseudoTest);
 
@@ -470,7 +460,7 @@ static void efuse_ShadowRead2Byte(struct adapter *padapter, u16 Offset, u16 *Val
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 
 	*Value = pEEPROM->efuse_eeprom_data[Offset];
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+1]<<8;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
 
 }	/*  EFUSE_ShadowRead2Byte */
 
@@ -480,9 +470,9 @@ static void efuse_ShadowRead4Byte(struct adapter *padapter, u16 Offset, u32 *Val
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 
 	*Value = pEEPROM->efuse_eeprom_data[Offset];
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+1]<<8;
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+2]<<16;
-	*Value |= pEEPROM->efuse_eeprom_data[Offset+3]<<24;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 2] << 16;
+	*Value |= pEEPROM->efuse_eeprom_data[Offset + 3] << 24;
 
 }	/*  efuse_ShadowRead4Byte */
 
@@ -508,7 +498,8 @@ void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoT
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 	u16 mapLen = 0;
 
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, bPseudoTest);
+	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_MAP_LEN,
+				 (void *)&mapLen, bPseudoTest);
 
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
@@ -519,7 +510,6 @@ void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoT
 	/* void *)&pHalData->EfuseMap[EFUSE_INIT_MAP][0], mapLen); */
 } /*  EFUSE_ShadowMapUpdate */
 
-
 /*-----------------------------------------------------------------------------
  * Function:	EFUSE_ShadowRead
  *
-- 
2.25.1

