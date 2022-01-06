Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18BA4865DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiAFONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbiAFONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:13:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C62C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 06:13:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A270561A32
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 14:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5BFC36AE0;
        Thu,  6 Jan 2022 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641478420;
        bh=veutsRFUwa9z/eJAKuABD/dWPy10kh8Exy8k3RIMy6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLpui3QCqtcs/STyGWN1L7c5fIy8N6Dh3ai+Xd0ChVi9njNNqNysXlIwbCAuwiI6o
         vS6FSWqkdq1XQaP6ryz/BusKu17Z+xBCm8+NdXk6fSMr6qa5U3SuvzepA1OE5uWxU3
         ZK5b78rKsljGCKwc1ZhUd491z1PMqnsS1lVEvVHM=
Date:   Thu, 6 Jan 2022 15:13:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/56] staging: r8188eu: rename camelcase SetToDs to
 set_to_ds
Message-ID: <Ydb5EYA0EWRJTjVB@kroah.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
 <20220103190326.363960-3-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103190326.363960-3-alb3rt0.m3rciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 08:01:37PM +0100, Alberto Merciai wrote:
> Rename camel case macro SetToDs into set_to_ds.
> 
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
>  drivers/staging/r8188eu/core/rtw_xmit.c     | 2 +-
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c  | 2 +-
>  drivers/staging/r8188eu/include/wifi.h      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 0aa958f20cd6..6c784134d957 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -5409,7 +5409,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
>  	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)
>  		SetFrDs(fctrl);
>  	else if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
> -		SetToDs(fctrl);
> +		set_to_ds(fctrl);

This patch will not be needed at all if you take my advice from patch
01.

The goal is to make readable code, not just rename things to pass a perl
script's suggestions :)

thanks,

greg k-h
