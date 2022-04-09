Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706F84FA6A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbiDIKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiDIKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:08:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2551E113D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 03:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEF32B80C9A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34014C385A0;
        Sat,  9 Apr 2022 10:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649498792;
        bh=NAQtph30uEO7eC6lMY1b0zJzkFKIF/qHWGhISKIBkNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEqIrxRokn4rJF5NX5RrL5uyXL3YZ1vi40mZUCB7MR067JAzxX0WM4ck2hru89UXF
         XqBhJ1h9iElMoymaVR1ujIRuP1P5wNMKcfxMiRKJyVjJDPe5Ix5kK8HBiaVYhDSkrm
         weLYn08XlU+Z4EesrBRyi0bxztAgUQRTq8XW84/g=
Date:   Sat, 9 Apr 2022 12:06:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Colton <cspur43@gmail.com>
Cc:     len.baker@gmx.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Staging: rtl8192e: rtllib_softmac_wx.c: Fixed multiple coding
 style issues
Message-ID: <YlFapZupbQSX8c1s@kroah.com>
References: <7cf8c5e16847aa2a9430298ba264900227a90026.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cf8c5e16847aa2a9430298ba264900227a90026.camel@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 03:24:30AM -0500, Colton wrote:
>     Staging: rtl8192e: rtllib_softmac_wx.c: Fixed multiple coding style issues
>     
>     Fixed issues  with whitespace, unbalanced braces unnecessary (int) casts, and attempted to fix alignment issue still flagged by checkpatch.pl
>     
>     Signed-off-by: Colton Spurgin <cspur43@gmail.com>
> 

> From 42fd3afd5effcb667562a417e4e895fbc09cbc2c Mon Sep 17 00:00:00 2001
> From: Colton <cspur43@gmail.com>
> Date: Sat, 9 Apr 2022 02:46:34 -0500
> Subject: [PATCH] Staging: rtl8192e: rtllib_softmac_wx.c: Fixed multiple coding
>  style issues
> 
> Fixed issues  with whitespace, unbalanced braces unnecessary (int) casts, and attempted to fix alignment issue still flagged by checkpatch.pl
> 
> Signed-off-by: Colton Spurgin <cspur43@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_softmac_wx.c | 42 ++++++--------------
>  1 file changed, 13 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> index 57a6d1130b6a..f67b829f28d1 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> @@ -12,7 +12,6 @@
>   * own it's copyright ;-)
>   */
>  #include <linux/etherdevice.h>
> -
>  #include "rtllib.h"
>  #include "dot11d.h"
>  /* FIXME: add A freqs */
> @@ -25,7 +24,6 @@ const long rtllib_wlan_frequencies[] = {
>  };
>  EXPORT_SYMBOL(rtllib_wlan_frequencies);
>  
> -
>  int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
>  			     union iwreq_data *wrqu, char *b)
>  {
> @@ -41,8 +39,8 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
>  
>  	/* if setting by freq convert to channel */
>  	if (fwrq->e == 1) {
> -		if ((fwrq->m >= (int) 2.412e8 &&
> -		     fwrq->m <= (int) 2.487e8)) {
> +		if ((fwrq->m >= 2.412e8 &&
> +		     fwrq->m <= 2.487e8)) {
>  			int f = fwrq->m / 100000;
>  			int c = 0;
>  
> @@ -83,7 +81,6 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
>  }
>  EXPORT_SYMBOL(rtllib_wx_set_freq);
>  
> -
>  int rtllib_wx_get_freq(struct rtllib_device *ieee,
>  			     struct iw_request_info *a,
>  			     union iwreq_data *wrqu, char *b)
> @@ -92,7 +89,7 @@ int rtllib_wx_get_freq(struct rtllib_device *ieee,
>  
>  	if (ieee->current_network.channel == 0)
>  		return -1;
> -	fwrq->m = rtllib_wlan_frequencies[ieee->current_network.channel-1] *
> +	fwrq->m = rtllib_wlan_frequencies[ieee->current_network.channel - 1] *
>  		  100000;
>  	fwrq->e = 1;
>  	return 0;
> @@ -128,13 +125,11 @@ int rtllib_wx_get_wap(struct rtllib_device *ieee,
>  }
>  EXPORT_SYMBOL(rtllib_wx_get_wap);
>  
> -
>  int rtllib_wx_set_wap(struct rtllib_device *ieee,
>  			 struct iw_request_info *info,
>  			 union iwreq_data *awrq,
>  			 char *extra)
>  {
> -
>  	int ret = 0;
>  	unsigned long flags;
>  
> @@ -164,7 +159,6 @@ int rtllib_wx_set_wap(struct rtllib_device *ieee,
>  		goto out;
>  	}
>  
> -
>  	if (ifup)
>  		rtllib_stop_protocol(ieee, true);
>  
> @@ -220,7 +214,6 @@ int rtllib_wx_get_essid(struct rtllib_device *ieee, struct iw_request_info *a,
>  	spin_unlock_irqrestore(&ieee->lock, flags);
>  
>  	return ret;
> -
>  }
>  EXPORT_SYMBOL(rtllib_wx_get_essid);
>  
> @@ -228,10 +221,9 @@ int rtllib_wx_set_rate(struct rtllib_device *ieee,
>  			     struct iw_request_info *info,
>  			     union iwreq_data *wrqu, char *extra)
>  {
> -
>  	u32 target_rate = wrqu->bitrate.value;
>  
> -	ieee->rate = target_rate/100000;
> +	ieee->rate = target_rate / 100000;
>  	return 0;
>  }
>  EXPORT_SYMBOL(rtllib_wx_set_rate);
> @@ -250,16 +242,15 @@ int rtllib_wx_get_rate(struct rtllib_device *ieee,
>  }
>  EXPORT_SYMBOL(rtllib_wx_get_rate);
>  
> -
>  int rtllib_wx_set_rts(struct rtllib_device *ieee,
>  			     struct iw_request_info *info,
>  			     union iwreq_data *wrqu, char *extra)
>  {
>  	if (wrqu->rts.disabled || !wrqu->rts.fixed)
>  		ieee->rts = DEFAULT_RTS_THRESHOLD;
> -	else {
> +	} else {
>  		if (wrqu->rts.value < MIN_RTS_THRESHOLD ||
> -				wrqu->rts.value > MAX_RTS_THRESHOLD)
> +			wrqu->rts.value > MAX_RTS_THRESHOLD)
>  			return -EINVAL;
>  		ieee->rts = wrqu->rts.value;
>  	}
> @@ -268,8 +259,8 @@ int rtllib_wx_set_rts(struct rtllib_device *ieee,
>  EXPORT_SYMBOL(rtllib_wx_set_rts);
>  
>  int rtllib_wx_get_rts(struct rtllib_device *ieee,
> -			     struct iw_request_info *info,
> -			     union iwreq_data *wrqu, char *extra)
> +					struct iw_request_info *info,
> +					union iwreq_data *wrqu, char *extra)
>  {
>  	wrqu->rts.value = ieee->rts;
>  	wrqu->rts.fixed = 0;	/* no auto select */
> @@ -279,7 +270,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee,
>  EXPORT_SYMBOL(rtllib_wx_get_rts);
>  
>  int rtllib_wx_set_mode(struct rtllib_device *ieee, struct iw_request_info *a,
> -			     union iwreq_data *wrqu, char *b)
> +						union iwreq_data *wrqu, char *b)
>  {
>  	int set_mode_status = 0;
>  
> @@ -410,7 +401,6 @@ void rtllib_wx_sync_scan_wq(void *data)
>  
>  out:
>  	mutex_unlock(&ieee->wx_mutex);
> -
>  }
>  
>  int rtllib_wx_set_scan(struct rtllib_device *ieee, struct iw_request_info *a,
> @@ -441,7 +431,6 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
>  			struct iw_request_info *a,
>  			union iwreq_data *wrqu, char *extra)
>  {
> -
>  	int ret = 0, len, i;
>  	short proto_started;
>  	unsigned long flags;
> @@ -468,7 +457,6 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
>  	if (proto_started)
>  		rtllib_stop_protocol(ieee, true);
>  
> -
>  	/* this is just to be sure that the GET wx callback
>  	 * has consistent infos. not needed otherwise
>  	 */
> @@ -551,11 +539,10 @@ int rtllib_wx_get_name(struct rtllib_device *ieee, struct iw_request_info *info,
>  }
>  EXPORT_SYMBOL(rtllib_wx_get_name);
>  
> -
>  /* this is mostly stolen from hostap */
>  int rtllib_wx_set_power(struct rtllib_device *ieee,
> -				 struct iw_request_info *info,
> -				 union iwreq_data *wrqu, char *extra)
> +						struct iw_request_info *info,
> +						union iwreq_data *wrqu, char *extra)
>  {
>  	int ret = 0;
>  
> @@ -601,19 +588,17 @@ int rtllib_wx_set_power(struct rtllib_device *ieee,
>  	default:
>  		ret = -EINVAL;
>  		goto exit;
> -
>  	}
>  exit:
>  	mutex_unlock(&ieee->wx_mutex);
>  	return ret;
> -
>  }
>  EXPORT_SYMBOL(rtllib_wx_set_power);
>  
>  /* this is stolen from hostap */
>  int rtllib_wx_get_power(struct rtllib_device *ieee,
> -				 struct iw_request_info *info,
> -				 union iwreq_data *wrqu, char *extra)
> +						struct iw_request_info *info,
> +						union iwreq_data *wrqu, char *extra)
>  {
>  	mutex_lock(&ieee->wx_mutex);
>  
> @@ -643,6 +628,5 @@ int rtllib_wx_get_power(struct rtllib_device *ieee,
>  exit:
>  	mutex_unlock(&ieee->wx_mutex);
>  	return 0;
> -
>  }
>  EXPORT_SYMBOL(rtllib_wx_get_power);
> -- 
> 2.35.1
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

- Your patch breaks the build.

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

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
