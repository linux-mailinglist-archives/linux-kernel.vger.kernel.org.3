Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF43C4E51AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbiCWL45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiCWL44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:56:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E091762A0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EA53B81E7A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A848C340E8;
        Wed, 23 Mar 2022 11:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648036521;
        bh=Kh6//q8lEfsxzsneQNfL+To4XfzVzAkJSxRPpSaAUYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JK80qGKw+agiOw4Z20UFdLAhVGxk54bLgtAx+5kKYrCXoc2U2XkI8PirhyuZQxk0B
         vfaupcvl29O55NQFIfC7hAhkzy8Oe6U5E4mc7Uk2MeSxtFd1N2l2YyKzyfHqvQiy9J
         elzEvXHn3mIgYiy3lu1ZLBaSmiPVW+WQEX7gjg34=
Date:   Wed, 23 Mar 2022 12:55:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sathish Kumar <skumark1902@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix checkpatch warnings
Message-ID: <YjsKpQ7KEKXQNTWk@kroah.com>
References: <20220323113806.23689-1-skumark1902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323113806.23689-1-skumark1902@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 05:08:06PM +0530, Sathish Kumar wrote:
> This patch fixes the checkpatch.pl warnings like:
> CHECK: Lines should not end with a '('
> +               if (
> 
> CHECK: Please don't use multiple blank lines
> +
> +
> 
> CHECK: Blank lines aren't necessary before a close brace '}'
> +
> +}
> 
> CHECK: Unbalanced braces around else statement
> +               } else /*  set grant_bt to high */
> 
> Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
> ---
>  .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 842 ++++++++++--------
>  1 file changed, 453 insertions(+), 389 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> index b3d7f50fac4c..d4caff824dd5 100644
> --- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> +++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> @@ -15,9 +15,9 @@ static struct coex_sta_8723b_1ant *pCoexSta = &GLCoexSta8723b1Ant;
>  
>  /*  local function proto type if needed */
>  /*  local function start with halbtc8723b1ant_ */
> -static u8 halbtc8723b1ant_BtRssiState(
> -	u8 levelNum, u8 rssiThresh, u8 rssiThresh1
> -)
> +static u8 halbtc8723b1ant_BtRssiState(u8 levelNum,
> +				      u8 rssiThresh,
> +				      u8 rssiThresh1)
>  {
>  	s32 btRssi = 0;
>  	u8 btRssiState = pCoexSta->preBtRssiState;
> @@ -25,10 +25,8 @@ static u8 halbtc8723b1ant_BtRssiState(
>  	btRssi = pCoexSta->btRssi;
>  
>  	if (levelNum == 2) {
> -		if (
> -			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
> -			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
> -		) {
> +		if ((pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
> +		    (pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)) {
>  			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT))
>  
>  				btRssiState = BTC_RSSI_STATE_HIGH;
> @@ -44,18 +42,14 @@ static u8 halbtc8723b1ant_BtRssiState(
>  		if (rssiThresh > rssiThresh1)
>  			return pCoexSta->preBtRssiState;
>  
> -		if (
> -			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
> -			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)
> -		) {
> +		if ((pCoexSta->preBtRssiState == BTC_RSSI_STATE_LOW) ||
> +		    (pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_LOW)) {
>  			if (btRssi >= (rssiThresh + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT))
>  				btRssiState = BTC_RSSI_STATE_MEDIUM;
>  			else
>  				btRssiState = BTC_RSSI_STATE_STAY_LOW;
> -		} else if (
> -			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
> -			(pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_MEDIUM)
> -		) {
> +		} else if ((pCoexSta->preBtRssiState == BTC_RSSI_STATE_MEDIUM) ||
> +			   (pCoexSta->preBtRssiState == BTC_RSSI_STATE_STAY_MEDIUM)) {
>  			if (btRssi >= (rssiThresh1 + BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT))
>  				btRssiState = BTC_RSSI_STATE_HIGH;
>  			else if (btRssi < rssiThresh)
> @@ -75,24 +69,22 @@ static u8 halbtc8723b1ant_BtRssiState(
>  	return btRssiState;
>  }
>  
> -static void halbtc8723b1ant_UpdateRaMask(
> -	struct btc_coexist *pBtCoexist, bool bForceExec, u32 disRateMask
> -)
> +static void halbtc8723b1ant_UpdateRaMask(struct btc_coexist *pBtCoexist,
> +					 bool bForceExec,
> +					 u32 disRateMask)
>  {
>  	pCoexDm->curRaMask = disRateMask;
>  
>  	if (bForceExec || (pCoexDm->preRaMask != pCoexDm->curRaMask))
> -		pBtCoexist->fBtcSet(
> -			pBtCoexist,
> -			BTC_SET_ACT_UPDATE_RAMASK,
> -			&pCoexDm->curRaMask
> -		);
> +		pBtCoexist->fBtcSet(pBtCoexist,
> +				    BTC_SET_ACT_UPDATE_RAMASK,
> +				    &pCoexDm->curRaMask);
>  	pCoexDm->preRaMask = pCoexDm->curRaMask;
>  }
>  
> -static void halbtc8723b1ant_AutoRateFallbackRetry(
> -	struct btc_coexist *pBtCoexist, bool bForceExec, u8 type
> -)
> +static void halbtc8723b1ant_AutoRateFallbackRetry(struct btc_coexist *pBtCoexist,
> +						  bool bForceExec,
> +						  u8 type)
>  {
>  	bool bWifiUnderBMode = false;
>  
> @@ -101,17 +93,17 @@ static void halbtc8723b1ant_AutoRateFallbackRetry(
>  	if (bForceExec || (pCoexDm->preArfrType != pCoexDm->curArfrType)) {
>  		switch (pCoexDm->curArfrType) {
>  		case 0:	/*  normal mode */
> -			pBtCoexist->fBtcWrite4Byte(
> -				pBtCoexist, 0x430, pCoexDm->backupArfrCnt1
> -			);
> -			pBtCoexist->fBtcWrite4Byte(
> -				pBtCoexist, 0x434, pCoexDm->backupArfrCnt2
> -			);
> +			pBtCoexist->fBtcWrite4Byte(pBtCoexist,
> +						   0x430,
> +						   pCoexDm->backupArfrCnt1);
> +			pBtCoexist->fBtcWrite4Byte(pBtCoexist,
> +						   0x434,
> +						   pCoexDm->backupArfrCnt2);
>  			break;
>  		case 1:
> -			pBtCoexist->fBtcGet(
> -				pBtCoexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &bWifiUnderBMode
> -			);
> +			pBtCoexist->fBtcGet(pBtCoexist,
> +					    BTC_GET_BL_WIFI_UNDER_B_MODE,
> +					    &bWifiUnderBMode);
>  			if (bWifiUnderBMode) {
>  				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x430, 0x0);
>  				pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x434, 0x01010101);
> @@ -128,21 +120,19 @@ static void halbtc8723b1ant_AutoRateFallbackRetry(
>  	pCoexDm->preArfrType = pCoexDm->curArfrType;
>  }
>  
> -static void halbtc8723b1ant_RetryLimit(
> -	struct btc_coexist *pBtCoexist, bool bForceExec, u8 type
> -)
> +static void halbtc8723b1ant_RetryLimit(struct btc_coexist *pBtCoexist,
> +				       bool bForceExec,
> +				       u8 type)
>  {
>  	pCoexDm->curRetryLimitType = type;
>  
> -	if (
> -		bForceExec ||
> -		(pCoexDm->preRetryLimitType != pCoexDm->curRetryLimitType)
> -	) {
> +	if (bForceExec ||
> +	    (pCoexDm->preRetryLimitType != pCoexDm->curRetryLimitType)) {
>  		switch (pCoexDm->curRetryLimitType) {
>  		case 0:	/*  normal mode */
> -			pBtCoexist->fBtcWrite2Byte(
> -				pBtCoexist, 0x42a, pCoexDm->backupRetryLimit
> -			);
> +			pBtCoexist->fBtcWrite2Byte(pBtCoexist,
> +						   0x42a,
> +						   pCoexDm->backupRetryLimit);
>  			break;
>  		case 1:	/*  retry limit =8 */
>  			pBtCoexist->fBtcWrite2Byte(pBtCoexist, 0x42a, 0x0808);
> @@ -155,20 +145,19 @@ static void halbtc8723b1ant_RetryLimit(
>  	pCoexDm->preRetryLimitType = pCoexDm->curRetryLimitType;
>  }
>  
> -static void halbtc8723b1ant_AmpduMaxTime(
> -	struct btc_coexist *pBtCoexist, bool bForceExec, u8 type
> -)
> +static void halbtc8723b1ant_AmpduMaxTime(struct btc_coexist *pBtCoexist,
> +					 bool bForceExec,
> +					 u8 type)
>  {
>  	pCoexDm->curAmpduTimeType = type;
>  
> -	if (
> -		bForceExec || (pCoexDm->preAmpduTimeType != pCoexDm->curAmpduTimeType)
> -	) {
> +	if (bForceExec ||
> +	    (pCoexDm->preAmpduTimeType != pCoexDm->curAmpduTimeType)) {
>  		switch (pCoexDm->curAmpduTimeType) {
>  		case 0:	/*  normal mode */
> -			pBtCoexist->fBtcWrite1Byte(
> -				pBtCoexist, 0x456, pCoexDm->backupAmpduMaxTime
> -			);
> +			pBtCoexist->fBtcWrite1Byte(pBtCoexist,
> +						   0x456,
> +						   pCoexDm->backupAmpduMaxTime);
>  			break;
>  		case 1:	/*  AMPDU timw = 0x38 * 32us */
>  			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x456, 0x38);
> @@ -181,14 +170,12 @@ static void halbtc8723b1ant_AmpduMaxTime(
>  	pCoexDm->preAmpduTimeType = pCoexDm->curAmpduTimeType;
>  }
>  
> -static void halbtc8723b1ant_LimitedTx(
> -	struct btc_coexist *pBtCoexist,
> -	bool bForceExec,
> -	u8 raMaskType,
> -	u8 arfrType,
> -	u8 retryLimitType,
> -	u8 ampduTimeType
> -)
> +static void halbtc8723b1ant_LimitedTx(struct btc_coexist *pBtCoexist,
> +				      bool bForceExec,
> +				      u8 raMaskType,
> +				      u8 arfrType,
> +				      u8 retryLimitType,
> +				      u8 ampduTimeType)
>  {
>  	switch (raMaskType) {
>  	case 0:	/*  normal mode */
> @@ -209,13 +196,11 @@ static void halbtc8723b1ant_LimitedTx(
>  	halbtc8723b1ant_AmpduMaxTime(pBtCoexist, bForceExec, ampduTimeType);
>  }
>  
> -static void halbtc8723b1ant_LimitedRx(
> -	struct btc_coexist *pBtCoexist,
> -	bool bForceExec,
> -	bool bRejApAggPkt,
> -	bool bBtCtrlAggBufSize,
> -	u8 aggBufSize
> -)
> +static void halbtc8723b1ant_LimitedRx(struct btc_coexist *pBtCoexist,
> +				      bool bForceExec,
> +				      bool bRejApAggPkt,
> +				      bool bBtCtrlAggBufSize,
> +				      u8 aggBufSize)
>  {
>  	bool bRejectRxAgg = bRejApAggPkt;
>  	bool bBtCtrlRxAggSize = bBtCtrlAggBufSize;
> @@ -224,13 +209,13 @@ static void halbtc8723b1ant_LimitedRx(
>  	/*  */
>  	/*	Rx Aggregation related setting */
>  	/*  */
> -	pBtCoexist->fBtcSet(
> -		pBtCoexist, BTC_SET_BL_TO_REJ_AP_AGG_PKT, &bRejectRxAgg
> -	);
> +	pBtCoexist->fBtcSet(pBtCoexist,
> +			    BTC_SET_BL_TO_REJ_AP_AGG_PKT,
> +			    &bRejectRxAgg);
>  	/*  decide BT control aggregation buf size or not */
> -	pBtCoexist->fBtcSet(
> -		pBtCoexist, BTC_SET_BL_BT_CTRL_AGG_SIZE, &bBtCtrlRxAggSize
> -	);
> +	pBtCoexist->fBtcSet(pBtCoexist,
> +			    BTC_SET_BL_BT_CTRL_AGG_SIZE,
> +			    &bBtCtrlRxAggSize);
>  	/*  aggregation buf size, only work when BT control Rx aggregation size. */
>  	pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_U1_AGG_BUF_SIZE, &rxAggSize);
>  	/*  real update aggregation setting */
> @@ -307,9 +292,9 @@ static void halbtc8723b1ant_MonitorWiFiCtr(struct btc_coexist *pBtCoexist)
>  
>  	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
>  	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_S4_WIFI_RSSI, &wifiRssi);
> -	pBtCoexist->fBtcGet(
> -		pBtCoexist, BTC_GET_BL_WIFI_UNDER_B_MODE, &bWifiUnderBMode
> -	);
> +	pBtCoexist->fBtcGet(pBtCoexist,
> +			    BTC_GET_BL_WIFI_UNDER_B_MODE,
> +			    &bWifiUnderBMode);
>  
>  	if (pCoexSta->bUnderIps) {
>  		pCoexSta->nCRCOK_CCK = 0;
> @@ -333,31 +318,23 @@ static void halbtc8723b1ant_MonitorWiFiCtr(struct btc_coexist *pBtCoexist)
>  		pCoexSta->nCRCErr_11nAgg = pBtCoexist->fBtcRead2Byte(pBtCoexist, 0xfba);
>  	}
>  
> -
>  	/* reset counter */
>  	pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0xf16, 0x1, 0x1);
>  	pBtCoexist->fBtcWrite1ByteBitMask(pBtCoexist, 0xf16, 0x1, 0x0);
>  
>  	if (bWifiBusy && (wifiRssi >= 30) && !bWifiUnderBMode) {
> -		if (
> -			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) ||
> -			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY) ||
> -			(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY)
> -		) {
> -			if (
> -				pCoexSta->nCRCOK_CCK > (
> -					pCoexSta->nCRCOK_11g +
> -					pCoexSta->nCRCOK_11n +
> -					pCoexSta->nCRCOK_11nAgg
> -				)
> -			) {
> +		if ((pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_BUSY) ||
> +		    (pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_ACL_SCO_BUSY) ||
> +		    (pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_SCO_BUSY)) {
> +			if (pCoexSta->nCRCOK_CCK > (pCoexSta->nCRCOK_11g +
> +						    pCoexSta->nCRCOK_11n +
> +						    pCoexSta->nCRCOK_11nAgg)) {
>  				if (nCCKLockCounter < 5)
>  					nCCKLockCounter++;
>  			} else {
>  				if (nCCKLockCounter > 0)
>  					nCCKLockCounter--;
>  			}
> -
>  		} else {
>  			if (nCCKLockCounter > 0)
>  				nCCKLockCounter--;
> @@ -368,7 +345,6 @@ static void halbtc8723b1ant_MonitorWiFiCtr(struct btc_coexist *pBtCoexist)
>  	}
>  
>  	if (!pCoexSta->bPreCCKLock) {
> -
>  		if (nCCKLockCounter >= 5)
>  			pCoexSta->bCCKLock = true;
>  		else
> @@ -381,8 +357,6 @@ static void halbtc8723b1ant_MonitorWiFiCtr(struct btc_coexist *pBtCoexist)
>  	}
>  
>  	pCoexSta->bPreCCKLock =  pCoexSta->bCCKLock;
> -
> -
>  }
>  
>  static bool halbtc8723b1ant_IsWifiStatusChanged(struct btc_coexist *pBtCoexist)
> @@ -391,14 +365,14 @@ static bool halbtc8723b1ant_IsWifiStatusChanged(struct btc_coexist *pBtCoexist)
>  	bool bWifiBusy = false, bUnder4way = false, bBtHsOn = false;
>  	bool bWifiConnected = false;
>  
> -	pBtCoexist->fBtcGet(
> -		pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected
> -	);
> +	pBtCoexist->fBtcGet(pBtCoexist,
> +			    BTC_GET_BL_WIFI_CONNECTED,
> +			    &bWifiConnected);
>  	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
>  	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_HS_OPERATION, &bBtHsOn);
> -	pBtCoexist->fBtcGet(
> -		pBtCoexist, BTC_GET_BL_WIFI_4_WAY_PROGRESS, &bUnder4way
> -	);
> +	pBtCoexist->fBtcGet(pBtCoexist,
> +			    BTC_GET_BL_WIFI_4_WAY_PROGRESS,
> +			    &bUnder4way);
>  
>  	if (bWifiConnected) {
>  		if (bWifiBusy != bPreWifiBusy) {
> @@ -440,45 +414,37 @@ static void halbtc8723b1ant_UpdateBtLinkInfo(struct btc_coexist *pBtCoexist)
>  	}
>  
>  	/*  check if Sco only */
> -	if (
> -		pBtLinkInfo->bScoExist &&
> -		!pBtLinkInfo->bA2dpExist &&
> -		!pBtLinkInfo->bPanExist &&
> -		!pBtLinkInfo->bHidExist
> -	)
> +	if (pBtLinkInfo->bScoExist &&
> +	    !pBtLinkInfo->bA2dpExist &&
> +	    !pBtLinkInfo->bPanExist &&
> +	    !pBtLinkInfo->bHidExist)
>  		pBtLinkInfo->bScoOnly = true;
>  	else
>  		pBtLinkInfo->bScoOnly = false;
>  
>  	/*  check if A2dp only */
> -	if (
> -		!pBtLinkInfo->bScoExist &&
> -		pBtLinkInfo->bA2dpExist &&
> -		!pBtLinkInfo->bPanExist &&
> -		!pBtLinkInfo->bHidExist
> -	)
> +	if (!pBtLinkInfo->bScoExist &&
> +	    pBtLinkInfo->bA2dpExist &&
> +	    !pBtLinkInfo->bPanExist &&
> +	    !pBtLinkInfo->bHidExist)
>  		pBtLinkInfo->bA2dpOnly = true;
>  	else
>  		pBtLinkInfo->bA2dpOnly = false;
>  
>  	/*  check if Pan only */
> -	if (
> -		!pBtLinkInfo->bScoExist &&
> -		!pBtLinkInfo->bA2dpExist &&
> -		pBtLinkInfo->bPanExist &&
> -		!pBtLinkInfo->bHidExist
> -	)
> +	if (!pBtLinkInfo->bScoExist &&
> +	    !pBtLinkInfo->bA2dpExist &&
> +	    pBtLinkInfo->bPanExist &&
> +	    !pBtLinkInfo->bHidExist)
>  		pBtLinkInfo->bPanOnly = true;
>  	else
>  		pBtLinkInfo->bPanOnly = false;
>  
>  	/*  check if Hid only */
> -	if (
> -		!pBtLinkInfo->bScoExist &&
> -		!pBtLinkInfo->bA2dpExist &&
> -		!pBtLinkInfo->bPanExist &&
> -		pBtLinkInfo->bHidExist
> -	)
> +	if (!pBtLinkInfo->bScoExist &&
> +	    !pBtLinkInfo->bA2dpExist &&
> +	    !pBtLinkInfo->bPanExist &&
> +	    pBtLinkInfo->bHidExist)
>  		pBtLinkInfo->bHidOnly = true;
>  	else
>  		pBtLinkInfo->bHidOnly = false;
> @@ -565,11 +531,9 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
>  					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
>  			}
>  		} else {
> -			if (
> -				pBtLinkInfo->bHidExist &&
> -				pBtLinkInfo->bPanExist &&
> -				pBtLinkInfo->bA2dpExist
> -			) {
> +			if (pBtLinkInfo->bHidExist &&
> +			    pBtLinkInfo->bPanExist &&
> +			    pBtLinkInfo->bA2dpExist) {
>  				if (bBtHsOn)
>  					algorithm = BT_8723B_1ANT_COEX_ALGO_HID_A2DP;
>  				else
> @@ -578,14 +542,11 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
>  		}
>  	} else if (numOfDiffProfile >= 3) {
>  		if (pBtLinkInfo->bScoExist) {
> -			if (
> -				pBtLinkInfo->bHidExist &&
> -				pBtLinkInfo->bPanExist &&
> -				pBtLinkInfo->bA2dpExist
> -			) {
> +			if (pBtLinkInfo->bHidExist &&
> +			    pBtLinkInfo->bPanExist &&
> +			    pBtLinkInfo->bA2dpExist) {
>  				if (!bBtHsOn)
>  					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
> -
>  			}
>  		}
>  	}
> @@ -593,9 +554,8 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
>  	return algorithm;
>  }
>  
> -static void halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(
> -	struct btc_coexist *pBtCoexist, bool bLowPenaltyRa
> -)
> +static void halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(struct btc_coexist *pBtCoexist,
> +						       bool bLowPenaltyRa)
>  {
>  	u8 H2C_Parameter[6] = {0};
>  
> @@ -612,9 +572,9 @@ static void halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(
>  	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x69, 6, H2C_Parameter);
>  }
>  
> -static void halbtc8723b1ant_LowPenaltyRa(
> -	struct btc_coexist *pBtCoexist, bool bForceExec, bool bLowPenaltyRa
> -)
> +static void halbtc8723b1ant_LowPenaltyRa(struct btc_coexist *pBtCoexist,
> +					 bool bForceExec,
> +					 bool bLowPenaltyRa)
>  {
>  	pCoexDm->bCurLowPenaltyRa = bLowPenaltyRa;
>  
> @@ -622,20 +582,17 @@ static void halbtc8723b1ant_LowPenaltyRa(
>  		if (pCoexDm->bPreLowPenaltyRa == pCoexDm->bCurLowPenaltyRa)
>  			return;
>  	}
> -	halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(
> -		pBtCoexist, pCoexDm->bCurLowPenaltyRa
> -	);
> +	halbtc8723b1ant_SetSwPenaltyTxRateAdaptive(pBtCoexist,
> +						   pCoexDm->bCurLowPenaltyRa);
>  
>  	pCoexDm->bPreLowPenaltyRa = pCoexDm->bCurLowPenaltyRa;
>  }
>  
> -static void halbtc8723b1ant_SetCoexTable(
> -	struct btc_coexist *pBtCoexist,
> -	u32 val0x6c0,
> -	u32 val0x6c4,
> -	u32 val0x6c8,
> -	u8 val0x6cc
> -)
> +static void halbtc8723b1ant_SetCoexTable(struct btc_coexist *pBtCoexist,
> +					 u32 val0x6c0,
> +					 u32 val0x6c4,
> +					 u32 val0x6c8,
> +					 u8 val0x6cc)
>  {
>  	pBtCoexist->fBtcWrite4Byte(pBtCoexist, 0x6c0, val0x6c0);
>  
> @@ -646,14 +603,12 @@ static void halbtc8723b1ant_SetCoexTable(
>  	pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x6cc, val0x6cc);
>  }
>  
> -static void halbtc8723b1ant_CoexTable(
> -	struct btc_coexist *pBtCoexist,
> -	bool bForceExec,
> -	u32 val0x6c0,
> -	u32 val0x6c4,
> -	u32 val0x6c8,
> -	u8 val0x6cc
> -)
> +static void halbtc8723b1ant_CoexTable(struct btc_coexist *pBtCoexist,
> +				      bool bForceExec,
> +				      u32 val0x6c0,
> +				      u32 val0x6c4,
> +				      u32 val0x6c8,
> +				      u8 val0x6cc)
>  {
>  	pCoexDm->curVal0x6c0 = val0x6c0;
>  	pCoexDm->curVal0x6c4 = val0x6c4;
> @@ -661,18 +616,18 @@ static void halbtc8723b1ant_CoexTable(
>  	pCoexDm->curVal0x6cc = val0x6cc;
>  
>  	if (!bForceExec) {
> -		if (
> -			(pCoexDm->preVal0x6c0 == pCoexDm->curVal0x6c0) &&
> +		if ((pCoexDm->preVal0x6c0 == pCoexDm->curVal0x6c0) &&
>  		    (pCoexDm->preVal0x6c4 == pCoexDm->curVal0x6c4) &&
>  		    (pCoexDm->preVal0x6c8 == pCoexDm->curVal0x6c8) &&
> -		    (pCoexDm->preVal0x6cc == pCoexDm->curVal0x6cc)
> -		)
> +		    (pCoexDm->preVal0x6cc == pCoexDm->curVal0x6cc))
>  			return;
>  	}
>  
> -	halbtc8723b1ant_SetCoexTable(
> -		pBtCoexist, val0x6c0, val0x6c4, val0x6c8, val0x6cc
> -	);
> +	halbtc8723b1ant_SetCoexTable(pBtCoexist,
> +				     val0x6c0,
> +				     val0x6c4,
> +				     val0x6c8,
> +				     val0x6cc);
>  
>  	pCoexDm->preVal0x6c0 = pCoexDm->curVal0x6c0;
>  	pCoexDm->preVal0x6c4 = pCoexDm->curVal0x6c4;
> @@ -680,61 +635,84 @@ static void halbtc8723b1ant_CoexTable(
>  	pCoexDm->preVal0x6cc = pCoexDm->curVal0x6cc;
>  }
>  
> -static void halbtc8723b1ant_CoexTableWithType(
> -	struct btc_coexist *pBtCoexist, bool bForceExec, u8 type
> -)
> +static void halbtc8723b1ant_CoexTableWithType(struct btc_coexist *pBtCoexist,
> +					      bool bForceExec,
> +					      u8 type)
>  {
>  	pCoexSta->nCoexTableType = type;
>  
>  	switch (type) {
>  	case 0:
> -		halbtc8723b1ant_CoexTable(
> -			pBtCoexist, bForceExec, 0x55555555, 0x55555555, 0xffffff, 0x3
> -		);
> +		halbtc8723b1ant_CoexTable(pBtCoexist,
> +					  bForceExec,
> +					  0x55555555,
> +					  0x55555555,
> +					  0xffffff,
> +					  0x3);
>  		break;
>  	case 1:
> -		halbtc8723b1ant_CoexTable(
> -			pBtCoexist, bForceExec, 0x55555555, 0x5a5a5a5a, 0xffffff, 0x3
> -		);
> +		halbtc8723b1ant_CoexTable(pBtCoexist,
> +					  bForceExec,
> +					  0x55555555,
> +					  0x5a5a5a5a,
> +					  0xffffff,
> +					  0x3);
>  		break;
>  	case 2:
> -		halbtc8723b1ant_CoexTable(
> -			pBtCoexist, bForceExec, 0x5a5a5a5a, 0x5a5a5a5a, 0xffffff, 0x3
> -		);
> +		halbtc8723b1ant_CoexTable(pBtCoexist,
> +					  bForceExec,
> +					  0x5a5a5a5a,
> +					  0x5a5a5a5a,
> +					  0xffffff,
> +					  0x3);
>  		break;
>  	case 3:
> -		halbtc8723b1ant_CoexTable(
> -			pBtCoexist, bForceExec, 0xaaaa5555, 0xaaaa5a5a, 0xffffff, 0x3
> -		);
> +		halbtc8723b1ant_CoexTable(pBtCoexist,
> +					  bForceExec,
> +					  0xaaaa5555,
> +					  0xaaaa5a5a,
> +					  0xffffff,
> +					  0x3);
>  		break;
>  	case 4:
> -		halbtc8723b1ant_CoexTable(
> -			pBtCoexist, bForceExec, 0x55555555, 0xaaaa5a5a, 0xffffff, 0x3
> -		);
> +		halbtc8723b1ant_CoexTable(pBtCoexist,
> +					  bForceExec,
> +					  0x55555555,
> +					  0xaaaa5a5a,
> +					  0xffffff,
> +					  0x3);
>  		break;
>  	case 5:
> -		halbtc8723b1ant_CoexTable(
> -			pBtCoexist, bForceExec, 0x5a5a5a5a, 0xaaaa5a5a, 0xffffff, 0x3
> -		);
> +		halbtc8723b1ant_CoexTable(pBtCoexist,
> +					  bForceExec,
> +					  0x5a5a5a5a,
> +					  0xaaaa5a5a,
> +					  0xffffff,
> +					  0x3);
>  		break;
>  	case 6:
> -		halbtc8723b1ant_CoexTable(
> -			pBtCoexist, bForceExec, 0x55555555, 0xaaaaaaaa, 0xffffff, 0x3
> -		);
> +		halbtc8723b1ant_CoexTable(pBtCoexist,
> +					  bForceExec,
> +					  0x55555555,
> +					  0xaaaaaaaa,
> +					  0xffffff,
> +					  0x3);
>  		break;
>  	case 7:
> -		halbtc8723b1ant_CoexTable(
> -			pBtCoexist, bForceExec, 0xaaaaaaaa, 0xaaaaaaaa, 0xffffff, 0x3
> -		);
> +		halbtc8723b1ant_CoexTable(pBtCoexist,
> +					  bForceExec,
> +					  0xaaaaaaaa,
> +					  0xaaaaaaaa,
> +					  0xffffff,
> +					  0x3);
>  		break;
>  	default:
>  		break;
>  	}
>  }
>  
> -static void halbtc8723b1ant_SetFwIgnoreWlanAct(
> -	struct btc_coexist *pBtCoexist, bool bEnable
> -)
> +static void halbtc8723b1ant_SetFwIgnoreWlanAct(struct btc_coexist *pBtCoexist,
> +					       bool bEnable)
>  {
>  	u8 H2C_Parameter[1] = {0};
>  
> @@ -744,9 +722,9 @@ static void halbtc8723b1ant_SetFwIgnoreWlanAct(
>  	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x63, 1, H2C_Parameter);
>  }
>  
> -static void halbtc8723b1ant_IgnoreWlanAct(
> -	struct btc_coexist *pBtCoexist, bool bForceExec, bool bEnable
> -)
> +static void halbtc8723b1ant_IgnoreWlanAct(struct btc_coexist *pBtCoexist,
> +					  bool bForceExec,
> +					  bool bEnable)
>  {
>  	pCoexDm->bCurIgnoreWlanAct = bEnable;
>  
> @@ -759,9 +737,9 @@ static void halbtc8723b1ant_IgnoreWlanAct(
>  	pCoexDm->bPreIgnoreWlanAct = pCoexDm->bCurIgnoreWlanAct;
>  }
>  
> -static void halbtc8723b1ant_SetLpsRpwm(
> -	struct btc_coexist *pBtCoexist, u8 lpsVal, u8 rpwmVal
> -)
> +static void halbtc8723b1ant_SetLpsRpwm(struct btc_coexist *pBtCoexist,
> +				       u8 lpsVal,
> +				       u8 rpwmVal)
>  {
>  	u8 lps = lpsVal;
>  	u8 rpwm = rpwmVal;
> @@ -770,18 +748,17 @@ static void halbtc8723b1ant_SetLpsRpwm(
>  	pBtCoexist->fBtcSet(pBtCoexist, BTC_SET_U1_RPWM_VAL, &rpwm);
>  }
>  
> -static void halbtc8723b1ant_LpsRpwm(
> -	struct btc_coexist *pBtCoexist, bool bForceExec, u8 lpsVal, u8 rpwmVal
> -)
> +static void halbtc8723b1ant_LpsRpwm(struct btc_coexist *pBtCoexist,
> +				    bool bForceExec,
> +				    u8 lpsVal,
> +				    u8 rpwmVal)
>  {
>  	pCoexDm->curLps = lpsVal;
>  	pCoexDm->curRpwm = rpwmVal;
>  
>  	if (!bForceExec) {
> -		if (
> -			(pCoexDm->preLps == pCoexDm->curLps) &&
> -			(pCoexDm->preRpwm == pCoexDm->curRpwm)
> -		) {
> +		if ((pCoexDm->preLps == pCoexDm->curLps) &&
> +		    (pCoexDm->preRpwm == pCoexDm->curRpwm)) {
>  			return;
>  		}
>  	}
> @@ -791,16 +768,16 @@ static void halbtc8723b1ant_LpsRpwm(
>  	pCoexDm->preRpwm = pCoexDm->curRpwm;
>  }
>  
> -static void halbtc8723b1ant_SwMechanism(
> -	struct btc_coexist *pBtCoexist, bool bLowPenaltyRA
> -)
> +static void halbtc8723b1ant_SwMechanism(struct btc_coexist *pBtCoexist,
> +					bool bLowPenaltyRA)
>  {
>  	halbtc8723b1ant_LowPenaltyRa(pBtCoexist, NORMAL_EXEC, bLowPenaltyRA);
>  }
>  
> -static void halbtc8723b1ant_SetAntPath(
> -	struct btc_coexist *pBtCoexist, u8 antPosType, bool bInitHwCfg, bool bWifiOff
> -)
> +static void halbtc8723b1ant_SetAntPath(struct btc_coexist *pBtCoexist,
> +				       u8 antPosType,
> +				       bool bInitHwCfg,
> +				       bool bWifiOff)
>  {
>  	struct btc_board_info *pBoardInfo = &pBtCoexist->boardInfo;
>  	u32 fwVer = 0, u4Tmp = 0, cntBtCalChk = 0;
> @@ -840,8 +817,10 @@ static void halbtc8723b1ant_SetAntPath(
>  			/* Use H2C to set GNT_BT to HIGH */
>  			H2C_Parameter[0] = 1;
>  			pBtCoexist->fBtcFillH2c(pBtCoexist, 0x6E, 1, H2C_Parameter);
> -		} else /*  set grant_bt to high */
> +		} else {
> +			/*  set grant_bt to high */
>  			pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x765, 0x18);
> +		}
>  
>  		/* set wlan_act to always low */
>  		pBtCoexist->fBtcWrite1Byte(pBtCoexist, 0x76e, 0x4);
> @@ -908,7 +887,6 @@ static void halbtc8723b1ant_SetAntPath(
>  			}
>  		}
>  
> -
>  		/*  ext switch setting */
>  		switch (antPosType) {
>  		case BTC_ANT_PATH_WIFI:
> @@ -958,7 +936,6 @@ static void halbtc8723b1ant_SetAntPath(
>  			}
>  		}
>  
> -
>  		/*  internal switch setting */
>  		switch (antPosType) {
>  		case BTC_ANT_PATH_WIFI:
> @@ -984,9 +961,12 @@ static void halbtc8723b1ant_SetAntPath(
>  	}
>  }
>  
> -static void halbtc8723b1ant_SetFwPstdma(
> -	struct btc_coexist *pBtCoexist, u8 byte1, u8 byte2, u8 byte3, u8 byte4, u8 byte5
> -)
> +static void halbtc8723b1ant_SetFwPstdma(struct btc_coexist *pBtCoexist,
> +					u8 byte1,
> +					u8 byte2,
> +					u8 byte3,
> +					u8 byte4,
> +					u8 byte5)
>  {
>  	u8 H2C_Parameter[5] = {0};
>  	u8 realByte1 = byte1, realByte5 = byte5;
> @@ -1019,10 +999,10 @@ static void halbtc8723b1ant_SetFwPstdma(
>  	pBtCoexist->fBtcFillH2c(pBtCoexist, 0x60, 5, H2C_Parameter);
>  }
>  
> -
> -static void halbtc8723b1ant_PsTdma(
> -	struct btc_coexist *pBtCoexist, bool bForceExec, bool bTurnOn, u8 type
> -)
> +static void halbtc8723b1ant_PsTdma(struct btc_coexist *pBtCoexist,
> +				   bool bForceExec,
> +				   bool bTurnOn,
> +				   u8 type)
>  {
>  	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
>  	bool bWifiBusy = false;
> @@ -1037,10 +1017,8 @@ static void halbtc8723b1ant_PsTdma(
>  	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
>  
>  	if (!bForceExec) {
> -		if (
> -			(pCoexDm->bPrePsTdmaOn == pCoexDm->bCurPsTdmaOn) &&
> -			(pCoexDm->prePsTdma == pCoexDm->curPsTdma)
> -		)
> +		if ((pCoexDm->bPrePsTdmaOn == pCoexDm->bCurPsTdmaOn) &&
> +		    (pCoexDm->prePsTdma == pCoexDm->curPsTdma))
>  			return;
>  	}
>  
> @@ -1057,210 +1035,299 @@ static void halbtc8723b1ant_PsTdma(
>  		psTdmaByte4Val = 0x10; /*  0x778 = d/1 toggle */
>  	}
>  
> -
>  	if (bTurnOn) {
>  		if (pBtLinkInfo->bSlaveRole)
>  			psTdmaByte4Val = psTdmaByte4Val | 0x1;  /* 0x778 = 0x1 at wifi slot (no blocking BT Low-Pri pkts) */
>  
> -
>  		switch (type) {
>  		default:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x51, 0x1a, 0x1a, 0x0, psTdmaByte4Val
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x51,
> +						    0x1a,
> +						    0x1a,
> +						    0x0,
> +						    psTdmaByte4Val);
>  			break;
>  		case 1:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist,
> -				psTdmaByte0Val,
> -				0x3a + nWiFiDurationAdjust,
> -				0x03,
> -				psTdmaByte3Val,
> -				psTdmaByte4Val
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    psTdmaByte0Val,
> +						    0x3a + nWiFiDurationAdjust,
> +						    0x03,
> +						    psTdmaByte3Val,
> +						    psTdmaByte4Val);
>  			break;
>  		case 2:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist,
> -				psTdmaByte0Val,
> -				0x2d + nWiFiDurationAdjust,
> -				0x03,
> -				psTdmaByte3Val,
> -				psTdmaByte4Val
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    psTdmaByte0Val,
> +						    0x2d + nWiFiDurationAdjust,
> +						    0x03,
> +						    psTdmaByte3Val,
> +						    psTdmaByte4Val);
>  			break;
>  		case 3:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x51, 0x1d, 0x1d, 0x0, 0x10
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x51,
> +						    0x1d,
> +						    0x1d,
> +						    0x0,
> +						    0x10);
>  			break;
>  		case 4:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x93, 0x15, 0x3, 0x14, 0x0
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x93,
> +						    0x15,
> +						    0x3,
> +						    0x14,
> +						    0x0);
>  			break;
>  		case 5:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x61, 0x15, 0x3, 0x11, 0x10
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x61,
> +						    0x15,
> +						    0x3,
> +						    0x11,
> +						    0x10);
>  			break;
>  		case 6:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x61, 0x20, 0x3, 0x11, 0x11
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x61,
> +						    0x20,
> +						    0x3,
> +						    0x11,
> +						    0x11);
>  			break;
>  		case 7:
> -			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x13, 0xc, 0x5, 0x0, 0x0);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x13,
> +						    0xc,
> +						    0x5,
> +						    0x0,
> +						    0x0);
>  			break;
>  		case 8:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x93, 0x25, 0x3, 0x10, 0x0
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x93,
> +						    0x25,
> +						    0x3,
> +						    0x10,
> +						    0x0);
>  			break;
>  		case 9:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist,
> -				psTdmaByte0Val,
> -				0x21,
> -				0x3,
> -				psTdmaByte3Val,
> -				psTdmaByte4Val
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    psTdmaByte0Val,
> +						    0x21,
> +						    0x3,
> +						    psTdmaByte3Val,
> +						    psTdmaByte4Val);
>  			break;
>  		case 10:
> -			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x13, 0xa, 0xa, 0x0, 0x40);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x13,
> +						    0xa,
> +						    0xa,
> +						    0x0,
> +						    0x40);
>  			break;
>  		case 11:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist,
> -				psTdmaByte0Val,
> -				0x21,
> -				0x03,
> -				psTdmaByte3Val,
> -				psTdmaByte4Val
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    psTdmaByte0Val,
> +						    0x21,
> +						    0x03,
> +						    psTdmaByte3Val,
> +						    psTdmaByte4Val);
>  			break;
>  		case 12:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x51, 0x0a, 0x0a, 0x0, 0x50
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x51,
> +						    0x0a,
> +						    0x0a,
> +						    0x0,
> +						    0x50);
>  			break;
>  		case 13:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x51, 0x12, 0x12, 0x0, 0x10
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x51,
> +						    0x12,
> +						    0x12,
> +						    0x0,
> +						    0x10);
>  			break;
>  		case 14:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x51, 0x21, 0x3, 0x10, psTdmaByte4Val
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x51,
> +						    0x21,
> +						    0x3,
> +						    0x10,
> +						    psTdmaByte4Val);
>  			break;
>  		case 15:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x13, 0xa, 0x3, 0x8, 0x0
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x13,
> +						    0xa,
> +						    0x3,
> +						    0x8,
> +						    0x0);
>  			break;
>  		case 16:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x93, 0x15, 0x3, 0x10, 0x0
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x93,
> +						    0x15,
> +						    0x3,
> +						    0x10,
> +						    0x0);
>  			break;
>  		case 18:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x93, 0x25, 0x3, 0x10, 0x0
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x93,
> +						    0x25,
> +						    0x3,
> +						    0x10,
> +						    0x0);
>  			break;
>  		case 20:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x61, 0x3f, 0x03, 0x11, 0x10
> -
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x61,
> +						    0x3f,
> +						    0x03,
> +						    0x11,
> +						    0x10);
>  			break;
>  		case 21:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x61, 0x25, 0x03, 0x11, 0x11
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x61,
> +						    0x25,
> +						    0x03,
> +						    0x11,
> +						    0x11);
>  			break;
>  		case 22:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x61, 0x25, 0x03, 0x11, 0x10
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x61,
> +						    0x25,
> +						    0x03,
> +						    0x11,
> +						    0x10);
>  			break;
>  		case 23:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0xe3, 0x25, 0x3, 0x31, 0x18
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0xe3,
> +						    0x25,
> +						    0x3,
> +						    0x31,
> +						    0x18);
>  			break;
>  		case 24:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0xe3, 0x15, 0x3, 0x31, 0x18
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0xe3,
> +						    0x15,
> +						    0x3,
> +						    0x31,
> +						    0x18);
>  			break;
>  		case 25:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0xe3, 0xa, 0x3, 0x31, 0x18
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0xe3,
> +						    0xa,
> +						    0x3,
> +						    0x31,
> +						    0x18);
>  			break;
>  		case 26:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0xe3, 0xa, 0x3, 0x31, 0x18
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0xe3,
> +						    0xa,
> +						    0x3,
> +						    0x31,
> +						    0x18);
>  			break;
>  		case 27:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0xe3, 0x25, 0x3, 0x31, 0x98
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0xe3,
> +						    0x25,
> +						    0x3,
> +						    0x31,
> +						    0x98);
>  			break;
>  		case 28:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x69, 0x25, 0x3, 0x31, 0x0
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x69,
> +						    0x25,
> +						    0x3,
> +						    0x31,
> +						    0x0);
>  			break;
>  		case 29:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0xab, 0x1a, 0x1a, 0x1, 0x10
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0xab,
> +						    0x1a,
> +						    0x1a,
> +						    0x1,
> +						    0x10);
>  			break;
>  		case 30:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x51, 0x30, 0x3, 0x10, 0x10
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x51,
> +						    0x30,
> +						    0x3,
> +						    0x10,
> +						    0x10);
>  			break;
>  		case 31:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0xd3, 0x1a, 0x1a, 0x0, 0x58
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0xd3,
> +						    0x1a,
> +						    0x1a,
> +						    0x0,
> +						    0x58);
>  			break;
>  		case 32:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x61, 0x35, 0x3, 0x11, 0x11
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x61,
> +						    0x35,
> +						    0x3,
> +						    0x11,
> +						    0x11);
>  			break;
>  		case 33:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0xa3, 0x25, 0x3, 0x30, 0x90
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0xa3,
> +						    0x25,
> +						    0x3,
> +						    0x30,
> +						    0x90);
>  			break;
>  		case 34:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x53, 0x1a, 0x1a, 0x0, 0x10
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x53,
> +						    0x1a,
> +						    0x1a,
> +						    0x0,
> +						    0x10);
>  			break;
>  		case 35:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x63, 0x1a, 0x1a, 0x0, 0x10
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x63,
> +						    0x1a,
> +						    0x1a,
> +						    0x0,
> +						    0x10);
>  			break;
>  		case 36:
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0xd3, 0x12, 0x3, 0x14, 0x50
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0xd3,
> +						    0x12,
> +						    0x3,
> +						    0x14,
> +						    0x50);
>  			break;
>  		case 40: /*  SoftAP only with no sta associated, BT disable , TDMA mode for power saving */
>  			/* here softap mode screen off will cost 70-80mA for phone */
> -			halbtc8723b1ant_SetFwPstdma(
> -				pBtCoexist, 0x23, 0x18, 0x00, 0x10, 0x24
> -			);
> +			halbtc8723b1ant_SetFwPstdma(pBtCoexist,
> +						    0x23,
> +						    0x18,
> +						    0x00,
> +						    0x10,
> +						    0x24);
>  			break;
>  		}
>  	} else {
> @@ -1269,30 +1336,33 @@ static void halbtc8723b1ant_PsTdma(
>  		switch (type) {
>  		case 8: /* PTA Control */
>  			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x8, 0x0, 0x0, 0x0, 0x0);
> -			halbtc8723b1ant_SetAntPath(
> -				pBtCoexist, BTC_ANT_PATH_PTA, false, false
> -			);
> +			halbtc8723b1ant_SetAntPath(pBtCoexist,
> +						   BTC_ANT_PATH_PTA,
> +						   false,
> +						   false);
>  			break;
>  		case 0:
>  		default:  /* Software control, Antenna at BT side */
>  			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x0, 0x0, 0x0, 0x0, 0x0);
> -			halbtc8723b1ant_SetAntPath(
> -				pBtCoexist, BTC_ANT_PATH_BT, false, false
> -			);
> +			halbtc8723b1ant_SetAntPath(pBtCoexist,
> +						   BTC_ANT_PATH_BT,
> +						   false,
> +						   false);
>  			break;
>  		case 9:   /* Software control, Antenna at WiFi side */
>  			halbtc8723b1ant_SetFwPstdma(pBtCoexist, 0x0, 0x0, 0x0, 0x0, 0x0);
> -			halbtc8723b1ant_SetAntPath(
> -				pBtCoexist, BTC_ANT_PATH_WIFI, false, false
> -			);
> +			halbtc8723b1ant_SetAntPath(pBtCoexist,
> +						   BTC_ANT_PATH_WIFI,
> +						   false,
> +						   false);
>  			break;
>  		}
>  	}
>  
>  	rssiAdjustVal = 0;
> -	pBtCoexist->fBtcSet(
> -		pBtCoexist, BTC_SET_U1_RSSI_ADJ_VAL_FOR_1ANT_COEX_TYPE, &rssiAdjustVal
> -	);
> +	pBtCoexist->fBtcSet(pBtCoexist,
> +			    BTC_SET_U1_RSSI_ADJ_VAL_FOR_1ANT_COEX_TYPE,
> +			    &rssiAdjustVal);
>  
>  	/*  update pre state */
>  	pCoexDm->bPrePsTdmaOn = pCoexDm->bCurPsTdmaOn;
> @@ -1306,38 +1376,32 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
>  	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
>  	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
>  
> -	if (
> -		!bWifiConnected &&
> -		pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE
> -	) {
> +	if (!bWifiConnected &&
> +	    pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE) {
>  		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
>  
>  		bCommon = true;
> -	} else if (
> -		bWifiConnected &&
> -		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE)
> -	) {
> +	} else if (bWifiConnected &&
> +		   (pCoexDm->btStatus ==
> +		    BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE)) {
>  		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
>  
>  		bCommon = true;
> -	} else if (
> -		!bWifiConnected &&
> -		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE)
> -	) {
> +	} else if (!bWifiConnected &&
> +		   (pCoexDm->btStatus ==
> +		    BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE)) {
>  		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
>  
>  		bCommon = true;
> -	} else if (
> -		bWifiConnected &&
> -		(pCoexDm->btStatus == BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE)
> -	) {
> +	} else if (bWifiConnected &&
> +		   (pCoexDm->btStatus ==
> +		    BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE)) {
>  		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
>  
>  		bCommon = true;
> -	} else if (
> -		!bWifiConnected &&
> -		(pCoexDm->btStatus != BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE)
> -	) {
> +	} else if (!bWifiConnected &&
> +		   (pCoexDm->btStatus !=
> +		    BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE)) {
>  		/* halbtc8723b1ant_SwMechanism(pBtCoexist, false); */
>  
>  		bCommon = true;
> -- 
> 2.17.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
