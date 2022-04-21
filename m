Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3D509826
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385369AbiDUG5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385477AbiDUG4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:56:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22535183AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:52:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w1so6977218lfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6+6bxldii5Dc2dUQ6OMHALIXJSUR/ARMrZh/AkI+TKc=;
        b=nalTcqVTfeljfGTtbxRoySr9fUivjCVPXeWmidEh9QY8vMrVzU0Mlw6kBYK1sistNA
         vPLbtZoev0Y1VFs2ZtwV++mUz56HDUg8WnEAvUm4DKuaR4uFojqSNaJu76V+bCYMi47f
         WRc1wzmh5i0EmZGMSRHi5RgMuLOmUeP+8ujie3dHdHb3zfBRmT8PZAsgN6lO8bIc8Qa4
         /Bs87CRbabqWatk7JbC/Qq8tIcmbqYnRCV6nOB+iYXslpgksxrnWo5pxQTgpcoQZa4Lq
         eTG6DeBlkbKEZZpliDTJC9Ax1dDF7bSISvo64chBsOg1pliOmvVn/n9q8aqI7daB9RmS
         EUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6+6bxldii5Dc2dUQ6OMHALIXJSUR/ARMrZh/AkI+TKc=;
        b=Qrv4+ncJahqVFCkQ7YZixDG0avaYbrgJHPl7tSntbbOIXnpwRUyk5IP2oVHlSZ/1if
         L/bXo02Iw+sSNDET/niRbwUVgxQbhNNMkgUvWRRFYfEZatzzTSoryjcV3XBqO3VfvwPA
         GDNNQMW4kUWCBH+xAuSeKfjytKHFHq+/ZOCpt89wTbUD/5m23ezud8KdLYYEEzC9Lu8a
         cbs1iJKzmnaPlIOkpyTJ4NyXSsx9Q5Y9cpb0y8v+HUjC/wpYBHfrNqUxAjsOWlLQ1rtA
         M/lRLUpoGABI9ulhv+2CkpxYuZogkHH4NfoJQw0enUiXQ5WnRSrfyDAVUnWA7Uc/+C1K
         q3uQ==
X-Gm-Message-State: AOAM5327ZWBH1wNFMgmjbiYLvrLBiU1kSBpkXOjLvIsu/ZhDh/MWwtND
        wkoY0U5W00vwcVbKxuU8Qm426tSvWD9jsA==
X-Google-Smtp-Source: ABdhPJxKznDViSFRFwchnjjNQx/dxacV4ML4fquU62oTlcUSDdAhDqk+2dvDkWwWtWrb3BgeXeE4Zw==
X-Received: by 2002:a05:6512:260a:b0:43d:909a:50cf with SMTP id bt10-20020a056512260a00b0043d909a50cfmr17021274lfb.195.1650523942172;
        Wed, 20 Apr 2022 23:52:22 -0700 (PDT)
Received: from crux (h-98-128-204-26.A444.priv.bahnhof.se. [98.128.204.26])
        by smtp.gmail.com with ESMTPSA id j15-20020a196e0f000000b0046dd665d50asm2080359lfc.263.2022.04.20.23.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 23:52:21 -0700 (PDT)
Date:   Thu, 21 Apr 2022 08:52:19 +0200
From:   Artur Bujdoso <artur.bujdoso@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2] staging: rtl8723bs: remove leftover code for other chips
Message-ID: <YmD/I19v8sJLrOQo@crux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up unreferenced definitions in hal headers and code.

Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
---
v2: removed formatting changes from this commit and references and defines to
    unused variable ChipVersion.ICType noted by Pavel Skripkin <paskripkin@gmail.com>

 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |  11 -
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   8 -
 drivers/staging/rtl8723bs/include/HalVerDef.h |  10 -
 .../staging/rtl8723bs/include/hal_com_reg.h   | 295 ------------------
 4 files changed, 324 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index af50674b2a65..9091f2f75fe1 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -68,16 +68,6 @@ enum btc_chip_interface {
 	BTC_INTF_MAX
 };
 
-enum {
-	BTC_CHIP_UNDEF		= 0,
-	BTC_CHIP_CSR_BC4	= 1,
-	BTC_CHIP_CSR_BC8	= 2,
-	BTC_CHIP_RTL8723A	= 3,
-	BTC_CHIP_RTL8821	= 4,
-	BTC_CHIP_RTL8723B	= 5,
-	BTC_CHIP_MAX
-};
-
 /*  following is for wifi link status */
 #define WIFI_STA_CONNECTED				BIT0
 #define WIFI_AP_CONNECTED				BIT1
@@ -87,7 +77,6 @@ enum {
 
 struct btc_board_info {
 	/*  The following is some board information */
-	u8 btChipType;
 	u8 pgAntNum;	/*  pg ant number */
 	u8 btdmAntNum;	/*  ant number for btdm */
 	u8 btdmAntPos;		/* Bryant Add to indicate Antenna Position for (pgAntNum = 2) && (btdmAntNum = 1)  (DPDT+1Ant case) */
diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index f4b3e8b28712..9acd49323c7c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -1113,11 +1113,6 @@ void EXhalbtcoutsrc_Periodical(struct btc_coexist *pBtCoexist)
 /* 	halbtcoutsrc_NormalLowPower(pBtCoexist); */
 }
 
-void EXhalbtcoutsrc_SetChipType(u8 chipType)
-{
-	GLBtCoexist.boardInfo.btChipType = BTC_CHIP_RTL8723B;
-}
-
 void EXhalbtcoutsrc_SetAntNum(u8 type, u8 antNum)
 {
 	if (BT_COEX_ANT_TYPE_PG == type) {
@@ -1188,9 +1183,6 @@ void hal_btcoex_SetChipType(struct adapter *padapter, u8 chipType)
 
 
 	pHalData = GET_HAL_DATA(padapter);
-	pHalData->bt_coexist.btChipType = chipType;
-
-	EXhalbtcoutsrc_SetChipType(chipType);
 }
 
 void hal_btcoex_SetPgAntNum(struct adapter *padapter, u8 antNum)
diff --git a/drivers/staging/rtl8723bs/include/HalVerDef.h b/drivers/staging/rtl8723bs/include/HalVerDef.h
index 8f654a49fb9d..d0ce21ccc1cc 100644
--- a/drivers/staging/rtl8723bs/include/HalVerDef.h
+++ b/drivers/staging/rtl8723bs/include/HalVerDef.h
@@ -9,16 +9,7 @@
 
 /*  hal_ic_type_e */
 enum hal_ic_type_e { /* tag_HAL_IC_Type_Definition */
-	CHIP_8192S	=	0,
-	CHIP_8188C	=	1,
-	CHIP_8192C	=	2,
-	CHIP_8192D	=	3,
-	CHIP_8723A	=	4,
-	CHIP_8188E	=	5,
-	CHIP_8812	=	6,
-	CHIP_8821	=	7,
 	CHIP_8723B	=	8,
-	CHIP_8192E	=	9,
 };
 
 /* hal_chip_type_e */
@@ -58,7 +49,6 @@ struct hal_version { /* tag_HAL_VERSION */
 	u8 			ROMVer;
 };
 
-/* VERSION_8192C			VersionID; */
 /* hal_version			VersionID; */
 
 /*  Get element */
diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index 8213dcf48b34..d8d03752dc2e 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -72,13 +72,9 @@
 #define REG_MULTI_FUNC_CTRL			0x0068 /*  RTL8723 WIFI/BT/GPS Multi-Function control source. */
 #define REG_GSSR						0x006c
 #define REG_AFE_XTAL_CTRL_EXT			0x0078 /* RTL8188E */
-#define REG_XCK_OUT_CTRL				0x007c /* RTL8188E */
 #define REG_MCUFWDL					0x0080
-#define REG_WOL_EVENT					0x0081 /* RTL8188E */
 #define REG_MCUTSTCFG					0x0084
 #define REG_FDHM0						0x0088
-#define REG_HOST_SUSP_CNT				0x00BC	/*  RTL8192C Host suspend counter on FPGA platform */
-#define REG_SYSTEM_ON_CTRL			0x00CC	/*  For 8723AE Reset after S3 */
 #define REG_EFUSE_ACCESS				0x00CF	/*  Efuse access protection for RTL8723 */
 #define REG_BIST_SCAN					0x00D0
 #define REG_BIST_RPT					0x00D4
@@ -117,7 +113,6 @@
 #define REG_FWIMR						0x0130
 #define REG_FWISR						0x0134
 #define REG_FTIMR						0x0138
-#define REG_FTISR						0x013C /* RTL8192C */
 #define REG_PKTBUF_DBG_CTRL			0x0140
 #define REG_RXPKTBUF_CTRL				(REG_PKTBUF_DBG_CTRL+2)
 #define REG_PKTBUF_DBG_DATA_L			0x0144
@@ -132,11 +127,9 @@
 #define REG_MBIST_START				0x0174
 #define REG_MBIST_DONE					0x0178
 #define REG_MBIST_FAIL					0x017C
-#define REG_32K_CTRL					0x0194 /* RTL8188E */
 #define REG_C2HEVT_MSG_NORMAL		0x01A0
 #define REG_C2HEVT_CLEAR				0x01AF
 #define REG_MCUTST_1					0x01c0
-#define REG_MCUTST_WOWLAN			0x01C7	/*  Defined after 8188E series. */
 #define REG_FMETHR						0x01C8
 #define REG_HMETFR						0x01CC
 #define REG_HMEBOX_0					0x01D0
@@ -525,44 +518,6 @@
 #define MAX_MSS_DENSITY_2T			0x13
 #define MAX_MSS_DENSITY_1T			0x0A
 
-/*  */
-/*        8192C Cmd9346CR bits					(Offset 0xA, 16bit) */
-/*  */
-#define CmdEEPROM_En				BIT5	 /*  EEPROM enable when set 1 */
-#define CmdEERPOMSEL				BIT4	/*  System EEPROM select, 0: boot from E-FUSE, 1: The EEPROM used is 9346 */
-#define Cmd9346CR_9356SEL			BIT4
-
-/*  */
-/*        8192C GPIO MUX Configuration Register (offset 0x40, 4 byte) */
-/*  */
-#define GPIOSEL_GPIO				0
-#define GPIOSEL_ENBT				BIT5
-
-/*  */
-/*        8192C GPIO PIN Control Register (offset 0x44, 4 byte) */
-/*  */
-#define GPIO_IN					REG_GPIO_PIN_CTRL		/*  GPIO pins input value */
-#define GPIO_OUT				(REG_GPIO_PIN_CTRL+1)	/*  GPIO pins output value */
-#define GPIO_IO_SEL				(REG_GPIO_PIN_CTRL+2)	/*  GPIO pins output enable when a bit is set to "1"; otherwise, input is configured. */
-#define GPIO_MOD				(REG_GPIO_PIN_CTRL+3)
-
-/*  */
-/*        8811A GPIO PIN Control Register (offset 0x60, 4 byte) */
-/*  */
-#define GPIO_IN_8811A			REG_GPIO_PIN_CTRL_2		/*  GPIO pins input value */
-#define GPIO_OUT_8811A			(REG_GPIO_PIN_CTRL_2+1)	/*  GPIO pins output value */
-#define GPIO_IO_SEL_8811A		(REG_GPIO_PIN_CTRL_2+2)	/*  GPIO pins output enable when a bit is set to "1"; otherwise, input is configured. */
-#define GPIO_MOD_8811A			(REG_GPIO_PIN_CTRL_2+3)
-
-/*  */
-/*        8723/8188E Host System Interrupt Mask Register (offset 0x58, 32 byte) */
-/*  */
-#define HSIMR_GPIO12_0_INT_EN			BIT0
-#define HSIMR_SPS_OCP_INT_EN			BIT5
-#define HSIMR_RON_INT_EN				BIT6
-#define HSIMR_PDN_INT_EN				BIT7
-#define HSIMR_GPIO9_INT_EN				BIT25
-
 /*  */
 /*        8723/8188E Host System Interrupt Status Register (offset 0x5C, 32 byte) */
 /*  */
@@ -572,22 +527,6 @@
 #define HSISR_PDNINT					BIT7
 #define HSISR_GPIO9_INT					BIT25
 
-/*  */
-/*        8192C (MSR) Media Status Register	(Offset 0x4C, 8 bits) */
-/*  */
-/*
-Network Type
-00: No link
-01: Link in ad hoc network
-10: Link in infrastructure network
-11: AP mode
-Default: 00b.
-*/
-#define MSR_NOLINK				0x00
-#define MSR_ADHOC				0x01
-#define MSR_INFRA				0x02
-#define MSR_AP					0x03
-
 /*  */
 /*        USB INTR CONTENT */
 /*  */
@@ -786,206 +725,6 @@ Default: 00b.
 #define IMR_OCPINT				BIT1
 #define IMR_WLANOFF			BIT0
 
-/*  */
-/*  8723E series PCIE Host IMR/ISR bit */
-/*  */
-/*  IMR DW0 Bit 0-31 */
-#define PHIMR_TIMEOUT2				BIT31
-#define PHIMR_TIMEOUT1				BIT30
-#define PHIMR_PSTIMEOUT			BIT29
-#define PHIMR_GTINT4				BIT28
-#define PHIMR_GTINT3				BIT27
-#define PHIMR_TXBCNERR				BIT26
-#define PHIMR_TXBCNOK				BIT25
-#define PHIMR_TSF_BIT32_TOGGLE	BIT24
-#define PHIMR_BCNDMAINT3			BIT23
-#define PHIMR_BCNDMAINT2			BIT22
-#define PHIMR_BCNDMAINT1			BIT21
-#define PHIMR_BCNDMAINT0			BIT20
-#define PHIMR_BCNDOK3				BIT19
-#define PHIMR_BCNDOK2				BIT18
-#define PHIMR_BCNDOK1				BIT17
-#define PHIMR_BCNDOK0				BIT16
-#define PHIMR_HSISR_IND_ON			BIT15
-#define PHIMR_BCNDMAINT_E			BIT14
-#define PHIMR_ATIMEND_E			BIT13
-#define PHIMR_ATIM_CTW_END		BIT12
-#define PHIMR_HISRE_IND			BIT11	/*  RO. HISRE Indicator (HISRE & HIMRE is true, this bit is set to 1) */
-#define PHIMR_C2HCMD				BIT10
-#define PHIMR_CPWM2				BIT9
-#define PHIMR_CPWM					BIT8
-#define PHIMR_HIGHDOK				BIT7		/*  High Queue DMA OK Interrupt */
-#define PHIMR_MGNTDOK				BIT6		/*  Management Queue DMA OK Interrupt */
-#define PHIMR_BKDOK					BIT5		/*  AC_BK DMA OK Interrupt */
-#define PHIMR_BEDOK					BIT4		/*  AC_BE DMA OK Interrupt */
-#define PHIMR_VIDOK					BIT3		/*  AC_VI DMA OK Interrupt */
-#define PHIMR_VODOK				BIT2		/*  AC_VO DMA Interrupt */
-#define PHIMR_RDU					BIT1		/*  Receive Descriptor Unavailable */
-#define PHIMR_ROK					BIT0		/*  Receive DMA OK Interrupt */
-
-/*  PCIE Host Interrupt Status Extension bit */
-#define PHIMR_BCNDMAINT7			BIT23
-#define PHIMR_BCNDMAINT6			BIT22
-#define PHIMR_BCNDMAINT5			BIT21
-#define PHIMR_BCNDMAINT4			BIT20
-#define PHIMR_BCNDOK7				BIT19
-#define PHIMR_BCNDOK6				BIT18
-#define PHIMR_BCNDOK5				BIT17
-#define PHIMR_BCNDOK4				BIT16
-/*  bit12 15: RSVD */
-#define PHIMR_TXERR					BIT11
-#define PHIMR_RXERR					BIT10
-#define PHIMR_TXFOVW				BIT9
-#define PHIMR_RXFOVW				BIT8
-/*  bit2-7: RSVD */
-#define PHIMR_OCPINT				BIT1
-/*  bit0: RSVD */
-
-#define UHIMR_TIMEOUT2				BIT31
-#define UHIMR_TIMEOUT1				BIT30
-#define UHIMR_PSTIMEOUT			BIT29
-#define UHIMR_GTINT4				BIT28
-#define UHIMR_GTINT3				BIT27
-#define UHIMR_TXBCNERR				BIT26
-#define UHIMR_TXBCNOK				BIT25
-#define UHIMR_TSF_BIT32_TOGGLE	BIT24
-#define UHIMR_BCNDMAINT3			BIT23
-#define UHIMR_BCNDMAINT2			BIT22
-#define UHIMR_BCNDMAINT1			BIT21
-#define UHIMR_BCNDMAINT0			BIT20
-#define UHIMR_BCNDOK3				BIT19
-#define UHIMR_BCNDOK2				BIT18
-#define UHIMR_BCNDOK1				BIT17
-#define UHIMR_BCNDOK0				BIT16
-#define UHIMR_HSISR_IND			BIT15
-#define UHIMR_BCNDMAINT_E			BIT14
-/* RSVD	BIT13 */
-#define UHIMR_CTW_END				BIT12
-/* RSVD	BIT11 */
-#define UHIMR_C2HCMD				BIT10
-#define UHIMR_CPWM2				BIT9
-#define UHIMR_CPWM					BIT8
-#define UHIMR_HIGHDOK				BIT7		/*  High Queue DMA OK Interrupt */
-#define UHIMR_MGNTDOK				BIT6		/*  Management Queue DMA OK Interrupt */
-#define UHIMR_BKDOK				BIT5		/*  AC_BK DMA OK Interrupt */
-#define UHIMR_BEDOK				BIT4		/*  AC_BE DMA OK Interrupt */
-#define UHIMR_VIDOK					BIT3		/*  AC_VI DMA OK Interrupt */
-#define UHIMR_VODOK				BIT2		/*  AC_VO DMA Interrupt */
-#define UHIMR_RDU					BIT1		/*  Receive Descriptor Unavailable */
-#define UHIMR_ROK					BIT0		/*  Receive DMA OK Interrupt */
-
-/*  USB Host Interrupt Status Extension bit */
-#define UHIMR_BCNDMAINT7			BIT23
-#define UHIMR_BCNDMAINT6			BIT22
-#define UHIMR_BCNDMAINT5			BIT21
-#define UHIMR_BCNDMAINT4			BIT20
-#define UHIMR_BCNDOK7				BIT19
-#define UHIMR_BCNDOK6				BIT18
-#define UHIMR_BCNDOK5				BIT17
-#define UHIMR_BCNDOK4				BIT16
-/*  bit14-15: RSVD */
-#define UHIMR_ATIMEND_E			BIT13
-#define UHIMR_ATIMEND				BIT12
-#define UHIMR_TXERR					BIT11
-#define UHIMR_RXERR					BIT10
-#define UHIMR_TXFOVW				BIT9
-#define UHIMR_RXFOVW				BIT8
-/*  bit2-7: RSVD */
-#define UHIMR_OCPINT				BIT1
-/*  bit0: RSVD */
-
-
-#define HAL_NIC_UNPLUG_ISR			0xFFFFFFFF	/*  The value when the NIC is unplugged for PCI. */
-#define HAL_NIC_UNPLUG_PCI_ISR		0xEAEAEAEA	/*  The value when the NIC is unplugged for PCI in PCI interrupt (page 3). */
-
-/*  */
-/*        8188 IMR/ISR bits */
-/*  */
-#define IMR_DISABLED_88E			0x0
-/*  IMR DW0(0x0060-0063) Bit 0-31 */
-#define IMR_TXCCK_88E				BIT30		/*  TXRPT interrupt when CCX bit of the packet is set */
-#define IMR_PSTIMEOUT_88E			BIT29		/*  Power Save Time Out Interrupt */
-#define IMR_GTINT4_88E				BIT28		/*  When GTIMER4 expires, this bit is set to 1 */
-#define IMR_GTINT3_88E				BIT27		/*  When GTIMER3 expires, this bit is set to 1 */
-#define IMR_TBDER_88E				BIT26		/*  Transmit Beacon0 Error */
-#define IMR_TBDOK_88E				BIT25		/*  Transmit Beacon0 OK */
-#define IMR_TSF_BIT32_TOGGLE_88E	BIT24		/*  TSF Timer BIT32 toggle indication interrupt */
-#define IMR_BCNDMAINT0_88E		BIT20		/*  Beacon DMA Interrupt 0 */
-#define IMR_BCNDERR0_88E			BIT16		/*  Beacon Queue DMA Error 0 */
-#define IMR_HSISR_IND_ON_INT_88E	BIT15		/*  HSISR Indicator (HSIMR & HSISR is true, this bit is set to 1) */
-#define IMR_BCNDMAINT_E_88E		BIT14		/*  Beacon DMA Interrupt Extension for Win7 */
-#define IMR_ATIMEND_88E			BIT12		/*  CTWidnow End or ATIM Window End */
-#define IMR_HISR1_IND_INT_88E		BIT11		/*  HISR1 Indicator (HISR1 & HIMR1 is true, this bit is set to 1) */
-#define IMR_C2HCMD_88E				BIT10		/*  CPU to Host Command INT Status, Write 1 clear */
-#define IMR_CPWM2_88E				BIT9			/*  CPU power Mode exchange INT Status, Write 1 clear */
-#define IMR_CPWM_88E				BIT8			/*  CPU power Mode exchange INT Status, Write 1 clear */
-#define IMR_HIGHDOK_88E			BIT7			/*  High Queue DMA OK */
-#define IMR_MGNTDOK_88E			BIT6			/*  Management Queue DMA OK */
-#define IMR_BKDOK_88E				BIT5			/*  AC_BK DMA OK */
-#define IMR_BEDOK_88E				BIT4			/*  AC_BE DMA OK */
-#define IMR_VIDOK_88E				BIT3			/*  AC_VI DMA OK */
-#define IMR_VODOK_88E				BIT2			/*  AC_VO DMA OK */
-#define IMR_RDU_88E					BIT1			/*  Rx Descriptor Unavailable */
-#define IMR_ROK_88E					BIT0			/*  Receive DMA OK */
-
-/*  IMR DW1(0x00B4-00B7) Bit 0-31 */
-#define IMR_BCNDMAINT7_88E		BIT27		/*  Beacon DMA Interrupt 7 */
-#define IMR_BCNDMAINT6_88E		BIT26		/*  Beacon DMA Interrupt 6 */
-#define IMR_BCNDMAINT5_88E		BIT25		/*  Beacon DMA Interrupt 5 */
-#define IMR_BCNDMAINT4_88E		BIT24		/*  Beacon DMA Interrupt 4 */
-#define IMR_BCNDMAINT3_88E		BIT23		/*  Beacon DMA Interrupt 3 */
-#define IMR_BCNDMAINT2_88E		BIT22		/*  Beacon DMA Interrupt 2 */
-#define IMR_BCNDMAINT1_88E		BIT21		/*  Beacon DMA Interrupt 1 */
-#define IMR_BCNDOK7_88E			BIT20		/*  Beacon Queue DMA OK Interrupt 7 */
-#define IMR_BCNDOK6_88E			BIT19		/*  Beacon Queue DMA OK Interrupt 6 */
-#define IMR_BCNDOK5_88E			BIT18		/*  Beacon Queue DMA OK Interrupt 5 */
-#define IMR_BCNDOK4_88E			BIT17		/*  Beacon Queue DMA OK Interrupt 4 */
-#define IMR_BCNDOK3_88E			BIT16		/*  Beacon Queue DMA OK Interrupt 3 */
-#define IMR_BCNDOK2_88E			BIT15		/*  Beacon Queue DMA OK Interrupt 2 */
-#define IMR_BCNDOK1_88E			BIT14		/*  Beacon Queue DMA OK Interrupt 1 */
-#define IMR_ATIMEND_E_88E			BIT13		/*  ATIM Window End Extension for Win7 */
-#define IMR_TXERR_88E				BIT11		/*  Tx Error Flag Interrupt Status, write 1 clear. */
-#define IMR_RXERR_88E				BIT10		/*  Rx Error Flag INT Status, Write 1 clear */
-#define IMR_TXFOVW_88E				BIT9			/*  Transmit FIFO Overflow */
-#define IMR_RXFOVW_88E				BIT8			/*  Receive FIFO Overflow */
-
-/*===================================================================
-=====================================================================
-Here the register defines are for 92C. When the define is as same with 92C,
-we will use the 92C's define for the consistency
-So the following defines for 92C is not entire!!!!!!
-=====================================================================
-=====================================================================*/
-/*
-Based on Datasheet V33---090401
-Register Summary
-Current IOREG MAP
-0x0000h ~ 0x00FFh   System Configuration (256 Bytes)
-0x0100h ~ 0x01FFh   MACTOP General Configuration (256 Bytes)
-0x0200h ~ 0x027Fh   TXDMA Configuration (128 Bytes)
-0x0280h ~ 0x02FFh   RXDMA Configuration (128 Bytes)
-0x0300h ~ 0x03FFh   PCIE EMAC Reserved Region (256 Bytes)
-0x0400h ~ 0x04FFh   Protocol Configuration (256 Bytes)
-0x0500h ~ 0x05FFh   EDCA Configuration (256 Bytes)
-0x0600h ~ 0x07FFh   WMAC Configuration (512 Bytes)
-0x2000h ~ 0x3FFFh   8051 FW Download Region (8196 Bytes)
-*/
-	/*  */
-	/* 		 8192C (TXPAUSE) transmission pause	(Offset 0x522, 8 bits) */
-	/*  */
-/*  Note: */
-/* 	The  bits of stopping AC(VO/VI/BE/BK) queue in datasheet RTL8192S/RTL8192C are wrong, */
-/* 	the correct arrangement is VO - Bit0, VI - Bit1, BE - Bit2, and BK - Bit3. */
-/* 	8723 and 88E may be not correct either in the earlier version. Confirmed with DD Tim. */
-/*  By Bruce, 2011-09-22. */
-#define StopBecon		BIT6
-#define StopHigh			BIT5
-#define StopMgt			BIT4
-#define StopBK			BIT3
-#define StopBE			BIT2
-#define StopVI			BIT1
-#define StopVO			BIT0
-
 /*  */
 /*        8192C (RCR) Receive Configuration Register	(Offset 0x608, 32 bits) */
 /*  */
@@ -1557,10 +1296,6 @@ Current IOREG MAP
 #define SDIO_HIMR_ATIMEND_E_MSK		BIT26
 #define SDIO_HIMR_CTWEND_MSK			BIT27
 
-/* RTL8188E SDIO Specific */
-#define SDIO_HIMR_MCU_ERR_MSK			BIT28
-#define SDIO_HIMR_TSF_BIT32_TOGGLE_MSK		BIT29
-
 /*  SDIO Host Interrupt Service Routine */
 #define SDIO_HISR_RX_REQUEST			BIT0
 #define SDIO_HISR_AVAL					BIT1
@@ -1583,10 +1318,6 @@ Current IOREG MAP
 #define SDIO_HISR_ATIMEND_E			BIT26
 #define SDIO_HISR_CTWEND				BIT27
 
-/* RTL8188E SDIO Specific */
-#define SDIO_HISR_MCU_ERR				BIT28
-#define SDIO_HISR_TSF_BIT32_TOGGLE	BIT29
-
 #define MASK_SDIO_HISR_CLEAR		(SDIO_HISR_TXERR |\
 									SDIO_HISR_RXERR |\
 									SDIO_HISR_TXFOVW |\
@@ -1651,39 +1382,13 @@ Current IOREG MAP
 #define GPS_HWPDN_SL			BIT21	/*  GPS HW PDn polarity control */
 #define GPS_FUNC_EN			BIT22	/*  GPS function enable */
 
-/* 3 REG_LIFECTRL_CTRL */
-#define HAL92C_EN_PKT_LIFE_TIME_BK		BIT3
-#define HAL92C_EN_PKT_LIFE_TIME_BE		BIT2
-#define HAL92C_EN_PKT_LIFE_TIME_VI		BIT1
-#define HAL92C_EN_PKT_LIFE_TIME_VO		BIT0
-
-#define HAL92C_MSDU_LIFE_TIME_UNIT		128	/*  in us, said by Tim. */
-
-/* 2 8192D PartNo. */
-#define PARTNO_92D_NIC							(BIT7|BIT6)
-#define PARTNO_92D_NIC_REMARK				(BIT5|BIT4)
-#define PARTNO_SINGLE_BAND_VS				BIT3
-#define PARTNO_SINGLE_BAND_VS_REMARK		BIT1
-#define PARTNO_CONCURRENT_BAND_VC			(BIT3|BIT2)
-#define PARTNO_CONCURRENT_BAND_VC_REMARK	(BIT1|BIT0)
-
 /*  */
 /*  General definitions */
 /*  */
 
-#define LAST_ENTRY_OF_TX_PKT_BUFFER_8188E		176
-#define LAST_ENTRY_OF_TX_PKT_BUFFER_8812			255
 #define LAST_ENTRY_OF_TX_PKT_BUFFER_8723B		255
-#define LAST_ENTRY_OF_TX_PKT_BUFFER_8192C		255
-#define LAST_ENTRY_OF_TX_PKT_BUFFER_DUAL_MAC	127
 
 #define POLLING_LLT_THRESHOLD				20
 #define POLLING_READY_TIMEOUT_COUNT		1000
 
-
-/*  GPIO BIT */
-#define	HAL_8192C_HW_GPIO_WPS_BIT	BIT2
-#define	HAL_8192EU_HW_GPIO_WPS_BIT	BIT7
-#define	HAL_8188E_HW_GPIO_WPS_BIT	BIT7
-
 #endif /* __HAL_COMMON_H__ */
-- 
2.30.2

