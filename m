Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DEA4F6DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiDFW0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiDFW0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:26:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A581F1243
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649283894; x=1680819894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ul8bkNTWCZSfrE080PpKA25aPmx91a7UEV1J5UUEQU=;
  b=B+nyWI28M7PkyX3TtvOVuMXsW+6CjdL9V4uvKIWo1TO1eeJ7IKt+kiQY
   6jMFo1SEMyH0KfjGoJ0XfTTk8hzuA9ddSKqR7b8fZOATEEibLL8NyUivd
   Nd4vIkh1QansZqq+Dz5k4VLK6HJskYw7ZHOCxUuTQjnabGJH7GH8A8S0D
   Dr+07+RYnhKSSneIyI8DLo4JKBwk20xkmB8uIr069qUvQIGmGEXoaTReS
   UbfoYD89FL53WKvNdJQJDS5izOjJKiyi9018licob54Wxy/U9fG5y0Oyb
   8OX/IWvNGDryjoFAL2ee0JX05FhlSgCFSZW20SpmqICCgmyjgaNEuBIoo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="260864262"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="260864262"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:24:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="524662523"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:24:53 -0700
Date:   Wed, 6 Apr 2022 15:27:02 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: remove unnecessary parentheses
Message-ID: <20220406222702.GA1210425@alison-desk>
References: <20220406215051.20483-1-eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406215051.20483-1-eng.alaamohamedsoliman.am@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 11:50:51PM +0200, Alaa Mohamed wrote:
> Reported by checkpatch:
> 
> CHECK: Unnecessary parentheses around param->u.crypt.key[16]: 85
> CHECK: Unnecessary parentheses around param->u.crypt.key[24]: 87
> CHECK: Unnecessary parentheses around padapter->mlmepriv: 603
> CHECK: Unnecessary parentheses around wrqu->encoding: 1497
> CHECK: Unnecessary parentheses around wrqu->encoding: 1592
> CHECK: Unnecessary parentheses around padapter->mlmepriv: 1593
> CHECK: Unnecessary parentheses around wrqu->param: 1673
> CHECK: Unnecessary parentheses around pmlmepriv->scanned_queue.lock: 1967
> CHECK: Unnecessary parentheses around pmlmepriv->scanned_queue.lock: 1977
> CHECK: Unnecessary parentheses around pmlmepriv->scanned_queue.lock: 1999

Revisit Julia's feedback on v1. Your commit message can note the
common property these changes share rather than listing each checkpatch
message.

> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
> Changes in v2:
> 	- Edit commit subject
> 	- Edit commit message
> 	- Fix the same check in more lines
> 	- Remove space before '.skey' in
> "memcpy(psta->tkiptxmickey.skey," in lines 84 and 86.

Remove space change needs to be in a separate patch. It is not
like the other changes.


> ---
>  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> index 3b6926613257..e11332352285 100644
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> @@ -81,10 +81,10 @@ static inline void handle_pairwise_key(struct sta_info *psta,
>  	memcpy(psta->x_UncstKey.skey, param->u.crypt.key,
>  	       (param->u.crypt. key_len > 16 ? 16 : param->u.crypt.key_len));
>  	if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
> -		memcpy(psta->tkiptxmickey. skey,
> -		       &(param->u.crypt.key[16]), 8);
> -		memcpy(psta->tkiprxmickey. skey,
> -		       &(param->u.crypt.key[24]), 8);
> +		memcpy(psta->tkiptxmickey.skey,
> +		       &param->u.crypt.key[16], 8);
> +		memcpy(psta->tkiprxmickey.skey,
> +		       &param->u.crypt.key[24], 8);
>  		padapter->securitypriv. busetkipkey = false;
>  		mod_timer(&padapter->securitypriv.tkip_timer,
>  			  jiffies + msecs_to_jiffies(50));
> @@ -600,7 +600,7 @@ static int r8711_wx_get_name(struct net_device *dev,
>  	u32 ht_ielen = 0;
>  	char *p;
>  	u8 ht_cap = false;
> -	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
> +	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
>  	struct wlan_bssid_ex *pcur_bss = &pmlmepriv->cur_network.network;
>  	u8 *prates;
>  
> @@ -1494,7 +1494,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
>  	u32 keyindex_provided;
>  	struct NDIS_802_11_WEP	 wep;
>  	enum NDIS_802_11_AUTHENTICATION_MODE authmode;
> -	struct iw_point *erq = &(wrqu->encoding);
> +	struct iw_point *erq = &wrqu->encoding;
>  	struct _adapter *padapter = netdev_priv(dev);
>  
>  	key = erq->flags & IW_ENCODE_INDEX;
> @@ -1589,8 +1589,8 @@ static int r8711_wx_get_enc(struct net_device *dev,
>  {
>  	uint key;
>  	struct _adapter *padapter = netdev_priv(dev);
> -	struct iw_point *erq = &(wrqu->encoding);
> -	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
> +	struct iw_point *erq = &wrqu->encoding;
> +	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
>  	union Keytype *dk = padapter->securitypriv.DefKey;
>  
>  	if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
> @@ -1670,7 +1670,7 @@ static int r871x_wx_set_auth(struct net_device *dev,
>  				union iwreq_data *wrqu, char *extra)
>  {
>  	struct _adapter *padapter = netdev_priv(dev);
> -	struct iw_param *param = (struct iw_param *)&(wrqu->param);
> +	struct iw_param *param = (struct iw_param *)&wrqu->param;
>  	int paramid;
>  	int paramval;
>  	int ret = 0;
> @@ -1964,7 +1964,7 @@ static int r871x_get_ap_info(struct net_device *dev,
>  		return -EINVAL;
>  	data[32] = 0;
>  
> -	spin_lock_irqsave(&(pmlmepriv->scanned_queue.lock), irqL);
> +	spin_lock_irqsave(&pmlmepriv->scanned_queue.lock, irqL);
>  	phead = &queue->queue;
>  	plist = phead->next;
>  	while (1) {
> @@ -1974,7 +1974,7 @@ static int r871x_get_ap_info(struct net_device *dev,
>  		if (!mac_pton(data, bssid)) {
>  			netdev_info(dev, "r8712u: Invalid BSSID '%s'.\n",
>  				    (u8 *)data);
> -			spin_unlock_irqrestore(&(pmlmepriv->scanned_queue.lock),
> +			spin_unlock_irqrestore(&pmlmepriv->scanned_queue.lock,
>  					       irqL);
>  			return -EINVAL;
>  		}
> @@ -1996,7 +1996,7 @@ static int r871x_get_ap_info(struct net_device *dev,
>  		}
>  		plist = plist->next;
>  	}
> -	spin_unlock_irqrestore(&(pmlmepriv->scanned_queue.lock), irqL);
> +	spin_unlock_irqrestore(&pmlmepriv->scanned_queue.lock, irqL);
>  	if (pdata->length >= 34) {
>  		if (copy_to_user((u8 __user *)pdata->pointer + 32,
>  		    (u8 *)&pdata->flags, 1))
> -- 
> 2.35.1
> 
> 
