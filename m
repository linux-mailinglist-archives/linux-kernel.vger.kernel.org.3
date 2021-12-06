Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231DD469248
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbhLFJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhLFJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:27:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4C6C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 01:23:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y12so39886006eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 01:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2gHMMGGS+tglxRv4LxIuECYeTyvsGkAyR2dtBkBQhg=;
        b=ctU96csHNohh3JdhlDhAofSoAsM4c+ljkrB0C93cKAzryFC6rSPVIQb6fgcDZIVLH8
         lmUphfDMBSJ6KswOl7Pmnq+MYfqaJ9Kp16uOvNBQntcrbSqPWu0ysZdmNBKwZ2yqOGot
         XUfigDQsIS6baj7QT8vqyp4flh9t2YSXM8qa+AJV6NGwYABYTfm4olylF+J/4Gp+ecHD
         Xp6yh4I1yY8Iu9jgTKLCqVUM+YHgi5HjsO12jLei4PGHjcshYYyRrmlDcDT5kia/pFam
         Tg1wZBAsOF0ZS+oUMdsGOJIkfQAhHngTME5/ENSpQlZbTZzQQHdrfWHyCCFYb+7N4Wrp
         Ui2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2gHMMGGS+tglxRv4LxIuECYeTyvsGkAyR2dtBkBQhg=;
        b=Uby64svQyd+ZK3bVoUSTeFMcgA5pDsmNYloCjM4yc8jD++0SblCR9DoWMmicXVgzbt
         vI/8ciVq0nTN0sqibH1sELZbSE/aC/pdR+OWnuNDMYWnEPiHAaNUPw8OD5KrgkG6KXqW
         yEOiau6+N8qRqCT8CHWUg/3lDgoWBLErykEwyoEJyEaRRTOw3699V1NJoZRWLKu3mApx
         V3SVs2nh+Od/10W/goIQ+kIf8TIqGLCssiV3GUudn8NlG7VaJ4gV5zSYvr30LDxB9oSf
         nVtbbdGIEiWE33FgvfPv2MMaTOaAE1djz19ydb8Q9gbsYuHTfSNNJHtZswXrcgX27gKF
         GYSA==
X-Gm-Message-State: AOAM531ko+ZiM4ZDTmn2Zt4+cm1M/PFdcjODT5V8z8/Up8ILDaYt4M8F
        0u3sDkxQVJoIlipDuVvaxqjGvx2vaeE=
X-Google-Smtp-Source: ABdhPJx/en8N1HrPN/sgsJRlOtyMEwn7nb+gQmj46pndaqNFmzmtb3oW/eyGxevFGDSWT48ev2olLg==
X-Received: by 2002:a17:906:d187:: with SMTP id c7mr46460002ejz.477.1638782635673;
        Mon, 06 Dec 2021 01:23:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id nd22sm6819877ejc.98.2021.12.06.01.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 01:23:55 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: convert type of HalData in struct adapter
Date:   Mon,  6 Dec 2021 10:22:58 +0100
Message-Id: <20211206092258.3765-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adapter->HalData is used in the GET_HAL_DATA macro all across the
driver code but nobody checks if its allocation in
rtl188eu_alloc_haldata() was successful or not.

To avoid errors when the allocation fails convert the type of field
HalData from void pointer to struct hal_data_8188eu. Remove
GET_HAL_DATA, rtl8188eu_alloc_haldata(), rtl8188e_free_hal_data().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Tested on x86_64 with InterTech DMG-02.

 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 24 ++++----
 drivers/staging/r8188eu/hal/odm.c             |  6 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    | 12 ++--
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 14 ++---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 24 +++-----
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 26 ++++-----
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 12 ++--
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  4 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 58 ++++++++-----------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  4 +-
 drivers/staging/r8188eu/include/drv_types.h   |  4 +-
 drivers/staging/r8188eu/include/hal_intf.h    |  3 -
 .../staging/r8188eu/include/rtl8188e_hal.h    |  6 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 10 +---
 17 files changed, 91 insertions(+), 122 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 701708d01233..9694893fadcc 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -98,7 +98,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	struct adapter *Adapter
 	)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u8 ThermalValue = 0, delta, delta_LCK, delta_IQK, offset;
 	u8 ThermalValue_AVG_count = 0;
 	u32 ThermalValue_AVG = 0;
@@ -365,7 +365,7 @@ phy_PathA_IQK_8188E(struct adapter *adapt)
 {
 	u32 regeac, regE94, regE9C;
 	u8 result = 0x00;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	/* 1 Tx IQK */
@@ -403,7 +403,7 @@ phy_PathA_RxIQK(struct adapter *adapt)
 {
 	u32 regeac, regE94, regE9C, regEA4, u4tmp;
 	u8 result = 0x00;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	/* 1 Get TXIMR setting */
@@ -506,7 +506,7 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 {
 	u32 Oldval_0, X, TX0_A, reg;
 	s32 Y, TX0_C;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	if (final_candidate == 0xFF) {
@@ -549,7 +549,7 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 void _PHY_SaveADDARegisters(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegisterNum)
 {
 	u32 i;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	for (i = 0; i < RegisterNum; i++) {
@@ -574,7 +574,7 @@ static void _PHY_SaveMACRegisters(
 static void reload_adda_reg(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegiesterNum)
 {
 	u32 i;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	for (i = 0; i < RegiesterNum; i++)
@@ -602,7 +602,7 @@ _PHY_PathADDAOn(
 		u32 *ADDAReg)
 {
 	u32 i;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	ODM_SetBBReg(dm_odm, ADDAReg[0], bMaskDWord, 0x0b1b25a0);
@@ -634,7 +634,7 @@ static void _PHY_PIModeSwitch(
 	)
 {
 	u32 mode;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	mode = PIMode ? 0x01000100 : 0x01000000;
@@ -723,7 +723,7 @@ static bool phy_SimularityCompare_8188E(
 
 static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 	u32 i;
 	u8 PathAOK;
@@ -839,7 +839,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 {
 	u8 tmpreg;
 	u32 RF_Amode = 0, RF_Bmode = 0, LC_Cal;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	/* Check continuous TX and Packet TX */
@@ -894,7 +894,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 
 void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 	s32 result[4][8];	/* last is final result */
 	u8 i, final_candidate;
@@ -1006,7 +1006,7 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
 {
 	bool singletone = false, carrier_sup = false;
 	u32 timeout = 2000, timecount = 0;
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *pHalData = &adapt->haldata;
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	if (!(dm_odm->SupportAbility & ODM_RF_CALIBRATION))
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 5629556cca8a..8d126a3a287b 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -789,7 +789,7 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 
 static void FindMinimumRSSI(struct adapter *pAdapter)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+	struct hal_data_8188e *pHalData = &pAdapter->haldata;
 	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
 	struct mlme_priv	*pmlmepriv = &pAdapter->mlmepriv;
 
@@ -804,7 +804,7 @@ static void FindMinimumRSSI(struct adapter *pAdapter)
 void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
 	int	i;
 	int	tmpEntryMaxPWDB = 0, tmpEntryMinPWDB = 0xff;
@@ -928,7 +928,7 @@ void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
 	u64	cur_tx_bytes = 0;
 	u64	cur_rx_bytes = 0;
 	u8	bbtchange = false;
-	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	struct xmit_priv		*pxmitpriv = &Adapter->xmitpriv;
 	struct recv_priv		*precvpriv = &Adapter->recvpriv;
 	struct registry_priv	*pregpriv = &Adapter->registrypriv;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index e44bcde92cc3..ca24e17c369d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -49,7 +49,7 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	u8 h2c_box_num;
 	u32 msgbox_addr;
 	u32 msgbox_ex_addr;
-	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	u8 cmd_idx, ext_cmd_len;
 	u32 h2c_cmd = 0;
 	u32 h2c_cmd_ex = 0;
@@ -104,7 +104,7 @@ u8 rtl8188e_set_raid_cmd(struct adapter *adapt, u32 mask)
 {
 	u8 buf[3];
 	u8 res = _SUCCESS;
-	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 
 	if (haldata->fw_ractrl) {
 		__le32 lmask;
@@ -128,7 +128,7 @@ u8 rtl8188e_set_raid_cmd(struct adapter *adapt, u32 mask)
 /* arg[5] = Short GI */
 void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi_level)
 {
-	struct hal_data_8188e *haldata = GET_HAL_DATA(pAdapter);
+	struct hal_data_8188e *haldata = &pAdapter->haldata;
 
 	u8 macid, raid, short_gi_rate = false;
 
@@ -461,7 +461,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 		return;
 	}
 
-	haldata = GET_HAL_DATA(adapt);
+	haldata = &adapt->haldata;
 	pxmitpriv = &adapt->xmitpriv;
 	pmlmeext = &adapt->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
@@ -547,7 +547,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 
 void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 {
-	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	bool	bSendBeacon = false;
@@ -642,7 +642,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 
 void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state)
 {
-	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	struct wifidirect_info	*pwdinfo = &adapt->wdinfo;
 	struct P2P_PS_Offload_t	*p2p_ps_offload = &haldata->p2p_ps_offload;
 	u8 i;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 75b438e1ce78..f8d2c98b3e35 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -24,7 +24,7 @@ static void dm_InitGPIOSetting(struct adapter *Adapter)
 /*  */
 static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 {
-	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *hal_data = &Adapter->haldata;
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
 	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 
@@ -48,7 +48,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
 	struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
 	struct pwrctrl_priv *pwrctrlpriv = &Adapter->pwrctrlpriv;
-	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *hal_data = &Adapter->haldata;
 	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
 	int i;
@@ -82,7 +82,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 
 void rtl8188e_InitHalDm(struct adapter *Adapter)
 {
-	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *hal_data = &Adapter->haldata;
 	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 
 	dm_InitGPIOSetting(Adapter);
@@ -94,7 +94,7 @@ void rtl8188e_InitHalDm(struct adapter *Adapter)
 void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 {
 	u8 hw_init_completed = Adapter->hw_init_completed;
-	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *hal_data = &Adapter->haldata;
 	struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
 	u8 bLinked = false;
 
@@ -116,7 +116,7 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 
 void rtl8188e_init_dm_priv(struct adapter *Adapter)
 {
-	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *hal_data = &Adapter->haldata;
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
 
 	memset(pdmpriv, 0, sizeof(struct dm_priv));
@@ -127,7 +127,7 @@ void rtl8188e_init_dm_priv(struct adapter *Adapter)
 /*  Compare RSSI for deciding antenna */
 void AntDivCompare8188E(struct adapter *Adapter, struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src)
 {
-	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *hal_data = &Adapter->haldata;
 
 	if (0 != hal_data->AntDivCfg) {
 		/* select optimum_antenna for before linked =>For antenna diversity */
@@ -141,7 +141,7 @@ void AntDivCompare8188E(struct adapter *Adapter, struct wlan_bssid_ex *dst, stru
 /*  Add new function to reset the state of antenna diversity before link. */
 u8 AntDivBeforeLink8188E(struct adapter *Adapter)
 {
-	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *hal_data = &Adapter->haldata;
 	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 	struct sw_ant_switch *dm_swat_tbl = &dm_odm->DM_SWAT_Table;
 	struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 3fbaccbbe775..71b857b0773b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -550,7 +550,7 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	s32	rtStatus = _SUCCESS;
 	u8 writeFW_retry = 0;
 	u32 fwdl_start_time;
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(padapter);
+	struct hal_data_8188e *pHalData = &padapter->haldata;
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 	struct device *device = dvobj_to_dev(dvobj);
 	struct rt_firmware_hdr *pFwHdr = NULL;
@@ -626,7 +626,7 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 
 void rtl8188e_InitializeFirmwareVars(struct adapter *padapter)
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(padapter);
+	struct hal_data_8188e *pHalData = &padapter->haldata;
 
 	/*  Init Fw LPS related. */
 	padapter->pwrctrlpriv.bFwCurrentInPSMode = false;
@@ -635,12 +635,6 @@ void rtl8188e_InitializeFirmwareVars(struct adapter *padapter)
 	pHalData->LastHMEBoxNum = 0;
 }
 
-void rtl8188e_free_hal_data(struct adapter *padapter)
-{
-	kfree(padapter->HalData);
-	padapter->HalData = NULL;
-}
-
 /*  */
 /*			Efuse related code */
 /*  */
@@ -837,9 +831,7 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 {
 	u32				value32;
 	struct HAL_VERSION		ChipVersion;
-	struct hal_data_8188e	*pHalData;
-
-	pHalData = GET_HAL_DATA(padapter);
+	struct hal_data_8188e *pHalData = &padapter->haldata;
 
 	value32 = rtw_read32(padapter, REG_SYS_CFG);
 	ChipVersion.ChipType = ((value32 & RTL_ID) ? TEST_CHIP : NORMAL_CHIP);
@@ -855,7 +847,7 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 
 void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	struct odm_dm_struct *podmpriv = &pHalData->odmpriv;
 	switch (eVariable) {
 	case HAL_ODM_STA_INFO:
@@ -1133,7 +1125,7 @@ void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
 
 void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool AutoLoadFail)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+	struct hal_data_8188e *pHalData = &padapter->haldata;
 	struct txpowerinfo24g pwrInfo24G;
 	u8 rfPath = 0;
 	u8 ch, group;
@@ -1182,7 +1174,7 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 
 void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoadFail)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+	struct hal_data_8188e *pHalData = &pAdapter->haldata;
 
 	if (!AutoLoadFail) {
 		pHalData->CrystalCap = hwinfo[EEPROM_XTAL_88E];
@@ -1207,7 +1199,7 @@ void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool Auto
 
 void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool AutoLoadFail)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+	struct hal_data_8188e *pHalData = &pAdapter->haldata;
 	struct registry_priv	*registry_par = &pAdapter->registrypriv;
 
 	if (!AutoLoadFail) {
@@ -1239,7 +1231,7 @@ void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool
 
 void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool AutoloadFail)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	/*  ThermalMeter from EEPROM */
 	if (!AutoloadFail)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 02fbcf02e95c..faabfd61f5b4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -143,7 +143,7 @@ phy_RFSerialRead(
 	)
 {
 	u32 retValue = 0;
-	struct hal_data_8188e				*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[eRFPath];
 	u32 NewOffset;
 	u32 tmplong, tmplong2;
@@ -242,7 +242,7 @@ phy_RFSerialWrite(
 	)
 {
 	u32 DataAndAddr = 0;
-	struct hal_data_8188e				*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[eRFPath];
 	u32 NewOffset;
 
@@ -355,7 +355,7 @@ rtl8188e_PHY_SetRFReg(
  *---------------------------------------------------------------------------*/
 s32 PHY_MACConfig8188E(struct adapter *Adapter)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	int rtStatus = _SUCCESS;
 
 	/*  */
@@ -387,7 +387,7 @@ phy_InitBBRFRegisterDefinition(
 		struct adapter *Adapter
 )
 {
-	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	/*  RF Interface Sowrtware Control */
 	pHalData->PHYRegDef[RF_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 LSBs if read 32-bit from 0x870 */
@@ -464,7 +464,7 @@ phy_InitBBRFRegisterDefinition(
 
 void storePwrIndexDiffRateOffset(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u32 Data)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	if (RegAddr == rTxAGC_A_Rate18_06)
 		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][0] = Data;
@@ -505,7 +505,7 @@ void storePwrIndexDiffRateOffset(struct adapter *Adapter, u32 RegAddr, u32 BitMa
 static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
 {
 	struct eeprom_priv *pEEPROM = &Adapter->eeprompriv;
-	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	int			rtStatus = _SUCCESS;
 
 	/*  */
@@ -546,7 +546,7 @@ PHY_BBConfig8188E(
 	)
 {
 	int	rtStatus = _SUCCESS;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u32 RegVal;
 	u8 CrystalCap;
 
@@ -585,7 +585,7 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 			       u8 *ofdmPowerLevel, u8 *BW20PowerLevel,
 			       u8 *BW40PowerLevel)
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u8 index = (channel - 1);
 
 	/*  1. CCK */
@@ -603,7 +603,7 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
 				   u8 *ofdmPowerLevel, u8 *BW20PowerLevel, u8 *BW40PowerLevel)
 {
-	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	pHalData->CurrentCckTxPwrIdx = cckPowerLevel[0];
 	pHalData->CurrentOfdm24GTxPwrIdx = ofdmPowerLevel[0];
@@ -667,7 +667,7 @@ _PHY_SetBWMode92C(
 		struct adapter *Adapter
 )
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u8 regBwOpMode;
 	u8 regRRSR_RSC;
 
@@ -742,7 +742,7 @@ _PHY_SetBWMode92C(
 void PHY_SetBWMode8188E(struct adapter *Adapter, enum ht_channel_width Bandwidth,	/*  20M or 40M */
 			unsigned char	Offset)		/*  Upper, Lower, or Don't care */
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	enum ht_channel_width tmpBW = pHalData->CurrentChannelBW;
 
 	pHalData->CurrentChannelBW = Bandwidth;
@@ -759,7 +759,7 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 {
 	u8 eRFPath = 0;
 	u32 param1, param2;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	if (Adapter->bNotifyChannelChange)
 		DBG_88E("[%s] ch = %d\n", __func__, channel);
@@ -777,7 +777,7 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
 {
 	/*  Call after initialization */
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	if (channel == 0)
 		channel = 1;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 69d887da170d..0b982cc7c86f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -46,7 +46,7 @@
 void rtl8188e_PHY_RF6052SetBandwidth(struct adapter *Adapter,
 				     enum ht_channel_width Bandwidth)
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	switch (Bandwidth) {
 	case HT_CHANNEL_WIDTH_20:
@@ -84,7 +84,7 @@ rtl8188e_PHY_RF6052SetCckTxPower(
 		struct adapter *Adapter,
 		u8 *pPowerlevel)
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	struct mlme_ext_priv *pmlmeext = &Adapter->mlmeextpriv;
 	u32 TxAGC[2] = {0, 0}, tmpval = 0, pwrtrac_value;
 	bool TurboScanOff = false;
@@ -166,7 +166,7 @@ rtl8188e_PHY_RF6052SetCckTxPower(
 static void getpowerbase88e(struct adapter *Adapter, u8 *pPowerLevelOFDM,
 			    u8 *pPowerLevelBW20, u8 *pPowerLevelBW40, u8 Channel, u32 *OfdmBase, u32 *MCSBase)
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u32 powerBase0, powerBase1;
 	u8 i;
 
@@ -190,7 +190,7 @@ static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
 				    u8 index, u32 *powerBase0, u32 *powerBase1,
 				    u32 *pOutWriteVal)
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u8	i, chnlGroup = 0, pwr_diff_limit[4], customer_pwr_limit;
 	s8	pwr_diff = 0;
 	u32	writeVal, customer_limit, rf;
@@ -349,7 +349,7 @@ rtl8188e_PHY_RF6052SetOFDMTxPower(
 		u8 *pPowerLevelBW40,
 		u8 Channel)
 {
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u32 writeVal[2], powerBase0[2], powerBase1[2], pwrtrac_value;
 	u8 direction;
 	u8 index = 0;
@@ -379,7 +379,7 @@ rtl8188e_PHY_RF6052SetOFDMTxPower(
 static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 {
 	struct bb_reg_def *pPhyReg;
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *pHalData = &Adapter->haldata;
 	u32 u4RegValue = 0;
 	u8 eRFPath = 0;
 	int rtStatus = _SUCCESS;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 053d9549873d..90d426199f52 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -126,7 +126,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat
 {
 	struct adapter *padapter = precvframe->adapter;
 	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(padapter);
+	struct hal_data_8188e *pHalData = &padapter->haldata;
 	struct phy_info *pPHYInfo  = &pattrib->phy_info;
 	u8 *wlanhdr;
 	struct odm_per_pkt_info	pkt_info;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
index 452d4bb87aba..2d03daa2f135 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
@@ -36,7 +36,7 @@ void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8	LedCfg;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+	struct hal_data_8188e *pHalData = &padapter->haldata;
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		goto exit;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index b7feb4d8c8aa..293541db597d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -154,7 +154,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	u8 data_rate, pwr_status, offset;
 	struct adapter		*adapt = pxmitframe->padapter;
 	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	struct tx_desc	*ptxdesc = (struct tx_desc *)pmem;
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
@@ -382,7 +382,7 @@ static u32 xmitframe_need_length(struct xmit_frame *pxmitframe)
 
 s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	struct xmit_frame *pxmitframe = NULL;
 	struct xmit_frame *pfirstframe = NULL;
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index b8e1b78c74a1..1aac0140ac8d 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -12,6 +12,7 @@
 #include "../include/rtw_iol.h"
 #include "../include/usb_ops.h"
 #include "../include/usb_osintf.h"
+#include "../include/Hal8188EPwrSeq.h"
 
 #define		HAL_MAC_ENABLE	1
 #define		HAL_BB_ENABLE		1
@@ -19,7 +20,7 @@
 
 static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
 {
-	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 
 	switch (NumOutPipe) {
 	case	3:
@@ -49,7 +50,7 @@ static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumOutPi
 
 void rtl8188eu_interface_configure(struct adapter *adapt)
 {
-	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	struct dvobj_priv	*pdvobjpriv = adapter_to_dvobj(adapt);
 
 	if (pdvobjpriv->ishighspeed)
@@ -75,7 +76,7 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 {
 	u16 value16;
 	/*  HW Power on sequence */
-	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	if (haldata->bMacPwrCtrlOn)
 		return _SUCCESS;
 
@@ -130,7 +131,7 @@ static void _InitInterrupt(struct adapter *Adapter)
 
 static void _InitQueueReservedPage(struct adapter *Adapter)
 {
-	struct hal_data_8188e		*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
 	u32 numHQ	= 0;
 	u32 numLQ	= 0;
@@ -198,7 +199,7 @@ static void _InitNormalChipRegPriority(struct adapter *Adapter, u16 beQ,
 
 static void _InitNormalChipOneOutEpPriority(struct adapter *Adapter)
 {
-	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	u16 value = 0;
 	switch (haldata->OutEpQueueSel) {
@@ -220,7 +221,7 @@ static void _InitNormalChipOneOutEpPriority(struct adapter *Adapter)
 
 static void _InitNormalChipTwoOutEpPriority(struct adapter *Adapter)
 {
-	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct registry_priv *pregistrypriv = &Adapter->registrypriv;
 	u16 beQ, bkQ, viQ, voQ, mgtQ, hiQ;
 	u16 valueHi = 0;
@@ -286,7 +287,7 @@ static void _InitNormalChipThreeOutEpPriority(struct adapter *Adapter)
 
 static void _InitQueuePriority(struct adapter *Adapter)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	switch (haldata->OutEpNumber) {
 	case 1:
@@ -330,7 +331,7 @@ static void _InitDriverInfoSize(struct adapter *Adapter, u8 drvInfoSize)
 
 static void _InitWMACSetting(struct adapter *Adapter)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	haldata->ReceiveConfig = RCR_AAP | RCR_APM | RCR_AM | RCR_AB |
 				  RCR_CBSSID_DATA | RCR_CBSSID_BCN |
@@ -422,7 +423,7 @@ static void _InitRetryFunction(struct adapter *Adapter)
  *---------------------------------------------------------------------------*/
 static void usb_AggSettingTxUpdate(struct adapter *Adapter)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 	u32 value32;
 
 	if (Adapter->registrypriv.wifi_spec)
@@ -457,7 +458,7 @@ usb_AggSettingRxUpdate(
 		struct adapter *Adapter
 	)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 	u8 valueDMA;
 	u8 valueUSB;
 
@@ -511,7 +512,7 @@ usb_AggSettingRxUpdate(
 
 static void InitUsbAggregationSetting(struct adapter *Adapter)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	/*  Tx aggregation setting */
 	usb_AggSettingTxUpdate(Adapter);
@@ -529,7 +530,7 @@ static void _InitOperationMode(struct adapter *Adapter)
 
 static void _InitBeaconParameters(struct adapter *Adapter)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	rtw_write16(Adapter, REG_BCN_CTRL, 0x1010);
 
@@ -569,7 +570,7 @@ enum {
 
 static void _InitAntenna_Selection(struct adapter *Adapter)
 {
-	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	if (haldata->AntDivCfg == 0)
 		return;
@@ -591,7 +592,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	u16  value16;
 	u8 txpktbuf_bndy;
 	u32 status = _SUCCESS;
-	struct hal_data_8188e		*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
 	u32 init_start_time = jiffies;
@@ -839,7 +840,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 static void CardDisableRTL8188EU(struct adapter *Adapter)
 {
 	u8 val8;
-	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
 	val8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
@@ -942,7 +943,7 @@ unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 static void _ReadLEDSetting(struct adapter *Adapter, u8 *PROMContent, bool AutoloadFail)
 {
 	struct led_priv *pledpriv = &Adapter->ledpriv;
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	pledpriv->bRegUseLed = true;
 	haldata->bLedOpenDrain = true;/*  Support Open-drain arrangement for controlling the LED. */
@@ -998,7 +999,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 
 static void ResumeTxBeacon(struct adapter *adapt)
 {
-	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
@@ -1012,7 +1013,7 @@ static void ResumeTxBeacon(struct adapter *adapt)
 
 static void StopTxBeacon(struct adapter *adapt)
 {
-	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 
 	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
 	/*  which should be read from register to a global variable. */
@@ -1119,7 +1120,7 @@ static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
 
 void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct dm_priv	*pdmpriv = &haldata->dmpriv;
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
 
@@ -1636,7 +1637,7 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
 
 	switch (variable) {
@@ -1692,7 +1693,7 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 /* Query setting of specified variable. */
 u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 	u8 bResult = _SUCCESS;
 
 	switch (eVariable) {
@@ -1777,7 +1778,7 @@ u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable
 /* Change default setting of specified variable. */
 u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct hal_data_8188e *haldata = &Adapter->haldata;
 	u8 bResult = _SUCCESS;
 
 	switch (eVariable) {
@@ -1831,7 +1832,7 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	u8 shortGIrate = false;
 	int	supportRateNum = 0;
 	struct sta_info	*psta;
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
@@ -1942,11 +1943,10 @@ void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 
 void rtl8188eu_init_default_value(struct adapter *adapt)
 {
-	struct hal_data_8188e *haldata;
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	struct pwrctrl_priv *pwrctrlpriv;
 	u8 i;
 
-	haldata = GET_HAL_DATA(adapt);
 	pwrctrlpriv = &adapt->pwrctrlpriv;
 
 	/* init default value */
@@ -1963,11 +1963,3 @@ void rtl8188eu_init_default_value(struct adapter *adapt)
 	for (i = 0; i < HP_THERMAL_NUM; i++)
 		haldata->odmpriv.RFCalibrateInfo.ThermalValue_HP[i] = 0;
 }
-
-void rtl8188eu_alloc_haldata(struct adapter *adapt)
-{
-	adapt->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
-	if (!adapt->HalData)
-		DBG_88E("cant not alloc memory for HAL DATA\n");
-	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
-}
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 6232e5c49e85..9ec55a77dccd 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -185,7 +185,7 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 
 static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbuf)
 {
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 
 	if (pkt_len != INTERRUPT_MSG_FORMAT_LEN) {
 		DBG_88E("%s Invalid interrupt content length (%d)!\n", __func__, pkt_len);
@@ -213,7 +213,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 	struct sk_buff *pkt_copy = NULL;
 	struct recv_frame	*precvframe = NULL;
 	struct rx_pkt_attrib	*pattrib = NULL;
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	struct hal_data_8188e *haldata = &adapt->haldata;
 	struct recv_priv	*precvpriv = &adapt->recvpriv;
 	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
 
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 595113ac230f..798bd225ffe4 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -34,6 +34,7 @@
 #include "rtw_p2p.h"
 #include "rtw_ap.h"
 #include "rtw_br_ext.h"
+#include "rtl8188e_hal.h"
 
 #define DRIVERVERSION	"v4.1.4_6773.20130222"
 
@@ -205,8 +206,7 @@ struct adapter {
 	struct	hostapd_priv	*phostapdpriv;
 	struct wifidirect_info	wdinfo;
 
-	void *HalData;
-	u32 hal_data_sz;
+	struct hal_data_8188e haldata;
 
 	s32	bDriverStopped;
 	s32	bSurpriseRemoved;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 7de35fde15a9..6eb630f9b6bf 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -108,15 +108,12 @@ typedef s32 (*c2h_id_filter)(u8 id);
 
 #define is_boot_from_eeprom(adapter) (adapter->eeprompriv.EepromOrEfuse)
 
-void rtl8188eu_alloc_haldata(struct adapter *adapt);
-
 void rtl8188eu_interface_configure(struct adapter *adapt);
 void ReadAdapterInfo8188EU(struct adapter *Adapter);
 void rtl8188eu_init_default_value(struct adapter *adapt);
 void rtl8188e_SetHalODMVar(struct adapter *Adapter,
 			   enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
-void rtl8188e_free_hal_data(struct adapter *padapter);
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState);
 void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf);
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index eaa4b24055d8..fcde9c6924bb 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -13,11 +13,10 @@
 #include "rtl8188e_recv.h"
 #include "rtl8188e_xmit.h"
 #include "rtl8188e_cmd.h"
-#include "Hal8188EPwrSeq.h"
 #include "rtl8188e_sreset.h"
 #include "rtw_efuse.h"
-
 #include "odm_precomp.h"
+#include "odm.h"
 
 /* 		RTL8188E Power Configuration CMDs for USB/SDIO interfaces */
 #define Rtl8188E_NIC_PWR_ON_FLOW		rtl8188E_power_on_flow
@@ -297,9 +296,6 @@ struct hal_data_8188e {
 	u8	UsbRxAggPageTimeout;
 };
 
-#define GET_HAL_DATA(__pAdapter)				\
-	((struct hal_data_8188e *)((__pAdapter)->HalData))
-
 /*  rtl8188e_hal_init.c */
 s32 rtl8188e_FirmwareDownload(struct adapter *padapter);
 void _8051Reset88E(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index ac57b96558d5..ad20ab12ee8c 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -567,8 +567,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	_rtw_free_recv_priv(&padapter->recvpriv);
 
-	rtl8188e_free_hal_data(padapter);
-
 	/* free the old_pnetdev */
 	if (padapter->rereg_nd_name_priv.old_pnetdev) {
 		free_netdev(padapter->rereg_nd_name_priv.old_pnetdev);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 6e08ccafe2b9..5c1faf01cb51 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -361,9 +361,6 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	SET_NETDEV_DEV(pnetdev, dvobj_to_dev(dvobj));
 	padapter = rtw_netdev_priv(pnetdev);
 
-	/* step 2. allocate HalData */
-	rtl8188eu_alloc_haldata(padapter);
-
 	padapter->intf_start = &usb_intf_start;
 	padapter->intf_stop = &usb_intf_stop;
 
@@ -385,7 +382,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 
 	/* step 5. */
 	if (rtw_init_drv_sw(padapter) == _FAIL)
-		goto free_hal_data;
+		goto handle_dualmac;
 
 #ifdef CONFIG_PM
 	if (padapter->pwrctrlpriv.bSupportRemoteWakeup) {
@@ -413,7 +410,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 
 	/* step 6. Tell the network stack we exist */
 	if (register_netdev(pnetdev) != 0)
-		goto free_hal_data;
+		goto handle_dualmac;
 
 	DBG_88E("bDriverStopped:%d, bSurpriseRemoved:%d, bup:%d, hw_init_completed:%d\n"
 		, padapter->bDriverStopped
@@ -424,9 +421,6 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 
 	status = _SUCCESS;
 
-free_hal_data:
-	if (status != _SUCCESS)
-		kfree(padapter->HalData);
 handle_dualmac:
 	if (status != _SUCCESS)
 		rtw_handle_dualmac(padapter, 0);
-- 
2.34.1

