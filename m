Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E742549BA48
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381493AbiAYRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:25:38 -0500
Received: from relay036.a.hostedemail.com ([64.99.140.36]:63973 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1587860AbiAYRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:23:02 -0500
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id A81D8226FE;
        Tue, 25 Jan 2022 17:22:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 356BA20037;
        Tue, 25 Jan 2022 17:22:51 +0000 (UTC)
Message-ID: <b40820130b12bedce168f70886b9ff9dd98d2b08.camel@perches.com>
Subject: Re: [Patch  1/3] Staging: rtl8723bs: Placing opening { braces in
 previous line
From:   Joe Perches <joe@perches.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Cc:     fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 09:22:53 -0800
In-Reply-To: <20220124034456.8665-2-jagathjog1996@gmail.com>
References: <20220124034456.8665-1-jagathjog1996@gmail.com>
         <20220124034456.8665-2-jagathjog1996@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: ujaimyencnwmrey7kj7okky61fr7khfu
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 356BA20037
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+cER3feRAnHr9g8xb3BJva3Bfg7EsAbUc=
X-HE-Tag: 1643131371-237344
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-24 at 09:14 +0530, Jagath Jog J wrote:
> Fix following checkpatch.pl error by placing opening {
> braces in previous line
> ERROR: that open brace { should be on the previous line
[]
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
[]
> @@ -113,13 +113,10 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
>  	struct ieee80211_supported_band *spt_band = NULL;
>  	int n_channels, n_bitrates;
>  
> -	if (band == NL80211_BAND_2GHZ)
> -	{
> +	if (band == NL80211_BAND_2GHZ) {
>  		n_channels = RTW_2G_CHANNELS_NUM;
>  		n_bitrates = RTW_G_RATES_NUM;
> -	}
> -	else
> -	{
> +	} else {
>  		goto exit;
>  	}

Reversing the test would be less indented and simpler code:

	if (band != NL80211_BAND_2GHZ)
		goto exit;

	n_channels = RTW_2G_CHANNELS_NUM;
	n_bitrates = RTW_G_RATES_NUM;

etc...


