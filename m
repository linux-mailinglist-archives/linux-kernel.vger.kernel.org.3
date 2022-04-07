Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7004F7F45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245328AbiDGMm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiDGMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:42:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5E46B0F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:40:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso3574025wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ESXsgDuQIXejSrmAyWLUEYcgoVkyH/x9fwJZGvyRrHA=;
        b=AlYNI45UDam4vghYMsCgiBahfXLVGX9hr9b4O7cYofF0+qalGkjsC9j9eGMeyZVqQ2
         WBb9P895y2rBXFrXhCHgaDtX4Na4wVUEag87hFL3gsYg3hfZQyJZ75faJJj3JnAIJCdT
         LDYdi5IZ2iyplO/g5JaNxArE6sFIE41GFZPXkESPP7HbX7jHegPaKmPrE8D6ljLvLwiX
         kJuvc/IvGNdD76C9Qg0wpHheU2q8wTcPxi6jg18vaUAZ8ffME7Us7si9ILmbbYrgDnen
         GGrYS2m2m+gCvb6R30AFV7JpYXicd8Xxk8bAWqqmW5hPSti/s2FNwT83zQWEyFGjubbK
         73eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ESXsgDuQIXejSrmAyWLUEYcgoVkyH/x9fwJZGvyRrHA=;
        b=CSKrE9TMii500hnwAcfMbR3DX9ScX5cOlfq119QTDJSC9E3SpTdez3yR2dAoqI8W+H
         fe8vdYlkrEVXAz/JHSxLu+pNVfDG/Q5fub/+gewwJ4HgabFjVzRtO/h4Wc8m7jySYoGh
         XxPIGCwlkMj6VLDPNIl4L8hle8iSEGltmVbqh+lN6B3gOnllKC/rPF2d/twLpi5ttmWq
         FH7RefBRLt+ioNZcZJC6c10xGGGMHAWQFR9o9m0dzvm0gO2XZYszXitp2szvo7dj7zph
         uiYWInF6dmCeICi19RRkO2mpAm4phZbQGMsIoIQJ2NQR0jmESi/9eebVUXj3WS14Qm7O
         32dg==
X-Gm-Message-State: AOAM533ByrVZzv5Fv0dGWpXTCJK10T3IAs8BBzbLwK3C8bhi8yRodmkb
        q2/SRy7NPqs70K+xfDfwrMM=
X-Google-Smtp-Source: ABdhPJzeuhUW1FWxOxL2MmX6+1xrT2M+ACwh8503/9XrxwabAC0SPUQAFRLG+P1yuyWZQbu6+uzdjg==
X-Received: by 2002:a7b:cf0a:0:b0:38e:6bbc:6a8d with SMTP id l10-20020a7bcf0a000000b0038e6bbc6a8dmr11935419wmg.57.1649335226633;
        Thu, 07 Apr 2022 05:40:26 -0700 (PDT)
Received: from [192.168.1.14] ([197.57.231.245])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b0038c949ef0d5sm9321174wmq.8.2022.04.07.05.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:40:26 -0700 (PDT)
Message-ID: <6167ed61-7162-6fb5-61eb-802275da440f@gmail.com>
Date:   Thu, 7 Apr 2022 14:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] staging: rtl8712: remove unnecessary parentheses
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220406224057.5260-1-eng.alaamohamedsoliman.am@gmail.com>
 <alpine.DEB.2.22.394.2204070606000.2191@hadrien>
 <658b52bb-7384-143d-ab90-afcfdcec6eeb@gmail.com>
 <alpine.DEB.2.22.394.2204071438000.2213@hadrien>
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2204071438000.2213@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ٧‏/٤‏/٢٠٢٢ ١٤:٣٩, Julia Lawall wrote:
>
> On Thu, 7 Apr 2022, Alaa Mohamed wrote:
>
>> On ٧/٤/٢٠٢٢ ٠٦:٠٦, Julia Lawall wrote:
>>> On Thu, 7 Apr 2022, Alaa Mohamed wrote:
>>>
>>>> Reported by checkpatch:
>>>>
>>>> CHECK: Unnecessary parentheses around param->u.crypt.key[16]: 85
>>>> CHECK: Unnecessary parentheses around param->u.crypt.key[24]: 87
>>>> CHECK: Unnecessary parentheses around padapter->mlmepriv: 603
>>>> CHECK: Unnecessary parentheses around wrqu->encoding: 1497
>>>> CHECK: Unnecessary parentheses around wrqu->encoding: 1592
>>>> CHECK: Unnecessary parentheses around padapter->mlmepriv: 1593
>>>> CHECK: Unnecessary parentheses around wrqu->param: 1673
>>>> CHECK: Unnecessary parentheses around pmlmepriv->scanned_queue.lock: 1967
>>>> CHECK: Unnecessary parentheses around pmlmepriv->scanned_queue.lock: 1977
>>>> CHECK: Unnecessary parentheses around pmlmepriv->scanned_queue.lock: 1999
>>> This still needs to be improved.
>> Should be something like :
>>
>> CHECK: Unnecessary parentheses '(' around struct
> That seems like a good direction, thanks.  Maybe "Remove unnecessary
> parentheses around structure field references"
It is better , Thank you :)
> julia
>
>> ?
>>>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>> 	- Edit commit subject
>>>> 	- Edit commit message
>>>> 	- Fix the same check in more lines
>>>> 	- Remove space before '.skey' in
>>>> "memcpy(psta->tkiptxmickey.skey," in lines 84 and 86.
>>>> ---
>>>> Changes in v3:
>>>> 	return the space before '.skey' in
>>>> "memcpy(psta->tkiptxmickey.skey," in lines 84 and 86
>>> Thanks for taking care of this part.
>>>
>>> julia
>>>
>>>> ---
>>>>    drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 20 +++++++++----------
>>>>    1 file changed, 10 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
>>>> b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
>>>> index 3b6926613257..f1e352b7f83e 100644
>>>> --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
>>>> +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
>>>> @@ -82,9 +82,9 @@ static inline void handle_pairwise_key(struct sta_info
>>>> *psta,
>>>>    	       (param->u.crypt. key_len > 16 ? 16 : param->u.crypt.key_len));
>>>>    	if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
>>>>    		memcpy(psta->tkiptxmickey. skey,
>>>> -		       &(param->u.crypt.key[16]), 8);
>>>> +		       &param->u.crypt.key[16], 8);
>>>>    		memcpy(psta->tkiprxmickey. skey,
>>>> -		       &(param->u.crypt.key[24]), 8);
>>>> +		       &param->u.crypt.key[24], 8);
>>>>    		padapter->securitypriv. busetkipkey = false;
>>>>    		mod_timer(&padapter->securitypriv.tkip_timer,
>>>>    			  jiffies + msecs_to_jiffies(50));
>>>> @@ -600,7 +600,7 @@ static int r8711_wx_get_name(struct net_device *dev,
>>>>    	u32 ht_ielen = 0;
>>>>    	char *p;
>>>>    	u8 ht_cap = false;
>>>> -	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
>>>> +	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
>>>>    	struct wlan_bssid_ex *pcur_bss = &pmlmepriv->cur_network.network;
>>>>    	u8 *prates;
>>>>
>>>> @@ -1494,7 +1494,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
>>>>    	u32 keyindex_provided;
>>>>    	struct NDIS_802_11_WEP	 wep;
>>>>    	enum NDIS_802_11_AUTHENTICATION_MODE authmode;
>>>> -	struct iw_point *erq = &(wrqu->encoding);
>>>> +	struct iw_point *erq = &wrqu->encoding;
>>>>    	struct _adapter *padapter = netdev_priv(dev);
>>>>
>>>>    	key = erq->flags & IW_ENCODE_INDEX;
>>>> @@ -1589,8 +1589,8 @@ static int r8711_wx_get_enc(struct net_device *dev,
>>>>    {
>>>>    	uint key;
>>>>    	struct _adapter *padapter = netdev_priv(dev);
>>>> -	struct iw_point *erq = &(wrqu->encoding);
>>>> -	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
>>>> +	struct iw_point *erq = &wrqu->encoding;
>>>> +	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
>>>>    	union Keytype *dk = padapter->securitypriv.DefKey;
>>>>
>>>>    	if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
>>>> @@ -1670,7 +1670,7 @@ static int r871x_wx_set_auth(struct net_device *dev,
>>>>    				union iwreq_data *wrqu, char *extra)
>>>>    {
>>>>    	struct _adapter *padapter = netdev_priv(dev);
>>>> -	struct iw_param *param = (struct iw_param *)&(wrqu->param);
>>>> +	struct iw_param *param = (struct iw_param *)&wrqu->param;
>>>>    	int paramid;
>>>>    	int paramval;
>>>>    	int ret = 0;
>>>> @@ -1964,7 +1964,7 @@ static int r871x_get_ap_info(struct net_device *dev,
>>>>    		return -EINVAL;
>>>>    	data[32] = 0;
>>>>
>>>> -	spin_lock_irqsave(&(pmlmepriv->scanned_queue.lock), irqL);
>>>> +	spin_lock_irqsave(&pmlmepriv->scanned_queue.lock, irqL);
>>>>    	phead = &queue->queue;
>>>>    	plist = phead->next;
>>>>    	while (1) {
>>>> @@ -1974,7 +1974,7 @@ static int r871x_get_ap_info(struct net_device *dev,
>>>>    		if (!mac_pton(data, bssid)) {
>>>>    			netdev_info(dev, "r8712u: Invalid BSSID '%s'.\n",
>>>>    				    (u8 *)data);
>>>> -
>>>> spin_unlock_irqrestore(&(pmlmepriv->scanned_queue.lock),
>>>> +			spin_unlock_irqrestore(&pmlmepriv->scanned_queue.lock,
>>>>    					       irqL);
>>>>    			return -EINVAL;
>>>>    		}
>>>> @@ -1996,7 +1996,7 @@ static int r871x_get_ap_info(struct net_device *dev,
>>>>    		}
>>>>    		plist = plist->next;
>>>>    	}
>>>> -	spin_unlock_irqrestore(&(pmlmepriv->scanned_queue.lock), irqL);
>>>> +	spin_unlock_irqrestore(&pmlmepriv->scanned_queue.lock, irqL);
>>>>    	if (pdata->length >= 34) {
>>>>    		if (copy_to_user((u8 __user *)pdata->pointer + 32,
>>>>    		    (u8 *)&pdata->flags, 1))
>>>> --
>>>> 2.35.1
>>>>
>>>>
>>>>
> >
