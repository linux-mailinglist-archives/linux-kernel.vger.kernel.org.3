Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD11E58A7BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiHEIFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiHEIFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:05:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E699175B9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:05:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x21so2428452edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHbOmXbgjKHOMupCWCh1THeozZUBQlhqxyrI1uVreNM=;
        b=avTDh8alnwidHdGjaLWWHbEUbXwgqB4B1HrCBlHmSoa1uVDIVlW6MEK/eH6N0fk46U
         8VBjO6v/+GSAvzRSXs1/6J7/GNuub4e5ux7bFXa3PMxp2BaZ2wUVF1EhFUV5le4YzWUW
         /pmoRxTSINUx99MFRK7OFav41PaGaObqvAuhRQUef2SLcJOlMATo2iERHpkAwDHjCgy7
         LvU3Vo/8XmXn2cvKZo3ZeGOdvooEAVFzGAOe9GSLvIGTLtp84UbEkqlqFmqmkYAi7I0Y
         ZPqLbFsZF9xzUbnUMhD30alnv/iIBM9ptu7MmLTKJ+oRndiS1OD4x0vD6EY7t4Yf+S4W
         QfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHbOmXbgjKHOMupCWCh1THeozZUBQlhqxyrI1uVreNM=;
        b=mmUULDSkinx4xa8rK/Ty+KjsxSQaSV0pYs7vTAGngV6i0139TYXfW/5fbuF0hKBHWz
         1kAqASik/lGJ1A1ECSvoSM4+LzoWwB7nRO9VDrvoH71eBOwOKXBc9c4mBJdllgzdBgzt
         Waesv+oI7N0qySeAPr3d2NfSZuLKw9Os6T2kGYLTlUpq+fyn2kUKEqRa1kGEWThcUj/q
         XcGAH+SoSZF5NqTG7QogJowS3LRhrYtaRomCBBZ+GQjfnPqZonW0bk7QTK1X4HXaaRhE
         xzi2XC8oouwtIS5Ktv2x9kTPxYk/UBbI0EnjAcW1xluCvt0hIRg0OjF58Qdf69Z/2b7t
         67IA==
X-Gm-Message-State: ACgBeo2i4hPRUbCOgRYRrbEiIa/5112fZFV85O8aUcC7ZvJKyndlCfcW
        C541ZVRghJqr5F79o5g7Ymk=
X-Google-Smtp-Source: AA6agR6GlyqK4MiOYzo14g8mdn64a+2Hdm17nSXR1HYAVoYMynS8IS8YVLYBH/i4LkWn7je1zn+LPA==
X-Received: by 2002:aa7:de91:0:b0:43a:d5b0:e0bb with SMTP id j17-20020aa7de91000000b0043ad5b0e0bbmr5446987edv.165.1659686740812;
        Fri, 05 Aug 2022 01:05:40 -0700 (PDT)
Received: from localhost.localdomain ([88.208.127.92])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906939600b00730670379f5sm1287849ejx.221.2022.08.05.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 01:05:40 -0700 (PDT)
From:   Simone Serra <serrazimone@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        soumya.negi97@gmail.com, hdegoede@redhat.com,
        straube.linux@gmail.com
Cc:     Simone Serra <serrazimone@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed checkpatch warnings
Date:   Fri,  5 Aug 2022 10:05:38 +0200
Message-Id: <20220805080538.230906-1-serrazimone@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all checkpatch warnings

Signed-off-by: Simone Serra <serrazimone@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 25 +++++++++++++++-------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 06e727ce9cc2..d2d69321d47a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -71,7 +71,8 @@ Efuse_Write1ByteToFakeContent(u16 Offset, u8 Value)
  * When			Who		Remark
  * 11/17/2008	MHC		Create Version 0.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 void
 Efuse_PowerSwitch(
 struct adapter *padapter,
@@ -96,7 +97,8 @@ u8 PwrState)
  * When			Who		Remark
  * 11/16/2008	MHC		Create Version 0.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 u16
 Efuse_GetCurrentSize(
 	struct adapter *padapter,
@@ -112,6 +114,7 @@ u8
 Efuse_CalculateWordCnts(u8 word_en)
 {
 	u8 word_cnts = 0;
+
 	if (!(word_en & BIT(0)))
 		word_cnts++; /*  0 : write enable */
 	if (!(word_en & BIT(1)))
@@ -190,7 +193,8 @@ EFUSE_GetEfuseDefinition(
  * When			Who		Remark
  * 09/23/2008	MHC		Copy from WMAC.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 u8
 EFUSE_Read1Byte(
 struct adapter *Adapter,
@@ -359,7 +363,8 @@ Efuse_PgPacketWrite(struct adapter *padapter,
  * 11/16/2008	MHC		Create Version 0.
  * 11/21/2008	MHC		Fix Write bug when we only enable late word.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 void
 efuse_WordEnableDataRead(u8 word_en,
 						u8 *sourdata,
@@ -411,7 +416,8 @@ Efuse_WordEnableDataWrite(struct adapter *padapter,
  * When			Who		Remark
  * 11/11/2008	MHC		Create Version 0.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 void
 Efuse_ReadAllMap(
 	struct adapter *padapter,
@@ -448,7 +454,8 @@ void Efuse_ReadAllMap(struct adapter *padapter, u8 efuseType, u8 *Efuse, bool bP
  * When			Who		Remark
  * 11/12/2008	MHC		Create Version 0.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void efuse_ShadowRead1Byte(struct adapter *padapter, u16 Offset, u8 *Value)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
@@ -494,7 +501,8 @@ static void efuse_ShadowRead4Byte(struct adapter *padapter, u16 Offset, u32 *Val
  * When			Who		Remark
  * 11/13/2008	MHC		Create Version 0.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoTest)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
@@ -527,7 +535,8 @@ void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoT
  * When			Who		Remark
  * 11/12/2008	MHC		Create Version 0.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 void EFUSE_ShadowRead(struct adapter *padapter, u8 Type, u16 Offset, u32 *Value)
 {
 	if (Type == 1)
-- 
2.25.1

