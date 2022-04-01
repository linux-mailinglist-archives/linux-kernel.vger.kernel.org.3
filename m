Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001AF4EEA45
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344451AbiDAJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiDAJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:22:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD774D9F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:20:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so2093166pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 02:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LFtUg3u3VYdeZvhiRcY/z/2bhIMWBKnFZ2t7REW/PJQ=;
        b=cxpFnMw3NC61aI5DsFBlOxMIowepnNZSC+8Eowc1Pkk1GfBW+YiIJTPkEyzves3C/K
         krOXe3SrEIADx3RSw3RJIAmRVDEs1HCfYu8P60lZ7lpEBdBAuu8KlnhQ3KybYiO257OQ
         L5T8NfC+FPxJbX3t6piZfIwMzpAb1FJ+kGJ0OWWfIEu7fMAUS4FhbxqbsKfgGPSZ0cfv
         UBeT4qnl1Byvq43I/nnDDtWQQcOSZ5U0lAwjVb+k5XO4bZ87NzeTuq5GYwykM++u6DCW
         TfcjsuvOb4pNyYN5BbVs7a/+YTBd2RcU81AnMXXjiANAxBrOFX+BzBuoPUrea7aKUyEb
         iB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LFtUg3u3VYdeZvhiRcY/z/2bhIMWBKnFZ2t7REW/PJQ=;
        b=7m+d1Z5bf6EDGuz8QfmIh6mlB3MZKk9Cb7vPJfHPVLAYgQZRikexPjKURkX+ny7qB0
         FTGvlZxRKhudpvCMLJNlPHb7tDrRlIFES76BnyzTKw9H+0Np3Gx4iLN1CRStF7fENLgy
         sXr6DHxUVZ6/a+cjMwDNCsYPR40REkh2rG6HOZrZbHU8o+LwSp0mnXkuBM0xFMHKhW3J
         HNnDIfrkgDA2ACH01pFDH2htACJvS91b6Sh8K3OqHvtdp2u3JeuQ2FNkxvnoP0vrxa1f
         Ce/HrTFc3AoEn3YGrPPNffqNW4aA80oYyrU2HaEcWhnG+23kg8cyVCdNAeQRI7oWQ4fu
         jwIg==
X-Gm-Message-State: AOAM532UbjUG81YcczbpUgphCWiJLYqbq1woORlDDHLAyEP5HKhO2Cud
        HBpb3mfbSKDZUdYzbNcYGsY=
X-Google-Smtp-Source: ABdhPJz+FmGqvLNqAEExf5O2J1IIBq3yy6UIfnGEYiZZjX9lFCv5CPjNJC38VYcUdM8w7I73rhq7Nw==
X-Received: by 2002:a05:6a00:a8b:b0:4cd:6030:4df3 with SMTP id b11-20020a056a000a8b00b004cd60304df3mr9995453pfl.40.1648804822690;
        Fri, 01 Apr 2022 02:20:22 -0700 (PDT)
Received: from ubuntu-vm.jnpr.net ([116.197.184.14])
        by smtp.gmail.com with ESMTPSA id j6-20020a63b606000000b003808b0ea96fsm1760301pgf.66.2022.04.01.02.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 02:20:22 -0700 (PDT)
From:   Sathish Kumar <skumark1902@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Sathish Kumar <skumark1902@gmail.com>
Subject: [PATCH] staging: rtl8712: Fix multiple blank lines warning
Date:   Fri,  1 Apr 2022 14:50:07 +0530
Message-Id: <20220401092007.6653-1-skumark1902@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warnings like:
CHECK: Please don't use multiple blank lines
+
+

Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h    | 1 -
 drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h | 3 ---
 drivers/staging/rtl8712/rtl8712_macsetting_regdef.h | 2 --
 drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h   | 1 -
 drivers/staging/rtl8712/rtl8712_security_bitdef.h   | 1 -
 drivers/staging/rtl8712/rtl8712_spec.h              | 3 ---
 drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h     | 4 ----
 drivers/staging/rtl8712/rtl8712_syscfg_regdef.h     | 2 --
 drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h   | 1 -
 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h       | 1 -
 drivers/staging/rtl8712/rtl871x_cmd.h               | 2 --
 drivers/staging/rtl8712/rtl871x_ioctl.h             | 1 -
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h          | 1 -
 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h     | 3 ---
 drivers/staging/rtl8712/sta_info.h                  | 1 -
 drivers/staging/rtl8712/wifi.h                      | 1 -
 16 files changed, 28 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
index e125c7222ab5..68bdec07f51e 100644
--- a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
@@ -91,6 +91,5 @@
 #define	_BCNSPACE_MSK			0x0FFF
 #define	_BCNSPACE_SHT			0
 
-
 #endif /* __RTL8712_CMDCTRL_BITDEF_H__*/
 
diff --git a/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h b/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
index 3d9f40fa8469..46d758d3f3a4 100644
--- a/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
@@ -7,7 +7,6 @@
 #ifndef __RTL8712_MACSETTING_BITDEF_H__
 #define __RTL8712_MACSETTING_BITDEF_H__
 
-
 /*MACID*/
 /*BSSID*/
 
@@ -28,7 +27,5 @@
 
 /*BUILDUSER*/
 
-
-
 #endif /* __RTL8712_MACSETTING_BITDEF_H__*/
 
diff --git a/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h b/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
index e8cb2eee9294..64740d99c252 100644
--- a/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
@@ -16,7 +16,5 @@
 #define BUILDTIME			(RTL8712_MACIDSETTING_ + 0x0024)
 #define BUILDUSER			(RTL8712_MACIDSETTING_ + 0x0028)
 
-
-
 #endif /*__RTL8712_MACSETTING_REGDEF_H__*/
 
diff --git a/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h b/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
index a3eaee0e1b69..9ed5653f3f7f 100644
--- a/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
@@ -39,6 +39,5 @@
 #define MCS_TXAGC7			(RTL8712_RATECTRL_ + 0x67)
 #define CCK_TXAGC			(RTL8712_RATECTRL_ + 0x68)
 
-
 #endif	/*__RTL8712_RATECTRL_REGDEF_H__*/
 
diff --git a/drivers/staging/rtl8712/rtl8712_security_bitdef.h b/drivers/staging/rtl8712/rtl8712_security_bitdef.h
index 1c26a7eca64a..44275ef455a0 100644
--- a/drivers/staging/rtl8712/rtl8712_security_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_security_bitdef.h
@@ -30,6 +30,5 @@
 #define	_RXUSEDK					BIT(1)
 #define	_TXUSEDK					BIT(0)
 
-
 #endif	/*__RTL8712_SECURITY_BITDEF_H__*/
 
diff --git a/drivers/staging/rtl8712/rtl8712_spec.h b/drivers/staging/rtl8712/rtl8712_spec.h
index c0bab4c49ae9..613a410e5714 100644
--- a/drivers/staging/rtl8712/rtl8712_spec.h
+++ b/drivers/staging/rtl8712/rtl8712_spec.h
@@ -30,7 +30,6 @@
 
 #define RTL8712_IOBASE_FF	0x10300000 /*IOBASE_FIFO 0x1031000~0x103AFFFF*/
 
-
 /*IOREG Offset for 8712*/
 #define RTL8712_SYSCFG_		RTL8712_IOBASE_IOREG
 #define RTL8712_CMDCTRL_	(RTL8712_IOBASE_IOREG + 0x40)
@@ -47,7 +46,6 @@
 #define RTL8712_DEBUGCTRL_	(RTL8712_IOBASE_IOREG + 0x310)
 #define RTL8712_OFFLOAD_	(RTL8712_IOBASE_IOREG + 0x2D0)
 
-
 /*FIFO for 8712*/
 #define RTL8712_DMA_BCNQ	(RTL8712_IOBASE_FF + 0x10000)
 #define RTL8712_DMA_MGTQ	(RTL8712_IOBASE_FF + 0x20000)
@@ -60,7 +58,6 @@
 #define RTL8712_DMA_H2CCMD	(RTL8712_IOBASE_FF + 0x90000)
 #define RTL8712_DMA_C2HCMD	(RTL8712_IOBASE_FF + 0xA0000)
 
-
 /*------------------------------*/
 
 /*BIT 16 15*/
diff --git a/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h b/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
index a328ca9b340c..d92df3fbd2b1 100644
--- a/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
@@ -117,20 +117,17 @@
 						       * Block's Bandgap.
 						       */
 
-
 /*--------------------------------------------------------------------------*/
 /*       SPS1_CTRL bits				(Offset 0x18-1E, 56bits)*/
 /*--------------------------------------------------------------------------*/
 #define	SPS1_SWEN		BIT(1)	/* Enable vsps18 SW Macro Block.*/
 #define	SPS1_LDEN		BIT(0)	/* Enable VSPS12 LDO Macro block.*/
 
-
 /*----------------------------------------------------------------------------*/
 /*       LDOA15_CTRL bits		(Offset 0x20, 8bits)*/
 /*----------------------------------------------------------------------------*/
 #define	LDA15_EN		BIT(0)	/* Enable LDOA15 Macro Block*/
 
-
 /*----------------------------------------------------------------------------*/
 /*       8192S LDOV12D_CTRL bit		(Offset 0x21, 8bits)*/
 /*----------------------------------------------------------------------------*/
@@ -140,7 +137,6 @@
 /*CLK_PS_CTRL*/
 #define	_CLK_GATE_EN		BIT(0)
 
-
 /* EFUSE_CTRL*/
 #define EF_FLAG			BIT(31)		/* Access Flag, Write:1;
 						 *	        Read:0
diff --git a/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h b/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
index e95eb5832ec4..da5efcdedabe 100644
--- a/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
@@ -14,7 +14,6 @@
 #ifndef __RTL8712_SYSCFG_REGDEF_H__
 #define __RTL8712_SYSCFG_REGDEF_H__
 
-
 #define SYS_ISO_CTRL		(RTL8712_SYSCFG_ + 0x0000)
 #define SYS_FUNC_EN		(RTL8712_SYSCFG_ + 0x0002)
 #define PMC_FSM			(RTL8712_SYSCFG_ + 0x0004)
@@ -39,6 +38,5 @@
 #define RCLK_MON		(RTL8712_SYSCFG_ + 0x003E)
 #define EFUSE_CLK_CTRL		(RTL8712_SYSCFG_ + 0x02F8)
 
-
 #endif /*__RTL8712_SYSCFG_REGDEF_H__*/
 
diff --git a/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
index 1af5f1dd3c20..d7bc9dd5cecd 100644
--- a/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
@@ -45,6 +45,5 @@
 /*BCNERRTH*/
 /*MLT*/
 
-
 #endif /* __RTL8712_TIMECTRL_BITDEF_H__*/
 
diff --git a/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h b/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
index d3b45c6cd855..ea164e482347 100644
--- a/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
@@ -45,6 +45,5 @@
 #define	_RPT_CNT_MSK			0x000FFFFF
 #define	_RPT_CNT_SHT			0
 
-
 #endif	/*__RTL8712_WMAC_BITDEF_H__*/
 
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 95e9ea5b2d98..c7b43a8cd53f 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -316,7 +316,6 @@ enum _RT_CHANNEL_DOMAIN {
 	RT_CHANNEL_DOMAIN_MAX,
 };
 
-
 struct SetChannelPlan_param {
 	enum _RT_CHANNEL_DOMAIN ChannelPlan;
 };
@@ -338,7 +337,6 @@ struct getdatarate_rsp {
 	u8 datarates[NumRates];
 };
 
-
 /*
  *	Caller Mode: Any
  *	AP: AP can use the info for the contents of beacon frame
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl.h b/drivers/staging/rtl8712/rtl871x_ioctl.h
index 634e67461712..d6332a8c7f4f 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl.h
+++ b/drivers/staging/rtl8712/rtl871x_ioctl.h
@@ -13,7 +13,6 @@
 	#define OID_802_11_PMKID                        0x0d010123
 #endif
 
-
 /* For DDK-defined OIDs*/
 #define OID_NDIS_SEG1	0x00010100
 #define OID_NDIS_SEG2	0x00010200
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h b/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
index 98204493a04c..aa4d5ce471f2 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
@@ -148,7 +148,6 @@ extern struct oid_obj_priv oid_rtl_seg_87_12_00[32];
 
 #endif /* _RTL871X_MP_IOCTL_C_ */
 
-
 enum MP_MODE {
 	MP_START_MODE,
 	MP_STOP_MODE,
diff --git a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h b/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
index ca5072e11e22..a08c5d2f59e3 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
+++ b/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
@@ -26,7 +26,6 @@
 #ifndef __RTL871X_MP_PHY_REGDEF_H
 #define __RTL871X_MP_PHY_REGDEF_H
 
-
 /*--------------------------Define Parameters-------------------------------*/
 
 /*============================================================
@@ -1008,7 +1007,6 @@
 #define	ANTENNA_C	0x4
 #define	ANTENNA_D	0x8
 
-
 /* accept all physical address */
 #define RCR_AAP		BIT(0)
 #define RCR_APM		BIT(1)		/* accept physical match */
@@ -1032,6 +1030,5 @@
 
 /*--------------------------Define Parameters-------------------------------*/
 
-
 #endif	/*__INC_HAL8192SPHYREG_H */
 
diff --git a/drivers/staging/rtl8712/sta_info.h b/drivers/staging/rtl8712/sta_info.h
index 9b7e5ffa380d..6286c622475e 100644
--- a/drivers/staging/rtl8712/sta_info.h
+++ b/drivers/staging/rtl8712/sta_info.h
@@ -21,7 +21,6 @@
 #define NUM_STA 32
 #define NUM_ACL 64
 
-
 /* if mode ==0, then the sta is allowed once the addr is hit.
  * if mode ==1, then the sta is rejected once the addr is non-hit.
  */
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index b8acb9c7395d..498e6dec7e67 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -186,7 +186,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 #define _CAPABILITY_			2
 #define _TIMESTAMP_				8
 
-
 /*-----------------------------------------------------------------------------
  *			Below is the definition for WMM
  *------------------------------------------------------------------------------
-- 
2.17.1

