Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4A94F671F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiDFRdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239533AbiDFRcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:32:48 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09B021E19
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jzSTEJQcGfGZ7JxkMk9H1mBl0JJZpFa9fo6uzqvky2Q=;
  b=sGIk5oEDLdgRxABX5JIFjj+a2Kwz7ZcKwYfWPfcBi5oloLW25ieCgVX/
   iZY2U4Tiz6RogGzLu2VXuXumoCAbtyqXBs8t6/aRFgKMPg6hWiQ+j5wF8
   0Qfe7ljgfV39td61LZ7Ny1ypPWU0gjUPh0ww4ZnvjbDemrUPJFdQcKLOj
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,240,1643670000"; 
   d="scan'208";a="30395387"
Received: from unknown (HELO hadrien) ([95.128.147.62])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 17:37:48 +0200
Date:   Wed, 6 Apr 2022 17:37:43 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: remove Unnecessary parentheses
In-Reply-To: <20220406152858.14076-1-eng.alaamohamedsoliman.am@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204061735340.2349@hadrien>
References: <20220406152858.14076-1-eng.alaamohamedsoliman.am@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you want to capitalize something in the subject, it could be the first
word.  Capitalizing the second word is a bit strange.

On Wed, 6 Apr 2022, Alaa Mohamed wrote:

> Reported by checkpatch:
>
> CHECK: Unnecessary parentheses

Indicating that the problem was detected by checkpatch is good.  But
actually, the parentheses all have the same property.  So you could use
the log message to describe what kind of unnecessary parentheses were
removed.  That would help the maintainer know what to look for.

julia

> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> index 3b6926613257..6c692ad7bde7 100644
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> @@ -82,9 +82,9 @@ static inline void handle_pairwise_key(struct sta_info *psta,
>  	       (param->u.crypt. key_len > 16 ? 16 : param->u.crypt.key_len));
>  	if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
>  		memcpy(psta->tkiptxmickey. skey,
> -		       &(param->u.crypt.key[16]), 8);
> +		       &param->u.crypt.key[16], 8);
>  		memcpy(psta->tkiprxmickey. skey,
> -		       &(param->u.crypt.key[24]), 8);
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
>
