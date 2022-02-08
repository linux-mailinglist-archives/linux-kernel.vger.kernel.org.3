Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84D4AD634
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbiBHLW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiBHJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:44:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE36DC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:44:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F207B81986
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8123CC340ED;
        Tue,  8 Feb 2022 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644313438;
        bh=MVQhg8NpG08aednBukcoUd9p2iT4HIpeS1hAaBzlgiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgC3owl0d7PScJDX+10Dq6sHiMpDwqZv51bZf2cCbpj4GkVct6QyY4jLSFijPlMYJ
         0x7fh5DZeH2Kqms8VJfq8UUEyVpkIZIutidqwtH1eBU/ozMb16/KtYdNeuRQR9Evvk
         r0+geT57FuTxHegGAGWfGJ9S3scLcsQWPJRgmHak=
Date:   Tue, 8 Feb 2022 10:43:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leonardo Araujo <leonardo.aa88@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Staging: r8188eu: core: alignment should match open
 parenthesis
Message-ID: <YgI7VtmUtD0nJ2O0@kroah.com>
References: <20220207234824.27893-1-leonardo.aa88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207234824.27893-1-leonardo.aa88@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:48:24PM -0300, Leonardo Araujo wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
> index e02dd8e11c95..c7803144355a 100644
> --- a/drivers/staging/r8188eu/core/rtw_ap.c
> +++ b/drivers/staging/r8188eu/core/rtw_ap.c
> @@ -942,8 +942,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
>  				pmlmepriv->num_sta_ht_no_gf++;
>  			}
>  			DBG_88E("%s STA %pM - no greenfield, num of non-gf stations %d\n",
> -				   __func__, (psta->hwaddr),
> -				   pmlmepriv->num_sta_ht_no_gf);
> +				__func__, (psta->hwaddr),
> +				pmlmepriv->num_sta_ht_no_gf);
>  		}
>  
>  		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH_20_40) == 0) {
> @@ -952,8 +952,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
>  				pmlmepriv->num_sta_ht_20mhz++;
>  			}
>  			DBG_88E("%s STA %pM - 20 MHz HT, num of 20MHz HT STAs %d\n",
> -				   __func__, (psta->hwaddr),
> -				   pmlmepriv->num_sta_ht_20mhz);
> +				__func__, (psta->hwaddr),
> +				pmlmepriv->num_sta_ht_20mhz);
>  		}
>  	} else {
>  		if (!psta->no_ht_set) {
> -- 
> 2.29.0
> 
> 

This patch does not apply to my tree at all.  What tree/branch did you
make it against?

Always work against linux-next at the very least, and the subsystem
development branch usually, so that you do not duplicate work that
others have already done.

thanks,

greg k-h
